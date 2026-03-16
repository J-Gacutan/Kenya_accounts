# RAG Schema: Academic Citations & Evidence Linking

## Overview
This schema structures academic publications, peer-reviewed sources, and policy documents cited in SEEA EA research, enabling rigorous evidence linking for research outputs. Each claim in a publication must be traceable to a specific citation.

---

## Core Entity Schema

### 1. **Academic Source**

```json
{
  "source_id": "string (unique identifier, e.g., 'source_2025_001')",
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
  "geographic_focus": ["string array (e.g., 'Madagascar', 'Western Indian Ocean')"],
  "ecosystem_focus": ["string array (e.g., 'Coral Reefs M1.3', 'Marine Protected Areas')"],
  "methodology": "string (e.g., 'systematic review', 'field survey', 'modeling')",
  "language": "string (e.g., 'English', 'French')",
  "access_type": "enum: [OPEN_ACCESS, SUBSCRIPTION, PAYWALLED, RESTRICTED]",
  "peer_review_status": "enum: [PEER_REVIEWED, GRAY_LITERATURE, UNPUBLISHED]",
  "quality_score": "float (0-1, editorial assessment of rigor)",
  "relevance_tags": ["string array (e.g., 'SEEA_EA', 'ecosystem_accounting', 'WIO')"],
  "metadata": {
    "indexed_date": "YYYY-MM-DD",
    "last_verified": "YYYY-MM-DD",
    "data_source": "string (how this source was acquired)",
    "pdf_available": "boolean",
    "pdf_path": "string (internal path to PDF if available)",
    "full_text_available": "boolean",
    "notes": "string (e.g., 'key foundational work', 'contradicts source_2025_003')"
  }
}
```

---

### 2. **Citation (Specific Claim Link)**

```json
{
  "citation_id": "string (unique identifier, e.g., 'cite_2025_001')",
  "source_id": "string (references academic_source.source_id)",
  "publication_id": "string (references publication document, e.g., 'POLICY_BRIEF_Madagascar_CoralReef')",
  "claim_text": "string (the specific statement being cited, max 200 words)",
  "claim_section": "string (e.g., 'Introduction', 'Methods', 'Results')",
  "claim_page_number": "integer (page where claim appears in publication)",
  "specific_location": "string (e.g., 'Figure 3, Panel B', 'Table 1, Row 4', 'Section 3.2, Paragraph 2')",
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
    "flags": ["string array (e.g., 'needs_peer_review', 'requires_clarification')"]
  }
}
```

---

### 3. **Evidence Cluster**

```json
{
  "cluster_id": "string (e.g., 'evidence_fish_biomass_ref_level')",
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

### 4. **Publication Document**

```json
{
  "publication_id": "string (e.g., 'POLICY_BRIEF_Madagascar_CoralReef')",
  "publication_type": "enum: [POLICY_BRIEF, RESEARCH_ARTICLE, TECHNICAL_REPORT, GUIDELINE, BOOK_CHAPTER]",
  "title": "string",
  "authors": ["string array"],
  "publication_date": "YYYY-MM-DD",
  "status": "enum: [DRAFT, PEER_REVIEW, IN_PRESS, PUBLISHED, ARCHIVED]",
  "abstract": "string (300-500 words)",
  "target_audience": ["string array (e.g., 'policymakers', 'researchers', 'practitioners')"],
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
- **POLICY_DOCUMENT** — International treaty, decree, or policy instrument
- **DATASET** — Data publication or repository
- **PREPRINT** — Pre-publication version (arXiv, bioRxiv, etc.)

### Claim Types
- **FACTUAL** — Observable facts (e.g., "Madagascar's EEZ is ~1.14 million km²")
- **STATISTICAL** — Numerical findings with uncertainty (e.g., "MPA coverage at 1.35% in 2026")
- **METHODOLOGICAL** — Technical procedures (e.g., "SEEA EA requires spatial extent mapping")
- **CONCEPTUAL** — Theoretical frameworks (e.g., "Ecosystem accounting integrates social-ecological dynamics")
- **NORMATIVE** — Policy recommendations or value statements

### Confidence Levels
- **HIGH** — Multiple peer-reviewed sources, consensus, recent data
- **MEDIUM** — Peer-reviewed but limited sources, some uncertainty
- **LOW** — Single source, gray literature, or methodological limitations
- **DISPUTED** — Contradicting sources with similar credibility

### Consensus Levels
- **STRONG_CONSENSUS** — 3+ independent sources, HIGH confidence
- **MODERATE_CONSENSUS** — 2+ sources with minor disagreements
- **MIXED_VIEWS** — Sources present different perspectives
- **DISPUTED** — Direct contradictions with similar evidence weight

---

## Example Records

### Example 1: Peer-Reviewed Journal Article

```json
{
  "source_id": "source_2026_001",
  "source_type": "PEER_REVIEWED_JOURNAL",
  "title": "Land and Terrestrial Ecosystem Accounts, 1990 to 2014: South Africa as a Paradigm for SEEA EA Implementation",
  "authors": ["Statistics South Africa (Stats SA)", "South African National Biodiversity Institute (SANBI)"],
  "publication_year": 2017,
  "journal_name": "Environmental Science & Policy",
  "volume": "75",
  "issue": "3",
  "pages": "123-145",
  "doi": "10.1016/j.envsci.2017.05.012",
  "url": "https://doi.org/10.1016/j.envsci.2017.05.012",
  "publisher": "Elsevier",
  "abstract": "This paper presents the first national-level SEEA EA ecosystem extent and condition accounts for South Africa, covering 25 years of land cover change. The study demonstrates how satellite imagery combined with national data sources can be integrated into a standardized statistical framework...",
  "keywords": ["SEEA Ecosystem Accounting", "ecosystem extent", "land cover", "South Africa", "biomes"],
  "geographic_focus": ["South Africa"],
  "ecosystem_focus": ["Terrestrial ecosystems", "Protected areas"],
  "methodology": "satellite imagery analysis, national data integration, multi-temporal assessment",
  "language": "English",
  "access_type": "PAYWALLED",
  "peer_review_status": "PEER_REVIEWED",
  "quality_score": 0.95,
  "relevance_tags": ["SEEA_EA", "extent_accounts", "paradigm", "African_implementation"],
  "metadata": {
    "indexed_date": "2026-03-16",
    "last_verified": "2026-03-16",
    "data_source": "Academic databases (ScienceDirect); requested from authors",
    "pdf_available": true,
    "pdf_path": "Madagascar/docs/sources/Stats_SA_2017_Land_Terrestrial_Ecosystem_Accounts.pdf",
    "full_text_available": true,
    "notes": "Foundational work for South Africa ecosystem accounting; directly applicable methodology for Madagascar."
  }
}
```

### Example 2: Citation Record

```json
{
  "citation_id": "cite_2026_001",
  "source_id": "source_2026_001",
  "publication_id": "POLICY_BRIEF_Madagascar_CoralReef",
  "claim_text": "South Africa has emerged as the continental leader in SEEA EA implementation through systematic ecosystem extent and condition accounts spanning 25 years of data.",
  "claim_section": "Implementation Examples",
  "claim_page_number": 5,
  "specific_location": "Table 1, Row 2; Figure 2, Panel A",
  "quote_text": "By documenting changes from the historical state of ecosystems to their modified state, the accounts provide a clear picture of degradation and expansion of human-influenced biomes.",
  "quote_page": "p. 128",
  "paraphrase_level": "CLOSE_PARAPHRASE",
  "claim_type": "FACTUAL",
  "confidence_level": "HIGH",
  "supporting_sources": ["source_2026_002", "source_2026_003"],
  "contradicting_sources": [],
  "context_notes": "This claim establishes South Africa as a precedent for ecosystem accounting in African contexts, directly relevant to Madagascar's implementation pathway.",
  "metadata": {
    "created_date": "2026-03-16",
    "verified_by": "Project Team",
    "verification_date": "2026-03-16",
    "flags": []
  }
}
```

### Example 3: Evidence Cluster

```json
{
  "cluster_id": "evidence_fish_biomass_reference",
  "claim_statement": "Appropriate reference levels for coral reef fish biomass in the Western Indian Ocean range from 400-700 kg/ha, with regional variation dependent on habitat complexity and management history.",
  "citations": [
    "cite_2026_004",
    "cite_2026_005",
    "cite_2026_006"
  ],
  "consensus_level": "MODERATE_CONSENSUS",
  "evidence_strength": "2 peer-reviewed studies directly measuring WIO reefs; 1 meta-analysis including regional data; regional variation not fully resolved",
  "key_papers": [
    "source_2026_004",
    "source_2026_005"
  ],
  "gaps_or_limitations": "Limited data from Madagascar specifically; most reference levels from East Africa or Indo-Pacific; climate change impacts on baseline unclear",
  "recommendations_for_further_evidence": [
    "Historical biomass surveys from Madagascar archives (pre-2000)",
    "Unfished or minimally fished control sites in Madagascar",
    "Regional synthesis of WIO reference conditions"
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

### 1. **Source Acquisition**
- Identify relevant academic/policy sources
- Complete Academic Source record
- Store PDF locally or link to access URL

### 2. **Publication Draft**
- Author writes claim/statement
- Note which sources should support it
- Create preliminary Citation records

### 3. **Citation Verification**
- Team member reads source and verifies claim support
- Complete Citation record (quote_text, confidence_level, etc.)
- Flag if claim misrepresents source or needs revision

### 4. **Evidence Clustering**
- Group related citations by claim theme
- Assess consensus across sources
- Identify gaps or disagreements

### 5. **Quality Assurance**
- Generate citation completeness report
- Peer-review flagged claims
- Update publication status

---

## Search & Indexing Strategy

### Key Search Dimensions
1. **Source-based** — "All sources on fish biomass in WIO"
2. **Claim-based** — "What evidence supports the 500 kg/ha reference level?"
3. **Confidence-based** — "Show only HIGH confidence citations"
4. **Consensus-based** — "Which claims have strong consensus?"
5. **Publication-based** — "Show citation coverage for [publication]"
6. **Gap-based** — "Which sections lack peer-reviewed support?"

### Semantic Fields for RAG Indexing
- **title** — Publication identification
- **abstract** — Semantic content matching
- **keywords** — Explicit semantic tags
- **claim_text** — Specific claim matching
- **quote_text** — Direct evidence phrases

---

## Quality Metrics

### Citation Completeness Score
```
Completeness = (citations_fully_verified / total_claims) × 100
Target: 95%+ for published works
```

### Evidence Quality Distribution
Track prevalence of confidence levels across publication:
- **HIGH** — Should comprise 70%+
- **MEDIUM** — Up to 20%
- **LOW** — <10% (flag for revision)
- **DISPUTED** — Should be explicitly acknowledged

### Consensus Assessment
For each major claim, track:
- Number of supporting sources
- Agreement/disagreement patterns
- Geographic/methodological variation

---

## Integration with Policy RAG

```
Academic Citation Schema + Policy RAG Schema
          ↓
    Bidirectional Linking
          ↓
  Academic → Policy Implementation
  Policy → Academic Knowledge Gap
```

**Example Integration Query:**
"Show me the academic evidence base supporting Madagascar's Nairobi Convention obligations on coral reef condition monitoring."

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
