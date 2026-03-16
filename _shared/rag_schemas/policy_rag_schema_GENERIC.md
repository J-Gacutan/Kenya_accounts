# RAG Schema: Coastal & Marine Policies — Generic Template

## Overview
This schema structures national coastal and marine policies and international commitments for Retrieval Augmented Generation (RAG), enabling semantic search, filtering, and cross-linking between policy instruments and compliance obligations. This generic template can be adapted for any coastal nation by substituting country-specific laws, ministries, and example records.

---

## Core Entity Schema

### 1. **Policy Document**

```json
{
  "policy_id": "string (unique identifier)",
  "policy_name": "string",
  "policy_type": "enum: [LEGISLATION, DECREE, STRATEGY, COMMITMENT, ACTION_PLAN]",
  "country": "string (country name)",
  "issuing_body": "string (e.g., Ministry of Fisheries and Marine Resources)",
  "adoption_date": "YYYY-MM-DD",
  "effective_date": "YYYY-MM-DD",
  "status": "enum: [ACTIVE, SUPERSEDED, PROPOSED, EXPIRED]",
  "legal_instrument_number": "string (e.g., Law n° XXX, Decree n° YYY)",
  "document_url": "string (URL to official document or source)",
  "document_source": "string (e.g., Official Gazette, Government Portal, International Convention)",
  "full_text_url": "string (link to full PDF if available)",
  "policy_summary": "string (200-300 words)",
  "key_objectives": ["string array"],
  "target_ecosystems": ["string array (e.g., coral reef, seagrass, mangrove)]",
  "implementation_status": "string (percentage or descriptive status)",
  "responsible_ministries": ["string array"],
  "linked_policies": ["policy_id array (cross-references)"],
  "international_commitments": ["commitment_id array"],
  "spatial_scope": "string (e.g., EEZ, coastal zone, specific regions)",
  "temporal_scope": "string (e.g., 2015-2025)",
  "metadata": {
    "created_date": "YYYY-MM-DD",
    "last_updated": "YYYY-MM-DD",
    "data_source": "string (where this record came from)",
    "reliability_score": "float (0-1, confidence in accuracy)",
    "notes": "string"
  }
}
```

---

### 2. **International Commitment**

```json
{
  "commitment_id": "string (unique identifier)",
  "commitment_name": "string (e.g., Nairobi Convention)",
  "commitment_type": "enum: [TREATY, AGREEMENT, PROTOCOL, DECLARATION, FRAMEWORK]",
  "organization": "string (e.g., UNEP, IOC, CBD)",
  "signature_date": "YYYY-MM-DD",
  "ratification_date": "YYYY-MM-DD",
  "entry_into_force_date": "YYYY-MM-DD",
  "country_ratification_status": "enum: [SIGNATORY, RATIFIED, ACCEDED, NOT_SIGNED]",
  "commitment_url": "string (URL to official commitment text)",
  "document_source": "string (e.g., UN Treaty Database, Secretariat)",
  "full_text_url": "string",
  "commitment_summary": "string (200-300 words)",
  "key_obligations": ["string array"],
  "target_ecosystems": ["string array"],
  "reporting_requirements": ["string array"],
  "compliance_deadline": "YYYY-MM-DD or null",
  "implementing_policies": ["policy_id array"],
  "regional_context": "string (e.g., region name, regional body)",
  "enforcement_mechanism": "string (how compliance is monitored)",
  "metadata": {
    "created_date": "YYYY-MM-DD",
    "last_updated": "YYYY-MM-DD",
    "data_source": "string",
    "reliability_score": "float (0-1)",
    "notes": "string"
  }
}
```

---

### 3. **Policy-Commitment Linkage**

```json
{
  "linkage_id": "string",
  "policy_id": "string",
  "commitment_id": "string",
  "relationship_type": "enum: [IMPLEMENTS, ALIGNS_WITH, SUPERSEDES, COMPLEMENTS, FULFILLS]",
  "alignment_strength": "enum: [DIRECT, PARTIAL, INDIRECT]",
  "implementation_gap": "string (describe any gaps between policy and commitment)",
  "cross_reference_section": "string (specific article/section numbers)",
  "notes": "string"
}
```

---

### 4. **Ecosystem Coverage**

```json
{
  "ecosystem_id": "string",
  "ecosystem_name": "string (e.g., Photic Coral Reefs M1.3, Seagrass beds)",
  "seea_classification": "string (UN SEEA EA code)",
  "policies": ["policy_id array"],
  "international_commitments": ["commitment_id array"],
  "protection_mechanisms": ["string array (MPA, LMMA, CITES, etc.)"],
  "spatial_extent": "string (geographic description or GIS polygon reference)",
  "conservation_status": "string",
  "key_threats": ["string array"],
  "metadata": {
    "last_assessed": "YYYY-MM-DD"
  }
}
```

---

### 5. **Policy Instrument Index**

```json
{
  "instrument_id": "string",
  "instrument_type": "enum: [LEGISLATION, DECREE, MINISTERIAL_ORDER, REGULATION, PROTOCOL, ACTION_PLAN, STRATEGY]",
  "instrument_name": "string",
  "reference_number": "string (e.g., Law n° XXXX)",
  "issuing_authority": "string",
  "adoption_date": "YYYY-MM-DD",
  "document_source": "string (e.g., Official Gazette, Government Portal)",
  "document_url": "string",
  "full_text_url": "string",
  "keywords": ["string array (for semantic search)"],
  "summary": "string",
  "articles_affecting_coastal_marine": ["string array (specific articles/sections)"],
  "implementation_agencies": ["string array"],
  "enforcement_body": "string",
  "penalty_provisions": "string",
  "metadata": {
    "indexed_date": "YYYY-MM-DD",
    "data_quality": "enum: [VERIFIED, PRELIMINARY, DRAFT]",
    "notes": "string"
  }
}
```

---

## Taxonomy & Controlled Vocabularies

### Policy Types
- **LEGISLATION** — Primary law (national statute)
- **DECREE** — Executive decree (government order)
- **STRATEGY** — Strategic framework (5–10 year policy direction)
- **COMMITMENT** — International commitment or pledge
- **ACTION_PLAN** — Implementation roadmap with timelines and agencies

### Commitment Types
- **TREATY** — Binding international agreement
- **PROTOCOL** — Protocol to a treaty
- **AGREEMENT** — Bilateral or multilateral agreement
- **DECLARATION** — Non-binding statement
- **FRAMEWORK** — Overarching framework

### Target Ecosystems (SEEA EA aligned)
- Photic Coral Reefs (M1.3)
- Seagrass Beds (M1.1)
- Mangroves (M1.2)
- Rocky Reefs (M1.4)
- Kelp Forests (M1.5)
- Coastal Waters (M2)
- Open Ocean (M3)

### Relationship Types
- **IMPLEMENTS** — Policy directly implements commitment
- **ALIGNS_WITH** — Policy aligns with commitment objectives
- **SUPERSEDES** — Policy replaces earlier instrument
- **COMPLEMENTS** — Policy adds to commitment
- **FULFILLS** — Policy satisfies specific commitment obligation

---

## Implementation Notes

### Technical Stack
- **Database:** PostgreSQL with JSONB columns for flexible schema
- **Vector Database:** Pinecone or Weaviate for semantic search (embedding model: OpenAI `text-embedding-3-large` or open-source equivalent)
- **API:** FastAPI for REST endpoints
- **Query patterns:** Semantic search (e.g., "What commitments require coral reef conservation?") and structured filters (country, ecosystem, policy type)

### Data Entry Workflow
1. Identify policy documents (official gazette, government portal, international treaty database)
2. Extract key fields into Policy Document or International Commitment entity
3. Standardise country, ministry names, and ecosystem classifications
4. Link policies to international commitments (manually or via semantic similarity)
5. Generate embeddings for full_text_url content or policy_summary
6. Test search queries (semantic + structured filters)

### Validation & Quality Assurance
- Set `reliability_score` based on source authority (Official Gazette = 0.95; Government Portal = 0.85; Secondary sources = 0.70)
- Cross-reference policy names and dates with official government sources
- Flag entries with reliability_score < 0.75 for manual review
- For ecosystem coverage, validate SEEA EA classification codes against UN SEEA EA Handbook (2021)

---

## Country-Specific Adaptation Checklist

To adapt this generic schema for a new coastal country:

- [ ] Replace "country" field example with target country name
- [ ] Identify and list target country's ministries (e.g., Ministry of Environment, Ministry of Fisheries)
- [ ] Compile list of national coastal/marine laws and policy instruments
- [ ] Identify international commitments the country is party to (CBD, Ramsar, Nairobi Convention, etc.)
- [ ] Create example policy and commitment records (3–5 each) with real data
- [ ] Validate ecosystem classifications against national marine spatial plans
- [ ] Set up database and embeddings pipeline
- [ ] Test semantic search queries (5–10 representative queries)
- [ ] Document data sources and reliability scores for all records
- [ ] Establish update cadence (e.g., quarterly review for new laws, annual policy linkage review)

---

## See Also

- Country-specific implementations: `Madagascar/docs/policy_rag_schema.md`, `Mozambique/docs/policy_rag_schema.md`
- Academic evidence linking: `Madagascar/docs/academic_rag_schema.md`
- SEEA EA Framework: UN (2021), *System of Environmental-Economic Accounting — Ecosystem Accounting*
