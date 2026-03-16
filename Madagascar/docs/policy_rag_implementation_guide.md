# RAG Implementation Guide: Madagascar Policy Database

## Quick Start

This guide explains how to implement a Retrieval Augmented Generation (RAG) system for Madagascar's coastal and marine policies using the schema defined in `policy_rag_schema.md`.

---

## Data Structure Overview

```
policy_rag_sample_data.json
├── policies[] (9 national policy documents)
├── international_commitments[] (5 global/regional treaties & frameworks)
├── policy_commitment_linkages[] (cross-reference relationships)
└── ecosystem_coverage[] (coral reefs, seagrass, mangroves)
```

**Total Records in Sample:**
- 9 national policies (legislation, decrees, strategies)
- 5 international commitments (treaties, protocols, frameworks)
- 6 policy-commitment linkages
- 3 ecosystem coverage records

---

## Setup Instructions

### 1. Database Preparation

**Option A: PostgreSQL (Recommended for production)**

```sql
-- Create schema
CREATE TABLE policies (
  policy_id TEXT PRIMARY KEY,
  policy_name TEXT NOT NULL,
  policy_type VARCHAR(50),
  country TEXT,
  issuing_body TEXT,
  adoption_date DATE,
  effective_date DATE,
  status VARCHAR(20),
  legal_instrument_number TEXT UNIQUE,
  document_url TEXT,
  document_source TEXT,
  full_text_url TEXT,
  policy_summary TEXT,
  key_objectives TEXT[],
  target_ecosystems TEXT[],
  implementation_status TEXT,
  responsible_ministries TEXT[],
  linked_policies TEXT[],
  international_commitments TEXT[],
  spatial_scope TEXT,
  temporal_scope TEXT,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE international_commitments (
  commitment_id TEXT PRIMARY KEY,
  commitment_name TEXT NOT NULL,
  commitment_type VARCHAR(50),
  organization TEXT,
  signature_date DATE,
  ratification_date DATE,
  entry_into_force_date DATE,
  madagascar_ratification_status VARCHAR(20),
  commitment_url TEXT,
  document_source TEXT,
  full_text_url TEXT,
  commitment_summary TEXT,
  key_obligations TEXT[],
  target_ecosystems TEXT[],
  reporting_requirements TEXT[],
  compliance_deadline DATE,
  implementing_policies TEXT[],
  regional_context TEXT,
  enforcement_mechanism TEXT,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE policy_commitment_linkages (
  linkage_id TEXT PRIMARY KEY,
  policy_id TEXT REFERENCES policies(policy_id),
  commitment_id TEXT REFERENCES international_commitments(commitment_id),
  relationship_type VARCHAR(50),
  alignment_strength VARCHAR(20),
  implementation_gap TEXT,
  cross_reference_section TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ecosystem_coverage (
  ecosystem_id TEXT PRIMARY KEY,
  ecosystem_name TEXT NOT NULL,
  seea_classification TEXT,
  policies TEXT[],
  international_commitments TEXT[],
  protection_mechanisms TEXT[],
  spatial_extent TEXT,
  conservation_status VARCHAR(50),
  key_threats TEXT[],
  last_assessed DATE,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Create full-text search indices
CREATE INDEX policies_summary_idx ON policies USING GIN(to_tsvector('english', policy_summary));
CREATE INDEX commitments_summary_idx ON international_commitments USING GIN(to_tsvector('english', commitment_summary));
```

**Option B: Vector Database (Pinecone, Weaviate, Milvus)**

```python
# Example: Pinecone setup
import pinecone
from sentence_transformers import SentenceTransformer

# Initialize Pinecone
pinecone.init(api_key="YOUR_API_KEY", environment="us-west1-gcp")

# Create index with embeddings
pinecone.create_index(
    "madagascar-policies",
    dimension=384,  # sentence-transformers/all-MiniLM-L6-v2
    metric="cosine"
)

# Generate embeddings for policy summaries
model = SentenceTransformer('all-MiniLM-L6-v2')

policies_data = [...] # Load from policy_rag_sample_data.json

for policy in policies_data:
    embedding = model.encode(policy['policy_summary'])
    pinecone.Index("madagascar-policies").upsert([(
        policy['policy_id'],
        embedding.tolist(),
        {
            "policy_name": policy['policy_name'],
            "policy_type": policy['policy_type'],
            "target_ecosystems": policy['target_ecosystems'],
            "document_source": policy['document_source'],
            "document_url": policy['document_url']
        }
    )])
```

---

## Implementation: RAG Query Interface

### 2. Query Types & Examples

**A. Ecosystem-Based Queries**

```python
# Query: "What policies protect seagrass in Madagascar?"
query = "seagrass conservation policies"
embedding = model.encode(query)
results = pinecone.Index("madagascar-policies").query(
    embedding,
    top_k=5,
    filter={"target_ecosystems": {"$in": ["Seagrass Beds (M1.1)"]}}
)

# Expected results: policy_004, policy_006, policy_008, policy_009
```

**B. Commitment-Based Queries**

```python
# Query: "Which national policies implement the Nairobi Convention?"
query = "Nairobi Convention implementation"
results = pinecone.Index("madagascar-policies").query(
    embedding,
    top_k=10
)
# Cross-reference with policy_commitment_linkages table
# Filter for commitment_id = "commitment_001"
```

**C. Temporal Queries**

```sql
-- Query: "What policies were adopted after 2015?"
SELECT * FROM policies
WHERE adoption_date > '2015-01-01'
ORDER BY adoption_date DESC;

-- Expected: Law 2015-053, Decree 2016-1492, Trawl-Free Zone 2021
```

**D. Implementation Status Queries**

```sql
-- Query: "Which policies are ACTIVE but have low implementation status?"
SELECT policy_name, implementation_status, responsible_ministries
FROM policies
WHERE status = 'ACTIVE'
  AND implementation_status LIKE '%50%'
ORDER BY implementation_status ASC;

-- Expected: Fisheries Decree 2016-1492, ICZM Decree 2010-137, Blue Economy Policy
```

**E. Gap Analysis Queries**

```sql
-- Query: "Show all policy-commitment linkages with IMPLEMENTATION_GAP noted"
SELECT
    p.policy_name,
    ic.commitment_name,
    l.implementation_gap
FROM policy_commitment_linkages l
JOIN policies p ON l.policy_id = p.policy_id
JOIN international_commitments ic ON l.commitment_id = ic.commitment_id
WHERE l.implementation_gap IS NOT NULL
ORDER BY p.policy_name;
```

---

## 3. Python RAG Implementation (Prototype)

```python
import json
from typing import List, Dict
from sentence_transformers import SentenceTransformer
import pinecone

class MadagascarPolicyRAG:
    def __init__(self, pinecone_api_key: str, pinecone_env: str):
        self.model = SentenceTransformer('all-MiniLM-L6-v2')
        pinecone.init(api_key=pinecone_api_key, environment=pinecone_env)
        self.index = pinecone.Index("madagascar-policies")

        # Load policy data
        with open('policy_rag_sample_data.json') as f:
            self.data = json.load(f)
        self._index_documents()

    def _index_documents(self):
        """Index all policy summaries and commitment descriptions"""
        vectors = []

        # Index policies
        for policy in self.data['policies']:
            embedding = self.model.encode(policy['policy_summary'])
            vectors.append((
                policy['policy_id'],
                embedding.tolist(),
                {
                    'type': 'policy',
                    'name': policy['policy_name'],
                    'document_source': policy['document_source'],
                    'ecosystems': policy['target_ecosystems'],
                    'status': policy['status']
                }
            ))

        # Index commitments
        for commitment in self.data['international_commitments']:
            embedding = self.model.encode(commitment['commitment_summary'])
            vectors.append((
                commitment['commitment_id'],
                embedding.tolist(),
                {
                    'type': 'commitment',
                    'name': commitment['commitment_name'],
                    'document_source': commitment['document_source'],
                    'organization': commitment['organization'],
                    'status': commitment['madagascar_ratification_status']
                }
            ))

        # Upsert to Pinecone
        self.index.upsert(vectors=vectors, batch_size=100)

    def search_by_ecosystem(self, ecosystem: str, top_k: int = 5) -> List[Dict]:
        """Find policies and commitments for a specific ecosystem"""
        query = f"{ecosystem} conservation management protection"
        embedding = self.model.encode(query)

        # Query Pinecone
        results = self.index.query(embedding, top_k=top_k)

        # Enrich with metadata
        enriched = []
        for match in results['matches']:
            doc_id = match['id']
            metadata = match['metadata']

            # Find full document
            if metadata['type'] == 'policy':
                doc = next((p for p in self.data['policies'] if p['policy_id'] == doc_id), None)
            else:
                doc = next((c for c in self.data['international_commitments'] if c['commitment_id'] == doc_id), None)

            if doc:
                enriched.append({
                    'id': doc_id,
                    'name': metadata['name'],
                    'type': metadata['type'],
                    'source': metadata['document_source'],
                    'url': doc.get('document_url'),
                    'relevance_score': match['score'],
                    'summary': doc['policy_summary'] if metadata['type'] == 'policy' else doc['commitment_summary']
                })

        return enriched

    def find_implementing_policies(self, commitment_id: str) -> List[Dict]:
        """Find policies implementing a specific commitment"""
        commitment = next(
            (c for c in self.data['international_commitments'] if c['commitment_id'] == commitment_id),
            None
        )

        if not commitment:
            return []

        implementing_policy_ids = commitment.get('implementing_policies', [])
        policies = [
            next((p for p in self.data['policies'] if p['policy_id'] == pid), None)
            for pid in implementing_policy_ids
        ]
        return [p for p in policies if p]

    def get_implementation_gaps(self) -> List[Dict]:
        """Show all documented implementation gaps"""
        gaps = []
        for linkage in self.data['policy_commitment_linkages']:
            if linkage.get('implementation_gap'):
                policy = next((p for p in self.data['policies'] if p['policy_id'] == linkage['policy_id']), None)
                commitment = next((c for c in self.data['international_commitments'] if c['commitment_id'] == linkage['commitment_id']), None)

                gaps.append({
                    'policy': policy['policy_name'] if policy else None,
                    'commitment': commitment['commitment_name'] if commitment else None,
                    'gap_description': linkage['implementation_gap'],
                    'relationship': linkage['relationship_type'],
                    'alignment_strength': linkage['alignment_strength']
                })
        return gaps

# Usage
rag = MadagascarPolicyRAG("YOUR_API_KEY", "YOUR_ENV")

# Find policies for coral reef conservation
coral_policies = rag.search_by_ecosystem("Photic Coral Reefs (M1.3)", top_k=5)
print(coral_policies)

# Find policies implementing Nairobi Convention
nairobi_implementing = rag.find_implementing_policies("commitment_001")
print(nairobi_implementing)

# Show all gaps
gaps = rag.get_implementation_gaps()
for gap in gaps:
    print(f"{gap['policy']} → {gap['commitment']}: {gap['gap_description']}")
```

---

## 4. Web Interface (Streamlit Example)

```python
import streamlit as st
from rag_implementation import MadagascarPolicyRAG

st.set_page_config(page_title="Madagascar Policy RAG", layout="wide")

st.title("🌊 Madagascar Coastal & Marine Policies")
st.subheader("Integrated Retrieval System for National Policies & International Commitments")

# Initialize RAG
@st.cache_resource
def load_rag():
    return MadagascarPolicyRAG("YOUR_API_KEY", "YOUR_ENV")

rag = load_rag()

# Tabs for different query types
tab1, tab2, tab3, tab4 = st.tabs(
    ["🌿 Ecosystem Search", "📋 Commitments", "📊 Implementation Gap", "🔗 Linkages"]
)

with tab1:
    st.header("Find Policies by Ecosystem")
    ecosystem = st.selectbox(
        "Select Ecosystem",
        ["Photic Coral Reefs (M1.3)", "Seagrass Beds (M1.1)", "Mangroves (M1.2)", "Coastal Waters (M2)"]
    )

    if st.button("Search"):
        results = rag.search_by_ecosystem(ecosystem, top_k=10)
        for result in results:
            with st.container(border=True):
                st.subheader(result['name'])
                st.write(f"**Type:** {result['type']}")
                st.write(f"**Source:** {result['source']}")
                st.write(f"**Relevance:** {result['relevance_score']:.2%}")
                st.caption(result['summary'][:300] + "...")
                if result['url']:
                    st.link_button("Read Full Document", result['url'])

with tab2:
    st.header("International Commitments & Implementing Policies")
    commitment_id = st.selectbox(
        "Select Commitment",
        {
            "Nairobi Convention": "commitment_001",
            "Convention on Biological Diversity": "commitment_002",
            "CITES": "commitment_003",
            "Nagoya Protocol": "commitment_004",
            "SAPPHIRE": "commitment_005"
        }
    )

    if st.button("Find Implementing Policies"):
        policies = rag.find_implementing_policies(commitment_id)
        st.success(f"Found {len(policies)} implementing policies")
        for policy in policies:
            with st.container(border=True):
                st.subheader(policy['policy_name'])
                st.write(f"**Status:** {policy['status']}")
                st.write(f"**Implementation:** {policy['implementation_status']}")

with tab3:
    st.header("Implementation Gaps Analysis")
    gaps = rag.get_implementation_gaps()

    st.write(f"**Total gaps documented:** {len(gaps)}")
    for gap in gaps:
        with st.container(border=True):
            st.write(f"**Policy:** {gap['policy']}")
            st.write(f"**Commitment:** {gap['commitment']}")
            st.write(f"**Gap:** {gap['gap_description']}")
            st.write(f"**Alignment:** {gap['alignment_strength']} ({gap['relationship']})")

with tab4:
    st.header("Policy-Commitment Linkages")
    st.dataframe(
        rag.get_linkages_dataframe(),
        use_container_width=True
    )
```

---

## 5. Data Maintenance & Updates

### Update Frequency
- **Quarterly:** Monitor Madagascar Official Gazette, Nairobi Convention CoP decisions
- **Monthly:** Check MPRH announcements, new decrees, policy amendments

### Update Process

```python
def update_policy(policy_id: str, updates: Dict):
    """Update a single policy record"""
    # Find in database
    # Apply updates
    # Re-embed policy_summary if changed
    # Update Pinecone index
    # Log change with timestamp
    pass

def add_new_commitment(commitment_data: Dict):
    """Add new international commitment"""
    # Validate against schema
    # Assign commitment_id
    # Create embedding
    # Upsert to vector DB
    # Log addition
    pass
```

### Quality Assurance
- Cross-reference all URLs quarterly (check for 404s)
- Verify implementation status with MPRH annually
- Update gap analysis when policies are amended
- Track document source reliability scores

---

## 6. Integration with SEEA EA Accounting

### Linking to Condition Accounts

```python
def map_policies_to_seea_components(ecosystem: str) -> Dict:
    """Show how national policies support SEEA EA condition accounting"""

    seea_mapping = {
        "Extent": {
            "relevant_policies": ["policy_001", "policy_003", "policy_009"],
            "data_requirements": ["benthic habitat maps", "MPA boundaries"],
            "gap": "Sentinel-2 mapping in progress (Mar 2026)"
        },
        "Condition": {
            "relevant_policies": ["policy_001", "policy_003", "policy_004"],
            "data_requirements": ["fish UVC surveys", "invertebrate sampling"],
            "gap": "Standardized monitoring protocols still being developed"
        },
        "Services": {
            "relevant_policies": ["policy_005", "policy_008", "policy_009"],
            "data_requirements": ["landings data", "fisher income surveys"],
            "gap": "Landing site data collection needs strengthening (Decree 2016-1492)"
        }
    }

    return seea_mapping.get(ecosystem, {})
```

---

## 7. Key Considerations

### Security
- Store API keys in environment variables (`.env`)
- Use role-based access control (RBAC) for document access
- Audit log all policy updates and searches

### Performance
- Vector DB queries: ~100ms (Pinecone)
- SQL full-text search: ~500ms (PostgreSQL)
- Cache frequently accessed policies (Redis)

### Scalability
- Current sample: 9 policies + 5 commitments
- Expected growth: +5-10 policies/year, +1-2 commitments/year
- Prepare for 50+ documents within 3 years

---

## Reference: Sample Query Results

**Query:** "What commitments require Madagascar to report on coral reef extent?"

**Expected Results:**
1. **Commitment:** Nairobi Convention (commitment_001)
   - Key Obligation: "Conduct marine ecosystem diagnostic assessments and condition monitoring"
   - Reporting Requirement: "Biennial national reports to Conference of Parties"
   - Implementing Policy: Decree 2010-137 (ICZM), NBSAP 2015-2025
   - Status: Regular reporting occurs

2. **Commitment:** CBD (commitment_002)
   - Key Obligation: "Establish and manage protected area systems"
   - Reporting Requirement: "Periodic reports on protected area networks and effectiveness"
   - Implementing Policy: NBSAP 2015-2025, MPA expansion target
   - Status: Behind schedule (45% toward target)

3. **Commitment:** SAPPHIRE (commitment_005)
   - Key Obligation: "Monitor ecosystem health"
   - Reporting Requirement: "Ecosystem monitoring data"
   - Implementing Policy: Blue Economy Policy, LMMA Framework
   - Status: Active monitoring through LMMA network

---

## Next Steps

1. **Load sample data** into PostgreSQL or Pinecone
2. **Test queries** against expected results
3. **Deploy Streamlit interface** for stakeholder access
4. **Integrate with SEEA EA workflow** (link policies → extent/condition → services)
5. **Schedule quarterly data updates** (Gazette monitoring)
6. **Establish linkages to WDPA database** (protected area verification)

