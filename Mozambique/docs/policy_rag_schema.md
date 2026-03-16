# RAG Schema: Mozambique Coastal & Marine Policies

## Overview
This schema structures Mozambique's national coastal and marine policies and international commitments for Retrieval Augmented Generation (RAG), enabling semantic search, filtering, and cross-linking between policy instruments and compliance obligations.

---

## Core Entity Schema

### 1. **Policy Document**

```json
{
  "policy_id": "string (unique identifier)",
  "policy_name": "string",
  "policy_type": "enum: [LEGISLATION, DECREE, STRATEGY, COMMITMENT, ACTION_PLAN]",
  "country": "Mozambique",
  "issuing_body": "string (e.g., Ministry of Marine and Fisheries)",
  "adoption_date": "YYYY-MM-DD",
  "effective_date": "YYYY-MM-DD",
  "status": "enum: [ACTIVE, SUPERSEDED, PROPOSED, EXPIRED]",
  "legal_instrument_number": "string (e.g., Law No. 22/2013, Decree No. 54/2015)",
  "document_url": "string (URL to official document or source)",
  "document_source": "string (e.g., Official Gazette, Government Portal, FAO FAOLEX, Nairobi Convention)",
  "full_text_url": "string (link to full PDF if available)",
  "policy_summary": "string (200-300 words)",
  "key_objectives": ["string array"],
  "target_ecosystems": ["string array (e.g., coral reef, seagrass, mangrove)"],
  "implementation_status": "string (percentage or descriptive status)",
  "responsible_ministries": ["string array"],
  "linked_policies": ["policy_id array (cross-references)"],
  "international_commitments": ["commitment_id array"],
  "spatial_scope": "string (e.g., EEZ, coastal zone, specific regions)",
  "temporal_scope": "string (e.g., 2013-present or 2020-2030)",
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
  "commitment_name": "string (e.g., Nairobi Convention, CBD, UNCLOS)",
  "commitment_type": "enum: [TREATY, AGREEMENT, PROTOCOL, DECLARATION, FRAMEWORK]",
  "organization": "string (e.g., UNEP, IOC, CBD Secretariat, UN)",
  "signature_date": "YYYY-MM-DD",
  "ratification_date": "YYYY-MM-DD",
  "entry_into_force_date": "YYYY-MM-DD",
  "mozambique_ratification_status": "enum: [SIGNATORY, RATIFIED, ACCEDED, NOT_SIGNED]",
  "commitment_url": "string (URL to official commitment text)",
  "document_source": "string (e.g., UN Treaty Database, UNEP Secretariat, UNSDRI)",
  "full_text_url": "string",
  "commitment_summary": "string (200-300 words)",
  "key_obligations": ["string array"],
  "target_ecosystems": ["string array"],
  "reporting_requirements": ["string array"],
  "compliance_deadline": "YYYY-MM-DD or null",
  "implementing_policies": ["policy_id array"],
  "regional_context": "string (e.g., Western Indian Ocean, Southern Africa)",
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
  "ecosystem_name": "string (e.g., Photic Coral Reefs M1.3, Seagrass beds M1.1)",
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
  "reference_number": "string (e.g., Law No. 22/2013)",
  "issuing_authority": "string",
  "adoption_date": "YYYY-MM-DD",
  "document_source": "string (e.g., Official Gazette, Government of Mozambique)",
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
- **LEGISLATION** — Primary law (e.g., Fisheries Law No. 22/2013)
- **DECREE** — Executive decree (e.g., Decree No. 54/2015)
- **STRATEGY** — Strategic framework (e.g., POLMAR, MSP framework)
- **COMMITMENT** — International commitment
- **ACTION_PLAN** — Implementation roadmap (e.g., Coral Reef Strategy & Action Plan)

### Commitment Types
- **TREATY** — Binding international agreement (e.g., UNCLOS)
- **PROTOCOL** — Protocol to a treaty (e.g., Nairobi Convention protocols)
- **AGREEMENT** — Bilateral/multilateral agreement
- **DECLARATION** — Non-binding statement
- **FRAMEWORK** — Overarching framework (e.g., UN SDGs)

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

### Example 1: National Policy Document (Fisheries Law)

```json
{
  "policy_id": "moz_policy_001",
  "policy_name": "Fisheries Law",
  "policy_type": "LEGISLATION",
  "country": "Mozambique",
  "issuing_body": "Ministry of Marine and Fisheries (MMF)",
  "adoption_date": "2013-11-15",
  "effective_date": "2013-11-15",
  "status": "ACTIVE",
  "legal_instrument_number": "Law No. 22/2013",
  "document_url": "https://www.ecolex.org/details/legislation/fisheries-law-no-222013-lex-faoc128917/",
  "document_source": "FAO FAOLEX Database; Government of Mozambique Official Gazette",
  "full_text_url": "https://theoutlawocean.com/toolkit/global-fishing-legislation/mozambique/fisheries-law-no-22-2013",
  "policy_summary": "Core fisheries legislation establishing the legal regime for all fishing activities in Mozambican waters. Comprises 4 Titles with 112 articles establishing fishing activity governance, species protection, ecosystem approach to fisheries management (EAF), management plans, marine spatial planning, and sustainable resource use. Prohibits illegal mangrove harvesting and unsustainable fishing in mangrove areas. Requires management plans to account for biological, economic, social, and environmental aspects including life cycles of species and exploitation strategies.",
  "key_objectives": [
    "Establish legal regime for fishing activities in Mozambican waters",
    "Implement Ecosystem Approach to Fisheries Management (EAF)",
    "Develop and enforce fisheries management and conservation plans",
    "Protect species and manage marine spatial resources",
    "Ensure sustainable use of biological aquatic resources",
    "Protect seagrass and mangrove ecosystems from destructive practices"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "70% (operational; enforcement gaps remain in enforcement)",
  "responsible_ministries": [
    "Ministry of Marine and Fisheries (MMF)",
    "National Institute for Fisheries Research (IIP)"
  ],
  "linked_policies": [
    "moz_policy_002",
    "moz_policy_003"
  ],
  "international_commitments": [
    "moz_commitment_001",
    "moz_commitment_002",
    "moz_commitment_003"
  ],
  "spatial_scope": "Mozambique EEZ (200 nautical miles) + territorial waters",
  "temporal_scope": "2013-present (indefinite)",
  "metadata": {
    "created_date": "2026-03-15",
    "last_updated": "2026-03-15",
    "data_source": "FAO FAOLEX; Government of Mozambique; PLOS Climate 2024; The Outlaw Ocean Project",
    "reliability_score": 0.95,
    "notes": "Primary fisheries legal framework; enforced by MMF and IIP"
  }
}
```

### Example 2: National Policy Document (Environmental Framework)

```json
{
  "policy_id": "moz_policy_002",
  "policy_name": "Framework Environmental Act",
  "policy_type": "LEGISLATION",
  "country": "Mozambique",
  "issuing_body": "Ministry of Environment, Ecology, Forests and the Sea",
  "adoption_date": "1997-01-15",
  "effective_date": "1997-01-15",
  "status": "ACTIVE",
  "legal_instrument_number": "Law No. 20/97",
  "document_url": "https://www.ecolex.org/details/legislation/environmental-act-lex-faoc011016/",
  "document_source": "FAO FAOLEX Database; Government of Mozambique",
  "full_text_url": null,
  "policy_summary": "Foundation environmental protection framework establishing legal basis for environmental assessment, protection, and management. Works in conjunction with Decree 54/2015 (EIA regulation) to govern environmental impact assessment of marine and coastal projects. Applies to all development activities affecting marine and coastal habitats.",
  "key_objectives": [
    "Establish environmental protection framework",
    "Require Environmental Impact Assessment (EIA) for development projects",
    "Manage environmental risks to coastal and marine ecosystems",
    "Protect marine and coastal habitats from harmful activities"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "60% (EIA required but enforcement patchy)",
  "responsible_ministries": [
    "Ministry of Environment, Ecology, Forests and the Sea"
  ],
  "linked_policies": [
    "moz_policy_001",
    "moz_policy_004"
  ],
  "international_commitments": [
    "moz_commitment_001",
    "moz_commitment_004"
  ],
  "spatial_scope": "National territory; coastal zone focus",
  "temporal_scope": "1997-present (indefinite)",
  "metadata": {
    "created_date": "2026-03-15",
    "last_updated": "2026-03-15",
    "data_source": "FAO FAOLEX; Government of Mozambique",
    "reliability_score": 0.90,
    "notes": "Foundational law; specific EIA procedures in Decree 54/2015"
  }
}
```

### Example 3: National Strategy (POLMAR)

```json
{
  "policy_id": "moz_policy_003",
  "policy_name": "Policy and Strategy of the Sea (POLMAR)",
  "policy_type": "STRATEGY",
  "country": "Mozambique",
  "issuing_body": "Government of Mozambique (Inter-ministerial)",
  "adoption_date": "2020-01-01",
  "effective_date": "2020-01-01",
  "status": "ACTIVE",
  "legal_instrument_number": "POLMAR",
  "document_url": "https://sdgs.un.org/partnerships/mozambican-marine-spatial-planning-coastal-and-ocean-management",
  "document_source": "UN SDGS Partnership Platform; Government of Mozambique",
  "full_text_url": null,
  "policy_summary": "Strategic framework for strengthening state sovereignty over Mozambican waters and developing a 'blue, profitable and sustainable economy at sea.' Establishes normative framework for use of marine resources aligned with UN SDGs. Drives development of Marine Spatial Planning (MSP) for coastal and ocean management, including coral reef zonation, seagrass protection, and integrated coastal zone management.",
  "key_objectives": [
    "Strengthen state sovereignty over marine resources",
    "Develop blue economy in sustainable manner",
    "Align maritime activities with UN SDGs",
    "Establish Marine Spatial Planning framework",
    "Integrate ecosystem protection into economic development",
    "Implement coral reef and seagrass conservation through MSP"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "50% (MSP framework in development; ongoing coordination)",
  "responsible_ministries": [
    "Ministry of Marine and Fisheries (MMF)",
    "Ministry of Economy and Finance",
    "Ministry of Environment, Ecology, Forests and the Sea",
    "Ministry of Land, Environment and Rural Development"
  ],
  "linked_policies": [
    "moz_policy_001",
    "moz_policy_002"
  ],
  "international_commitments": [
    "moz_commitment_001",
    "moz_commitment_005"
  ],
  "spatial_scope": "Mozambique EEZ; coastal zones",
  "temporal_scope": "2020-present; 2030 vision",
  "metadata": {
    "created_date": "2026-03-15",
    "last_updated": "2026-03-15",
    "data_source": "UN SDGS Platform; Government of Mozambique; WWF SWIO",
    "reliability_score": 0.85,
    "notes": "Overarching strategic framework; drives MSP integration of coral reef and seagrass protection"
  }
}
```

### Example 4: International Commitment (Nairobi Convention)

```json
{
  "commitment_id": "moz_commitment_001",
  "commitment_name": "Nairobi Convention for the Eastern African Region",
  "commitment_type": "TREATY",
  "organization": "UNEP (United Nations Environment Programme)",
  "signature_date": "1985-06-21",
  "ratification_date": "1994-02-14",
  "entry_into_force_date": "1996-05-30",
  "mozambique_ratification_status": "RATIFIED",
  "commitment_url": "https://www.nairobiconvention.org/",
  "document_source": "UNEP Regional Seas Programme; Nairobi Convention Secretariat; UN Treaty Collection",
  "full_text_url": "https://www.nairobiconvention.org/documents/",
  "commitment_summary": "Regional framework for protection and sustainable management of marine and coastal environments in the Eastern African region, covering Western Indian Ocean. Establishes obligations for Integrated Coastal Zone Management (ICZM), Marine Protected Areas (MPAs), pollution prevention, climate change adaptation, and ecosystem monitoring. Contracting Parties include Comoros, France, Kenya, Madagascar, Mauritius, Mozambique, Seychelles, Somalia, Tanzania, and South Africa.",
  "key_obligations": [
    "Develop and implement Integrated Coastal Zone Management (ICZM) strategies",
    "Establish and manage Marine Protected Areas (MPAs) covering 23% of maritime jurisdiction",
    "Monitor and control marine pollution",
    "Implement Locally Managed Marine Areas (LMMAs)",
    "Conduct marine ecosystem assessments for coral reefs and seagrass",
    "Report on implementation progress to Conference of Parties (CoP)",
    "Integrate climate change adaptation into coastal planning",
    "Coordinate regional marine spatial planning"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "reporting_requirements": [
    "Biennial national reports to CoP on ICZM implementation",
    "MPA and LMMA status reports",
    "Marine ecosystem condition assessments",
    "Coral reef and seagrass monitoring data",
    "Marine pollution incident reports"
  ],
  "compliance_deadline": null,
  "implementing_policies": [
    "moz_policy_001",
    "moz_policy_002",
    "moz_policy_003"
  ],
  "regional_context": "Western Indian Ocean; Southern Africa region",
  "enforcement_mechanism": "Conference of Parties (CoP) reviews; subsidiary bodies monitor compliance; scientific advice through WIOMSA; sanctions for non-compliance",
  "metadata": {
    "created_date": "2026-03-15",
    "last_updated": "2026-03-15",
    "data_source": "UNEP Nairobi Convention Secretariat; UN Treaty Collection; Nairobi Convention Country Profile",
    "reliability_score": 0.99,
    "notes": "Mozambique ratified 1994; active participant in regional conservation initiatives"
  }
}
```

### Example 5: International Commitment (UN Convention on Biological Diversity)

```json
{
  "commitment_id": "moz_commitment_002",
  "commitment_name": "Convention on Biological Diversity (CBD)",
  "commitment_type": "TREATY",
  "organization": "CBD Secretariat (UN Environment Programme administered)",
  "signature_date": "1992-06-05",
  "ratification_date": "1995-09-20",
  "entry_into_force_date": "1993-12-29",
  "mozambique_ratification_status": "RATIFIED",
  "commitment_url": "https://www.cbd.int/",
  "document_source": "CBD Secretariat; UN Treaty Collection",
  "full_text_url": "https://www.cbd.int/convention/text/",
  "commitment_summary": "Global framework for biodiversity conservation, sustainable use, and equitable benefit-sharing. Requires signatory countries to develop National Biodiversity Strategy and Action Plans (NBSAP). Particularly relevant for marine ecosystems including coral reef conservation, seagrass protection, and species protection (CITES linkages). Post-2020 Global Biodiversity Framework includes Target 3 (30% protected areas by 2030) and related conservation targets.",
  "key_obligations": [
    "Develop and implement National Biodiversity Strategy and Action Plan (NBSAP)",
    "Establish protected area systems covering marine ecosystems",
    "Monitor and report on biodiversity status, particularly for species in coral reefs and seagrass",
    "Implement CITES for threatened species (e.g., sea turtles, sharks)",
    "Integrate biodiversity into sectoral planning (fisheries, tourism, development)",
    "Report on implementation progress to Conference of the Parties (CoP)",
    "Contribute to post-2020 Global Biodiversity Framework targets (30% protection by 2030)"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "reporting_requirements": [
    "National Biodiversity Strategy and Action Plan (NBSAP) updates",
    "Sixth National Report (2023) and subsequent periodic reports",
    "Coral reef and seagrass extent and condition data",
    "Species monitoring data for marine threatened species",
    "MPA coverage and connectivity reports"
  ],
  "compliance_deadline": "2030 (Global Biodiversity Framework targets)",
  "implementing_policies": [
    "moz_policy_001",
    "moz_policy_003"
  ],
  "regional_context": "Global; Western Indian Ocean implementation",
  "enforcement_mechanism": "Conference of Parties (CoP) reviews; National Reports; Access and Benefit-Sharing (ABS) provisions; Nagoya Protocol; peer review",
  "metadata": {
    "created_date": "2026-03-15",
    "last_updated": "2026-03-15",
    "data_source": "CBD Secretariat; UN Treaty Collection",
    "reliability_score": 0.99,
    "notes": "Mozambique ratified 1995; active NBSAP development; Post-2020 GBF alignment underway"
  }
}
```

### Example 6: Policy-Commitment Linkage

```json
{
  "linkage_id": "moz_linkage_001",
  "policy_id": "moz_policy_001",
  "commitment_id": "moz_commitment_001",
  "relationship_type": "IMPLEMENTS",
  "alignment_strength": "DIRECT",
  "implementation_gap": "Fisheries Law 22/2013 directly implements Nairobi Convention EAF and species protection obligations. However, enforcement capacity remains limited due to under-resourced monitoring and control. ICZM integration incomplete; seagrass protection mechanisms in Law exist but are under-utilized in practice.",
  "cross_reference_section": "Nairobi Convention Article 5 (EAF); Mozambique Law 22/2013 Articles 1-15 (fisheries management framework)",
  "notes": "Mozambique's fisheries management framework explicitly aligned with Nairobi Convention; regular reporting to CoP conducted"
}
```

---

## Search & Indexing Strategy

### Key Search Dimensions
1. **Ecosystem-based** — "What policies govern seagrass protection in Mozambique?"
2. **Commitment-based** — "Which national policies implement the Nairobi Convention?"
3. **Temporal** — "What policies were enacted since 2013?"
4. **Instrument-based** — "What decrees regulate fishing in MPAs?"
5. **Agency-based** — "Which policies does MMF enforce?"
6. **Status-based** — "Which policies are active vs. superseded?"
7. **Geographic** — "What protection applies to Inhambane and Maputo bays?"

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
| **Extent (M1.3 reef habitat, M1.1 seagrass)** | Law 22/2013 (benthic mapping authority), POLMAR (MSP + habitat mapping), Land Law 19/97 (mangrove mapping) | Nairobi Convention (coastal planning); CBD (biodiversity assessment) |
| **Condition (fish/invert biotic indicators)** | Law 22/2013 (stock assessment authority, EAF), IIP research programs | Nairobi Convention (ecosystem monitoring); CITES (species protection) |
| **Services (provisioning/regulating)** | Law 22/2013 (landings data authority), POLMAR (livelihood + economy goals) | CBD NBSAP (ecosystem services); Nairobi Convention (livelihood support) |
| **Valuation (economic)** | POLMAR (blue economy framework), MMF economic planning | CBD (benefit-sharing); UNCLOS (marine resource jurisdiction) |

---

## International Commitments — Quick Reference

| Commitment | Type | Year Ratified | Key Obligations for Coral/Seagrass |
|---|---|---|---|
| **Nairobi Convention** | TREATY | 1994 | ICZM; MPAs (23% target); ecosystem monitoring; LMMA support |
| **CBD** | TREATY | 1995 | NBSAP; species protection; 30% protected areas by 2030; reporting |
| **UNCLOS** | TREATY | 1997 | EEZ sovereignty; marine resource management; pollution prevention |
| **CITES** | TREATY | 2001 | Marine species protection (sea turtles, sharks, etc.) |
| **RAMSAR** | TREATY | 1991 | Wetland/mangrove ecosystem protection in coastal zones |
| **UN SDGs** | FRAMEWORK | 2015 | SDG 14 (marine conservation); SDG 13 (climate adaptation) |

---

## Data Quality & Maintenance

- **Reliability Score Scale:**
  - **0.95–1.0** — Official government source or treaty database
  - **0.80–0.95** — Peer-reviewed or reputable secondary source
  - **0.60–0.80** — News/NGO reporting, preliminary data
  - **<0.60** — Anecdotal or unverified

- **Update Frequency:** Quarterly (monitor official gazettes, Nairobi Convention CoP decisions, CBD CoP updates)
- **Verification Process:** Cross-reference against original sources; contact MMF/Ministry of Environment for confirmation
- **Owner:** Data curator (e.g., SEEA EA project team)

---

## Implementation Notes

**Tool Recommendations:**
- **Vector DB:** Pinecone, Weaviate, or Milvus for semantic search
- **Structured Storage:** PostgreSQL (policies/commitments) + JSONB (metadata)
- **Crawler/Parser:** Custom script to monitor Mozambique Official Gazette + Nairobi Convention updates
- **API:** FastAPI or Flask for RAG query interface
- **Frontend:** Streamlit dashboard or custom web interface for policy browsing/filtering

**Expected Query Patterns:**
- "What commitments require Mozambique to report on coral reef extent by 2030?"
- "Which policies govern seagrass protection in Inhambane bay?"
- "Show all ICZM-related strategies and their implementation status"
- "Link Nairobi Convention Article 5 to Mozambique's implementing policies"
- "What are the penalties for illegal fishing in marine protected areas?"
- "Which international agreements protect seagrass nursery areas?"

**Data Acquisition Priority (Next 3 Months):**
1. Compile full text URLs for Laws 22/2013, 20/97, 19/97, and Decree 54/2015
2. Obtain POLMAR full document from Government of Mozambique or UNSDRI
3. Map Mozambique's NBSAP to coral/seagrass priorities
4. Identify Coral Reef Strategy & Action Plan document
5. Cross-reference with WCS and JNCC coordination reports

---

## Comprehensive Policy Records (Enhanced with Deep Research)

### Example 7: Maritime Zones & Jurisdiction (Law No. 20/2019)

```json
{
  "policy_id": "moz_policy_004",
  "policy_name": "Law of the Sea (Revised)",
  "policy_type": "LEGISLATION",
  "country": "Mozambique",
  "issuing_body": "Government of Mozambique / Parliament",
  "adoption_date": "2019-11-08",
  "effective_date": "2019-11-08",
  "status": "ACTIVE",
  "legal_instrument_number": "Law No. 20/2019",
  "document_url": "https://www.ecolex.org/details/legislation/",
  "document_source": "Government of Mozambique Official Gazette; EcoLex Database",
  "full_text_url": null,
  "policy_summary": "Comprehensive maritime zones and jurisdiction law establishing Mozambique's legal regime for exercising sovereignty and jurisdiction over national maritime space, including living and non-living marine resources and use of maritime public domain. Supersedes earlier Lei do Mar framework (Decree-Law 31/76). Explicitly links to UNCLOS interpretation. Contains provisions on baseline coordinate approval, deposit with UN, marine pollution control, and marine scientific research authorization. Applies to coral reef and seagrass ecosystems in territorial sea and continental shelf.",
  "key_objectives": [
    "Establish sovereignty and jurisdiction over maritime space",
    "Regulate use of living and non-living marine resources",
    "Control marine pollution in national waters",
    "Regulate marine scientific research",
    "Implement UNCLOS framework in national law",
    "Manage maritime public domain"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "80% (operational; UNCLOS-aligned baseline governance in place)",
  "responsible_ministries": [
    "Ministry of Sea, Inland Waters and Fisheries",
    "Ministry of Environment, Ecology, Forests and the Sea"
  ],
  "linked_policies": [
    "moz_policy_001",
    "moz_policy_003",
    "moz_policy_005"
  ],
  "international_commitments": [
    "moz_commitment_005",
    "moz_commitment_006"
  ],
  "spatial_scope": "Territorial sea (12 nm), Continental shelf, EEZ (200 nm), maritime public domain",
  "temporal_scope": "2019-present",
  "metadata": {
    "created_date": "2026-03-16",
    "last_updated": "2026-03-16",
    "data_source": "Deep Research Report on Mozambique Ocean Policy (2026); Government of Mozambique",
    "reliability_score": 0.95,
    "notes": "Primary legal basis for maritime zones; UNCLOS-aligned; supersedes Decree-Law 31/76"
  }
}
```

### Example 8: Marine Spatial Planning (Decree No. 21/2017 — RJUEM)

```json
{
  "policy_id": "moz_policy_005",
  "policy_name": "Regime for Use of National Maritime Space (RJUEM)",
  "policy_type": "DECREE",
  "country": "Mozambique",
  "issuing_body": "Council of Ministers",
  "adoption_date": "2017-05-24",
  "effective_date": "2017-05-24",
  "status": "ACTIVE",
  "legal_instrument_number": "Decree No. 21/2017",
  "document_url": "https://www.ecolex.org/details/",
  "document_source": "Government of Mozambique Official Gazette",
  "full_text_url": null,
  "policy_summary": "Operational framework for marine spatial planning (MSP) in Mozambique. Establishes mechanisms for ordering and managing national maritime space including Plano de Situação (baseline situation plan) and Planos de Afectação (allocation plans) for uses/activities. Includes cadastre of marine uses with geo-spatial representations. Mandates public consultation and transparency procedures. Integrated with fisheries zoning, conservation areas, and coastal construction licensing. Foundation for Plano de Ordenamento do Espaço Marítimo (POEM) approved 2024.",
  "key_objectives": [
    "Establish mechanisms for ordering national maritime space",
    "Create spatial instruments (Plano de Situação / Planos de Afectação)",
    "Develop cadastre of marine uses and activities",
    "Allocate maritime space for fisheries, conservation, ports, tourism",
    "Enhance public consultation and transparency",
    "Reduce maritime use conflicts",
    "Support evidence-based allocation decisions"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "65% (RJUEM framework operational; POEM approved 2024; interoperability with fisheries/conservation systems incomplete)",
  "responsible_ministries": [
    "Ministry of Sea, Inland Waters and Fisheries",
    "Ministry of Environment, Ecology, Forests and the Sea",
    "Ministry of Economy and Finance"
  ],
  "linked_policies": [
    "moz_policy_001",
    "moz_policy_004",
    "moz_policy_006"
  ],
  "international_commitments": [
    "moz_commitment_001",
    "moz_commitment_004"
  ],
  "spatial_scope": "National maritime space (EEZ + territorial sea)",
  "temporal_scope": "2017-present",
  "metadata": {
    "created_date": "2026-03-16",
    "last_updated": "2026-03-16",
    "data_source": "Deep Research Report on Mozambique Ocean Policy (2026)",
    "reliability_score": 0.95,
    "notes": "Core MSP legal framework; POEM (national maritime spatial plan) approved 2024 but full integration with sectoral tools remains in progress"
  }
}
```

### Example 9: Modern Fisheries Regulation (Decree No. 89/2020 — REPMAR)

```json
{
  "policy_id": "moz_policy_006",
  "policy_name": "Maritime Fisheries Regulation (REPMAR)",
  "policy_type": "DECREE",
  "country": "Mozambique",
  "issuing_body": "Council of Ministers / Ministry of Sea, Inland Waters and Fisheries",
  "adoption_date": "2020-10-08",
  "effective_date": "2020-10-08",
  "status": "ACTIVE",
  "legal_instrument_number": "Decree No. 89/2020",
  "document_url": "https://www.ecolex.org/details/",
  "document_source": "Government of Mozambique Official Gazette; FAO FAOLEX",
  "full_text_url": null,
  "policy_summary": "Modernized operational regulation for maritime fisheries in Mozambique. Operationalizes licensing, annual fishing campaigns, vessel registers/cadastre, and port/at-sea inspection procedures. Explicitly embeds international compliance checks including VMS (Vessel Monitoring System) presence and RFMO IUU (Illegal, Unreported, Unregulated) list verification. References IOTC (Indian Ocean Tuna Commission) resolutions and SADC fisheries protocols. Revokes earlier 2003 decree. Provides standardized inspection documentation templates aligned to modern IUU deterrence practices.",
  "key_objectives": [
    "Operationalize maritime fisheries licensing and allocations",
    "Conduct port and at-sea inspections with standardized procedures",
    "Verify VMS and RFMO/IUU compliance at inspection points",
    "Maintain vessel registers and monitoring systems",
    "Plan annual fishing campaigns",
    "Align domestic inspections with IOTC conservation measures",
    "Detect and deter IUU fishing"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "75% (inspection procedures in place; VMS deployment ongoing; capacity and funding gaps remain)",
  "responsible_ministries": [
    "Ministry of Sea, Inland Waters and Fisheries",
    "National Fisheries Administration (CNAP)"
  ],
  "linked_policies": [
    "moz_policy_001",
    "moz_policy_007",
    "moz_policy_008"
  ],
  "international_commitments": [
    "moz_commitment_002",
    "moz_commitment_007"
  ],
  "spatial_scope": "Mozambique maritime jurisdiction and high seas (flag state measures)",
  "temporal_scope": "2020-present",
  "metadata": {
    "created_date": "2026-03-16",
    "last_updated": "2026-03-16",
    "data_source": "Deep Research Report on Mozambique Ocean Policy (2026)",
    "reliability_score": 0.95,
    "notes": "Modern IUU-focused regulation; embedded RFMO compliance checks; FAO external support ongoing for consolidation"
  }
}
```

### Example 10: International Commitment (UNCLOS & UNFSA)

```json
{
  "commitment_id": "moz_commitment_005",
  "commitment_name": "UN Convention on the Law of the Sea (UNCLOS)",
  "commitment_type": "TREATY",
  "organization": "UN (United Nations)",
  "signature_date": "1982-12-10",
  "ratification_date": "1997-03-13",
  "entry_into_force_date": "1994-11-16",
  "mozambique_ratification_status": "RATIFIED",
  "commitment_url": "https://treaties.un.org/pages/ViewDetailsIII.aspx?src=TREATY&mtdsg_no=XXI-6&chapter=21&Temp=mtdsg3&clang=_en",
  "document_source": "UN Treaty Collection (Status as of 8 March 2026)",
  "full_text_url": "https://www.un.org/depts/los/convention_agreements/texts/unclos/UNCLOS-TOC.htm",
  "commitment_summary": "Comprehensive global framework for rights and responsibilities of States concerning use of oceans, including maritime zones (territorial sea, EEZ, continental shelf), marine resource management, environmental protection, and marine scientific research. Forms legal basis for Mozambique's maritime zones (Law 20/2019) and fisheries governance framework. Also covers high seas freedoms, archipelago rights, straits transit, and dispute settlement. Underpins modern fisheries MCS obligations and environmental standards.",
  "key_obligations": [
    "Establish and respect 12 nm territorial sea and 200 nm EEZ",
    "Deposit baseline charts and coordinates with UN",
    "Manage marine living resources sustainably in EEZ",
    "Cooperate in conservation and management of shared stocks",
    "Protect and preserve marine environment",
    "Conduct marine scientific research with coastal state authorization",
    "Cooperate through regional fisheries bodies (RFMO)",
    "Implement flag state responsibilities for own vessels on high seas"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)",
    "Open Ocean (M3)"
  ],
  "reporting_requirements": [
    "Periodic reporting on maritime zone implementation",
    "Participation in RFMO meetings and reporting",
    "Marine environmental status reports through regional bodies"
  ],
  "compliance_deadline": null,
  "implementing_policies": [
    "moz_policy_004",
    "moz_policy_005",
    "moz_policy_001",
    "moz_policy_006"
  ],
  "regional_context": "Western Indian Ocean; global maritime governance",
  "enforcement_mechanism": "UN Convention on the Law of the Sea Commission; RFMO dispute resolution; contentious cases to International Court; flag state enforcement for high seas",
  "metadata": {
    "created_date": "2026-03-16",
    "last_updated": "2026-03-16",
    "data_source": "UN Treaty Collection; Deep Research Report (2026)",
    "reliability_score": 0.99,
    "notes": "Foundational global treaty; ratified by Mozambique 13 March 1997; Mozambique also acceded to 1994 Part XI Implementing Agreement same date"
  }
}
```

### Example 11: International Commitment (UN Fish Stocks Agreement)

```json
{
  "commitment_id": "moz_commitment_006",
  "commitment_name": "UN Agreement on Straddling Fish Stocks and Highly Migratory Fish Stocks (UNFSA)",
  "commitment_type": "TREATY",
  "organization": "UN (United Nations)",
  "signature_date": "1995-12-04",
  "ratification_date": "2008-12-10",
  "entry_into_force_date": "2001-12-11",
  "mozambique_ratification_status": "ACCEDED",
  "commitment_url": "https://treaties.un.org/pages/ViewDetails.aspx?chapter=21&clang=_en&mtdsg_no=XXI-7&src=TREATY",
  "document_source": "UN Treaty Collection (Status as of 8 March 2026)",
  "full_text_url": "https://www.un.org/depts/los/convention_agreements/texts/fish_stocks_agreement/CONF164_37.htm",
  "commitment_summary": "Implements and complements UNCLOS provisions for straddling and highly migratory fish stocks. Establishes precautionary approach, ecosystem-based fisheries management, and robust RFMO cooperation/enforcement frameworks. Requires flag states to enforce conservation measures and support high seas boarding/inspection by authorized RFMO inspectors. Particularly relevant to Mozambique's participation in IOTC (Indian Ocean Tuna Commission) and management of shared stocks (tunas, tuna-like species, sharks).",
  "key_obligations": [
    "Apply precautionary approach to straddling and migratory stocks",
    "Ensure flag state vessel compliance with RFMO measures",
    "Support RFMO boarding and inspection of flagged vessels",
    "Cooperate in data collection, stock assessments, and enforcement",
    "Participate in RFMO decision-making (e.g., TAC setting)",
    "Monitor and control IUU fishing activities",
    "Report compliance and conservation efforts"
  ],
  "target_ecosystems": [
    "Coastal Waters (M2)",
    "Open Ocean (M3)"
  ],
  "reporting_requirements": [
    "RFMO compliance action plans",
    "Catch and effort data submissions",
    "Boarding and inspection reports",
    "Port State Measures implementation"
  ],
  "compliance_deadline": "Ongoing (RFMO-dependent)",
  "implementing_policies": [
    "moz_policy_001",
    "moz_policy_006"
  ],
  "regional_context": "Indian Ocean (IOTC); high seas",
  "enforcement_mechanism": "RFMO compliance committees; RFMO board/inspection protocols; flag state enforcement for own vessels; port state controls",
  "metadata": {
    "created_date": "2026-03-16",
    "last_updated": "2026-03-16",
    "data_source": "UN Treaty Collection; Deep Research Report (2026)",
    "reliability_score": 0.99,
    "notes": "Acceded by Mozambique 10 December 2008; directly underpins IOTC compliance obligations and REPMAR inspection procedures"
  }
}
```

### Example 12: Conservation Framework (Law No. 16/2014 & amended by Law 5/2017)

```json
{
  "policy_id": "moz_policy_009",
  "policy_name": "Conservation Law (with 2017 Amendments)",
  "policy_type": "LEGISLATION",
  "country": "Mozambique",
  "issuing_body": "Government of Mozambique / Parliament",
  "adoption_date": "2014-06-20",
  "effective_date": "2014-06-20",
  "status": "ACTIVE",
  "legal_instrument_number": "Law No. 16/2014 (amended by Law No. 5/2017)",
  "document_url": "https://www.ecolex.org/details/",
  "document_source": "Government of Mozambique Official Gazette; EcoLex Database",
  "full_text_url": null,
  "policy_summary": "Foundational biodiversity and conservation areas law applicable to national territory and waters under national jurisdiction. Establishes categories of conservation areas (total protection and sustainable use). Amended in 2017 to strengthen enforcement provisions including broader search/seizure authority (with judicial authorization), treatment of attempts/frustrated offences, and defined roles for conservation ministry and police cooperation. Applies to marine protected areas, coastal/seagrass conservation zones, and mangrove reserves. Includes provisions for community partnerships and conservation financing mechanisms.",
  "key_objectives": [
    "Protect biodiversity in conservation areas",
    "Establish integrated conservation area management framework",
    "Enforce biodiversity protection in marine/coastal areas",
    "Support conservation area partnerships (public-private-community)",
    "Strengthen investigation and seizure procedures for conservation offences",
    "Integrate biodiversity protection into sectoral activities"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Mangroves (M1.2)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "70% (conservation areas designated; enforcement capacity variable; inter-agency coordination incomplete)",
  "responsible_ministries": [
    "Ministry of Environment, Ecology, Forests and the Sea",
    "Ministry of Land, Environment and Rural Development"
  ],
  "linked_policies": [
    "moz_policy_001",
    "moz_policy_004",
    "moz_policy_005"
  ],
  "international_commitments": [
    "moz_commitment_004",
    "moz_commitment_009"
  ],
  "spatial_scope": "National territory + waters under national jurisdiction (territorial sea + EEZ)",
  "temporal_scope": "2014-present (amended 2017)",
  "metadata": {
    "created_date": "2026-03-16",
    "last_updated": "2026-03-16",
    "data_source": "Deep Research Report on Mozambique Ocean Policy (2026)",
    "reliability_score": 0.95,
    "notes": "2017 amendments strengthened enforcement; applies to marine/coastal protected areas; coordination with fisheries governance needs improvement"
  }
}
```

### Example 13: Fisheries Co-Management (Decree No. 9/2024 — CCGP)

```json
{
  "policy_id": "moz_policy_010",
  "policy_name": "Fisheries Co-Management Committee (CCGP) Rules",
  "policy_type": "DECREE",
  "country": "Mozambique",
  "issuing_body": "Council of Ministers",
  "adoption_date": "2024-03-07",
  "effective_date": "2024-03-07",
  "status": "ACTIVE",
  "legal_instrument_number": "Decree No. 9/2024",
  "document_url": "https://www.ecolex.org/details/",
  "document_source": "Government of Mozambique Official Gazette",
  "full_text_url": null,
  "policy_summary": "Establishes organizational rules and functioning of Fisheries Co-Management Committees (CCGP) at provincial/district levels. Designed as consultative participatory bodies with multi-stakeholder representation (industrial, semi-industrial, artisanal fisheries, aquaculture, inspection/enforcement, communities). Functions include advising on TAC/TAE (Total Allowable Catch/Effort), zoning, closed seasons (defeso), MCS (Monitoring, Control, Surveillance) strategies, and fisheries/aquaculture policy proposals. Integrates community knowledge with central fisheries administration.",
  "key_objectives": [
    "Establish provincial-level participatory fisheries governance",
    "Integrate industrial, semi-industrial, artisanal, and aquaculture sectors",
    "Advise on TAC/TAE setting and enforcement",
    "Develop zoning and closed-season management",
    "Coordinate MCS strategies across sectors",
    "Incorporate community/fisher knowledge in management decisions",
    "Support implementation of national fisheries policies"
  ],
  "target_ecosystems": [
    "Photic Coral Reefs (M1.3)",
    "Seagrass Beds (M1.1)",
    "Coastal Waters (M2)"
  ],
  "implementation_status": "30% (CCGP framework recently established; operational capacity being developed)",
  "responsible_ministries": [
    "Ministry of Sea, Inland Waters and Fisheries",
    "Provincial Fisheries Administration"
  ],
  "linked_policies": [
    "moz_policy_001",
    "moz_policy_006",
    "moz_policy_007"
  ],
  "international_commitments": [
    "moz_commitment_002",
    "moz_commitment_005"
  ],
  "spatial_scope": "Provincial and district fisheries zones",
  "temporal_scope": "2024-present",
  "metadata": {
    "created_date": "2026-03-16",
    "last_updated": "2026-03-16",
    "data_source": "Deep Research Report on Mozambique Ocean Policy (2026)",
    "reliability_score": 0.95,
    "notes": "Very recent (March 2024); designed to improve participation in TAC/TAE and zoning decisions; implementation support from FAO ongoing"
  }
}
```

---

## Updated International Commitments Table

| Instrument | Domain | Mozambique Status (confirmed) | Adoption Year | Key Relevance to Coral/Seagrass |
| --- | --- | --- | --- | --- |
| UNCLOS (1982) | Maritime zones; rights/duties | Ratified **13 Mar 1997** | 1982 | Foundation for EEZ, continental shelf claims; marine environment duties |
| Part XI Implementing Agreement (1994) | Seabed/ISA regime | Acceded **13 Mar 1997** | 1994 | Deep seabed mining governance participation |
| UNFSA (1995) | High seas/RFMO fisheries | Acceded **10 Dec 2008** | 1995 | IOTC cooperation; straddling stock management; boarding/inspection |
| Nairobi Convention (1985) | WIO marine/coastal environment | Ratified **Nov 1996** | 1985 | ICZM; MPAs; regional cooperation; coastal ecosystem protection |
| CBD (1992) | Biodiversity incl. marine/coastal | Ratified **Aug 1994** (Resolution 2/94) | 1992 | NBSAP; species protection; marine protected areas; reporting |
| Ramsar (1971) | Wetlands incl. coastal/estuarine | Entry into force **2004** | 1971 | Mangrove and estuarine ecosystem protection |
| CMS (1979) | Migratory species | Party **1 Aug 2009** | 1979 | Sea turtle, shark, marine mammal protection; IOSEA MOU |
| PSMA (2009) | IUU deterrence / port controls | Ratified **19 Aug 2014** | 2009 | Port State Measures; vessel entry controls; IUU detection |
| BBNJ Agreement (2023) | High seas biodiversity | **Not signed/listed** (as of 8 Mar 2026) | 2023 | Not applicable unless ratified; would enable ABNJ conservation |
| SADC Fisheries Protocol | Regional fisheries cooperation | Referenced in REPMAR (Resolution 39/2002) | 2002 | Transboundary stock cooperation; regional MCS coordination |

---

## Governance Implementation Gaps (Evidence-Based)

### Data & Assessment Deficits

**Source:** World Bank MozAzul analysis (cited in Deep Research Report)

- Gaps in oceanographic, physical, economic, and biological data/assessments
- Affects TAC/TAE setting, MSP zoning, and EIA baseline monitoring

### RFMO Compliance Challenges

**Source:** IOTC Compliance Report (2025, cited in Deep Research Report)

- Repeated non-compliance issues identified by IOTC Compliance Committee
- At least one instance of missing compliance action plan submission
- Typical of institutional bandwidth and reporting coordination gaps

### Capacity & Financing Risks

**Source:** Decree 60/2018 revenue allocation provisions

- Fisheries fees earmarked for enforcement/research, but:
  - Absolute revenue base may be inadequate for patrols, VMS, port inspection staffing
  - Disbursement predictability needs empirical assessment

### MSP-Fisheries-Conservation Interoperability

- RJUEM MSP instruments (Plano de Situação / Planos de Afectação) not yet fully integrated with fisheries zoning and conservation area boundaries
- POEM (2024) approved but operational interoperability incomplete

---

## Key Source Document References

**Primary Deep Research Report:**
- [Mozambique Ocean Policy and International Commitments](file:///Users/z5238824/Downloads/deep-research-report.md) — Comprehensive synthesis with 70+ inline citations to official instruments, FAO/World Bank analyses, and UN Treaty Collection status as of 8 March 2026

**UN Treaty Collection (Status 8 March 2026):**
- [UNCLOS Status (XXI-6)](https://treaties.un.org/pages/ViewDetailsIII.aspx?src=TREATY&mtdsg_no=XXI-6&chapter=21&Temp=mtdsg3&clang=_en)
- [UNFSA Status (XXI-7)](https://treaties.un.org/pages/ViewDetails.aspx?chapter=21&clang=_en&mtdsg_no=XXI-7&src=TREATY)

**FAO Resources:**
- FAO PSMA implementation support (2025 mission to Mozambique)
- FAO FAOLEX database (Mozambique fisheries/environmental laws)

**World Bank:**
- MozAzul innovation platform report — Blue economy data gaps analysis

**Regional Bodies:**
- Nairobi Convention Secretariat (Mozambique COP participation; coastal/marine governance)
- IOTC Compliance Committee reports (2025) — Mozambique flag state compliance issues
