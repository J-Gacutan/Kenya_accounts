# RAG Schema: Academic Citations & Evidence Linking
**Kenya Blue Economy — SEEA EA Accounts**

## Overview
This schema structures academic publications, peer-reviewed sources, and policy documents cited in SEEA EA research for Kenya, enabling rigorous evidence linking for research outputs. Kenya's blue economy accounts span multiple ecosystem types (mangroves, seagrass, fisheries) and integrate governance, finance, and biophysical evidence. Each claim in a publication must be traceable to a specific citation.

---

## Core Entity Schema

### 1. Academic Source

```json
{
  "source_id": "string (unique identifier, e.g., 'source_2026_ken_001')",
  "source_type": "enum: [PEER_REVIEWED_JOURNAL, BOOK, BOOK_CHAPTER, CONFERENCE_PROCEEDINGS, REPORT, POLICY_DOCUMENT, DATASET, PREPRINT]",
  "title": "string",
  "authors": ["string array"],
  "publication_year": "YYYY",
  "publication_date": "YYYY-MM-DD (if available)",
  "journal_name": "string (if applicable)",
  "volume": "string (if applicable)",
  "issue": "string (if applicable)",
  "pages": "string (e.g., '123-145')",
  "doi": "string (e.g., '10.1234/example')",
  "url": "string (direct link to source)",
  "issn": "string (if journal)",
  "isbn": "string (if book)",
  "publisher": "string",
  "publisher_location": "string",
  "abstract": "string (200-500 words)",
  "keywords": ["string array"],
  "geographic_focus": ["string array (e.g., 'Kenya', 'Lamu County', 'Western Indian Ocean')"],
  "ecosystem_focus": ["string array (e.g., 'Mangroves MFT1.2', 'Seagrass MB2.2', 'Fisheries')"],
  "methodology": "string (e.g., 'field survey', 'remote sensing', 'financial modeling', 'policy analysis')",
  "language": "string (e.g., 'English')",
  "access_type": "enum: [OPEN_ACCESS, SUBSCRIPTION, PAYWALLED, RESTRICTED]",
  "peer_review_status": "enum: [PEER_REVIEWED, GRAY_LITERATURE, UNPUBLISHED]",
  "quality_score": "float (0-1, editorial assessment of rigor)",
  "relevance_tags": ["string array (e.g., 'SEEA_EA', 'blue_economy', 'blue_carbon', 'WIO', 'Kenya_NBES')"],
  "metadata": {
    "indexed_date": "YYYY-MM-DD",
    "last_verified": "YYYY-MM-DD",
    "data_source": "string (how this source was acquired)",
    "pdf_available": "boolean",
    "pdf_path": "string (internal path to PDF if available)",
    "full_text_available": "boolean",
    "notes": "string (e.g., 'key foundational work', 'contradicts source_2026_ken_003')"
  }
}
```

---

### 2. Citation (Specific Claim Link)

```json
{
  "citation_id": "string (unique identifier, e.g., 'cite_2026_ken_001')",
  "source_id": "string (references academic_source.source_id)",
  "publication_id": "string (references publication document, e.g., 'POLICY_BRIEF_Kenya_BlueEconomy')",
  "claim_text": "string (the specific statement being cited, max 200 words)",
  "claim_section": "string (e.g., 'Introduction', 'Methods', 'Blue Carbon', 'Governance')",
  "claim_page_number": "integer (page where claim appears in publication)",
  "specific_location": "string (e.g., 'Table 2, Row 3', 'Section 4.1, Paragraph 2')",
  "quote_text": "string (direct quote from source if applicable)",
  "quote_page": "integer or string (page number in source)",
  "paraphrase_level": "enum: [DIRECT_QUOTE, CLOSE_PARAPHRASE, GENERAL_REFERENCE]",
  "claim_type": "enum: [FACTUAL, STATISTICAL, METHODOLOGICAL, CONCEPTUAL, NORMATIVE]",
  "confidence_level": "enum: [HIGH, MEDIUM, LOW, DISPUTED]",
  "supporting_sources": ["source_id array (additional sources supporting same claim)"],
  "contradicting_sources": ["source_id array (sources that contradict this claim)"],
  "context_notes": "string (why this source supports this specific claim)",
  "metadata": {
    "created_date": "YYYY-MM-DD",
    "verified_by": "string (name/ID of person who verified the citation)",
    "verification_date": "YYYY-MM-DD",
    "flags": ["string array (e.g., 'needs_peer_review', 'gray_literature_only', 'requires_clarification')"]
  }
}
```

---

### 3. Evidence Cluster

```json
{
  "cluster_id": "string (e.g., 'evidence_mangrove_carbon_density_kenya')",
  "claim_statement": "string (overarching claim being supported)",
  "citations": ["citation_id array"],
  "consensus_level": "enum: [STRONG_CONSENSUS, MODERATE_CONSENSUS, MIXED_VIEWS, DISPUTED]",
  "evidence_strength": "string (synthesis of supporting evidence quality)",
  "key_papers": ["source_id array (most important sources)"],
  "gaps_or_limitations": "string (where evidence is weak or missing)",
  "recommendations_for_further_evidence": ["string array"],
  "metadata": {
    "compiled_date": "YYYY-MM-DD",
    "compiled_by": "string",
    "last_updated": "YYYY-MM-DD"
  }
}
```

---

### 4. Publication Document

```json
{
  "publication_id": "string (e.g., 'POLICY_BRIEF_Kenya_BlueEconomy')",
  "publication_type": "enum: [POLICY_BRIEF, RESEARCH_ARTICLE, TECHNICAL_REPORT, GUIDELINE, BOOK_CHAPTER]",
  "title": "string",
  "authors": ["string array"],
  "publication_date": "YYYY-MM-DD",
  "status": "enum: [DRAFT, PEER_REVIEW, IN_PRESS, PUBLISHED, ARCHIVED]",
  "abstract": "string (300-500 words)",
  "target_audience": ["string array (e.g., 'policymakers', 'investors', 'researchers')"],
  "geographic_scope": ["string array"],
  "ecosystem_scope": ["string array"],
  "total_citations": "integer",
  "citations_fully_verified": "integer",
  "citation_completion_percent": "float (0-100)",
  "citation_quality_score": "float (0-1, average quality of all citations)",
  "key_evidence_clusters": ["cluster_id array"],
  "metadata": {
    "created_date": "YYYY-MM-DD",
    "last_updated": "YYYY-MM-DD",
    "file_path": "string (local path to publication file)",
    "notes": "string"
  }
}
```

---

## Taxonomy & Controlled Vocabularies

### Source Types
- **PEER_REVIEWED_JOURNAL** — Published in peer-reviewed journal
- **BOOK** — Monograph (sole or primary authors)
- **BOOK_CHAPTER** — Chapter in edited volume
- **CONFERENCE_PROCEEDINGS** — Peer-reviewed conference publication
- **REPORT** — Government, NGO, or institutional report
- **POLICY_DOCUMENT** — National strategy, act, decree, or treaty
- **DATASET** — Data publication or repository
- **PREPRINT** — Pre-publication version

### Claim Types (Kenya-adapted)
- **FACTUAL** — Observable facts (e.g., "Kenya's EEZ covers 142,400 km²")
- **STATISTICAL** — Numerical findings with uncertainty (e.g., "Lamu mangrove carbon density: 560.23 Mg C ha⁻¹")
- **METHODOLOGICAL** — Technical procedures (e.g., "Plan Vivo requires a Project Idea Note before PDD submission")
- **CONCEPTUAL** — Theoretical frameworks (e.g., "Blue carbon sequesters carbon up to 4x faster than terrestrial forests")
- **NORMATIVE** — Policy recommendations or value statements (e.g., "IUU fishing must be eradicated to reach NBES targets")

### Confidence Levels
- **HIGH** — Multiple peer-reviewed sources, consensus, recent Kenya or WIO data
- **MEDIUM** — Peer-reviewed but limited sources, or Kenya-specific gray literature
- **LOW** — Single source, non-Kenya gray literature, or provisional/modeled values
- **DISPUTED** — Contradicting sources with similar credibility

### Relevance Tags (Kenya-specific)
- `blue_economy` — Blue economy strategy, governance, policy
- `blue_carbon` — Mangrove and seagrass carbon sequestration and credits
- `fisheries` — Artisanal and industrial fisheries; IUU; MCS
- `MSP` — Marine Spatial Planning
- `NBES_2025_2030` — National Blue Economy Strategy
- `KEMFSED` — World Bank KEMFSED project
- `mangrove` — Mangrove ecosystem (MFT1.2)
- `seagrass` — Seagrass meadow (MB2.2)
- `blue_finance` — Blue bonds, carbon credits, blended finance
- `NIFC` — Nairobi International Financial Centre
- `OOC11` — 11th Our Ocean Conference (Mombasa, June 2026)
- `WIO` — Western Indian Ocean regional context
- `IUU` — Illegal, unreported, unregulated fishing

---

## Example Records

### Example 1: Policy Document

```json
{
  "source_id": "source_2026_ken_001",
  "source_type": "POLICY_DOCUMENT",
  "title": "National Blue Economy Strategy 2025-2030",
  "authors": ["State Department for Blue Economy and Fisheries (SDBEF)", "Ministry of Mining, Blue Economy, and Maritime Affairs"],
  "publication_year": 2025,
  "publisher": "Government of Kenya",
  "publisher_location": "Nairobi, Kenya",
  "abstract": "The National Blue Economy Strategy 2025-2030 is anchored in the Fourth Medium Term Plan (MTP IV) of Kenya Vision 2030 and the Bottom-Up Economic Transformation Agenda (BETA). It sets targets including tripling annual fish production from 163,000 to 450,000 metric tons, and increasing blue revenue to KSh 350 billion by 2030. The strategy elevates the blue economy as a core economic pillar and coordinates across sectors including fisheries, mariculture, shipping, energy, and conservation.",
  "keywords": ["blue economy", "Kenya", "fisheries", "marine spatial planning", "NBES", "Vision 2030"],
  "geographic_focus": ["Kenya"],
  "ecosystem_focus": ["Marine and coastal ecosystems", "Fisheries", "Mangroves", "Seagrass"],
  "methodology": "policy analysis, stakeholder consultation, economic modeling",
  "language": "English",
  "access_type": "OPEN_ACCESS",
  "peer_review_status": "GRAY_LITERATURE",
  "quality_score": 0.85,
  "relevance_tags": ["blue_economy", "NBES_2025_2030", "fisheries", "MSP"],
  "metadata": {
    "indexed_date": "2026-03-16",
    "last_verified": "2026-03-16",
    "data_source": "Government of Kenya; referenced in strategic analysis document",
    "pdf_available": false,
    "pdf_path": "",
    "full_text_available": false,
    "notes": "Primary policy framework for all Kenya SEEA EA blue economy accounts; anchors revenue target of KSh 350B by 2030 and fish production target of 450,000 MT."
  }
}
```

### Example 2: Citation Record

```json
{
  "citation_id": "cite_2026_ken_001",
  "source_id": "source_2026_ken_001",
  "publication_id": "POLICY_BRIEF_Kenya_BlueEconomy",
  "claim_text": "Kenya's National Blue Economy Strategy 2025-2030 targets a nearly nine-fold increase in blue revenue to KSh 350 billion by 2030, anchored within Vision 2030 and the BETA agenda.",
  "claim_section": "Policy Context",
  "claim_page_number": 3,
  "specific_location": "Section 2.1, Paragraph 1",
  "quote_text": "",
  "quote_page": "",
  "paraphrase_level": "CLOSE_PARAPHRASE",
  "claim_type": "STATISTICAL",
  "confidence_level": "HIGH",
  "supporting_sources": ["source_2026_ken_002"],
  "contradicting_sources": [],
  "context_notes": "NBES 2025-2030 is the primary strategic document; revenue target and production figures are directly cited from the strategy and corroborated by the 2026 Budget Policy Statement.",
  "metadata": {
    "created_date": "2026-03-16",
    "verified_by": "Project Team",
    "verification_date": "2026-03-16",
    "flags": ["gray_literature_only"]
  }
}
```

### Example 3: Evidence Cluster

```json
{
  "cluster_id": "evidence_mangrove_carbon_density_kenya",
  "claim_statement": "Kenyan mangroves in Lamu and Kwale counties represent elite carbon sinks with densities of 560.23 and 526.34 Mg C ha⁻¹ respectively, generating projected annual revenues of approximately US$3.59 million at a conservative carbon price of US$20 per tCO₂e.",
  "citations": [
    "cite_2026_ken_010",
    "cite_2026_ken_011",
    "cite_2026_ken_012"
  ],
  "consensus_level": "MODERATE_CONSENSUS",
  "evidence_strength": "Site-specific carbon density values from survey data (Lamu and Kwale); revenue calculation is modeled, not independently verified; carbon price assumption is conservative relative to current voluntary market rates",
  "key_papers": [
    "source_2026_ken_010",
    "source_2026_ken_011"
  ],
  "gaps_or_limitations": "Primary peer-reviewed source for carbon density values not yet identified; revenue projection is sensitive to carbon price and area assumptions; Plan Vivo validation still pending for Lamu PIN",
  "recommendations_for_further_evidence": [
    "Identify peer-reviewed paper(s) underpinning the 560.23 and 526.34 Mg C ha⁻¹ density values",
    "Compare Lamu carbon density to WIO regional averages (Alongi 2014; Hamilton & Friess 2018)",
    "Sensitivity analysis on carbon price: US$10, US$20, US$50/tCO₂e",
    "Verify Plan Vivo PDD submission timeline (expected 2026)"
  ],
  "metadata": {
    "compiled_date": "2026-03-16",
    "compiled_by": "SEEA EA Research Team",
    "last_updated": "2026-03-16"
  }
}
```

---

## Integration Workflow

### 1. Source Acquisition
- Identify relevant academic, policy, and gray literature sources
- Complete Academic Source record
- Store PDF locally or link to access URL

### 2. Publication Draft
- Author writes claim/statement
- Note which sources should support it
- Create preliminary Citation records

### 3. Citation Verification
- Team member reads source and verifies claim support
- Complete Citation record (quote_text, confidence_level, etc.)
- Flag if claim misrepresents source or needs revision

### 4. Evidence Clustering
- Group related citations by claim theme
- Assess consensus across sources
- Identify gaps or disagreements

### 5. Quality Assurance
- Generate citation completeness report
- Peer-review flagged claims
- Update publication status

---

## Search & Indexing Strategy

### Key Search Dimensions for Kenya
1. **Source-based** — "All sources on blue carbon in WIO"
2. **Claim-based** — "What evidence supports the 560.23 Mg C ha⁻¹ carbon density for Lamu mangroves?"
3. **Confidence-based** — "Show only HIGH confidence citations"
4. **Consensus-based** — "Which blue economy claims have strong consensus?"
5. **Policy-based** — "Show all citations linking to NBES 2025-2030 targets"
6. **Gap-based** — "Which sections lack peer-reviewed support?"

### Semantic Fields for RAG Indexing
- **title** — Source identification
- **abstract** — Semantic content matching
- **keywords** — Explicit semantic tags
- **claim_text** — Specific claim matching
- **quote_text** — Direct evidence phrases

---

## Quality Metrics

### Citation Completeness Score
```
Completeness = (citations_fully_verified / total_claims) x 100
Target: 95%+ for published works
```

### Evidence Quality Distribution
- **HIGH** — Should comprise 70%+
- **MEDIUM** — Up to 20%
- **LOW** — <10% (flag for revision)
- **DISPUTED** — Should be explicitly acknowledged

### Kenya-Specific Quality Flags
- `gray_literature_only` — Claim supported only by government/NGO documents; seek peer-review corroboration
- `carbon_price_sensitive` — Financial projection sensitive to assumed carbon price
- `area_estimate_pending` — Revenue/yield calculation depends on extent mapping not yet complete
- `provisional_target` — Government policy target, not empirically achieved value

---

## Integration with Policy RAG

```
Academic Citation Schema + Policy RAG Schema
          |
    Bidirectional Linking
          |
  Academic --> Policy Implementation
  Policy --> Academic Knowledge Gap
```

**Example Integration Query:**
"Show me the academic evidence base supporting Kenya's Nairobi Convention obligations on blue carbon monitoring in Lamu and Kwale."

---

## Tools & Implementation

### Recommended Stack
- **Citation Manager:** Zotero, Mendeley, or custom JSON store
- **Vector DB:** Pinecone/Weaviate for semantic search across claims
- **Structured Storage:** PostgreSQL + JSONB for sources/citations
- **Validation Tool:** Custom Python script to check citation completeness
- **Dashboard:** Streamlit app showing publication citation coverage

### Key Reports
1. **Citation Completeness Report** — % of claims with verified sources
2. **Evidence Quality Summary** — Distribution of HIGH/MEDIUM/LOW confidence
3. **Consensus Map** — Which claims have strong vs. disputed evidence
4. **Gap Analysis** — Sections lacking peer-reviewed support
5. **Source Coverage** — Which sources are cited most/least frequently

---

## Maintenance & Updates

- **Update Frequency:** After each publication draft iteration
- **Verification Process:** Peer review of citation accuracy; spot-check quotes
- **Owner:** Publication lead author + review committee
- **Archive:** Store completed citation records with publication for reproducibility

---

**Document created:** 2026-03-16
**Adapted from:** `Madagascar/docs/rag/academic/academic_rag_schema.md`
**Country context:** Kenya — Blue economy, mangroves, seagrass, fisheries, governance
