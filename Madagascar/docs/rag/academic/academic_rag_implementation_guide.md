# Academic RAG Implementation Guide

## Overview
This guide explains how to use the Academic Citation Schema and extracted sources to build a Retrieval-Augmented Generation (RAG) system for evidence-linked publications.

---

## Quick Start: Three-Step Workflow

### 1. **Source Management**
- Add academic/policy sources to `academic_rag_citations_extracted.json`
- Complete metadata fields for each source
- Assign unique `source_id` (e.g., `source_2026_wio_001`)

### 2. **Citation Linking**
- For each claim in your publication, identify supporting sources
- Create Citation records linking claim → source
- Include quote text and page numbers
- Assess confidence level (HIGH/MEDIUM/LOW)

### 3. **Evidence Clustering**
- Group related citations by topic/claim
- Assess consensus across sources (STRONG/MODERATE/MIXED/DISPUTED)
- Identify gaps in evidence
- Flag for peer review if confidence is LOW

---

## File Structure

```
Madagascar/docs/
├── academic_rag_schema.md                    # Schema definitions (this file)
├── academic_rag_citations_extracted.json     # Source database (18 initial sources)
├── academic_rag_implementation_guide.md      # This guide
├── policy_rag_schema.md                      # Policy document schema
└── [publication files]/
    └── POLICY_BRIEF_Madagascar_CoralReef.md  # Publication with citation links
```

---

## Working with the Academic RAG

### Adding New Sources

**Step 1: Find source metadata**
- Title, authors, year
- DOI / URL
- Abstract
- Keywords, geographic/ecosystem focus

**Step 2: Create Academic Source record**
```json
{
  "source_id": "source_2026_wio_020",  // increment counter
  "source_type": "PEER_REVIEWED_JOURNAL",
  "title": "Your Source Title",
  "authors": ["Author A", "Author B"],
  "publication_year": 2026,
  "doi": "10.xxxx/xxxxx",
  "url": "https://...",
  "abstract": "...",
  "keywords": ["tag1", "tag2"],
  "geographic_focus": ["Madagascar", "WIO"],
  "ecosystem_focus": ["Coral Reefs"],
  "quality_score": 0.90,  // 0-1 scale
  "metadata": {
    "indexed_date": "2026-03-16",
    "pdf_available": true,
    "pdf_path": "Madagascar/docs/sources/Author_2026_Title.pdf"
  }
}
```

**Step 3: Add to `academic_rag_citations_extracted.json`**

### Linking Citations in Publications

**Step 1: Write your claim/statement**
```
"South Africa's ecosystem extent accounts demonstrate the feasibility of
national-scale SEEA EA implementation in African contexts."
```

**Step 2: Identify supporting sources**
- Search `academic_rag_citations_extracted.json` for relevant sources
- Look for sources matching your geographic/ecosystem focus
- Check abstract/keywords for relevance

**Step 3: Create Citation record**
```json
{
  "citation_id": "cite_2026_001",
  "source_id": "source_2026_wio_002",  // Reference to source
  "publication_id": "POLICY_BRIEF_Madagascar_CoralReef",
  "claim_text": "South Africa's ecosystem extent accounts demonstrate...",
  "claim_section": "Implementation Examples",
  "claim_page_number": 5,
  "quote_text": "By documenting changes from the historical state...",
  "quote_page": "p. 128",
  "paraphrase_level": "CLOSE_PARAPHRASE",
  "claim_type": "FACTUAL",
  "confidence_level": "HIGH",
  "supporting_sources": ["source_2026_wio_003"],
  "contradicting_sources": [],
  "context_notes": "Direct evidence of South Africa implementation success"
}
```

**Step 4: Add inline reference in publication**
```markdown
South Africa's ecosystem extent accounts demonstrate the feasibility
of national-scale SEEA EA implementation in African contexts
[cite_2026_001].
```

### Quality Assurance Checklist

Before finalizing a publication:

- [ ] All major claims have at least one citation
- [ ] Claims with policy relevance have HIGH or MEDIUM confidence citations
- [ ] Contradicting sources are explicitly acknowledged
- [ ] At least 70% of citations are PEER_REVIEWED or official POLICY_DOCUMENT
- [ ] Geographic/ecosystem specificity is clear (avoid overgeneralizing from single studies)
- [ ] Evidence Clusters created for each major topic area
- [ ] Consensus levels documented for contested claims
- [ ] Data gaps explicitly listed with recommendations

---

## Common Workflows

### Workflow 1: Writing a Policy Brief

1. **Outline your brief** with key claims
2. **Search for supporting sources**
   ```
   "What sources address Madagascar's SEEA EA capacity?"
   Search: geographic_focus = "Madagascar"
           AND relevance_tags = "ecosystem_accounting"
   ```
3. **Create Evidence Clusters** for each section
4. **Link citations** in draft text using `[cite_ID]` markers
5. **Generate Citation Completeness Report** (see tools below)
6. **Peer review** flagged LOW confidence claims
7. **Publish** with full citation list

### Workflow 2: Integrating with Policy RAG

**Policy RAG** (existing system) tracks:
- National policies (laws, decrees, strategies)
- International commitments (treaties, declarations)
- Implementation status

**Academic RAG** (new system) tracks:
- Peer-reviewed evidence supporting policy
- Data gaps identified by research
- Alternative implementation approaches

**Integration Query Example:**
```
"Show me the academic evidence supporting Madagascar's
Nairobi Convention obligation to establish ecosystem
condition accounts for coastal/marine ecosystems."

Response should include:
- Relevant academic sources (south African case studies,
  Kenya implementation guidance, SEEA EA framework)
- Linkage to policy commitments
- Data gaps and research recommendations
```

### Workflow 3: Creating an Evidence Brief

1. **Define your central claim**
   ```
   "Madagascar's marine ecosystem accounting should
   prioritize fish condition indices following SEEA EA methods."
   ```

2. **Search for all related sources**
   ```
   Search: (relevance_tags = "fish_condition"
            OR ecosystem_focus = "Coral Reefs")
           AND (peer_review_status = "PEER_REVIEWED"
            OR quality_score > 0.85)
   ```

3. **Create Evidence Cluster**
   ```json
   {
     "cluster_id": "evidence_fish_condition_priority",
     "claim_statement": "[your central claim]",
     "citations": ["cite_2026_001", "cite_2026_004", ...],
     "consensus_level": "MODERATE_CONSENSUS",
     "key_papers": ["source_2026_019"],
     "gaps_or_limitations": "Limited Madagascar-specific baseline data..."
   }
   ```

4. **Synthesize findings** into brief

---

## Tools & Scripts

### Citation Completeness Report (Python)

```python
import json

def generate_citation_report(publication_id, citations_file):
    """Generate citation coverage report for publication"""

    with open(citations_file) as f:
        data = json.load(f)

    citations = [c for c in data['citations']
                 if c['publication_id'] == publication_id]

    total_claims = estimate_claims(publication_id)  # from text analysis
    verified = sum(1 for c in citations if c['confidence_level'] == 'HIGH')

    confidence_dist = {
        'HIGH': sum(1 for c in citations if c['confidence_level'] == 'HIGH'),
        'MEDIUM': sum(1 for c in citations if c['confidence_level'] == 'MEDIUM'),
        'LOW': sum(1 for c in citations if c['confidence_level'] == 'LOW'),
    }

    report = {
        'publication': publication_id,
        'total_citations': len(citations),
        'completeness_percent': (verified / total_claims) * 100,
        'confidence_distribution': confidence_dist,
        'flags': [c['citation_id'] for c in citations
                  if c['confidence_level'] == 'LOW']
    }

    return report
```

### Source Finder (SQL-like pseudocode)

```sql
-- Find all sources on fish condition in WIO
SELECT * FROM academic_rag_sources
WHERE (ecosystem_focus CONTAINS "Fish" OR keywords CONTAINS "fish_condition")
  AND (geographic_focus CONTAINS "Madagascar" OR geographic_focus CONTAINS "WIO")
  AND quality_score > 0.85
ORDER BY publication_year DESC
```

### Consensus Mapper

Create a visual showing:
- Which claims have STRONG consensus (3+ high-quality sources)
- Which are MODERATE (2 sources with minor differences)
- Which are DISPUTED (conflicting sources)
- Which have NO CONSENSUS (single source)

---

## Citation Format for Publications

### In-Text Citation
Use bracket notation: `[cite_ID]` or `[cite_ID1, cite_ID2]`

Example:
```
"South Africa's Land and Terrestrial Ecosystem Accounts
[cite_2026_001] provide a proven model for national-scale
ecosystem accounting in African contexts."
```

### Footnote Format (Alternative)
```
¹ Stats SA & SANBI (2017). "Land and Terrestrial Ecosystem
Accounts, 1990 to 2014." Government of South Africa.
```

### Full Citation List
At end of publication, generate complete citation list from linked sources:

```markdown
## References

[cite_2026_001] Stats SA & SANBI (2017). Land and Terrestrial
Ecosystem Accounts, 1990 to 2014. Government of South Africa.

[cite_2026_002] UNSD (2021). System of Environmental-Economic
Accounting—Ecosystem Accounting. United Nations Statistical Commission.

[cite_2026_003] ...
```

---

## Best Practices

### DO:
- Link every factual claim to at least one source
- Include direct quotes when claiming specific findings
- Note page numbers for traceability
- Assess confidence honestly (don't rate uncertainty as HIGH)
- Group related claims into Evidence Clusters
- Flag contradictions and explain them
- Update sources as new research emerges

### DON'T:
- Over-cite: not every sentence needs a citation
- Misquote or paraphrase incorrectly: verify quotes directly
- Ignore contradicting sources: acknowledge them and explain differences
- Use paywalled sources without access: mark as inaccessible, note alternative
- Claim consensus where none exists: use appropriate consensus levels
- Cite gray literature without quality assessment

---

## Integration with Policy RAG

Your existing **Policy RAG** tracks Madagascar's legal/policy framework.
This **Academic RAG** complements it by tracking the *evidence base*.

### Cross-Linking Workflow

1. **Policy → Evidence:**
   ```
   Policy: "Madagascar must establish coral reef condition accounts
   (Nairobi Convention Article X)"

   Evidence Query: Show academic sources supporting this obligation:
   - SEEA EA framework documents
   - Regional precedents (South Africa, Kenya)
   - Data availability assessments
   ```

2. **Evidence → Policy Implementation:**
   ```
   Evidence: "Ecosystem condition indices for fish require
   biomass measurements following SEEA EA Annex Table Y"

   Policy Query: Which Madagascar decrees authorize this data collection?
   - Ministry of Fisheries authority
   - Data ownership/access rights
   - Budget allocation requirements
   ```

### Database Integration (Pseudocode)

```python
# Link academic evidence to policy commitments
def link_evidence_to_policy():
    for commitment in policy_rag['commitments']:
        # Find academic sources supporting this commitment
        supporting_sources = find_sources(
            keywords = commitment['key_obligations'],
            geographic_focus = 'Madagascar'
        )

        commitment['academic_evidence'] = supporting_sources
        commitment['evidence_gaps'] = identify_gaps(supporting_sources)

    return commitment_enriched_with_evidence
```

---

## Next Steps: Expected Additional PDFs

You mentioned "Expect more PDFs." When you provide them:

1. **Extract metadata** following Academic Source schema
2. **Assign source_id** (increment counter: source_2026_021, source_2026_022, etc.)
3. **Complete quality_score** based on peer review status and relevance
4. **Add to academic_rag_citations_extracted.json**
5. **Link to relevant claims** in your publication
6. **Update Evidence Clusters** as needed

### Priority PDF Categories to Watch For:
- **Madagascar-specific:** coral reef surveys, fisheries data, ecosystem assessments
- **SEEA EA methodological:** guidance documents, working papers from UNSD
- **WIO regional:** MPA reports, ocean account guidance, marine spatial planning
- **Economic valuation:** fisheries economics, ecosystem service pricing, natural capital methods

---

## Quick Reference: Key Acronyms

| Acronym | Meaning |
|---------|---------|
| SEEA EA | System of Environmental-Economic Accounting—Ecosystem Accounting |
| RAG | Retrieval-Augmented Generation |
| WIO | Western Indian Ocean |
| SIDS | Small Island Developing States |
| WAVES | Wealth Accounting and Valuation of Ecosystem Services |
| ANCA | Advancing Natural Capital Accounting |
| GOAP | Global Ocean Accounts Partnership |
| UNSD | United Nations Statistics Division |
| MPRH | Ministry of Fisheries and Marine Resources (Madagascar) |

---

## Getting Help

For questions on:
- **Academic RAG schema:** See `academic_rag_schema.md`
- **Existing sources:** See `academic_rag_citations_extracted.json`
- **Policy integration:** See `policy_rag_schema.md`
- **Publication template:** See `template_seea_publication.md`
