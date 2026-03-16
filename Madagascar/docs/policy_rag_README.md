# Madagascar Coastal & Marine Policy RAG System

## Overview

This directory contains a complete Retrieval Augmented Generation (RAG) system for Madagascar's national coastal and marine policies and international commitments. The system is designed to support SEEA EA ecosystem accounting by enabling rapid policy research, gap analysis, and integration of policy context into ecosystem assessments.

---

## Files in This Directory

### 1. **policy_rag_schema.md** — Core Data Model
Defines the complete JSON schema for:
- **Policy Documents** — national legislation, decrees, strategies
- **International Commitments** — treaties, protocols, regional agreements
- **Policy-Commitment Linkages** — relationships and implementation gaps
- **Ecosystem Coverage** — which policies/commitments protect coral reefs, seagrass, mangroves

**Key Features:**
- Controlled vocabularies (policy types, commitment types, relationship types)
- Reliability scoring (0–1 scale for data quality)
- Spatial and temporal scoping
- Metadata with document sources and URLs
- SEEA EA alignment fields

**Use this file if you need to:** Add new policies, understand the data structure, validate incoming records

---

### 2. **policy_rag_sample_data.json** — Populated Data
Complete sample dataset with:
- **9 National Policies** (Law 2015-053, Decree 2010-137, NBSAP 2015-2025, Blue Policy 2015, etc.)
- **5 International Commitments** (Nairobi Convention, CBD, CITES, Nagoya Protocol, SAPPHIRE)
- **6 Policy-Commitment Linkages** (showing implementation relationships and gaps)
- **3 Ecosystem Coverage Records** (coral reefs, seagrass, mangroves)

**All records include:**
- Document/source URLs
- Summary text for semantic search
- Implementation status assessments
- Known gaps and challenges

**Use this file if you need to:** Load the initial dataset, see real Madagascar policy examples, understand how to populate the schema

---

### 3. **policy_rag_implementation_guide.md** — Technical Setup
Step-by-step guide for building a working RAG system:

**Sections:**
- Database setup (PostgreSQL vs. vector DB)
- Index creation and full-text search configuration
- Python RAG class implementation (Pinecone/vector DB example)
- Streamlit web interface code
- Query patterns and examples
- Data maintenance procedures
- Integration with SEEA EA workflows

**Use this file if you need to:** Implement the RAG system, set up a query interface, integrate with your backend

---

## Quick Start: Using the RAG System

### For Policy Researchers
```bash
# Load the sample data into your database
psql your_db < load_policies.sql  # Load from policy_rag_sample_data.json

# Search for seagrass conservation policies
SELECT * FROM policies
WHERE 'Seagrass Beds (M1.1)' = ANY(target_ecosystems)
AND status = 'ACTIVE';
```

### For SEEA EA Condition Analysts
```python
# Find policies supporting coral reef accounting
rag.search_by_ecosystem("Photic Coral Reefs (M1.3)")

# Expected results:
# - Law 2015-053 (fish monitoring authority)
# - Decree 2010-137 (ICZM framework)
# - MPA expansion target (data on extent)
# - Trawl-free zones (community monitoring)
```

### For Gap Analysts
```sql
SELECT p.policy_name, ic.commitment_name, l.implementation_gap
FROM policy_commitment_linkages l
JOIN policies p ON l.policy_id = p.policy_id
JOIN international_commitments ic ON l.commitment_id = ic.commitment_id
WHERE l.implementation_gap IS NOT NULL;

-- Results show critical gaps like:
-- - ICZM enforcement inconsistency across regions
-- - MPA expansion behind target (45% vs. 100% by 2025)
-- - Landing site data collection needs strengthening
```

---

## Policy Coverage

### National Policies (9 Total)

| Instrument | Type | Year | Status | Implementation |
|---|---|---|---|---|
| Law n° 2015-053 | LEGISLATION | 2015 | ACTIVE | 75% |
| Decree N° 2010-137 | DECREE | 2010 | ACTIVE | 65% |
| Decree 2016-1492 | DECREE | 2016 | ACTIVE | 70% |
| NBSAP 2015-2025 | STRATEGY | 2015 | ACTIVE | 60% |
| Blue Policy | STRATEGY | 2015 | ACTIVE | 50% |
| MPA Expansion | COMMITMENT | 2014 | ACTIVE | 45% |
| LMMA Framework | STRATEGY | 2010 | ACTIVE | 70% |
| Trawl-Free Zone | DECREE | 2021 | ACTIVE | 50% |
| Ordinance 93022 | LEGISLATION | 1993 | SUPERSEDED | — |

### International Commitments (5 Total)

| Commitment | Organization | Ratification | Implementing Policies | Priority |
|---|---|---|---|---|
| Nairobi Convention | UNEP | 1999 | ICZM, MPA expansion | ⭐⭐⭐ |
| CBD | UNEP | 1995 | NBSAP, MPA expansion | ⭐⭐⭐ |
| CITES | UNEP | 1975 | Fisheries Law | ⭐⭐ |
| Nagoya Protocol | CBD | 2014 | NBSAP | ⭐ |
| SAPPHIRE | IOC/GEF | 2017 | Blue Policy, LMMA | ⭐⭐ |

---

## Key Implementation Gaps

| Gap | Policy/Commitment | Impact on Accounting | Priority |
|---|---|---|---|
| **ICZM enforcement inconsistency** | Decree 2010-137 ↔ Nairobi Conv. | Extent/condition data collection | HIGH |
| **MPA expansion behind schedule** | MPA target ↔ CBD/Nairobi | Spatial scope definition uncertain | HIGH |
| **Landing site data collection weak** | Decree 2016-1492 ↔ Policy 5 | Services accounting (landings data) | HIGH |
| **Trawl enforcement variable** | Trawl-free zone ↔ Decree 2016-1492 | Nursery service estimation | MEDIUM |
| **LMMA legal codification lacking** | LMMA framework ↔ Fisheries Law | Community data access uncertain | MEDIUM |
| **Genetic resource benefit-sharing underdeveloped** | Nagoya Protocol | Bioprospecting data missing | LOW |

---

## Integrating with SEEA EA Accounting

The policy RAG system directly supports the three SEEA EA accounting pillars:

### **1. Extent (Spatial Coverage)**
**Relevant Policies:**
- Law 2015-053 (benthic mapping authority)
- Decree 2010-137 (ICZM spatial planning)
- MPA expansion target (2014 declaration)

**Data Produced:**
- MPA boundaries (22 MPAs → 1.26% EEZ coverage)
- Trawl-free zone extent (coastal zones ~20 km)
- Ecosystem habitat maps (ongoing Sentinel-2 mapping)

**Critical Gap:** Sentinel-2 extent mapping in progress (Mar 2026)

### **2. Condition (Ecosystem Health)**
**Relevant Policies:**
- Law 2015-053 (stock conservation mandate)
- Decree 2016-1492 (size/gear limits for population structure)
- ICZM framework (ecosystem monitoring requirement)

**Data Produced:**
- Fish biomass & community composition (UVC surveys, 27 sites)
- Invertebrate indicators (COTS, sea urchins, clams)
- Habitat condition indices

**Critical Gap:** Standardized monitoring protocols still being developed

### **3. Services (Economic & Social Benefits)**
**Relevant Policies:**
- Blue Policy (livelihood objectives)
- Decree 2016-1492 (landing site data collection)
- LMMA framework (community benefit-sharing)
- SAPPHIRE (alternative livelihood pilots)

**Data Produced:**
- Fisheries landings (catch by species/family)
- Fisher income & livelihoods (LMMA surveys)
- Nursery service value (~$61K/yr provisional)
- Tourism/recreation value (pending visitor data)

**Critical Gap:** Landing site data collection needs MPRH enforcement; market price data missing

---

## Query Examples

### Example 1: "What's the legal basis for monitoring fish biomass?"

**Answer:** Law n° 2015-053 grants MPRH authority to establish stock conservation plans (Articles 18-25). Decree 2016-1492 operationalizes this via minimum size limits and landing site data collection requirements. Implementing agencies are MPRH + port authorities.

**Policy Link:** [Law 2015-053](https://theoutlawocean.com/toolkit/global-fishing-legislation/madagascar/fisheries-and-aquaculture-code)

### Example 2: "What commitments require Madagascar to report on coral reef protection?"

**Answer:**
1. **Nairobi Convention** — Requires biennial reports on ICZM and MPA effectiveness
2. **CBD** — Requires periodic reports on protected area networks and progress toward biodiversity targets
3. **SAPPHIRE** — Requires ecosystem monitoring data supporting alternative livelihood pilots

**Status:** Madagascar compliant with biennial Nairobi Convention CoP reporting; CBD NBSAP implementation ~60% complete; SAPPHIRE data collection underway (mud crab pilot in Ménabe).

### Example 3: "Show me all the gaps preventing coral reef ecosystem accounting"

**Answer:**
| Gap | Policy | Impact | Resolution Timeline |
|---|---|---|---|
| Sentinel-2 extent mapping incomplete | ICZM Decree 2010-137 | Cannot finalize reef area estimate | Mar 2026 (satellite processing) |
| Landing site data not collected systematically | Decree 2016-1492 | Cannot value provisioning services | Apr–Jun 2026 (MPRH enforcement) |
| Market price data missing | Blue Policy 2015 | Cannot calculate service value | Mar–Apr 2026 (market survey) |
| No-reef baseline transects not surveyed | NBSAP 2015-2025 | Cannot estimate nursery service impact | Apr–May 2026 (field campaign) |

---

## Data Quality & Maintenance

### Reliability Scores (All Records)
- **0.95–1.0** — Official government source or treaty database (Nairobi Convention, CBD, Official Gazette)
- **0.80–0.95** — Peer-reviewed or reputable secondary source (MDPI, WWF, WCS reporting)
- **0.60–0.80** — News/NGO reporting (Mongabay, Blue Ventures blogs)
- **<0.60** — Anecdotal or unverified (not in this dataset)

**Sample Data Quality:**
- Law 2015-053: 0.95 (official + multiple scholarly sources)
- Nairobi Convention: 0.99 (official treaty database)
- Trawl-free zone: 0.75 (news reports + NGO confirmation; enforcement verification needed)

### Update Cycle
- **Quarterly:** Monitor Madagascar Official Gazette, Nairobi Convention decisions
- **Monthly:** Check MPRH announcements, policy amendments
- **Annually:** Field verification of implementation status with MPRH

### Known Data Gaps
1. **Full text URLs** — Some official policy documents not yet digitized (pre-2015)
2. **Implementation status metrics** — Based on programmatic reports; formal government statistics not yet available
3. **Enforcement data** — Landing site compliance and MPA patrol reports not publicly available
4. **Regional variation** — Implementation status varies by region (SW Madagascar better-resourced); average presented

---

## Integration with Project Workflows

### For the SEEA EA Team
- Use `policy_rag_sample_data.json` to populate your database
- Reference implementation gaps when designing field surveys (e.g., landing site monitoring)
- Link policy status to condition account confidence intervals

### For the Protected Area Analysis Team
- Query ecosystem coverage records to link policies → WDPA polygons
- Use MPA expansion target to estimate extent growth scenarios
- Reference policy timeline (MPA target: 2025) for scenario planning

### For Services Accounting
- Map Blue Policy objectives (livelihood, alternative income) to service provisioning pathways
- Use LMMA framework as basis for community-level benefit-sharing data collection
- Reference Decree 2016-1492 landing site requirements for catch monitoring protocol

---

## Technical Stack Recommendations

| Component | Recommendation | Alternative |
|---|---|---|
| **Vector DB** | Pinecone | Weaviate, Milvus, Qdrant |
| **Structured DB** | PostgreSQL + JSONB | MongoDB (NoSQL), SQLite (simple) |
| **Embeddings** | sentence-transformers (all-MiniLM-L6-v2) | OpenAI embeddings (higher cost) |
| **Backend API** | FastAPI or Flask | Django, Node.js |
| **Frontend** | Streamlit (rapid prototyping) | React/Vue (production scale) |
| **Hosting** | AWS (RDS + EC2) | Azure, GCP, or self-hosted |

---

## Contact & Feedback

**Questions about policies?** Contact:
- MPRH (Madagascar Ministry of Fisheries & Marine Resources)
- Nairobi Convention Secretariat (regional coordination)
- Blue Ventures (Madagascar implementation partners)

**Questions about this RAG system?** See:
- `policy_rag_implementation_guide.md` (technical setup)
- `policy_rag_schema.md` (data structure)
- `policy_rag_sample_data.json` (example records)

---

## Version History

| Version | Date | Changes |
|---|---|---|
| 1.0 | 2026-03-15 | Initial release: 9 policies + 5 commitments + implementation guide |
| — | TBD | Automated Gazette monitoring, policy amendment tracking |
| — | TBD | Integration with WDPA database for protected area linkages |
| — | TBD | Time-series implementation status tracking |

