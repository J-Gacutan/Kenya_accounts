# SEEA EA Skills Library — Madagascar Coral Reef (M1.3)

This folder contains standardized operating procedures (SOPs) and skills templates for ecosystem accounting under the UN SEEA EA framework, **customized for the Madagascar coral reef project (2025–2026)**.

## Overview

Each skill file provides:
- **Conceptual framework** — What is being measured and why
- **Field protocols** — How data are collected
- **Data processing** — QA/QC, calculations, normalization
- **Reference levels** — Benchmarks for condition indices
- **Integration points** — Links to related accounts

## Skills Files

### Condition Accounts (What is the state of the ecosystem?)

#### [skill_condition_biotic_fish_invert.md](skill_condition_biotic_fish_invert.md)
**Purpose:** Calculate fish and invertebrate community condition indicators for photic coral reef ecosystems (M1.3)

| Element | Value |
|---------|-------|
| **Data source** | Underwater Visual Census (UVC) field surveys |
| **Indicators measured** | Fish biomass (kg/ha), species richness, COTS density |
| **Survey effort** | 27 sites, 85 stations, 2 transects/station, 5,186 fish records |
| **Field data date range** | 2025-11-11 to 2026-02-24 |
| **Key QA/QC issues** | GPS coordinate fixes, functional group harmonisation, invertebrate formula parsing |
| **Output files** | `fish_invert_site_condition.csv`, `fish_invert_seea_condition.csv` |
| **Status** | Data collected; analysis in progress |

**When to use:** Designing or executing fish/invertebrate surveys; understanding how site-level indicators are calculated.

---

#### [skill_condition_by_protected_area_m13_reef.md](skill_condition_by_protected_area_m13_reef.md)
**Purpose:** Assess fish and invertebrate condition separately by protected area, linking site-level metrics with WDPA metadata to analyze conservation effectiveness

| Element | Value |
|---------|-------|
| **Scope** | Site-level condition metrics stratified by WDPA designation (27 sites × 3–5 PAs) |
| **Condition variables** | Fish biomass, richness, abundance; COTS, urchin, clam indicators; stratified by PA name, IUCN category, governance type |
| **Key outputs** | Sites-to-PA linkage table (with full WDPA metadata), condition summary by PA, conservation effectiveness (PA vs. unprotected) |
| **PA metadata** | WDPA_ID, NAME, DESIG, IUCN_CAT, GOV_TYPE, OWN_TYPE, NO_TAKE, STATUS_YR |
| **Timeline** | Mar–Apr 2026 |
| **Status** | NEW SOP (2026-03-16); companion to skill_extent_protected_areas; ready to implement |

**When to use:** Analyzing whether PA designation affects fish/invertebrate community health; comparing service value inside vs. outside PAs; informing PA effectiveness monitoring and expansion decisions.

**Key analysis steps** (reuses spatial join from skill_extent_protected_areas):
1. Spatial join: site coordinates (from fish_invert_site_condition.csv) → WDPA polygons
2. Retain full WDPA attributes: NAME, IUCN_CAT, GOV_TYPE, NO_TAKE, STATUS_YR, etc.
3. Aggregate condition metrics per PA: Mean ± SE biomass, richness, invertebrate densities
4. Compare protected vs. unprotected condition: Effect size (% difference), statistical test if n ≥ 10

**Data requirements:**
- Condition metrics: `fish_invert_site_condition.csv` (from skill_condition_biotic_fish_invert.md)
- Site coordinates: Same 27 sites from UVC surveys
- WDPA shapefile: Free download from https://www.protectedplanet.net/
- WDPA metadata reference: `Madagascar/docs/WDPA_WDOECM_RAG_Schema.md`

---

#### [skill_condition_measurement_m13_reef.md](skill_condition_measurement_m13_reef.md)
**Purpose:** SOP for measuring ecosystem condition across all indicators (fish, invertebrate, benthic habitat) and normalizing to condition indices (0–1 scale)

| Element | Value |
|---------|-------|
| **Scope** | Photic coral reefs (M1.3) ecosystem condition framework |
| **Indicators** | Fish biomass, richness, COTS (inverted), seagrass, habitat composition |
| **Reference levels** | Fish: 1,150 kg/ha (WIO conservation target; McClanahan 2016); COTS: 15 ind/ha outbreak threshold (Dulvy 2021) |
| **Expected 2025 values** | Biomass: 1,929 kg/ha (CI: 1.0); Richness: 55 spp (CI: 0.53); COTS: 6.7 ind/ha (CI: 0.98) |
| **Composite CI (2025)** | 0.84 (moderate-to-good condition) |
| **Integration** | Links fish/invertebrate data to benthic habitat (extent) and ecosystem services |
| **Status** | Customized for Madagascar; baseline (2025) established |

**When to use:** Compiling the condition account; understanding reference levels and normalization methods; comparing across years (2025 vs. 2026).

**Key data QA/QC reminders:**
- Transect area: **250 m² (50 m × 5 m)** — confirmed with field team
- GPS fixes: 17 lat, 18 lon values need decimal point correction
- Functional group harmonisation: 17 raw → 7 standard groups (see skill_condition_biotic_fish_invert.md)

---

### Extent Accounts (How much ecosystem area exists?)

#### [skill_extent_measurement_m13_reef.md](skill_extent_measurement_m13_reef.md)
**Purpose:** SOP for mapping and quantifying photic coral reef area using satellite imagery and field validation

| Element | Value |
|---------|-------|
| **Spatial data** | Sentinel-2 satellite imagery (10 m resolution; free) |
| **Coverage** | Shoreline to ~25 m depth (practical limit for benthic classification) |
| **Classification method** | Spectral Angle Mapper (SAM) on Sentinel-2 3-band composite (B2, B3, B4) |
| **Target accuracy** | ≥75% overall; ≥70% coral class producer's accuracy |
| **Ground truth** | 27 UVC sites + 25–50 additional drop-camera validation points |
| **BSU grid** | 10 m × 10 m cells (100 m² per cell) |
| **Ecosystem types mapped** | Coral (M1.3), sand/rubble, seagrass (if present) |
| **Timeline** | Baseline (2025) ready Mar 2026; change analysis (2025–2026) pending 2026 imagery |
| **Status** | In progress; awaiting satellite imagery processing |

**When to use:** Setting up the extent account; understanding spatial methodology; validating coral reef area estimates.

**Key data acquisition needs:**
- Sentinel-2 mosaic for Nov 2025–Jan 2026 (baseline)
- Ground truth: drop-camera footage at field sites + supplementary sites
- Bathymetry: GEBCO 2023 for 25 m depth contour
- Shoreline: OSM or GEBCO

---

#### [skill_extent_protected_areas_m13_reef.md](skill_extent_protected_areas_m13_reef.md)
**Purpose:** SOP for analyzing ecosystem extent within and outside protected areas (WDPA) using ArcGIS Pro

| Element | Value |
|---------|-------|
| **GIS tool** | ArcGIS Pro (spatial join, intersect, dissolve operations) |
| **PA database** | WDPA (World Database of Protected Areas; Protected Planet download) |
| **Site assignment** | Fish/invertebrate UVC coordinates (27 sites) intersected with WDPA polygons |
| **Extent disaggregation** | Coral reef, seagrass area (ha) per PA and unprotected areas |
| **PA overlap handling** | Dissolve WDPA to avoid double-counting overlapping polygons |
| **Key outputs** | Sites-to-PA table, extent per PA pivot table, protected vs. unprotected extent summary |
| **Timeline** | Mar–May 2026 |
| **Status** | NEW SOP (2026-03-15); ready to implement |

**When to use:** Disaggregating ecosystem accounts by PA designation; informing conservation/resource management; communicating spatial distribution of ecosystem assets to decision-makers.

**Key analysis steps:**
1. Extract & deduplicate site coordinates (27 unique locations)
2. Create XY event layer in ArcGIS Pro; spatial join to WDPA
3. Calculate area_ha field for extent polygons
4. Intersect extent polygons with WDPA; summarize by habitat class
5. Dissolve overlapping WDPA polygons; calculate true PA coverage
6. Excel summary: Total extent − Protected extent = Unprotected extent

**Data requirements:**
- Site coordinates: `fish_invert_site_condition.csv` or raw UVC Excel
- Extent layer: Benthic habitat polygons (from skill_extent_measurement_m13_reef.md)
- WDPA shapefile: Free download from https://www.protectedplanet.net/

---

### Service Accounts (What benefits does the ecosystem provide?)

#### [skill_services_regulating_nursery_m13.md](skill_services_regulating_nursery_m13.md)
**Purpose:** Quantify fisheries nursery service — the ecosystem's contribution to wild-caught fish productivity through juvenile habitat and enhanced survival

| Element | Value |
|---------|-------|
| **Service** | Fisheries Nursery (CICES 6.1.1) |
| **Physical supply method** | Log Response Ratio (LRR = 31% enhancement for coral reefs) |
| **Annual enhanced production (estimated)** | ~20,362 kg/yr (subject to extent mapping and price data) |
| **Valuation method** | Market price of landed fish |
| **Unit price (assumed)** | $3/kg (RANGE: $2–5/kg) — **URGENT: CONFIRM via market survey** |
| **Estimated annual value** | **~$61,087/yr** (low: $41K, high: $102K; ±50% uncertainty) |
| **Value per hectare** | ~$122/ha/yr (reef area = 500 ha assumed) |
| **Status** | Preliminary estimate; CRITICAL data gaps in price + no-reef baseline |

**When to use:** Estimating ecosystem service value; identifying priority data acquisitions; communicating economic importance of reefs to decision-makers.

**URGENT DATA NEEDS (CRITICAL for accurate valuation):**
1. **Landed fish price** — Contact Laza + local fish markets in Anakao, Ifaty, Salary, Toliara (1 month)
2. **No-reef baseline** — Survey sandy/rubble areas for fish density (2026 field season)
3. **Ecosystem extent** — Complete satellite mapping (Mar 2026)
4. **Regional landings** — Request from Madagascar MPRH (Fisheries Ministry)

---

#### [skill_services_provisioning_wildfish_m13.md](skill_services_provisioning_wildfish_m13.md)
**Purpose:** Quantify wild fish provisioning service — the ecosystem's contribution to food security and livelihoods through actual catch

| Element | Value |
|---------|-------|
| **Service** | Wild fish provisioning (CICES 1.1.1) |
| **Physical supply method** | Catch surveys + landing site monitoring |
| **Annual catch (estimated)** | ~115,700 kg/yr (top-down estimate pending validation) |
| **Valuation method** | Resource Rent (Gross Revenue − Total Costs) |
| **Unit price** | $2.50/kg average ($1–8/kg by species family) |
| **Estimated gross revenue** | **~$289,250/yr** |
| **Estimated net profit (resource rent)** | **~$87,563/yr** (±50% uncertainty) |
| **Value per hectare** | ~$175–185/ha/yr (reef area = 500 ha assumed) |
| **Status** | Preliminary estimate; CRITICAL data gaps in landings + cost data |

**When to use:** Estimating economic value of reef fisheries; understanding local livelihood importance; comparing service values (nursery vs. provisioning).

**Distinction from Nursery Service:**
- **Nursery** (regulating): Measures ecosystem *capacity* — enhanced fish density due to reef structure (LRR method; ~$61K/yr)
- **Provisioning** (provisioning): Measures ecosystem *use* — actual human extraction via fishing (catch × price; ~$289K gross, $88K net)

**URGENT DATA NEEDS (CRITICAL):**
1. **Annual landings by species** — Request from Madagascar MPRH + conduct fisher surveys
2. **Landing site catch monitoring** — Establish weekly data collection at 3 sites (3 months; Apr–Jun 2026)
3. **Fisher cost survey** — Interview 20–30 fishers on expenses (labour, fuel, gear; Apr 2026)
4. **Market prices by species** — Coordinate with nursery service skill; monitor 4 weeks (Mar–Apr 2026)
5. **Catch allocation** — Validate species–habitat associations with fisher knowledge (10–15 expert interviews; Mar 2026)

---

## Cross-Skill Integration Map

```
┌─────────────────────────────────────────────────────────────┐
│           Ecosystem Condition Accounts (M1.3)               │
│                                                              │
│  skill_condition_biotic_fish_invert.md                       │
│  ├─ Fish UVC data (5,186 records)                           │
│  ├─ Invertebrate data (COTS, urchins, clams)               │
│  └─ Output: site-level indicators                          │
│       ↓                                                      │
│  skill_condition_measurement_m13_reef.md                    │
│  ├─ Integrate: benthic habitat (extent map)                │
│  ├─ Normalize: condition indices (0–1)                     │
│  └─ Output: SEEA EA condition account table                │
│       ↓                                                      │
└─────────────────────────────────────────────────────────────┘
       ↓ Condition Index (CI)
       ├─ Fish biomass CI: 1.0
       ├─ Richness CI: 0.53
       └─ COTS CI: 0.98 (inverted)
       ↓ Composite CI: 0.84
┌─────────────────────────────────────────────────────────────┐
│           Ecosystem Extent Accounts (M1.3)                  │
│                                                              │
│  skill_extent_measurement_m13_reef.md                       │
│  ├─ Sentinel-2 satellite imagery (10 m resolution)         │
│  ├─ SAM classification: coral, algae, sand, seagrass      │
│  ├─ Ground truth: 27 UVC sites + 25–50 points            │
│  └─ Output: ecosystem extent (hectares), change matrix    │
│       ↓ Ecosystem Area (hectares)                          │
│                                                              │
│  skill_extent_protected_areas_m13_reef.md                  │
│  ├─ WDPA spatial join: which sites in protected areas?    │
│  ├─ Extent disaggregation: reef (ha) per PA + unprotected │
│  └─ Output: PA assignment table, protected vs. unprotected │
│       ↓ Extent (ha) × PA Status                           │
└─────────────────────────────────────────────────────────────┘
       ↓ Extent (ha) × Condition (0–1)
       = Condition-adjusted extent
┌─────────────────────────────────────────────────────────────┐
│        Ecosystem Service Accounts (M1.3 → Fisheries)        │
│                                                              │
│  skill_services_regulating_nursery_m13.md                   │
│  ├─ LRR method: enhanced biomass = (1,929 − 300) kg/ha   │
│  ├─ Market price: $3/kg (URGENT: confirm)                 │
│  ├─ Extent: 500 ha (from extent account)                  │
│  └─ Output: fisheries nursery service value table         │
│       ↓                                                      │
│  Physical supply: 20,362 kg/yr                             │
│  Economic value: ~$61,087/yr (±50% uncertainty)           │
└─────────────────────────────────────────────────────────────┘
```

## How to Use This Library

### For Field Teams
1. Start with **skill_condition_biotic_fish_invert.md** — protocols for fish/invertebrate surveys
2. Reference **skill_extent_measurement_m13_reef.md** for field validation (drop-camera sites)
3. Use data sheets and QA/QC checklists (provided in each skill)

### For Data Analysts
1. Read **skill_condition_measurement_m13_reef.md** — understand indicator calculations + normalization
2. Use **skill_services_regulating_nursery_m13.md** + **skill_services_provisioning_wildfish_m13.md** — link condition data to service valuations
3. Generate output tables: `fish_invert_seea_condition.csv`, service supply & use tables (nursery + provisioning)

### For Decision-Makers & Communicators
1. Focus on **skill_services_regulating_nursery_m13.md** + **skill_services_provisioning_wildfish_m13.md** — ecosystem service values ($/year)
   - Nursery service: ~$61K/yr (regulating; enhanced production)
   - Provisioning service: ~$289K gross revenue, ~$88K net profit (livelihood value)
2. Reference **skill_condition_measurement_m13_reef.md** for condition summary (composite CI = 0.84)
3. Use **skill_extent_measurement_m13_reef.md** to understand spatial context (ecosystem area in hectares)

---

## Output Templates for Dissemination

After completing the skills above, use one of two templates to package SEEA EA account findings:

### [Scientific Publication Template](../../template_seea_publication.md)
**Purpose:** Peer-reviewed journal article or technical report for academic/institutional audiences

**When to use:**
- Publishing results in journals like *Ecosystem Services*, *Environmental Research Letters*, or *Nature Sustainability*
- Submitting to institutional repositories (WRI, UNEP, CGIAR, etc.)
- **Audience:** Environmental economists, ecologists, peer reviewers, researchers
- **Tone:** Academic rigor, methodological transparency, statistical disclosure, citable

**Which skills feed in:**
- **skill_condition_measurement_m13_reef.md** → Methods section (indicator definitions, reference levels, normalisation)
- **skill_extent_measurement_m13_reef.md** → Methods section (satellite classification, ground truth validation) + Results (extent account table)
- **skill_services_regulating_nursery_m13.md** + **skill_services_provisioning_wildfish_m13.md** → Methods + Results (service valuation pathways, supply tables)
- **skill_extent_protected_areas_m13_reef.md** → Results (extent disaggregated by PA status, protected vs. unprotected ecosystem service value)

**Key components:**
- 7-section structure: Title/Abstract → Intro → Methods (4 subsections) → Results → Discussion → Conclusions → Data Availability
- Sensitivity analysis table (transect area, reference levels, market prices, discount rates)
- Policy scenarios with cost-benefit sketches (status quo, protected area expansion, integrated restoration)
- Full reproducibility checklist (code availability, assumption transparency, 10-year data archival)

---

### [Policy Brief Template](../../POLICY_BRIEF_TEMPLATE.md)
**Purpose:** Concise 3-page summary for government and conservation decision-makers

**When to use:**
- Presenting findings to ministry officials, parliamentary committees, or conservation agencies
- Informing marine spatial planning or fisheries policy updates
- Communicating with donors (e.g., GCF, GEF, bilateral donors)
- **Audience:** Policy makers, NGO leaders, development partners, fisheries ministry officials
- **Tone:** Clear, actionable, locally grounded, emotionally engaging

**Which skills feed in:**
- **skill_condition_measurement_m13_reef.md** → Page 1 (headline condition findings; benchmark comparisons)
- **skill_services_regulating_nursery_m13.md** + **skill_services_provisioning_wildfish_m13.md** → Page 1 (economic price tag: USD 149K/yr total value)
- **skill_extent_protected_areas_m13_reef.md** → Page 2 (spatial policy lever: protected area expansion scenarios, value difference)
- All skills → Page 2 (policy gap analysis: which laws/decrees are missing real-time ecosystem monitoring?)

**Key components:**
- **Page 1:** Situation + data snapshot (3 headline findings, local context, policy gap)
- **Page 2:** Policy analysis (current regulations, gap analysis, tiered recommendations with responsible parties & timelines)
- **Page 3:** Engagement + action plan (stakeholder map, addressing objections, 0–6 month quick wins, monitoring framework)
- Visual format: 1 figure per page, 1 callout box per page, narrative prose (not tables)

---

### Decision Tree: Which Template to Use?

```text
Do you need to publish formally
in a journal or repository?
    │
    ├─ YES → Use SCIENTIFIC PUBLICATION TEMPLATE
    │        (Audience: researchers, peer reviewers, institutional archives)
    │        Full 8–10 pages | Methods-first | Statistical detail | Citable
    │
    └─ NO → Are you presenting to government officials
            or conservation decision-makers?
                │
                ├─ YES → Use POLICY BRIEF TEMPLATE
                │        (Audience: ministry, NGO, donors)
                │        Exactly 3 pages | Findings-first | Narrative | Actionable
                │
                └─ NOT SURE → Use BOTH templates in sequence:
                             1. Draft policy brief first (clarifies key messages)
                             2. Expand to publication template (adds methods rigor)
```


## Data Files Cross-Reference

| Skill File | Inputs From | Outputs To |
|---|---|---|
| skill_condition_biotic_fish_invert.md | Raw UVC Excel (Fishdata_OASIS_M.xlsx) | skill_condition_measurement_m13_reef.md |
| skill_condition_measurement_m13_reef.md | Fish condition + benthic habitat extent | SEEA EA condition account table |
| skill_extent_measurement_m13_reef.md | Sentinel-2 imagery + field validation | SEEA EA extent account table + skill_extent_protected_areas_m13_reef.md |
| skill_extent_protected_areas_m13_reef.md | Site coordinates + extent layer + WDPA polygons | Extent disaggregated by PA status (protected vs. unprotected) |
| skill_services_regulating_nursery_m13.md | Fish biomass (condition) + reef area (extent) + market price | SEEA EA regulating service account (nursery) |
| skill_services_provisioning_wildfish_m13.md | Catch data + fisher costs + market prices | SEEA EA provisioning service account (wild fish) |

## Priority Data Acquisitions (Next 3 Months)

| Data Element | Responsibility | Timeline | Criticality | Service(s) |
|---|---|---|---|---|
| **Landed fish market price** | Laza + local market surveys (Anakao, Ifaty, Salary, Toliara) | Mar–Apr 2026 | CRITICAL | Nursery + Provisioning |
| **Ecosystem extent mapping** | GIS team; skill_extent_measurement_m13_reef.md | Mar–Apr 2026 | CRITICAL | Condition + Extent + Both Services |
| **No-reef baseline fish density** | Field team; survey 5–10 sandy/rubble sites | Apr–May 2026 | HIGH | Nursery service |
| **Landing site catch monitoring** | Fisher monitoring at 3 ports (weekly visits; 3 months) | Apr–Jun 2026 | HIGH | Provisioning service |
| **Fisher cost survey** | Interview 20–30 fishers (labour, fuel, gear, vessel costs) | Apr 2026 | HIGH | Provisioning service |
| **Regional landings data** | Madagascar MPRH request (3–5 years, by species + gear) | Mar 2026 | HIGH | Provisioning service |
| **Sentinel-2 imagery (2026)** | Copernicus Data Hub (free) | Dec 2026–Jan 2027 | HIGH | Extent account (change detection) |
| **Species–habitat validation** | Fisher knowledge interviews (10–15 expert fishers) | Mar–Apr 2026 | MODERATE | Provisioning service |

---

## Document Control

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-03-04 | Claude Code | Initial creation; customized from Accounting bot templates |
| 1.1 | 2026-03-15 | Claude Code | Added skill_extent_protected_areas_m13_reef.md; updated cross-skill integration map |

## References & Related Resources

- **Accounting bot repo:** `/Users/z5238824/Documents/GitHub/Accounting bot/` (template SOPs)
- **UN SEEA EA Framework:** https://seea.un.org/
- **IUCN Global Ecosystem Typology:** https://www.iucnget.org/
- **Madagascar project docs:** `../cond_reef_fish_invert_plan.md`, `../data_flow_condition_to_services.md`

---

**Last updated:** 2026-03-15
**Maintainers:** AFRICA–Madagascar team
**Contact:** Laza (field data), Yves Amoros Mitondrasoa (extent/habitat)
