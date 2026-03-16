# Template: Scientific Publication of SEEA EA Environmental-Economic Accounts

**For:** Peer-reviewed journal articles, technical reports, and institutional repositories
**Framework:** UN System of Environmental-Economic Accounting — Ecosystem Accounting (SEEA EA)
**Target audience:** Environmental economists, ecologists, policy makers, institutional repositories (WRI, UNEP, et al.)

---

## SKELETON: Section Architecture & Guidance

### 1. **Title & Abstract** (0.5 page)
**Purpose:** Signal methodological rigor and policy relevance to editorial gatekeepers and database indexers.

**Content guidance:**
- Title must include explicit framework reference (e.g., "…using SEEA EA framework")
- Abstract: state ecosystem type, accounting period, headline condition/extent/value figures, and policy application
- Include data sources, number of observation stations/sites, and measurement period

**Audience signal:** "This follows international standards; results are reproducible and policy-ready."

---

### 2. **Introduction: Ecosystem & Policy Context** (1–1.5 pages)
**Purpose:** Establish why this ecosystem matters and what gap this account fills.

**Content guidance:**
- Describe focal ecosystem type (phylum, habitat, functional role)
- Link to SDGs, national/regional policy (e.g., MEA targets, fisheries policy, conservation pledges)
- Summarize existing condition/service assessments (if any) and methodological gaps this work addresses
- State research question(s): *What is the current condition/extent/economic value of X ecosystem, and how does it compare to reference levels?*

**Data/output expectations:**
- Reference map showing study area boundaries and sampling sites
- Table of key ecosystem services and their economic relevance (qualitative or monetary)

**Reproducibility requirement:** Cite SEEA EA technical handbooks (UN 2021, UNEP 2023) and relevant case studies (e.g., Costa Rica, Philippines, WAVES).

---

### 3. **Methods: Data, Indicators & Standardised Accounting** (2–2.5 pages)

#### 3a. Data Sources & Study Design
**Purpose:** Establish data quality and measurement rigor.

**Content guidance:**
- Table: data source (provider, collection date, method, spatial coverage, temporal scope, n observations/sites)
- Field sampling design: transect area, replicate design, observer training, QA/QC steps
- Remote sensing data: sensor, resolution, preprocessing, validation method

**Data/output expectations:**
- **Table 1:** Data inventory (source, dates, spatial/temporal extent, sample size, quality flags)
- **Figure 1:** Study area map with site locations, habitat zones, protected area boundaries

**Reproducibility requirement:** Reference observer credentials, training manuals, instrument calibrations, and dataset DOIs/availability statements.

---

#### 3b. Ecosystem Condition Accounting
**Purpose:** Link biotic measurements to SEEA EA condition indices (0–1 scale).

**Content guidance:**
- State which SEEA EA Condition Account template applies (e.g., biotic structure, water quality, habitat intactness)
- Define measurement indicators (e.g., fish biomass, species richness, coral cover) and justify against SEEA EA typology
- Explain standardisation pathway: raw measurements → species-level metrics → functional-group aggregation → normalisation to condition indices (0–1)
- Disclose reference levels (target/pristine baselines) with citations
- Identify and justify functional groups (e.g., herbivores, piscivores) or taxa groups (bivalves, echinoderms)

**Data/output expectations:**
- **Table 2:** Indicator definitions, measurement units, data source, reference level, and justification
- **Figure 2:** Condition index distributions across sites (box plot, violin plot, or heatmap)
- **Table 3:** Site-level condition account (rows = sites; columns = indicators + index)

**Reproducibility requirement:** Cite SEEA EA biotic condition methodology; provide formula for normalisation (e.g., C_i = measured / reference).

---

#### 3c. Ecosystem Extent Accounting (if applicable)
**Purpose:** Quantify spatial footprint of ecosystem state changes.

**Content guidance:**
- Describe benthic habitat classification (e.g., Sentinel-2 supervised classification, ground-truth validation)
- Map extent by habitat class and temporal change (t₀ → t₁)
- Disaggregate by spatial unit: total extent, per protected area, per management zone

**Data/output expectations:**
- **Figure 3:** Extent map (habitat classes, t₀ and t₁ if multi-temporal)
- **Table 4:** Extent account (ha by habitat class; percentage change if available)

**Reproducibility requirement:** Document classification accuracy (confusion matrix, producer/user accuracy); cite satellite data standard bands and classification protocol.

---

#### 3d. Ecosystem Services Valuation (if applicable)
**Purpose:** Quantify economic contribution to livelihoods and national accounts.

**Content guidance:**
- Identify services evaluated (e.g., fisheries nursery, wild fish provisioning, recreation, coastal protection)
- For each service: link to condition/extent account, state valuation method (avoided cost, market price, replacement cost, etc.), disclose assumptions and data sources
- Sensitivity analysis: vary key parameters (market prices ±25%, discount rates, reference baselines) and report ranges
- Comparison to baseline or business-as-usual scenario

**Data/output expectations:**
- **Table 5:** Service valuation summary (service, method, annual value USD, uncertainty/range, key parameters)
- **Figure 4:** Sensitivity tornado plot (which parameters most affect value?)

**Reproducibility requirement:** Cite SEEA EA service valuation methodologies (UN 2023, WAVES case studies); provide price data sources, discount rate justification, and scenario definitions.

---

### 4. **Results: Condition, Extent & Services by Site** (1.5–2 pages)
**Purpose:** Present empirical findings in tables and figures; anchor to SEEA EA account structure.

**Content guidance:**
- Summarize headline findings for condition (mean, range, by functional group or site tier)
- Compare condition to reference level: "X% of sites exceed reference level; Y% of sites below recovery threshold"
- If multi-year data: describe temporal trends
- If zoned (e.g., protected vs. unprotected): report disaggregated condition and service value by zone

**Data/output expectations:**
- **Table 6:** Condition account summary (ecosystem type, accounting period, condition indices with 95% CI, comparison to reference)
- **Figure 5:** Condition by site and functional group (stacked bar, radar plot, or animated map)
- **Table 7:** Service value disaggregated by management zone or governance unit (enables policy cost-benefit analysis)

**Reproducibility requirement:** Report sample sizes, statistical tests (ANOVA, bootstrapped CIs), and assumptions tested (normality, independence).

---

### 5. **Discussion: Drivers, Limitations & Policy Pathways** (1.5–2 pages)
**Purpose:** Interpret results in context of ecosystem dynamics, methodological constraints, and policy relevance.

**Content guidance:**
- Explain what drove observed condition (e.g., fishing pressure, sedimentation, climate stress); cite field observations or prior literature
- Address limitations: sampling effort, taxonomic resolution, reference level uncertainty, extrapolation caveats
- Flag open questions for future research
- Link condition/service results to policy: *Which ecosystem states require intervention? Which restoration pathways are viable?*
- Contrast this accounting with prior or alternative methods

**Data/output expectations:**
- Explicit statement of methodological assumptions and their sensitivity
- Table of data gaps and proposed acquisition timeline

**Reproducibility requirement:** Disclose all assumptions in a "Methods Transparency" box; provide code availability statement (GitHub, Zenodo, OSF).

---

### 6. **Conclusions & Next Steps** (0.5 page)
**Purpose:** Restate headline findings and operationalize for policy/management.

**Content guidance:**
- One-sentence summary of condition/extent/value
- Link to national policy and international commitments
- Identify next account to publish

**Audience signal:** "This account is policy-actionable and part of a living system; stakeholders can use it today."

---

### 7. **Data Availability & Supplementary Materials** (0.5 page)
**Purpose:** Maximize reproducibility and institutional uptake.

**Content guidance:**
- **Data availability statement:** Where raw field data, code, and processed account tables can be accessed (DOI, repository URL, license)
- **Code availability:** Link to analysis scripts (GitHub tag, Zenodo release)
- **Supplementary appendices** (if space permits):
  - Appendix A: Data QA/QC log (corrections made, outliers flagged)
  - Appendix B: SEEA EA account tables in full (extended version of Tables 3, 4, 6–7)
  - Appendix C: Sensitivity analysis detail (parameter ranges, tornado charts)
  - Appendix D: Observer field manuals and training materials

**Reproducibility requirement:** Cite SEEA EA data standards (SEEA Data Collaborator Network); commit to 10-year archival.

---

## Notes on Using This Template

This template is designed to structure SEEA EA environmental-economic accounts for publication in peer-reviewed venues or institutional repositories. It provides:

1. **Section architecture:** A 7-section structure aligned with SEEA EA methodological standards
2. **Reproducibility checkpoints:** Explicit reproducibility requirements at each step
3. **Flexibility:** Sections 3b–3d are marked "if applicable" — condition-only, extent-only, or full integrated accounts can use the subset of sections that apply
4. **Data-to-narrative flow:** Raw measurements → standardised indicators → policy-actionable accounts

## Adapting This Template for Your Ecosystem

When adapting for a specific ecosystem and region:

1. **Title & Abstract:** Insert your ecosystem type (e.g., "Photic Coral Reefs M1.3, Madagascar"), accounting period (dates), and data source (e.g., "27 UVC sites, Nov 2025–Feb 2026")
2. **Introduction:** Replace ecosystem and policy context sections with your specific ecosystem (region, ecosystem code, policy drivers)
3. **Methods:** Populate Section 3a with your data sources; Sections 3b–3d with your specific indicators, reference levels, and valuation methods
4. **Results:** Fill Tables 6–7 and Figures 5 with your empirical findings
5. **Discussion:** Address your ecosystem's specific drivers and policy constraints
6. **Conclusion:** Link to your country/region's policy and international commitments

See country-specific examples in the `Madagascar/docs/` and `Mozambique/docs/` folders for worked examples.
