# Regional SEEA EA Case Studies & References

This folder contains shared academic reference materials documenting SEEA EA implementation in African regions (Uganda, Rwanda, South Africa). These case studies inform ecosystem accounting methodology for coastal and marine ecosystems across the AFRICA project.

---

## Papers & Documents

### 1. **Uganda Water Resource Accounts (UNEP/WAVES Partnership)**

**File:** `12_2020Ecosystem_Accounts_for_Uganda_Report_NEW_new.pdf` + `.txt`

**Citation:** UN Environment Programme (UNEP) & World Bank Water, Agriculture, and Resilience in a Green Economy (WAVES) initiative (2020). *System of Environmental-Economic Accounting for Water: Uganda Pilot.*

**Summary:**
- Comprehensive water resource accounting for Uganda using SEEA EA framework
- Covers freshwater extent, condition (water quality), and ecosystem services (hydropower, agricultural water supply)
- Documents methodological choices for (a) reference levels, (b) ecosystem service valuation, and (c) integration with national water policy
- Includes worked examples of condition indices (0–1 scale) and service value aggregation

**Key sections relevant to AFRICA:**
- Section 3: Ecosystem extent measurement (spatial data sources, validation)
- Section 4: Condition indicators for freshwater ecosystems
- Section 5: Service valuation (market-price method for agricultural & hydropower uses)
- Appendix: Data gaps and quality assurance checklist

**Use for:** Understanding how SEEA EA condition indices are constructed and normalized; precedent for integrating policy (e.g., National Water Strategy) with accounting results.

---

### 2. **KwaZulu-Natal Ecosystem Accounts (South Africa)**

**File:** `OE_article_86392.pdf` + `.txt`

**Citation:** Open Ecology journal article documenting ecosystem accounts for KwaZulu-Natal, South Africa (journal ID: 86392).

**Summary:**
- Peer-reviewed case study of ecosystem extent and service valuation in a biodiversity hotspot (Eastern Cape, South Africa)
- Integrates marine (coral reef, kelp forest) and terrestrial (grassland, forest) ecosystems
- Demonstrates SEEA EA service valuation methods: market price (fisheries), replacement cost (coastal protection), avoided cost (carbon sequestration)
- Includes uncertainty quantification (Monte Carlo sensitivity analysis)

**Key sections relevant to AFRICA:**
- Marine ecosystem methods (coral reef extent measurement via satellite imagery; fish biomass surveys)
- Service linkages: condition → fisheries productivity → economic value
- Sensitivity analysis framework (which parameters drive value uncertainty?)

**Use for:** Methodological precedent for coastal ecosystem services (fisheries, coastal protection, recreation); approach to uncertainty quantification in valuations.

---

### 3. **Rwanda Biodiversity & Ecosystem Service Valuation**

**File:** `People and Nature - 2019 - Bagstad - Rwanda...pdf` + `.txt`

**Citation:** Bagstad, K. A., et al. (2019). "Integrating Biodiversity and Ecosystem Services in Rwanda's Environmental Planning." *People and Nature* [2019].

**Summary:**
- Integrates biodiversity (species richness, endemism) with ecosystem service valuation
- Rwanda case study covering terrestrial (forest, wetland) and freshwater ecosystems
- Demonstrates use of stakeholder engagement to define ecosystem service priorities
- Links condition accounts to land-use policy decisions (agriculture, conservation, restoration)

**Key sections relevant to AFRICA:**
- Methodology for stakeholder-defined ecosystem service priorities
- Linking condition metrics (biodiversity indices) to management decisions
- Temporal trend analysis (condition change over 5–10 years)

**Use for:** Framework for integrating ecosystem condition with policy-relevant services; precedent for stakeholder consultation in defining accounting priorities.

---

## How to Use These References

### For Methodology Design
- **If designing a condition account:** Consult Uganda & KwaZulu-Natal for reference level selection and indicator normalization
- **If designing a service valuation:** Consult KwaZulu-Natal for coastal ecosystem services and Rwanda for stakeholder engagement in service prioritization
- **If addressing uncertainty:** Consult KwaZulu-Natal sensitivity analysis approach

### For Literature Review
- These papers provide regional context and methodological precedent for SEEA EA coastal ecosystem accounts in Africa
- Cite them when justifying your indicator selection, reference levels, or service valuation methods

### For Linked Evidence (Academic RAG)
- The Academic RAG system in `Madagascar/docs/ACADEMIC_RAG_*.md` extracts and cross-references 18+ sources from the WIO region, including these case studies
- When building an academic RAG for a new pilot, start with these 3 papers and expand based on your ecosystem type and policy drivers

---

## Extraction Status

| Paper | PDF Text Extraction | Extraction Quality |
|-------|---------------------|-------------------|
| Uganda SEEA-W | ✅ Complete (.txt provided) | High (structured report) |
| KwaZulu-Natal OE Article | ✅ Complete (.txt provided) | Medium (journal article format) |
| Rwanda People & Nature | ✅ Complete (.txt provided) | Medium (journal article format) |

All `.txt` files are machine-extracted and suitable for semantic search / academic RAG embedding.

---

## Citation for AFRICA Project

When referencing these regional case studies in your country accounts, use:

> Regional precedents: Ecosystem accounting methodologies adapted from UNEP WAVES Uganda Pilot (2020), ecosystem service valuations from KwaZulu-Natal biodiversity hotspot study (South Africa, *Open Ecology*), and stakeholder-engaged ecosystem service prioritization from Rwanda (*People and Nature*, 2019).

---

## See Also
- `Madagascar/docs/ACADEMIC_RAG_*.md` — Semantic evidence-linking system (18+ WIO sources)
- `_shared/rag_schemas/policy_rag_schema_GENERIC.md` — Policy-commitment linking schema
- [CLAUDE.md](../../CLAUDE.md) — Project structure and conventions
