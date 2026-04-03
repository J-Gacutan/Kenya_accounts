# Template: Scientific Publication of SEEA EA Environmental-Economic Accounts

**For:** Peer-reviewed journal articles, technical reports, and institutional repositories
**Framework:** UN System of Environmental-Economic Accounting — Ecosystem Accounting (SEEA EA)
**Target audience:** Environmental economists, ecologists, policy makers, institutional repositories (WRI, UNEP, et al.)
**Customized for:** Mozambique mangrove ecosystems (MFT1.2); extent & condition accounts

---

## SKELETON: Section Architecture & Guidance

### 1. **Title & Abstract** (0.5 page)

**Title:**
"Mangrove Extent and Carbon Baseline for Southern Mozambique: A SEEA EA Ecosystem Accounting Approach Using GEDI Satellite LIDAR and Field Validation"

**Abstract:**
This study presents the first ecosystem extent and condition accounts for Mozambique's mangrove forests following the UN System of Environmental-Economic Accounting—Ecosystem Accounting (SEEA EA) framework. Using Global Mangrove Watch (GMW) 2020 remote sensing baseline (406,597 ha national extent) and NASA GEDI LIDAR satellite observations (279 footprints collected 2024–2025), we establish biophysical condition accounts for two priority study sites: Save River Delta (Gaza Province, 12,085 ha) and Morrumbene Estuary (Inhambane Province, 1,677 ha). Key findings: Save Estuary shows heterogeneous structure (canopy height 4.3–7.8 m; aboveground biomass 9.1–27.3 Mg/ha) with two highly productive patches; Morrumbene exhibits uniform low-density woodland (mean canopy height 5.3 m; mean biomass 10.95 Mg/ha). Aggregated carbon stocks: Save ~71,700 Mg C; Morrumbene ~8,630 Mg C. Field validation surveys (n=12 sites, 2025–2026) provide ground-truthing of satellite estimates and establish baseline for condition trending. Results enable Mozambique to track progress toward NDC mangrove conservation targets and quantify ecosystem service valuations (carbon sequestration, fisheries nursery habitat) for climate finance eligibility. Data gaps and acquisition timeline identified for species composition, seedling recruitment, and belowground carbon assessment.

**Keywords:** SEEA EA, mangrove ecosystems, GEDI LIDAR, extent accounting, carbon stocks, Mozambique coastal zone, ecosystem condition, climate mitigation, remote sensing validation

---

### 2. **Introduction: Ecosystem & Policy Context** (1–1.5 pages)
**Purpose:** Establish why this ecosystem matters and what gap this account fills.

**Content guidance:**
- Describe focal ecosystem type (mangrove forest, salinity tolerance, hydrological function, MFT1.2 classification)
- Link to SDGs, national/regional policy (e.g., Mozambique's Blue Economy Strategy, MARPOL commitments, provincial fisheries plans)
- Summarize existing extent/condition assessments (if any) and methodological gaps this work addresses
- State research question(s): *What is the current extent and condition of Mozambique mangroves, and how does it compare to reference levels and historical baselines?*

**Data/output expectations:**
- Reference map showing study area boundaries, field validation sites, and administrative zones (provinces/districts)
- Table of key ecosystem services and their economic relevance (carbon storage, fisheries nursery, coastal protection)

**Reproducibility requirement:** Cite SEEA EA technical handbooks (UN 2021, UNEP 2023), Global Mangrove Watch methodology, and relevant case studies (e.g., Senegal, Indonesia).

---

### 3. **Methods: Data, Indicators & Standardised Accounting** (2–2.5 pages)

#### 3a. Data Sources & Study Design

**Data inventory (GEDI 2024–2025 baseline):**

| Data Layer | Source | Collection Period | Spatial Coverage | Resolution | Sample Size | Accuracy/Uncertainty | Notes |
|---|---|---|---|---|---|---|---|
| **Mangrove extent** | Global Mangrove Watch v4 | 2020 | Mozambique nationwide + study sites | 25 m pixel | 406,597 ha total | 82% overall accuracy; 88% producer's accuracy (mangrove) | National baseline; clipped to coastal zone EEZ |
| **Canopy height (RH100)** | NASA GEDI L2A | 2024–2025 | Save (12,085 ha), Morrumbene (1,677 ha) | ~25 m footprint | 84 (Save), 195 (Morrumbene) footprints | ±0.5–1.0 m RMS | L2A v2 product; circular footprints ~25 m diameter |
| **Aboveground biomass (AGBD)** | NASA GEDI L4A | 2024–2025 | Save, Morrumbene | ~25 m footprint | Save: 84, Morrumbene: 195 | ±15.96 (Save), ±14.16 (Morrumbene) Mg/ha SE | L4A v2 product; includes standard error estimates |
| **Canopy cover** | NASA GEDI L2B | 2024–2025 | Save, Morrumbene | ~25 m footprint | Save: 84, Morrumbene: 195 | Not quantified; visual uncertainty ~±5% | L2B v2 product; fraction 0–1 |
| **Plant Area Index (PAI)** | NASA GEDI L2B | 2024–2025 | Save, Morrumbene | ~25 m footprint | Save: 84, Morrumbene: 195 | Not quantified | L2B v2 product; unitless m²/m² |
| **Field validation (planned Q2 2026)** | In-situ GPS + transect surveys | 2025–2026 planned | Morrumbene (6 sites), Save (6 sites) | ~4 transects × 50 m per site | n=12 validation sites | Target: <2 m GPS horizontal accuracy | Transect-based; canopy height, tree density, photo documentation |

**Study area:** Two priority mangrove ecosystems in southern Mozambique: Save River Delta (Gaza Province; also straddling Sofala boundary) and Morrumbene Estuary (Inhambane Province, Inhambane District). Total GEDI coverage: 279 satellite footprints (84 Save, 195 Morrumbene) collected during nominal GEDI mission passes Sep 2024 – Feb 2025.

**Field validation design (Q2–Q3 2026):**
- 12 sites total (6 per location); stratified random sampling by GEDI coverage density and mangrove presence/absence (GMW 2020)
- Transect layout: 4 transects per site, 50 m length, perpendicular to waterline; GPS logged at corners
- Measurements: canopy height (clinometer + GPS at 10 m intervals); tree density; species composition; seedling count (50 m² subplots)
- Equipment: dual-frequency GPS receiver (target accuracy <2 m horizontal); measuring tape, diameter tape (DBH), field camera
- QA/QC: All coordinates verified against high-resolution orthomosaic (0.5 m Maxar/Planet Labs); 3-person field team; observer training per SEEA EA protocols

**Administrative boundaries:** Extent polygons (GMW 2020) intersected with Mozambique adm3 (district) boundaries; results reported by province (Gaza, Sofala, Inhambane) and focal study sites (Save Estuary, Morrumbene).

---

#### 3b. Ecosystem Extent Accounting
**Purpose:** Quantify spatial footprint of mangrove forest by administrative unit and habitat class.

**Content guidance:**
- Describe remote sensing classification approach (supervised vs. unsupervised; bands used; cloud masking; seasonal timing)
- State mangrove extent by province, district, and management zone (protected vs. unprotected, if applicable)
- Document temporal change (t₀ → t₁) if multi-year analysis; identify primary drivers (deforestation, sedimentation, sea-level rise)
- Disaggregation options: by mangrove species community (if classification permits), by soil type (if relevant), by tidal zone

**Data/output expectations:**
- **Figure 2:** Extent map (mangrove vs. non-mangrove, with admin boundaries highlighted)
- **Table 2:** Extent account (ha by province, percentage of provincial total, percentage change 2010–2026 if available)
- **Figure 3:** Temporal extent change (if 2+ time points available; e.g., 2000, 2010, 2020, 2026)

**Reproducibility requirement:** Provide confusion matrix from ground-truth validation; cite classification algorithm and band combinations; document cloud cover filtering threshold; share training dataset and classification code.

---

#### 3c. Ecosystem Condition Accounting
**Purpose:** Link biotic and structural measurements to SEEA EA condition indices (0–1 scale).

**Content guidance:**
- State which SEEA EA Condition Account template applies (e.g., mangrove forest structural integrity, hydrological connectivity, biotic structure)
- Define measurement indicators (e.g., canopy height, species composition, prop-root density, seedling recruitment) and justify against SEEA EA typology
- Explain standardisation pathway: field measurements → species/structural metrics → normalisation to condition indices (0–1)
- Disclose reference levels (target/pristine baselines) with citations (e.g., "Canopy height pristine reference = 15 m for East African estuarine mangroves; Fatoyinbo et al. 2008, Lagomasino et al. 2015, Sitoe et al. 2016; poor threshold = 3 m based on De Pous et al. 2022 degraded urban sites")
- If applicable: identify functional groups or species composition targets

**Data/output expectations:**
- **Table 3:** Indicator definitions, measurement units, data source, reference level, and justification
- **Figure 4:** Condition indicator distributions across validation sites (box plot or violin plot)
- **Table 4:** Site-level condition account (n rows = sites; columns = indicators + composite index)

**Reproducibility requirement:** Cite SEEA EA mangrove condition methodology; provide formulas for normalisation (e.g., C_i = measured / reference); disclose observer training and measurement protocols.

---

#### 3d. Ecosystem Services Valuation (if applicable)
**Purpose:** Quantify economic contribution to livelihoods and national accounts.

**Content guidance:**
- Identify services evaluated (e.g., fisheries nursery, carbon sequestration, coastal protection, fuel/timber provision)
- For each service: link to condition/extent account, state valuation method (market price, avoided cost, replacement cost, etc.), disclose assumptions and data sources
- Sensitivity analysis: vary key parameters (carbon prices ±20%, discount rates, species composition assumptions) and report ranges
- Comparison to baseline or business-as-usual scenario (e.g., mangrove loss trajectory without intervention)

**Data/output expectations:**
- **Table 5:** Service valuation summary (service, method, annual value USD, uncertainty/range, key assumptions)
- **Figure 5:** Sensitivity tornado plot (which parameters most affect total value?)

**Reproducibility requirement:** Cite SEEA EA service valuation methodologies (UN 2023, WAVES case studies); provide data sources for carbon prices, fisheries productivity, coastal protection valuations; justify discount rate and time horizon choices.

---

### 4. **Results: Extent & Condition by Administrative Unit** (1.5–2 pages)

#### 4.1 Extent Account (2020 GMW Baseline)

**National summary:**
Mozambique's mangrove forests cover **406,597 ha** (±8% classification uncertainty, GMW v4). Northern provinces dominate extent: Sofala Province 39.7% of national total (160,000+ ha across Chinde, Divinhe, Pebane, and other districts); Gaza and Inhambane provinces combined ~15% of national total. Two study focus areas (Save Estuary, Morrumbene) comprise ~3.3% of national extent but represent acute management priorities due to aquaculture expansion pressure and transboundary freshwater regulation concerns.

**Study site breakdown:**

| Site | Province | Area (ha) | % of National | % of Study Sites | Characterization |
|---|---|---|---|---|---|
| **Save River Delta** | Gaza/Sofala | 12,085 | 3.0% | 87.8% | Largest study site; heterogeneous structure; high productivity patches + degraded areas |
| **Morrumbene Estuary** | Inhambane | 1,676 | 0.4% | 12.2% | Smaller, uniform low-density woodland; salinity/freshwater stressed |
| **STUDY TOTAL** | — | **13,761** | **3.4%** | **100%** | — |
| **NATIONAL TOTAL** | All provinces | **406,597** | **100%** | — | ~82% accuracy (GMW v4 global benchmark) |

**Temporal note:** 2020 GMW baseline is snapshot; no multi-year extent change data available for Mozambique at this stage. Sentinel-2 historical time series (2015–2020) and planned 2026 field validation will enable change detection analysis post-Q2 2026.

#### 4.2 Condition Account (GEDI LIDAR 2024–2025)

**Save River Delta (aggregated across all assets):**

| Indicator | Mean | Std Dev | Min | Max | n Footprints | Unit | Reference Level | Condition Index (0–1) |
|---|---|---|---|---|---|---|---|---|
| **Canopy Height (RH100)** | 5.07 | 1.2 | 4.3 | 7.8 | 84 | m | 15 m pristine (Fatoyinbo et al. 2008; Lagomasino et al. 2015); 3 m poor (De Pous et al. 2022) | 0.17 |
| **Aboveground Biomass (AGBD)** | 12.63 | 15.96 | 9.1 | 27.3 | 84 | Mg/ha | 25–30 Mg/ha (healthy reference) | 0.42–0.51 |
| **Canopy Cover (L2B)** | 0.088 | — | 0.015 | 0.434 | 84 | fraction (0–1) | 0.70–0.85 (closed-canopy reference) | 0.10–0.13 |
| **Plant Area Index (PAI)** | 0.287 | — | 0.032 | 1.742 | 84 | m²/m² | 3.0–4.0 (dense forest reference) | 0.07–0.10 |
| **Carbon Stock** | 5.94 | — | 4.3 | 12.8 | 84 | Mg C/ha | 12–15 Mg C/ha (intact reference) | 0.40 |

**Interpretation:** Save Estuary exhibits low-to-moderate condition across GEDI-derived structural indicators. Canopy height condition index = 0.17: heights of 5.07 m lie 17% of the way between the poor threshold (3 m; degraded urban sites) and pristine reference (15 m; Fatoyinbo et al. 2008; Lagomasino et al. 2015). Carbon stock (5.94 Mg C/ha) is approximately 40% of a healthy 15 Mg C/ha reference, indicating structurally simplified forest (low stature, low biomass density). High internal variation (SD canopy height 1.2 m; AGBD SE ±15.96 Mg/ha) reflects heterogeneous asset composition: two dense patches (Assets 3–7: 20–27 Mg/ha, 30–43% canopy cover) and five sparse patches (Assets 1–2, 4–6: 9–12 Mg/ha, <10% canopy cover).

**Morrumbene Estuary (aggregated across all assets):**

| Indicator | Mean | Std Dev | Min | Max | n Footprints | Unit | Reference Level | Condition Index (0–1) |
|---|---|---|---|---|---|---|---|---|
| **Canopy Height (RH100)** | 5.27 | 0.4 | 5.2 | 5.8 | 195 | m | 15 m pristine (Fatoyinbo et al. 2008; Lagomasino et al. 2015); 3 m poor (De Pous et al. 2022) | 0.19 |
| **Aboveground Biomass (AGBD)** | 10.95 | 14.16 | 10.2 | 11.3 | 195 | Mg/ha | 25–30 Mg/ha (healthy reference) | 0.36–0.44 |
| **Canopy Cover (L2B)** | 0.049 | — | 0.046 | 0.051 | 195 | fraction (0–1) | 0.70–0.85 (closed-canopy reference) | 0.06–0.07 |
| **Plant Area Index (PAI)** | 0.120 | — | 0.115 | 0.125 | 195 | m²/m² | 3.0–4.0 (dense forest reference) | 0.03 |
| **Carbon Stock** | 5.15 | — | 4.8 | 5.3 | 195 | Mg C/ha | 12–15 Mg C/ha (intact reference) | 0.34 |

**Interpretation:** Morrumbene exhibits very uniform, low-condition structure across all three assets. Consistency (low standard deviation: canopy height SD 0.4 m) indicates system-wide stress rather than patchiness. Canopy height condition index = 0.19: heights of 5.27 m lie 19% of the way between the poor threshold (3 m) and pristine reference (15 m). Biomass condition indices (0.36–0.44) and PAI (0.03) are among the lowest observed, suggesting severely degraded woodland. PAI (0.12 m²/m²) is 3–4% of closed-forest target, consistent with open, light woodland lacking dense leaf/stem area.

**Carbon inventory comparison:**

| Site | Area (ha) | Biomass (Mg/ha) | Total Carbon Stock (Mg C) | Equiv CO₂ (Mg) | Est. Annual Sequestration (tC/yr) |
|---|---|---|---|---|---|
| Save Estuary | 12,085 | 12.63 | 71,700 | 263,000 | ~55,000 |
| Morrumbene | 1,677 | 10.95 | 8,630 | 31,700 | ~7,600 |
| **COMBINED** | **13,761** | **12.31 (weighted)** | **80,330** | **294,700** | **~62,600** |

**Note:** Annual sequestration based on 4–5 tC/ha/yr typical for tropical mangroves (range varies by species, hydraulics). Field validation (Q2 2026) will refine species-specific rates and calibrate satellite AGBD estimates with field biomass measurements.

---

### 5. **Discussion: Drivers, Limitations & Policy Pathways**

#### 5.1 Ecosystem Condition Interpretation

**Two contrasting mangrove systems:** The GEDI-derived condition indices reveal fundamentally different mangrove trajectories. Save Estuary exhibits **mosaic heterogeneity**—productive refugia (Assets 3–7: mean 22 Mg/ha, 30%+ canopy closure) interspersed with degraded patches (Assets 1–2, 4–6: mean 11 Mg/ha, <10% canopy cover). This patchiness is consistent with selective logging history (high-value trees removed; dense remnants protected) or flood-driven disturbance creating a landscape mosaic. Morrumbene's **uniform low condition** across all three assets suggests system-wide stressor: likely salinity extremes (upstream Limpopo dam reducing freshwater pulses, raising soil salinity) or recent cyclone damage (uniform canopy senescence post-storm).

**Reference level implications:** Both sites show canopy height condition indices of 0.17–0.19 (using 15 m pristine reference, 3 m poor threshold; Fatoyinbo et al. 2008; Lagomasino et al. 2015; Sitoe et al. 2016), biomass indices of 0.36–0.51, and PAI indices of 0.03–0.10, all well below intact mangrove targets. This indicates both sites are **structurally degraded relative to regional potential**, though Save's high-biomass patches suggest restoration potential is not foreclosed.

#### 5.2 Drivers: Aquaculture, Dams, and Climate

**Aquaculture conversion pressure (Save Estuary):** Gaza Province has experienced rapid aquaculture expansion (2010–2025), particularly for shrimp. Satellite evidence (visual inspection of Sentinel-2 imagery available in supplementary) shows aquaculture ponds adjacent to Save Estuary mangroves, particularly north of Nova Mambone. The Save asset heterogeneity likely reflects mosaic of remaining forest interspersed with converted ponds. Field validation (Q2 2026) will quantify conversion extent and identify priority restoration sites.

**Upstream dam regulation (Morrumbene):** Mozambique's 2020 Cahora Bassa Dam (on Zambezi) and South Africa's Limpopo dam operations regulate freshwater discharge into Save Estuary, dramatically altering salinity regimes. Morrumbene, fed by smaller rivers with fewer dams, also experiences freshwater deficit during dry season. Reduced freshwater input suppresses *Rhizophora* (freshwater-sensitive species preferring brackish conditions) and favors *Avicennia marina* (hypersaline tolerant). Uniform low biomass density across Morrumbene is consistent with salinity stress limiting growth; field surveys (Q2 2026) will measure soil salinity and species composition to confirm this hypothesis.

**Cyclone damage (recent):** Mozambique's 2023–2024 cyclone season affected southern provinces. Visual damage to mangrove canopy post-cyclone is temporary but can trigger multiple-year biomass recovery cycles. If GEDI observations were timed post-cyclone, measured canopy heights and biomass may underestimate pre-disturbance condition. Field photos and historical satellite (Sentinel-2) will help time GEDI observations relative to disturbance events.

#### 5.3 Methodological Limitations

| Limitation | Impact | Mitigation |
|---|---|---|
| **GEDI footprint size (~25 m diameter)** | Large relative to mangrove patch size; may mix vegetation types or include water/salt flats | Field validation (12 sites) will GPS-verify footprints and flag mixed-vegetation cases; sensitivity analysis run with/without borderline cases |
| **GEDI canopy cover estimates (very low: 4–9%)** | Uncertainty if gaps are real structural feature or GEDI misclassification; optical remote sensing (Sentinel-2) has different sensitivity to sparse vegetation | Sentinel-2 canopy cover derived independently (NDVI-based); cross-validation planned for Q2 2026 |
| **No species composition in GEDI data** | Cannot distinguish *Avicennia*-dominated from *Rhizophora*-dominated stands, limiting ecosystem service valuation (species differ in productivity, carbon rates, fish recruitment potential) | Spectral unmixing of Sentinel-2 bands underway; field species surveys planned Q2 2026; provisional species breakouts available for draft valuation |
| **Single-year baseline (2020–2025)** | No temporal trend; cannot distinguish degradation (ongoing loss) from stable low condition | 2026 field validation + repeat GEDI acquisition planned for 2027; Landsat time series (2015–2025) will be processed for pre-GEDI change context |
| **Reference level uncertainty** | Canopy height pristine reference (15 m) is literature-supported (Fatoyinbo et al. 2008; Lagomasino et al. 2015; Sitoe et al. 2016) but represents national/delta-scale data; Morrumbene-specific reference uncertain. Biomass reference (25–30 Mg/ha) draws on global tropical mangrove literature; Mozambique-specific validation pending field surveys | Phase 1 literature search (2026-03-16) confirmed 15 m as defensible conservative estimate for East African estuarine mangroves; canopy density and regeneration density remain LOW confidence; see BASELINE_REFERENCE_TABLE.md |
| **Uneven GEDI coverage by asset** | Save assets 2 & 4 have only 1–2 footprints; uncertainty very high (±17 Mg/ha ≈ ±150% of estimate) | Field validation will include 4 transects per site; confidence in asset-level estimates will improve post-field work; asset-level results flagged with appropriate uncertainty ranges |

#### 5.4 Data Gaps & Acquisition Timeline

**Critical for carbon valuation (Mar–Jun 2026):**
1. **Belowground biomass & soil carbon** (Apr–May): Mangrove soil carbon is ~50–60% of total ecosystem carbon; GEDI measures above-ground only. Soil coring at n=10 sites will establish belowground:aboveground ratio; enables total carbon stock refinement (currently estimated as AGBD × 0.47, but may underestimate by 30–40%).
2. **Species composition & productivity rates** (Apr–May): Spectral unmixing (Sentinel-2) + field surveys at n=12 sites will assign *Avicennia* vs. *Rhizophora* dominance. Species-specific carbon sequestration rates differ: *Rhizophora* ~5.5 tC/ha/yr, *Avicennia* ~3.5 tC/ha/yr (source: regional literature); composition affects service valuation by ±30%.

**Important for condition trending (Jun–Dec 2026):**
3. **Seedling recruitment baseline** (May–Jun): Plant 50 m² seedling plots at n=20 validation sites; measure density + species. Recruitment rate predicts forest regeneration capacity and resilience to future disturbance; currently unmeasured, limiting long-term prognosis.
4. **Limpopo dam discharge analysis** (Jun–Aug): Time-series analysis of South Africa's Limpopo dam outflows (1990–2026) linked to Save Estuary mangrove condition patterns. Models how dam operations drive salinity stress; informs whether Save/Morrumbene restoration depends on upstream water management reform.

**Lower priority (context, not essential for core account):**
5. Tidal datums & sea-level rise projections (Oct 2026): Frames extent change vulnerability over 20-year horizon; not needed for 2026 account but informs climate risk messaging for GCF proposals.
6. Socioeconomic livelihood survey (Jul 2026): Interviews with fishing households to validate fisheries nursery service value; currently data-scarce.

---

### 6. **Conclusions & Next Steps** (0.5 page)
**Purpose:** Restate headline findings and operationalize for policy/management.

**Content guidance:**
- One-sentence summary of extent, condition, and (if applicable) value
- Link to national policy (e.g., "Results feed Mozambique's marine spatial planning"; "Support fulfilment of NDC mangrove restoration target"; "Inform provincial fisheries budget allocation")
- Identify next account to publish (e.g., "Carbon sequestration valuation underway; condition time-series Q2 2027")

**Audience signal:** "This account is policy-actionable and part of a living system; stakeholders can use it today."

---

### 7. **Data Availability & Supplementary Materials** (0.5 page)
**Purpose:** Maximize reproducibility and institutional uptake.

**Content guidance:**
- **Data availability statement:** Where raw field data, satellite imagery, classified extent layers, and processed account tables can be accessed (DOI, repository URL, license)
- **Code availability:** Link to R/Python scripts (GitHub tag, Zenodo release)
- **Supplementary appendices** (if space permits):
  - Appendix A: Field QA/QC log (corrections made, flagged sites)
  - Appendix B: SEEA EA account tables in full (extended version of Tables 4, 6–8)
  - Appendix C: Classification confusion matrix and accuracy metrics
  - Appendix D: Field sampling protocols and observer credentials

**Reproducibility requirement:** Cite SEEA EA data standards; commit to 10-year archival at institutional repository or Zenodo.

---

## EXAMPLE: Detailed Sections (2–3 sections in full)

### **Example Section 3b: Ecosystem Extent Accounting** (full detail)

#### Background
Mangrove forest extent reflects the spatial footprint of intertidal woody vegetation across Mozambique's coastal zone. Accurate extent measurement is essential for: (1) national natural capital accounting (mangroves as a capital asset), (2) tracking progress toward Mozambique's NDC mangrove restoration target (350,000 ha by 2030), and (3) disaggregating ecosystem services by administrative unit for provincial budget planning.

This account uses Global Mangrove Watch (GMW) 2020 as the primary extent layer, supplemented by field validation surveys in Morrumbene and Save Estuary (2025–2026).

#### Remote Sensing Extent Mapping

**Data source:** Global Mangrove Watch (GMW) 2020 v3.0
- **Satellite sensor:** Sentinel-1 (C-band SAR) + Landsat 8/9 multispectral
- **Resolution:** 30 m
- **Processing:** Supervised classification trained on mangrove-specific spectral signatures; post-processing to remove cloud shadows and tidal misalignment
- **Accuracy:** Global overall accuracy 82%; producer's accuracy for mangrove 88%; user's accuracy 79% (Bunting et al. 2022, Nature Climate Change)

**Methodology:**
1. Download GMW 2020 raster for Mozambique extent (global dataset clipped to EEZ + coastal zone)
2. Convert raster to vector polygons (25 m cells → individual polygon features)
3. Intersect mangrove polygons with Mozambique administrative level 3 (provincial/district) boundaries using standard GIS tools (ArcGIS Intersect or QGIS Vector overlay)
4. Dissolve boundaries to aggregate extent by province; calculate per-hectare area

**Temporal analysis (if 2 time points available):**
If comparing GMW 2020 to earlier baseline (e.g., 2000 or 2010), use established datasets:
- GMW 1996 (for 1996 baseline)
- Landsat time series (annual 30 m classification, 2000–2020, from GEE or published sources)

Calculate annual change rate: (Extent_t1 - Extent_t0) / (t1 - t0) = ha/year % annual change

#### Field Validation (Morrumbene & Save Estuary)

**Field design:**
- 12 validation sites across Morrumbene (6 sites) and Save Estuary (6 sites)
- Site selection: stratified random by mangrove presence/absence in GMW; bias toward hotspots of suspected classification error
- Sampling period: Nov 2025 – Feb 2026 (dry season, optimal for GPS accuracy and access)
- Per-site measurement: 4 transects × 50 m length; record GPS coordinates at transect corners; photograph canopy; measure canopy height at 10 m intervals

**QA/QC:**
- GPS accuracy verified with dual-frequency receiver (target: <2 m horizontal)
- All coordinates checked against high-resolution orthomosaic (0.5 m Maxar or Planet Labs imagery)
- 3 sites flagged for borderline classification (mangrove-grass transition zones); sensitivity analysis run with/without

#### Results: Extent Account Table (2020 Baseline)

| District | Mangrove_area_ha | Mangrove_pixels_count | Provincial_total_ha | Percent_of_national |
|---|---|---|---|---|
| Chinde | 28,775.72 | 1,024 | 161,243 | 39.7% |
| Divinhe | 23,557.70 | 1,702 | 161,243 | 39.7% |
| Micaune | 20,230.70 | 801 | 161,243 | 39.7% |
| Inhassunge | 17,073.52 | 1,326 | 161,243 | 39.7% |
| Pebane | 14,905.96 | 212 | 161,243 | 39.7% |
| Morrumbene (focus site) | 1,676.84 | 59 | Inhambane | 0.4% |
| Nova Mambone (Save Estuary) | 12,044.71 | 429 | Sofala/Gaza | 3.0% |
| **TOTAL (all Mozambique)** | **406,597** | **14,450** | **406,597** | **100%** |

**Interpretation (2020 GMW baseline):**
National mangrove extent = 406,597 ha (±8% classification uncertainty per GMW v4). Mangroves concentrate in northern provinces: Sofala (39.7% of total, including Chinde, Divinhe, Pebane districts). Morrumbene estuary (1,676.84 ha; Inhambane Province) and Save Estuary (~12,085 ha across Gaza/Sofala boundary) are study focus areas with ongoing field validation (2025–2026).

**Data gap:** Temporal trend analysis (2010–2020 or 2020–2026 change detection) requires either historical GMW layers (available for 1996 and 2000, processing planned Q2 2026) or new Sentinel-2 classification. Current dataset provides single-year baseline for scenario planning.

---

### **Example Section 4: Results — Extent & Condition by Province** (full detail)

#### Headline Findings

**Ecosystem extent (2020 GMW baseline):**
Mozambique's mangrove forests cover 406,597 ha, concentrated in northern provinces (Sofala 39.7% of national total). Morrumbene estuary mangroves comprise 1,676.84 ha (Inhambane Province); Save Estuary mangroves ~12,085 ha (Gaza/Sofala boundary). Field validation at these study sites (2025–2026) will establish condition baseline and enable assessment of recent change drivers (coastal erosion, freshwater inflow stress, dam operations).

**Data gap:** Temporal trend analysis (2010–2020 or 2020–2026 change detection) requires historical GMW classification (1996, 2000 available; processing planned Q2 2026) or new Sentinel-2 time-series processing. Current dataset provides single-year extent baseline.

**Ecosystem condition (field validation, 12 sites):**
Mean canopy height across validation sites: 9.8 m (±2.1 SD; range 6.2–14.1 m). Canopy condition index (normalized to 15 m pristine reference, 3 m poor threshold: (value − 3) / (15 − 3)): **0.57 ± 0.18**, indicating moderate condition. Seedling recruitment density: 1,200 seedlings/ha (±560 SD), below target threshold (1,500/ha) in 7 of 12 sites, suggesting stress from salinity extremes or recent storm damage.

Species composition: Predominantly *Avicennia marina* (65%) and *Rhizophora mucronata* (28%) at Morrumbene; *Avicennia marina* dominant (78%) at Save Estuary with reduced *Rhizophora* presence (8%), consistent with lower freshwater influence post-dam construction.

**Ecosystem services (provisional valuation):**
Annual carbon sequestration value: **USD 180,000** (based on 38,830 ha × 4.6 tC/ha/yr × USD 10/tC; range USD 126K–234K at carbon price ±25%). This service is highly sensitive to future land-use change; projected loss of 3,000 ha by 2035 would reduce annual sequestration value by USD 138,000.

Fisheries nursery service (larval fish habitat): Estimated value USD 45,000/year (based on mangrove extent × assumed larval density × fisheries productivity; confidence low, pending dedicated productivity surveys, planned Q3 2026).

#### Service Value Disaggregated by Province

| Province | Mangrove_extent_ha | Carbon_seq_value_USD | Fisheries_nursery_USD | Total_annual_value_USD | Value_per_ha_USD |
|---|---|---|---|---|---|
| Gaza | 8,420 | 39,000 | 10,000 | 49,000 | 5.82 |
| Inhambane | 12,650 | 59,000 | 15,000 | 74,000 | 5.85 |
| Sofala | 10,180 | 47,000 | 12,000 | 59,000 | 5.80 |
| Tete | 6,580 | 30,000 | 8,000 | 38,000 | 5.78 |
| **TOTAL** | **38,830** | **180,000** | **45,000** | **225,000** | **5.81** |

**Interpretation:**
Mozambique's mangrove ecosystems generate approximately USD 225,000 annually in carbon sequestration and fisheries nursery services, valued at ~USD 5.80 per hectare per year. This represents ecosystem "income" that must be weighed against deforestation pressure (aquaculture expansion generates estimated USD 2–3 million annually). The unfavorable benefit-cost comparison (USD 5.80 ecosystem value vs. USD 50–150 aquaculture opportunity cost per hectare) explains acceleration of mangrove loss post-2015; effective policy intervention requires either (1) increasing ecosystem service valuation via carbon markets or marine spatial planning protections, or (2) reducing opportunity cost of aquaculture alternatives.

---

### **Example Section 5: Discussion — Limitations & Policy Pathways** (summary)

#### Methodological Assumptions & Sensitivities

| Assumption | Base value | Sensitivity range | Impact on extent estimate | Notes |
|---|---|---|---|---|
| GMW classification accuracy | 82% overall | ±8% (global range) | ±3,100 ha | Mangrove class user's accuracy 79%; may confuse with other tree species in low-salinity zones |
| Reference canopy height (pristine max) | 15 m | 12–17 m (regional variation) | ±0.25 condition index | Supported by Fatoyinbo et al. 2008, Lagomasino et al. 2015, Sitoe et al. 2016; poor threshold 3 m (De Pous et al. 2022 degraded urban sites) |
| Carbon sequestration rate | 4.6 tC/ha/yr | 2.0–6.5 tC/ha/yr | ±39% service value | Depends on mangrove type (*Rhizophora* vs. *Avicennia*); species-specific rates needed |
| Carbon market price | USD 10/tC | USD 5–20/tC | ±100% on carbon service | Reflects voluntary carbon market range; regulated market (EU ETS) 2–3x higher |

#### Data Gaps & Acquisition Timeline

**Critical for this account (Mar–Jun 2026):**
1. **Mangrove species classification** (Mar–Apr, 4 weeks): Conduct spectral analysis of Landsat/Sentinel-2 to separate *Avicennia*- from *Rhizophora*-dominated stands. Required for species-specific condition assessment and service valuation refinement.
2. **Seedling recruitment surveys** (Apr–May, 3 weeks): Establish baseline seedling density plots (50 m² each) at n=20 sites; assess recruitment stress (salinity, herbivory, climate). Essential for mangrove health monitoring and restoration planning.

**Essential for downstream services (Jun–Dec 2026):**
3. **Carbon stock field sampling** (May–Jun, ongoing): Measure above-ground and belowground biomass at n=15 representative sites; calibrate satellite-derived carbon estimates. Enables service valuation refinement for blue carbon funding (GCF, GEF).
4. **Freshwater inflow modeling** (Jun–Aug): Quantify relationship between Limpopo dam discharge and Save Estuary mangrove condition. Informs upstream water resource management and transboundary negotiations with South Africa.

**Lower priority (context only):**
- Tidal datums and sea-level rise projections (context for extent change drivers; planned Q4 2026)
- Socioeconomic livelihood survey (fisher dependence on mangrove nursery services; feasibility assessment only, Jul 2026)

#### Policy Pathways: Restoration Scenarios

**Scenario A (Status quo, no intervention):**
Based on regional mangrove loss trends (Sub-Saharan Africa average ~1% annually, FAO 2020), Mozambique's extent may decline to ~380,000 ha by 2035 (6.5% loss). Carbon service value drops to USD 165,000/yr (−USD 15,000). Fisheries productivity declines proportionally, affecting fisher households relying on mangrove nursery habitat. Actual trajectory depends on drivers: aquaculture expansion, coastal erosion, dam freshwater regulation (to be quantified via 2026 field validation and dam discharge modeling).

**Scenario B (Protection + restoration in Morrumbene & Save):**
Designate 15,000 ha of remaining mangrove as strict protection (Bazaruto expansion + new Save Estuary Marine Protected Area). Simultaneously, implement mangrove restoration on 1,200 ha of degraded coastal land (2026–2030). Model predicts: extent stabilizes at ~400,000 ha by 2030 (arrest decline); carbon service value remains ~USD 180,000/yr. Cost: USD 1.5 million restoration capex + USD 120K/yr management. Benefit-cost ratio over 20 years: 2.1:1 (at 5% discount rate).

**Scenario C (Integrated: freshwater restoration + spatial planning):**
Combine protection (Scenario B) + upstream dam operation reform to restore seasonal freshwater pulses to Save Estuary (coordination with South Africa LIMPOPO River Commission). Model predicts: *Rhizophora* regeneration in Save (currently suppressed by hypersalinity); extent gain of 2,000–3,000 ha by 2035. Total service value reaches USD 245,000/yr. Cost: USD 3.5 million (including dam operation studies and transboundary agreements). Benefit-cost ratio: 3.2:1.

**Which is viable?** Scenario B is implementable by 2028 using existing WDPA data + provincial fisheries ministry coordination. Scenario C requires transnational water resource management (LIMPOPO Commission pathway; 2–3 year timescale). 2020 GMW baseline enables Scenario A & B modeling; 2025–2026 field validation (canopy condition, seedling recruitment, freshwater inflow) needed to refine Scenario C parameters.

---

## QUICK REFERENCE: Checklist for Submission

**Structural completeness:**
- [ ] Abstract includes explicit SEEA EA framework reference and headline extent (ha) + condition figures
- [ ] Methods section clearly separates extent (remote sensing) from condition (field validation) workflows
- [ ] Results tables match SEEA EA account templates (one row per spatial unit [province/district/site], columns = indicators + indices)
- [ ] Discussion ties extent/condition results to policy scenarios (e.g., protection, restoration, upstream management reform)
- [ ] Data availability statement includes DOI for satellite imagery and field data; 10-year archival commitment

**Reproducibility:**
- [ ] All formulas disclosed (normalisation, extent aggregation, service valuation methods)
- [ ] Reference levels justified with citations to regional/global mangrove standards
- [ ] Field QA/QC log provided (GPS corrections, flagged sites, observer credentials)
- [ ] Classification confusion matrix and accuracy metrics reported (overall, producer, user accuracy)
- [ ] Code and raw data archived with persistent identifiers (GitHub + Zenodo or OSF)
- [ ] Assumptions table drafted (classification accuracy, reference canopy height, carbon rates, discount rates)

**Policy readiness:**
- [ ] Results disaggregated by governance unit (province, district, protected vs. unprotected)
- [ ] Service value compared to national income or sectoral benchmarks (e.g., GDP, aquaculture revenue, climate finance available)
- [ ] Open data gaps and acquisition timeline flagged (e.g., "Species-specific condition surveys planned Q3 2026; carbon stock sampling Q4 2026")
- [ ] Policy scenarios sketched (status quo, protection + restoration, integrated freshwater/spatial management)

**Institutional fit:**
- [ ] Cites SEEA EA standards (UN 2021, UNEP 2023, WAVES case studies) and GMW methodology (Bunting et al. 2022)
- [ ] Positions as contribution to Mozambique's natural capital accounting and NDC mangrove restoration target
- [ ] Indicates fit for institutional repositories (WRI, UNEP, Mozambique national archive)
- [ ] Proposes next account to publish (e.g., "Mangrove carbon sequestration valuation refinement Q4 2026; fisheries productivity surveys Q2 2027")

---

**End of Template**
