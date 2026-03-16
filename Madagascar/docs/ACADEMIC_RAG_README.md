# Academic RAG System — Madagascar SEEA EA Project

## What Is This?

A **Retrieval-Augmented Generation (RAG) system** for academic publications that ensures every claim is linked to specific, traceable citations. This system complements your existing policy RAG and enables rigorous evidence-based publications.

**Files created (2026-03-16):**
1. **academic_rag_schema.md** — Schema definitions for sources, citations, evidence clusters
2. **academic_rag_citations_extracted.json** — Database of 18 extracted academic/policy sources
3. **academic_rag_implementation_guide.md** — Step-by-step workflow for using the RAG
4. **ACADEMIC_RAG_README.md** — This file (entry point)

---

## Why You Need This

### Problem
When writing academic publications or policy briefs, you need to:
- Link each claim to a specific source
- Track confidence levels (HIGH/MEDIUM/LOW)
- Identify where evidence is strong vs. weak
- Handle contradictions between sources
- Meet academic rigor standards

### Solution
This RAG system provides:
- **Structured citation tracking** — Know exactly where each claim comes from
- **Confidence assessment** — Distinguish between well-supported vs. tentative claims
- **Consensus mapping** — See which claims have strong consensus vs. disputed views
- **Gap identification** — Know what evidence is missing
- **Publication audit** — Completeness report before publication

---

## Quick Start (5 minutes)

### 1. Understand What You Have

**18 Initial Sources** extracted from your "Environmental-Economic Accounting Transitions in the WIO" academic background document:

- ✅ **SEEA EA Framework** — UN statistical standard (2021)
- ✅ **South Africa Case Study** — Mature implementation paradigm
- ✅ **Kenya Implementation** — Active adoption (2024 National Plan)
- ✅ **Madagascar Foundational Work** — WAVES accounts (forests, water)
- ✅ **Mauritius SIDS Example** — Corporate/watershed modeling
- ✅ **Mozambique Development** — Energy accounts (foundation)
- ✅ **Seychelles/GOAP** — Ocean accounting specialization
- ✅ **Fish Biomass Reference** — MacNeil et al. (2015)
- ✅ **Regional Assessment** — NoCaMo project ($5.7B/yr valuation)

### 2. See the Schema

Open **academic_rag_schema.md** to understand:
- How to define academic sources
- How to link citations to claims
- How to create evidence clusters
- Quality metrics and controlled vocabularies

### 3. Use the Implementation Guide

Open **academic_rag_implementation_guide.md** for:
- Step-by-step workflows
- Common patterns (policy brief, evidence brief)
- Citation format templates
- Python/SQL scripts for automation

### 4. Start Your Publication

Template workflow:
```
1. Outline your publication (e.g., policy brief on Madagascar reef accounting)
2. Search academic_rag_citations_extracted.json for relevant sources
3. For each claim: identify supporting sources
4. Create Citation records linking claim → source
5. Run completeness report
6. Peer review flagged LOW confidence claims
7. Publish with full citation list
```

---

## Your Current Publication

**File:** `POLICY_BRIEF_Madagascar_CoralReef.md`

**Status:** Ready for citation linking

**Next steps:**
1. [ ] Read through policy brief
2. [ ] For each major claim, identify supporting source(s)
3. [ ] Add citation links: `[cite_ID]` or `[cite_ID1, cite_ID2]`
4. [ ] Create Evidence Clusters for each section
5. [ ] Generate completeness report
6. [ ] Peer review

---

## File Inventory

### Core RAG Files
| File | Purpose | Size |
|------|---------|------|
| `academic_rag_schema.md` | Schema definitions + examples | ~700 lines |
| `academic_rag_citations_extracted.json` | Source database + initial 18 sources | ~1200 lines |
| `academic_rag_implementation_guide.md` | How-to guide + workflows | ~600 lines |
| `ACADEMIC_RAG_README.md` | This file (entry point) | — |

### Related Files (Your Existing System)
| File | Purpose |
|------|---------|
| `policy_rag_schema.md` | Policy document RAG (Madagascar laws, international commitments) |
| `policy_rag_sample_data.json` | Sample policy data |
| `POLICY_BRIEF_Madagascar_CoralReef.md` | Your main publication (ready for citation linking) |

---

## Integration Points

### With Policy RAG
**Your existing policy RAG** tracks Madagascar's legal framework.
**This academic RAG** tracks the evidence base supporting that framework.

**Cross-linking example:**
```
Policy: "Madagascar must establish coral reef condition accounts"
        (from Nairobi Convention commitment)
        ↓
Academic Evidence: South Africa's Land & Terrestrial Ecosystem Accounts
                   (demonstrates feasibility)
                   Kenya's National Plan for AEEA (regional precedent)
                   SEEA EA Framework (methodological standard)
```

### With Your Existing Publications
- **Skills library** (`Madagascar/docs/skills/`) — Now you can cite the academic evidence supporting each skill
- **Policy briefs** — Each claim can be traced back to academic sources
- **Technical reports** — Rigorous evidence trail for peer review

---

## How to Add New Sources

When you provide additional PDFs:

### Fast Track (5 minutes)
```json
{
  "source_id": "source_2026_020",
  "source_type": "PEER_REVIEWED_JOURNAL",
  "title": "[title from PDF]",
  "authors": "[authors from PDF]",
  "publication_year": 2026,
  "doi": "[if available]",
  "url": "[access link]",
  "abstract": "[first 200 words or summary]",
  "quality_score": 0.85,
  "pdf_path": "Madagascar/docs/sources/[filename].pdf",
  "metadata": {
    "indexed_date": "2026-03-XX",
    "notes": "[why this source is relevant]"
  }
}
```

Add this JSON object to `academic_rag_citations_extracted.json` under `"sources": [...]`

### Quality Assessment

Rate each source on quality (0-1):
- **0.95-1.0** — Peer-reviewed or official UN/government document
- **0.85-0.95** — Peer-reviewed, reputable secondary source
- **0.75-0.85** — Reputable NGO/research report with solid methodology
- **0.60-0.75** — Gray literature, preliminary, some methodological questions
- **<0.60** — Anecdotal, preliminary, limited evidence base

---

## Common Questions

### Q: Do I need to cite every sentence?
**A:** No. Cite:
- Factual claims (especially numbers)
- Methodological statements
- Claims relevant to policy decisions
- Anything you quote directly

Don't cite:
- Common knowledge
- Your own analysis
- Logical deductions from cited facts

### Q: What if I can't find a source for a claim?
**A:** Options:
1. Delete the claim (if not essential)
2. Reframe as "preliminary finding" or "likely hypothesis"
3. Flag it for research (add to gaps)
4. Request additional sources from team

### Q: How do I handle contradicting sources?
**A:** Explicitly acknowledge:
```
"While Smith et al. (2020) [cite_001] found fish biomass of 450 kg/ha,
Johnson et al. (2023) [cite_002] reported 650 kg/ha. The discrepancy
likely reflects [geographic variation / methodology differences / etc.]"
```

### Q: What if a source is paywalled?
**A:** Mark it in metadata:
```json
{
  "access_type": "PAYWALLED",
  "full_text_available": false,
  "notes": "Available through university subscription or interlibrary loan"
}
```

You can still cite it if you have access; just note the access barrier.

---

## Next Steps: Your Action Items

### Immediate (This Week)
- [ ] Read `academic_rag_schema.md` to understand structure
- [ ] Open `POLICY_BRIEF_Madagascar_CoralReef.md`
- [ ] Identify 3-5 major claims that need citations
- [ ] Find supporting sources from `academic_rag_citations_extracted.json`

### Short-term (Next 2 Weeks)
- [ ] Link all claims in policy brief to sources
- [ ] Create Evidence Clusters for each section
- [ ] Generate citation completeness report
- [ ] Peer review LOW confidence claims

### Medium-term (Next Month)
- [ ] Integrate with policy RAG (cross-link to Madagascar commitments)
- [ ] Add new PDFs as you receive them
- [ ] Create publication-specific citation lists
- [ ] Build automated completeness checker

---

## Tools Available

### Python Scripts (In Implementation Guide)
- `generate_citation_report()` — Citation completeness analysis
- `source_finder()` — SQL-like source search
- `link_evidence_to_policy()` — Cross-linking with policy RAG

### Search Capabilities
Once data is structured, you can query:
- "All sources on fish condition in Madagascar"
- "Which claims lack peer-reviewed support?"
- "What is the consensus on fish biomass reference level?"
- "Which Nairobi Convention commitments lack academic evidence?"

---

## Example: Full Publication Workflow

### Starting Point
You have: POLICY_BRIEF_Madagascar_CoralReef.md (draft, no citations)

### Step 1: Outline with Evidence Plan
```markdown
## Executive Summary
Claim: Madagascar's marine ecosystems provide $5.7B annual ecosystem value
Supporting source: source_2026_wio_016 (NoCaMo project)
Confidence: HIGH

## Background: SEEA EA Framework
Claim: SEEA EA adopted as UN statistical standard in 2021
Supporting source: source_2026_wio_001 (UNSD official document)
Confidence: HIGH

Claim: 98 countries implementing SEEA by 2025
Supporting source: source_2026_wio_018 (UNSD Global Assessment)
Confidence: HIGH

[... continue for each section ...]
```

### Step 2: Add In-Text Citations
```markdown
Madagascar's marine ecosystems provide substantial economic value,
estimated at US $5.7 billion annually [cite_2026_016]. This value
aligns with the System of Environmental-Economic Accounting—Ecosystem
Accounting (SEEA EA) framework [cite_2026_001], adopted as an
international statistical standard by the United Nations in 2021
[cite_2026_001].
```

### Step 3: Create Evidence Clusters
```json
{
  "cluster_id": "evidence_wio_value",
  "claim_statement": "WIO marine ecosystems deliver substantial economic value that is largely invisible in national GDP",
  "citations": ["cite_2026_016"],
  "consensus_level": "MODERATE_CONSENSUS",
  "key_papers": ["source_2026_016"],
  "gaps": ["Need Madagascar-specific valuation", "Regional variation not documented"]
}
```

### Step 4: Generate Report
```
Citation Completeness Report: POLICY_BRIEF_Madagascar_CoralReef
===============================================
Total claims: 28
Cited claims: 26 (92%)
Completeness: 92% ✅

Confidence distribution:
- HIGH: 18 (64%)
- MEDIUM: 7 (25%)
- LOW: 1 (4%)
- DISPUTED: 0 (0%)

Flags for review:
- Claim "Fish biomass reference level of 500 kg/ha" [cite_LOW_001]
  Reason: Single source; Madagascar-specific data lacking

Recommendation: Publish with flag on fish biomass reference level
```

### Step 5: Publish
Include full citations list at end, cross-referenced to in-text markers.

---

## Contact & Support

For questions on:
- **Schema definitions** → See `academic_rag_schema.md`
- **Implementation workflows** → See `academic_rag_implementation_guide.md`
- **Specific sources** → See `academic_rag_citations_extracted.json`
- **Policy integration** → See `policy_rag_schema.md`

---

## Appendix: Initial Sources at a Glance

| Source ID | Title | Type | Year | Focus |
|-----------|-------|------|------|-------|
| source_2026_wio_001 | SEEA EA Framework | Policy | 2021 | Global standard |
| source_2026_wio_002 | SA Land & Terrestrial Accounts | Report | 2017 | South Africa paradigm |
| source_2026_wio_003 | SA Protected Areas Accounts | Report | 2020 | Thematic accounting |
| source_2026_wio_005 | Kenya National Plan AEEA | Report | 2024 | Kenya implementation |
| source_2026_wio_008 | Madagascar Forest Accounts | Report | 2015 | Madagascar capacity |
| source_2026_wio_010 | Mahavavy-Kinkony ENCA | Report | 2025 | Madagascar recent |
| source_2026_wio_016 | NoCaMo Natural Capital | Report | 2023 | WIO valuation |
| source_2026_wio_018 | UNSD Global Assessment | Report | 2025 | Global momentum |
| source_2026_wio_019 | MacNeil Fish Biomass | Journal | 2015 | Reference levels |

---

**Ready to start? Open `academic_rag_implementation_guide.md` for step-by-step instructions.**

**Have PDFs to add? Follow the "How to Add New Sources" section above.**

**Questions? Check the FAQ or review the schemas.**

---

*Last updated: 2026-03-16*
*Schema version: 1.0*
*Total sources: 18 (initial extraction)*
*Status: Ready for publication workflow*
