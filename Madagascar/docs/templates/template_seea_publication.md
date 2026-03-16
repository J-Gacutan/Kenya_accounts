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
- Include data sources, number of observation stations/sites, and measurement period (e.g., "27 sites, 5,186 UVC records, Nov 2025–Feb 2026")

**Audience signal:** "This follows international standards; results are reproducible and policy-ready."

---

### 2. **Introduction: Ecosystem & Policy Context** (1–1.5 pages)
**Purpose:** Establish why this ecosystem matters and what gap this account fills.

**Content guidance:**
- Describe focal ecosystem type (phylum, habitat, functional role; e.g., "photic coral reefs, M1.3, tropical Indo-Pacific")
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
- Disclose reference levels (target/pristine baselines) with citations (e.g., "500 kg/ha biomass from MacNeil et al. 2015")
- Identify and justify functional groups (e.g., herbivores, piscivores) or taxa groups (bivalves, echinoderms)

**Data/output expectations:**
- **Table 2:** Indicator definitions, measurement units, data source, reference level, and justification
- **Figure 2:** Condition index distributions across sites (box plot, violin plot, or heatmap)
- **Table 3:** Site-level condition account (27 rows = sites; columns = indicators + index)

**Reproducibility requirement:** Cite SEEA EA biotic condition methodology (skill_condition_biotic_fish_invert.md equivalent); provide formula for normalisation (e.g., C_i = measured / reference).

---

#### 3c. Ecosystem Extent Accounting (if applicable)
**Purpose:** Quantify spatial footprint of ecosystem state changes.

**Content guidance:**
- Describe benthic habitat classification (e.g., Sentinel-2 supervised classification, ground-truth validation)
- Map extent by habitat class (healthy reef, degraded reef, non-reef) and temporal change (t₀ → t₁)
- Disaggregate by spatial unit: total extent, per protected area, per management zone

**Data/output expectations:**
- **Figure 3:** Extent map (habitat classes, t₀ and t₁ if multi-temporal)
- **Table 4:** Extent account (ha by habitat class; percentage change if available)

**Reproducibility requirement:** Document classification accuracy (confusion matrix, producer/user accuracy); cite Sentinel-2 standard bands and classification protocol.

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
- Compare condition to reference level: "X% of sites exceed biomass reference level; Y% of sites below recovery threshold"
- If multi-year data: describe temporal trends (2025 vs. 2026)
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
- Flag open questions for future research (e.g., market price survey needed for nursery service, no-reef baseline transects for recovery trajectory)
- Link condition/service results to policy: *Which ecosystem states require intervention? Which restoration pathways are viable?*
- Contrast this accounting with prior or alternative methods (e.g., older habitat maps, expert judgment)

**Data/output expectations:**
- Explicit statement of methodological assumptions and their sensitivity (e.g., "Transect area = 100 m²; if 400 m²², condition indices shift by ±X%")
- Table of data gaps and proposed acquisition timeline (e.g., market price survey by Apr 2026, landings monitoring by Jun 2026)

**Reproducibility requirement:** Disclose all assumptions in a "Methods Transparency" box; provide code availability statement (GitHub, Zenodo, OSF).

---

### 6. **Conclusions & Next Steps** (0.5 page)
**Purpose:** Restate headline findings and operationalize for policy/management.

**Content guidance:**
- One-sentence summary of condition/extent/value
- Link to national policy (e.g., "Results feed Madagascar's marine spatial planning"; "Support fulfilment of SDG 14.2 commitment")
- Identify next account to publish (e.g., "Extent mapping now underway; services valuation pending market price survey")

**Audience signal:** "This account is policy-actionable and part of a living system; stakeholders can use it today."

---

### 7. **Data Availability & Supplementary Materials** (0.5 page)
**Purpose:** Maximize reproducibility and institutional uptake.

**Content guidance:**
- **Data availability statement:** Where raw field data, code, and processed account tables can be accessed (DOI, repository URL, license)
- **Code availability:** Link to R scripts (GitHub tag, Zenodo release)
- **Supplementary appendices** (if space permits):
  - Appendix A: Data QA/QC log (corrections made, outliers flagged)
  - Appendix B: SEEA EA account tables in full (extended version of Tables 3, 4, 6–7)
  - Appendix C: Sensitivity analysis detail (parameter ranges, tornado charts)
  - Appendix D: Observer field manuals and training materials

**Reproducibility requirement:** Cite SEEA EA data standards (SEEA Data Collaborator Network); commit to 10-year archival.

---

## EXAMPLE: Detailed Sections (2–3 sections in full)

### **Example Section 3b: Ecosystem Condition Accounting** (full detail)

#### Background
Ecosystem condition reflects the structural and functional health of biotic communities relative to a reference state. For coral reef fish and mobile macro-invertebrates, condition is assessed via three standardised indicators: (1) total fish biomass, (2) species richness, and (3) trophic functional group composition. These correspond to SEEA EA "Biotic Condition" template (UN 2021, Annex B.3) [1].

This approach has been successfully applied in peer-reviewed ecosystem accounting programs across the Western Indian Ocean region. South Africa's subnational ecosystem accounts demonstrate that reef condition indices can be meaningfully integrated with ecosystem service valuations [2], while Rwanda's 25-year ecosystem services trend analysis shows how condition monitoring reveals long-term ecosystem degradation drivers and the effectiveness of protected areas [3].

#### Measurement & Aggregation

**Field data:** Underwater visual census (UVC) of fish ≥2 cm and mobile invertebrates (holothuroids, echinoids, bivalves) at 27 sites (85 transects, 100 m² each; 20 m length × 5 m width) across SW Madagascar coral reefs, Nov 2025–Feb 2026. Each transect: species identification, size class (cm TL for fish; mm for urchins/clams), observer quality flag.

**Quality assurance:**
- All species standardised to taxonomy reference (Reef Life Survey; FishBase 2025)
- Outlier transects (n = 3) flagged for observer bias; sensitivity analysis run with/without
- GPS locations verified against habitat mapping; 4 sites relocated due to marine debris exclusion

**Biomass calculation:**
For fish, W (g) = a × L^b, where L = length (cm), and a, b sourced from FishBase family-level estimates. Equations applied across six size classes: larvae (2–5 cm), juvenile (6–15 cm), subadult (16–25 cm), small adult (26–35 cm), large adult (36–50 cm), mega fauna (>50 cm). Results aggregated to site-level total (kg) and scaled to per-hectare density (kg/ha).

Invertebrate biomass: Sea urchins (Echinometra, *Diadema*) and clams (Tridacna) measured as count/ha; COTS (*Acanthaster* spp.) reported as incident rate (number of sightings per transect); no direct biomass calculation due to field measurement constraints.

**Reference levels:**
- Fish biomass: 500 kg/ha (MacNeil et al. 2015, *Nature Sustainability*, pristine Indo-Pacific reefs, n=42 sites; ±150 kg/ha range to account for regional variation) [4]. This reference level aligns with biomass targets documented in other Indian Ocean reef systems and ecosystem accounting programs [5].
- Species richness: 85 species per site (observed median across 27 sites; reference: 120 spp. from historical biodiversity surveys, 1990s, same area, Randriarimanantena et al. 2003)
- Trophic functional group composition: Target state derived from ecosystem models (Palomares & Pauly 2009, EcoCpath); healthy reefs: herbivores 40–50%, corallivores 5–10%, piscivores 25–35%. This composition aligns with functional diversity targets established in peer-reviewed reef condition assessments [6].

**Normalisation to condition indices (0–1):**
Condition index C_i = measured_i / reference_i, capped at 1.0 (no "super-healthy" scores). For each indicator:
- C_biomass = observed_biomass / 500 kg/ha
- C_richness = observed_richness / 85 spp.
- C_functional = 1 - Σ|observed_fg% - target_fg%| / 200 (sum of squared deviations)

**Functional group assignment:** Fish aggregated post-hoc using ecological literature (reef fish feeding guilds; herbivorous, corallivorous, planktivorous, piscivorous) and functional trait databases (FishMORE 2025).

#### Results: Condition Account Table

| Site ID | n_transects | Fish_biomass_kg_ha | C_biomass | Fish_richness_spp | C_richness | Functional_balance_index | C_functional | Composite_condition_index | 95%_CI_lower | 95%_CI_upper |
|---------|------------|-------------------|-----------|------------------|-----------|------------------------|-------------|---------------------------|--------------|--------------|
| SW01    | 3          | 480               | 0.96      | 78               | 0.92      | 0.88                   | 0.88        | **0.92**                  | 0.81         | 1.00         |
| SW02    | 3          | 280               | 0.56      | 52               | 0.61      | 0.62                   | 0.62        | **0.60**                  | 0.47         | 0.73         |
| SW03    | 3          | 65                | 0.13      | 25               | 0.29      | 0.35                   | 0.35        | **0.26**                  | 0.15         | 0.40         |
| …       | …          | …                 | …         | …                | …         | …                      | …           | …                         | …            | …            |
| Mean (n=27) | 85      | 310 ± 145         | 0.62      | 61 ± 22          | 0.72      | 0.64 ± 0.18            | 0.64        | **0.66 ± 0.14**           | 0.56         | 0.76         |

**Interpretation:**
Mean composite condition index = 0.66 (moderate condition). 44% of sites exceed biomass reference level (C ≥ 0.80); 56% below recovery threshold (C < 0.60). Trophic imbalance (excess planktivores, low piscivore abundance) suggests historical overfishing signal; functional recovery potential estimated at 5–10 years with fishing pressure reduction (sensitivity: varies with discount rate assumption in service valuation).

---

### **Example Section 4: Results — Condition & Service Value** (full detail)

#### Headline Findings

**Ecosystem condition (2025–26 field season):**
The Madagascar M1.3 coral reef ecosystem shows moderate biotic condition (composite index = 0.66; 95% CI 0.56–0.76). Fish biomass averages 310 kg/ha (±145 range), 62% of the reference level. Species richness (61 ± 22 spp. per site) is below historical baseline (85 spp.), indicating biodiversity loss. Functional group composition skews toward small planktivores (48% vs. target 30%), suggesting trophic truncation consistent with selective removal of predators.

Geospatial pattern: Condition is highest in the south-western protected zone (C = 0.78, n=8 sites); lowest in the unprotected northeastern zone (C = 0.44, n=9 sites). The 0.34-unit difference suggests protection is effective, though absolute condition remains moderate across all zones.

**Ecosystem extent (2026 satellite mapping; preliminary):**
Total coral reef benthic habitat: 2,847 ha (±8% Sentinel-2 classification uncertainty). Habitat composition: healthy reef (1,203 ha, 42%), degraded reef (1,210 ha, 43%), seagrass transition (434 ha, 15%). Comparison to 1990 historical extent (4,200 ha) indicates 32% habitat loss over 36 years; primary driver: coastal sedimentation + fishing pressure (corroborated by field observer notes).

**Ecosystem services (provisional valuation):**
Annual economic value of wild fish provisioning: **USD 88,000 net profit** (range: USD 42K–134K at ±25% market price and cost uncertainty). Primary contribution: small pelagics and mullet (family *Carangidae*, *Mugilidae*), 65% of landings value.

Annual value of fisheries nursery service: **USD 61,000** (range: USD 27K–95K), based on juvenile fish biomass (42 kg/ha; functional recovery model; 5-year recruitment trajectory). This service depends critically on mangrove-seagrass nursery extent (not yet mapped; Mar 2026 priority).

No monetary estimate for recreation or coastal protection (data gaps: tourism visitor data, wave energy models).

#### Service Value Disaggregated by Management Zone

| Management Zone | Extent_ha | Condition_index | Wild_fish_USD | Nursery_service_USD | Total_value_USD | Value_per_ha_USD | 95%_range_USD |
|---|---|---|---|---|---|---|---|
| Protected (South-West) | 1,080 | 0.78 | 34,000 | 28,000 | 62,000 | 57 | 28–92 |
| Unprotected (North-East) | 1,767 | 0.44 | 54,000 | 33,000 | 87,000 | 49 | 22–74 |
| **Total** | **2,847** | **0.66** | **88,000** | **61,000** | **149,000** | **52** | **50–166** |

**Interpretation:**
Despite smaller extent, protected zone yields higher value per hectare (USD 57/ha vs. USD 49/ha in unprotected), driven by 0.34-unit condition premium. Expansion of protected area from 38% to 60% current extent would increase total ecosystem service value by ~USD 31,000/yr under current recovery trajectory (with 5-year lag for juvenile recruitment).

---

### **Example Section 5: Discussion — Limitations & Policy Pathways** (summary)

#### Methodological Assumptions & Sensitivities

| Assumption | Base value | Sensitivity range | Impact on condition index | Notes |
|---|---|---|---|---|
| Transect area | 100 m² | 400 m² (20×20) | −0.12 to +0.08 | Smaller transects increase per-ha scaling variance; awaiting field team confirmation |
| Fish biomass reference | 500 kg/ha | 350–650 kg/ha | ±0.15 | MacNeil et al. (2015) range spans Indo-Pacific; Madagascar-specific baseline needed |
| Species richness reference | 85 spp. | 70–100 spp. | ±0.08 | Historical survey (1990s) has lower taxonomy precision; may conflate cryptic species |
| Market price (pelagics) | USD 3.2/kg | USD 2.4–4.0/kg | ±25% on service value | Laza field notes (Nov 2025); formal fish market survey required (Mar 2026) |

#### Data Gaps & Acquisition Timeline

**Critical for this account (Mar–Jun 2026):**
1. **Market price survey** (Mar–Apr, 2 weeks): Engage local fish landing sites (n=5) to establish landed price distribution by family. Required for provisioning service refinement.
2. **No-reef baseline transects** (Apr–May, 3 weeks): Measure bare substrate community (macroalgae, rubble) to improve nursery service baseline and recovery model parameterisation.

**Essential for downstream services (Jun–Dec 2026):**
3. Landing site catch monitoring (Apr–Jun, ongoing): Partner with MPRH to log species, size, and weight at 3 landing sites; enables provisioning service validation and fisher welfare assessment.
4. Sentinel-2 extent time series (Mar–Jun): Validate 2025 classification against high-resolution orthomosaic; produce annual time-series 2015–2026 for trend analysis.

**Lower priority (context only):**
- Protected area shapefile update (WDPA Q4 2026 release): will refine protected/unprotected disaggregation
- Tourist visitor survey: feasibility assessment only (Jul 2026)

#### Policy Pathways: Restoration Scenarios

**Scenario A (Status quo, no intervention):**
Condition remains 0.66; service value plateaus at USD 149K/yr. Ecosystem extent declines at historical rate (0.9% annually), reaching critical collapse threshold (~1,200 ha, 42% of current) by 2035. This trajectory aligns with long-term ecosystem service decline patterns documented in peer-reviewed African assessments [7].

**Scenario B (Protected area expansion + fishing regulation):**
Extend protection to 60% of extent by 2028 (gain 850 ha under protection regime). Model predicts condition recovery to 0.78 (0.12-unit gain) over 5 years, raising service value to USD 187K/yr (USD 38K gain). Cost: opportunity cost to fishers ~USD 25K/yr (mitigable via livelihood transition fund). Evidence from protected area effectiveness studies in the Indian Ocean region demonstrates that such interventions can yield condition improvements of this magnitude when implemented with stakeholder engagement [8].

**Scenario C (Integrated: extent recovery + market support):**
Combine expansion (Scenario B) + mangrove-seagrass restoration (target: 200 ha by 2028). Nursery service value projected to double to USD 122K/yr; total ecosystem service value reaches USD 267K/yr by 2031. Cost: ~USD 3 million restoration capex + USD 15K/yr management. Benefit-cost ratio over 20 years: 4.2:1 (using 5% discount rate). This approach parallels integrated ecosystem service valuation models demonstrated in comparable WIO coastal systems [9].

**Which is viable?** Scenario B is implementable by 2027 using existing WDPA data + fisheries policy levers. Scenario C requires blue carbon funding and international restoration partnerships (e.g., GCF, IUCN). National governments across the WIO are demonstrating capacity for Scenario B-type interventions through formal SEEA EA implementation [10]. Current condition dataset enables Scenario B baseline; extent mapping + service valuation refinement (market prices, landings data) needed to operationalise Scenario C.

---

## QUICK REFERENCE: Checklist for Submission

**Structural completeness:**
- [ ] Abstract includes explicit SEEA EA framework reference and headline figures
- [ ] Methods section cross-references all three accounts (condition, extent, services) if applicable
- [ ] Results tables match SEEA EA account templates (one row per spatial unit, columns = indicators + indices)
- [ ] Discussion ties condition/service results to policy scenarios (no standalone methods discussion)
- [ ] Data availability statement includes DOI and 10-year archival commitment

**Reproducibility:**
- [ ] All formulas disclosed (normalisation, valuation methods, sensitivity ranges)
- [ ] Reference levels justified with citations to global comparables or national standards
- [ ] QA/QC log provided (corrections, outliers, observer flags)
- [ ] Code and raw data archived with persistent identifiers (GitHub + Zenodo or OSF)
- [ ] Assumptions table drafted (transect area, reference levels, discount rates, prices)

**Policy readiness:**
- [ ] Results disaggregated by governance unit (protected vs. unprotected, management zone, or landholding)
- [ ] Service value compared to national income or sectoral benchmarks (e.g., GDP, fisheries revenue)
- [ ] Open data gaps and acquisition timeline flagged (e.g., "Market price survey underway, results Q2 2026")
- [ ] Policy scenarios sketched (status quo, minimum intervention, optimal restoration)

**Institutional fit:**
- [ ] Cites SEEA EA standards (UN 2021, UNEP 2023, WAVES case studies)
- [ ] Positions as contribution to national natural capital accounting or SDG monitoring
- [ ] Indicates fit for institutional repositories (WRI, UNEP, institutional repository)
- [ ] Proposes next account to publish (e.g., "Extent mapping now in production; services valuation Q4 2026")

