# RAG Schema: Madagascar Coastal & Marine Policies

## Overview
This schema structures Madagascar's national coastal and marine policies and international commitments for Retrieval Augmented Generation (RAG), enabling semantic search, filtering, and cross-linking between policy instruments and compliance obligations.

---

## Core Entity Schema

### 1. **Policy Document**

```json
{
  "policy_id": "string (unique identifier)",
  "policy_name": "string",
  "policy_type": "enum: [LEGISLATION, DECREE, STRATEGY, COMMITMENT, ACTION_PLAN]",
  "country": "Madagascar",
  "issuing_body": "string (e.g., Ministry of Fisheries and Marine Resources)",
  "adoption_date": "YYYY-MM-DD",
  "effective_date": "YYYY-MM-DD",
  "status": "enum: [ACTIVE, SUPERSEDED, PROPOSED, EXPIRED]",
  "legal_instrument_number": "string (e.g., Law n° 2015-053, Decree N° 2010-137)",
  "document_url": "string (URL to official document or source)",
  "document_source": "string (e.g., Official Gazette, Government Portal, Nairobi Convention)",
  "full_text_url": "string (link to full PDF if available)",
  "policy_summary": "string (200-300 words)",
  "key_objectives": ["string array"],
  "target_ecosystems": ["string array (e.g., coral reef, seagrass, mangrove)]",
  "implementation_status": "string (percentage or descriptive status)",
  "responsible_ministries": ["string array"],
  "linked_policies": ["policy_id array (cross-references)"],
  "international_commitments": ["commitment_id array"],
  "spatial_scope": "string (e.g., EEZ, coastal zone, specific regions)",
  "temporal_scope": "string (e.g., 2015-2025 for NBSAP)",
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
  "madagascar_ratification_status": "enum: [SIGNATORY, RATIFIED, ACCEDED, NOT_SIGNED]",
  "commitment_url": "string (URL to official commitment text)",
  "document_source": "string (e.g., UN Treaty Database, UNEP Secretariat)",
  "full_text_url": "string",
  "commitment_summary": "string (200-300 words)",
  "key_obligations": ["string array"],
  "target_ecosystems": ["string array"],
  "reporting_requirements": ["string array"],
  "compliance_deadline": "YYYY-MM-DD or null",
  "implementing_policies": ["policy_id array"],
  "regional_context": "string (e.g., Western Indian Ocean, Eastern Africa)",
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
  "reference_number": "string (e.g., Law n° 2015-053)",
  "issuing_authority": "string",
  "adoption_date": "YYYY-MM-DD",
  "document_source": "string (e.g., Official Gazette, Government of Madagascar)",
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
- **LEGISLATION** — Primary law (e.g., Law n° 2015-053)
- **DECREE** — Executive decree (e.g., Decree N° 2010-137)
- **STRATEGY** — Strategic framework (e.g., Blue Policy, NBSAP)
- **COMMITMENT** — International commitment
- **ACTION_PLAN** — Implementation roadmap

### Commitment Types
- **TREATY** — Binding international agreement
- **PROTOCOL** — Protocol to a treaty (e.g., Nairobi Convention protocols)
- **AGREEMENT** — Bilateral/multilateral agreement
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

## Example Records

### Example 1: National Policy Document

```json
{
  "policy_id": "policy_001",
  "policy_name": "Law on Fisheries and Aquaculture Code",
  "policy_type": "LEGISLATION",
  "country": "Madagascar",
  "issuing_body": "Ministry of Fisheries and Marine Resources",
  "adoption_date": "2015-12-02",
  "effective_date": "2015-12-02",
  "status": "ACTIVE",
  "legal_instrument_number": "Law n° 2015-053",
  "document_url": "https://theoutlawocean.com/toolkit/global-fishing-legislation/madagascar/fisheries-and-aquaculture-code",
  "document_source": "Government of Madagascar Official Gazette; The Outlaw Ocean Project",
  "policy_summary": "Core fisheries legislation granting MPRH authority to develop and enforce fisheries management and conservation plans. Includes provisions for species protection, gear restrictions, marine spatial management, and fisher training requirements.",
  "key_objectives": [
    "Regulate fishing and aquaculture activities",
    "Ensure sustainable resource management",
    "Establish conservation plans for fish stocks",
    "Promote fisher training and infrastructure development"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "75% (Decree 2016-1492 provides implementing details)",
  "responsible_ministries": [
    "Ministry of Fisheries and Marine Resources (MPRH)",
    "Ministry of Environment, Ecology, Forests and the Sea"
  ],
  "linked_policies": [
    "policy_002",
    "policy_003",
    "policy_004"
  ],
  "international_commitments": [
    "commitment_001",
    "commitment_003"
  ],
  "spatial_scope": "Madagascar EEZ (200 nautical miles) + territorial waters",
  "temporal_scope": "2015-present (indefinite)",
  "metadata": {
    "created_date": "2026-03-15",
    "last_updated": "2026-03-15",
    "data_source": "Government of Madagascar; The Outlaw Ocean Project; MDPI scholarly review",
    "reliability_score": 0.95,
    "notes": "Primary fisheries legal framework; actively enforced by MPRH"
  }
}
```

### Example 2: International Commitment

```json
{
  "commitment_id": "commitment_001",
  "commitment_name": "Nairobi Convention for the Eastern African Region",
  "commitment_type": "TREATY",
  "organization": "UNEP (United Nations Environment Programme)",
  "signature_date": "1985-06-21",
  "ratification_date": "1999-03-24",
  "entry_into_force_date": "1996-05-30",
  "madagascar_ratification_status": "RATIFIED",
  "commitment_url": "https://www.nairobiconvention.org/",
  "document_source": "UNEP Regional Seas Programme; Nairobi Convention Secretariat",
  "full_text_url": "https://www.nairobiconvention.org/documents/",
  "commitment_summary": "Regional framework for protection and sustainable management of marine and coastal environments in the Eastern African region. Covers pollution prevention, protected area management, coastal zone planning, and integration of climate change adaptation. Contracting Parties: Comoros, France, Kenya, Madagascar, Mauritius, Mozambique, Seychelles, Somalia, Tanzania, South Africa.",
  "key_obligations": [
    "Develop Integrated Coastal Zone Management (ICZM) strategies",
    "Establish and manage Marine Protected Areas (MPAs)",
    "Monitor and control marine pollution",
    "Implement Locally Managed Marine Areas (LMMAs)",
    "Conduct marine ecosystem assessments",
    "Report on implementation progress"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "reporting_requirements": [
    "Biennial national reports to CoP",
    "ICZM strategy updates",
    "MPA status reports",
    "Marine pollution incident reports"
  ],
  "compliance_deadline": null,
  "implementing_policies": [
    "policy_002",
    "policy_004",
    "policy_005"
  ],
  "regional_context": "Western Indian Ocean; Eastern Africa region",
  "enforcement_mechanism": "Conference of Parties (CoP) reviews; subsidiary bodies monitor compliance; scientific advice through WIOMSA",
  "metadata": {
    "created_date": "2026-03-15",
    "last_updated": "2026-03-15",
    "data_source": "UNEP Nairobi Convention Secretariat; UN Treaty Collection",
    "reliability_score": 0.99,
    "notes": "Madagascar a founding/early signatory; COP11 to be hosted in Antananarivo"
  }
}
```

### Example 3: Policy-Commitment Linkage

```json
{
  "linkage_id": "linkage_001",
  "policy_id": "policy_002",
  "commitment_id": "commitment_001",
  "relationship_type": "IMPLEMENTS",
  "alignment_strength": "DIRECT",
  "implementation_gap": "ICZM Decree (2010-137) partially implements Nairobi Convention ICZM obligations; coastal zone mapping and multi-sector coordination frameworks are in place but enforcement across administrative levels remains inconsistent.",
  "cross_reference_section": "Nairobi Convention Article 3 (ICZM); Madagascar Decree N° 2010-137",
  "notes": "Madagascar's ICZM framework was explicitly developed to meet Nairobi Convention obligations initiated in 2002. Regular reporting to CoP occurs."
}
```

---

## Search & Indexing Strategy

### Key Search Dimensions
1. **Ecosystem-based** — "What policies govern seagrass protection?"
2. **Commitment-based** — "Which national policies implement the Nairobi Convention?"
3. **Temporal** — "What policies were enacted since 2015?"
4. **Instrument-based** — "What decrees regulate fishing in MPAs?"
5. **Agency-based** — "Which policies does MPRH enforce?"
6. **Status-based** — "Which policies are active vs. superseded?"

### Semantic Fields for RAG Indexing
- **policy_summary** — Primary text for semantic search
- **key_objectives** — Intent-based matching
- **target_ecosystems** — Ecosystem filtering
- **keywords** — Explicit semantic tags
- **implementation_gap** — Gap analysis queries

---

## Integration with SEEA EA Condition Accounts

| SEEA Component | Policy Coverage | Commitment Coverage |
|---|---|---|
| **Extent (M1.3 reef habitat)** | Decree 2010-137 (ICZM), Law 2015-053 (benthic mapping authority), NBSAP 2015-2025 | Nairobi Convention (coastal planning); CBD (biodiversity assessment) |
| **Condition (fish/invert)** | Law 2015-053 (stock conservation), Decree 2016-1492 (gear/size limits), Blue Policy 2015 | Nairobi Convention (ecosystem monitoring); CITES (species protection) |
| **Services (provisioning/regulating)** | Law 2015-053 (landings data authority), Blue Policy (livelihood objectives), NBSAP | SAPPHIRE project (alternative livelihoods), IOC agreements (fisheries cooperation) |
| **Valuation (economic)** | Blue Policy (SDG alignment), NBSAP 2015-2025 (USD 203M allocation) | — |

---

## Data Quality & Maintenance

- **Reliability Score Scale:**
  - **0.95–1.0** — Official government source or treaty database
  - **0.80–0.95** — Peer-reviewed or reputable secondary source
  - **0.60–0.80** — News/NGO reporting, preliminary data
  - **<0.60** — Anecdotal or unverified

- **Update Frequency:** Quarterly (monitor official gazettes, Nairobi Convention CoP decisions)
- **Verification Process:** Cross-reference against original sources; contact MPRH/Ministry of Environment for confirmation
- **Owner:** Data curator (e.g., SEEA EA project team)

---

## Implementation Notes

**Tool Recommendations:**
- **Vector DB:** Pinecone, Weaviate, or Milvus for semantic search
- **Structured Storage:** PostgreSQL (policies/commitments) + JSONB (metadata)
- **Crawler/Parser:** Custom script to monitor Madagascar Official Gazette + Nairobi Convention updates
- **API:** FastAPI or Flask for RAG query interface
- **Frontend:** Streamlit dashboard or custom web interface for policy browsing/filtering

**Expected Query Patterns:**
- "What commitments require Madagascar to report on coral reef extent by 2027?"
- "Which policies govern juvenile fish protection in seagrass nurseries?"
- "Show all ICZM-related decrees and their implementation status"
- "Link Nairobi Convention Article 3 to Madagascar's implementing policies"
- "What are the penalties for illegal fishing in designated protected areas?"

