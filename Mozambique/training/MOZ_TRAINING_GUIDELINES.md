# Mozambique SEEA EA Ecosystem Accounting -- Training Guidelines

**Purpose:** Practical training guide for researchers, statisticians, and practitioners building SEEA EA mangrove ecosystem accounts from NASA GEDI spaceborne LiDAR data.

**Audience:** Remote sensing analysts, GIS specialists, national statistics office staff, environmental economists, conservation planners, and carbon project developers.

**Prerequisite knowledge:** Basic GIS skills, familiarity with spreadsheet data management, and (for analysis modules) introductory R programming. No prior remote sensing or LiDAR experience required.

---

## Table of Contents

1. [Training Overview](#1-training-overview)
2. [Module 1: SEEA EA Foundations and Remote Sensing Context](#2-module-1-seea-ea-foundations-and-remote-sensing-context)
3. [Module 2: Understanding GEDI Data](#3-module-2-understanding-gedi-data)
4. [Module 3: Extent Mapping with GMW and GIS](#4-module-3-extent-mapping-with-gmw-and-gis)
5. [Module 4: Condition Account from GEDI](#5-module-4-condition-account-from-gedi)
6. [Module 5: Carbon Stock Estimation](#6-module-5-carbon-stock-estimation)
7. [Module 6: Cross-Site and Cross-Country Comparison](#7-module-6-cross-site-and-cross-country-comparison)
8. [Module 7: Field Validation Planning](#8-module-7-field-validation-planning)
9. [Module 8: Policy Communication](#9-module-8-policy-communication)
10. [Practical Exercises](#10-practical-exercises)
11. [Assessment Criteria](#11-assessment-criteria)
12. [Resources and Further Reading](#12-resources-and-further-reading)

---

## 1. Training Overview

### 1.1 Learning Objectives

By the end of this training, participants will be able to:

1. Explain the SEEA EA framework and how remote sensing supports ecosystem accounting
2. Interpret NASA GEDI LiDAR variables (canopy height, cover, biomass, PAI)
3. Apply the confidence framework for GEDI-based estimates (HIGH/MODERATE/LOW)
4. Calculate mangrove extent per administrative unit using GIS intersection workflows
5. Normalise GEDI structural indicators to condition indices (0-1 scale)
6. Aggregate asset-level condition to site-level using area-weighting
7. Derive carbon stock estimates from GEDI biomass and asset area
8. Assemble SEEA EA condition and carbon account tables
9. Plan field validation surveys to upgrade PROVISIONAL accounts to CONFIRMED
10. Communicate accounting results to conservation planners and policymakers

### 1.2 Training Structure

| Module | Duration (suggested) | Delivery mode | Prerequisites |
|--------|---------------------|---------------|---------------|
| 1. SEEA EA + Remote Sensing | 0.5 day | Lecture + discussion | None |
| 2. Understanding GEDI Data | 0.5 day | Lecture + data exploration | Module 1 |
| 3. Extent Mapping (GIS) | 0.5 day | Hands-on (ArcGIS/QGIS) | Basic GIS |
| 4. Condition Account | 1 day | Hands-on (R + Excel) | Module 2 |
| 5. Carbon Stock Estimation | 0.5 day | Hands-on (R + Excel) | Module 4 |
| 6. Cross-Site Comparison | 0.5 day | Workshop | Modules 4-5 |
| 7. Field Validation Planning | 0.5 day | Workshop + planning | Module 4 |
| 8. Policy Communication | 0.5 day | Workshop + writing | All modules |

**Total:** ~4.5 days (can be delivered as a continuous workshop or split across sessions)

### 1.3 Software Requirements

| Software | Version | Purpose | Modules |
|----------|---------|---------|---------|
| R | 4.3+ | Statistical analysis | 4-6 |
| RStudio | 2023+ | IDE for R | 4-6 |
| R packages | readr, dplyr, here | Data manipulation | 4-6 |
| ArcGIS Pro or QGIS | 3.0+ / 3.28+ | Spatial analysis | 3 |
| Excel / LibreOffice | Any | Data review | All |

---

## 2. Module 1: SEEA EA Foundations and Remote Sensing Context

### 2.1 SEEA EA Recap

Three account types: extent (area), condition (quality), services (benefits).

For Mozambique mangroves:
- **Extent:** GMW 2020 provides the area baseline (ha per admin unit and per asset)
- **Condition:** GEDI LiDAR provides structural indicators normalised to 0-1
- **Services:** Carbon stock (Mg C) as a physical account; monetary valuation deferred to future work

### 2.2 Why Remote Sensing?

Remote sensing fills gaps where field surveys are not feasible:
- Large, inaccessible mangrove systems (Save Estuary: 12,085 ha)
- Baseline needed before field teams are deployed
- Wall-to-wall coverage (every asset measured, not just sampled sites)
- Repeatable (satellite revisits enable temporal monitoring)
- Low cost (GEDI data are freely available from NASA)

### 2.3 Limitations of Remote Sensing

- No species identification (structural metrics only)
- No biotic health indicators (disease, quality, recruitment)
- Measurement artefacts (GEDI footprints include non-mangrove surfaces)
- Calibration required (field validation needed to confirm satellite estimates)

### 2.4 Discussion Questions

- When would you choose remote sensing over field surveys? When would you choose both?
- What policy decisions could a PROVISIONAL (unvalidated) account inform?
- How does GEDI compare to other remote sensing sources (Sentinel-2, Planet, drone LiDAR)?

---

## 3. Module 2: Understanding GEDI Data

### 3.1 How GEDI Works

GEDI fires laser pulses from the International Space Station. Each pulse illuminates a ~25 m diameter footprint on the ground. The return waveform reveals:

- **Top of canopy** (RH100): height of the tallest vegetation return
- **Ground level:** height of the lowest return
- **Canopy profile:** vertical distribution of vegetation (used for cover and PAI)
- **Biomass model:** Allometric relationships convert height profiles to AGBD

### 3.2 GEDI Products Used

| Product | Level | What it provides |
|---------|-------|-----------------|
| L2A | Footprint | Canopy height metrics (RH25, RH50, RH75, RH100) |
| L2B | Footprint | Canopy cover fraction, Plant Area Index |
| L4A v2 | Footprint | Above-ground biomass density (Mg/ha) + standard error |

All products are aggregated to asset-level means in the input data (Point_Count = number of footprints).

### 3.3 Data Exploration Exercise

**Exercise 2.1:** Open MOZ_mangrove_condition_by_asset.csv and answer:

1. How many assets does each site have?
2. Which asset has the most GEDI footprints? Which has the fewest?
3. What is the range of canopy heights across all assets?
4. Are the AGBD standard errors larger or smaller than the mean AGBD values?
5. Which asset would you flag as LOW confidence, and why?

---

## 4. Module 3: Extent Mapping with GMW and GIS

### 4.1 Three-Step GIS Workflow

1. **Intersect** GMW 2020 mangrove polygons with admin boundaries
2. **Calculate area** in hectares for each clipped polygon
3. **Summarise** total mangrove area per admin unit

### 4.2 Key GIS Concepts

**Intersection:** Clips input features to the boundaries of overlay features, retaining attributes from both layers. Mangrove polygons that cross admin boundaries are split.

**Area calculation:** Always recalculate area after intersection (clipping changes geometry). Use geodesic area for WGS 1984; planar area for projected CRS.

**Summarise:** Group-by admin unit name; statistic = SUM of area_ha.

### 4.3 Asset Delineation

Mangrove assets are individual contiguous polygons from GMW boundaries. Each asset receives:
- A unique Asset_ID
- An area_ha value (from ArcGIS or R conversion)
- A site label (Save or Morrumbene)

**Morrumbene area conversion:** Shape_Area in square degrees must be converted to hectares using a latitude-corrected factor:

```
lat = -23.5 deg S
area_factor = (111000 x cos(lat x pi/180) x 111000) / 10000
area_ha = Shape_Area x area_factor
```

### 4.4 Practical Exercise

**Exercise 3.1:** Given the following data:

| Admin unit | Mangrove polygons | Area range |
|-----------|------------------|-----------|
| Gaza Province | 84 polygons | 0.5 - 841 ha |
| Inhambane Province | 12 polygons | 2 - 512 ha |

Calculate:
- Total mangrove area for each province
- Number of assets per province
- Average asset size per province

---

## 5. Module 4: Condition Account from GEDI

### 5.1 Learning Objectives

- Apply linear rescaling normalisation to GEDI structural indicators
- Handle negative CI values (clamp to 0)
- Compute composite condition index per asset
- Apply area-weighting for site-level aggregation
- Assign and propagate confidence ratings

### 5.2 Normalisation Step-by-Step

For each of the four indicators, for each asset:

```
Step 1: Look up the observed value (e.g., mean_rh100 = 5.07 m)
Step 2: Look up the reference levels (poor = 3, pristine = 15)
Step 3: Calculate: CI = (5.07 - 3) / (15 - 3) = 2.07 / 12 = 0.173
Step 4: Clamp: if CI < 0, set CI = 0; if CI > 1, set CI = 1
Step 5: Repeat for all 4 indicators
Step 6: Composite = mean(CI_height, CI_cover, CI_agbd, CI_pai)
```

### 5.3 Area-Weighting for Site Aggregation

```
CCI_site = sum(CCI_i x area_ha_i) / sum(area_ha_i)
```

Why area-weight? A 841-ha asset should contribute more to the site-level index than a 6-ha asset. Simple averaging would give every asset equal influence regardless of size.

### 5.4 Key Concepts

**Below-poor values:** Both sites have canopy cover below the poor threshold (0.30). The formula produces a negative number, which is clamped to 0. This means "at or below minimum expected condition." It does not mean "no ecosystem."

**Composite interpretation:** A CCI of 0.07 means the ecosystem is at 7% of the way from degraded to pristine across all four structural dimensions. This is a single summary number useful for SEEA EA tables and policy communication.

### 5.5 Practical Exercises

**Exercise 4.1:** Calculate CIs for Save Asset 8:
- Height: 6.26 m (poor=3, pristine=15)
- Cover: 0.328 (poor=0.30, pristine=0.70)
- AGBD: 20.75 Mg/ha (poor=5, pristine=100)
- PAI: 1.293 (poor=0.05, pristine=2.0)

**Exercise 4.2:** Calculate the area-weighted CCI for Morrumbene (3 assets). Compare with the simple (unweighted) mean. How much does weighting change the result?

---

## 6. Module 5: Carbon Stock Estimation

### 6.1 Method

```
Total carbon (Mg C) = carbon density (Mg C/ha) x area (ha)
CO2 equivalent (Mg CO2) = total carbon x 3.664
Uncertainty (Mg C) = AGBD SE x 0.47 x area
```

### 6.2 Carbon vs. Condition

Carbon stock is a physical quantity, not a condition index. It is NOT normalised to 0-1. Instead, it is reported in absolute units (Mg C, Mg CO2) that connect to:
- REDD+ and voluntary carbon markets
- National greenhouse gas inventories
- Blue carbon financing mechanisms

### 6.3 Practical Exercise

**Exercise 5.1:** Calculate the carbon account for all Morrumbene assets:

| Asset | Carbon density (Mg C/ha) | Area (ha) | Total carbon (Mg C) | CO2 eq (Mg CO2) |
|-------|--------------------------|-----------|---------------------|------------------|
| 1 | 5.29 | 512 | ? | ? |
| 2 | 5.07 | 448 | ? | ? |
| 3 | 4.80 | 109 | ? | ? |
| **Total** | | **1,069** | ? | ? |

**Exercise 5.2:** If voluntary carbon credits sell for USD 15 per tonne CO2:
- What is the indicative value of Morrumbene's standing carbon stock?
- What caveat must you attach to this estimate? (Hint: standing stock vs. annual sequestration; additionality; uncertainty bounds)

---

## 7. Module 6: Cross-Site and Cross-Country Comparison

### 7.1 Comparing Save and Morrumbene

Both sites use identical methods, indicators, and reference levels. Direct comparison is valid:

| Metric | Save | Morrumbene | Winner |
|--------|------|-----------|--------|
| Composite CCI | 0.118 | 0.072 | Save |
| Data confidence | Mixed | Higher | Morrumbene |
| Heterogeneity | High | Low | -- |

### 7.2 Comparing Mozambique (GEDI) with Kenya (Field)

Kenya mangrove composite CI = 0.397 (field-based: stem density, DBH, height, cover, quality).
Mozambique composite CCI = 0.072-0.118 (GEDI-based: height, cover, AGBD, PAI).

**Can these be compared?** Both are on a 0-1 scale, but:
- Different indicators (5 vs. 4; biotic vs. structural only)
- Different reference levels (Kenya: WIO field literature; Mozambique: WIO + global remote sensing)
- Different measurement methods (direct measurement vs. satellite)

**Fair comparison requires:** Measuring the same indicators at both sites, OR using GEDI for Kenya mangroves alongside the field data to create a parallel structural account.

### 7.3 Discussion Questions

- What does it mean that Kenya mangroves score CI = 0.40 on field indicators while Mozambique scores CI = 0.07-0.12 on satellite indicators?
- Could the difference be partly methodological rather than ecological?
- How would you design a study to separate methodological differences from real condition differences?

---

## 8. Module 7: Field Validation Planning

### 8.1 Purpose of Field Validation

Field validation answers:
1. Are GEDI height estimates accurate for these mangroves?
2. Does GEDI AGBD match field-derived biomass from allometric equations?
3. Is low canopy cover real or a GEDI artefact?
4. What species are present? How does this affect reference levels?
5. Are there disturbance indicators (logging, erosion) not visible to GEDI?

### 8.2 Field Protocol (Minimum)

Per asset (minimum 3 plots):
- **Canopy height:** Clinometer or height pole; compare with GEDI rh100
- **DBH:** All stems >= 2.5 cm within 10 m radius plot
- **Stem density:** Stems per m2
- **Species:** Identify Rhizophora, Ceriops, Avicennia, Bruguiera proportions
- **Regeneration:** Seedlings and saplings < 1.3 m
- **Disturbance:** Logging scars, erosion, dieback

### 8.3 Priority Sites for Validation

| Priority | Asset | Reason |
|----------|-------|--------|
| 1 | Save Asset 3 | Highest CCI (0.43) but only 3 GEDI footprints; need to confirm or revise |
| 2 | Save Asset 6 | HIGH confidence (31 footprints) but very low CCI (0.045); confirm degradation |
| 3 | Morrumbene Asset 1 | HIGH confidence (85 footprints); representative of uniform structure |
| 4 | Save Assets 2 + 4 | LOW confidence (1-2 footprints); need any ground truth at all |

### 8.4 Practical Exercise

**Exercise 7.1:** Design a 5-day field validation campaign for Save Estuary:
- How many plots per asset?
- Which assets would you prioritise?
- What equipment do you need?
- How would you co-locate plots with GEDI footprints?

---

## 9. Module 8: Policy Communication

### 9.1 Key Messages for Mozambique

**Condition:** Both Save and Morrumbene mangroves show low structural condition (CCI 0.07-0.12), driven by sparse canopy and low biomass. Save Estuary has two productive patches (Assets 3 and 8) that are conservation priorities.

**Carbon:** Combined mangrove carbon stock across both sites is approximately 16,650 Mg C (61,000 Mg CO2 equivalent). This is an underestimate if GEDI underreports biomass in sparse canopy.

**Heterogeneity:** Save Estuary's internal variation (CCI range 0.04-0.43) means site-level averages hide important conservation information. Asset-level reporting is essential.

**Data quality:** All values are PROVISIONAL. Field validation is needed before using these estimates for carbon credit applications or policy commitments.

### 9.2 Policy Brief Framing

For multi-country work, frame at the Western Indian Ocean regional level:
- Headline: "WIO mangrove condition and carbon stocks" (not "Mozambique mangroves")
- Data: Country-specific in the evidence sections
- Context: Regional threats, regional commitments (Nairobi Convention, WIO-SAP)

### 9.3 Practical Exercise

**Exercise 8.1:** Draft a 150-word executive summary for a provincial government official that includes:
- One condition finding
- One carbon stock number
- One policy recommendation
- One data quality caveat

---

## 10. Practical Exercises

### Exercise Summary

| Exercise | Module | Time | Skills practiced |
|----------|--------|------|-----------------|
| 2.1 GEDI data exploration | 2 | 20 min | Data literacy, confidence assessment |
| 3.1 Extent calculation | 3 | 30 min | GIS concepts, area arithmetic |
| 4.1 CI calculation (Save Asset 8) | 4 | 25 min | Normalisation formula, clamping |
| 4.2 Area-weighted aggregation | 4 | 20 min | Weighting, site-level reporting |
| 5.1 Carbon account (Morrumbene) | 5 | 25 min | Carbon calculation, CO2 conversion |
| 5.2 Carbon valuation | 5 | 15 min | Economic interpretation, caveats |
| 7.1 Field validation plan | 7 | 30 min | Survey design, prioritisation |
| 8.1 Executive summary | 8 | 25 min | Policy communication |

### Data Files for Exercises

All in `Mozambique/03_outputs/`:
- MOZ_mangrove_condition_by_asset.csv
- MOZ_mangrove_condition_by_site.csv
- MOZ_mangrove_carbon_account.csv
- MOZ_mangrove_seea_condition_account.csv
- MOZ_FINDINGS_OVERVIEW.md

---

## 11. Assessment Criteria

### 11.1 Competency Levels

| Level | Description |
|-------|-------------|
| Awareness | Can describe GEDI-based ecosystem accounts and their purpose |
| Practitioner | Can run the pipeline, calculate CIs, produce SEEA EA tables |
| Lead analyst | Can adapt reference levels, design field validation, handle edge cases |
| Technical reviewer | Can evaluate methodology, compare with field-based approaches, advise on data quality |

### 11.2 Knowledge Check

| Topic | Assessment |
|-------|-----------|
| GEDI variables and their meaning | Match variable to ecological interpretation |
| Confidence framework | Assign ratings given Point_Count values |
| Normalisation | Calculate CI from observed value and reference levels |
| Area-weighting | Compute site-level CCI from asset data |
| Carbon estimation | Derive total carbon and CO2 equivalent from density and area |
| Data quality | Identify and explain PROVISIONAL status and its implications |

---

## 12. Resources and Further Reading

### 12.1 GEDI Resources

| Resource | Access |
|----------|--------|
| GEDI Mission Overview | gedi.umd.edu |
| GEDI Data Products (LP DAAC) | lpdaac.usgs.gov/products/gedi |
| GEDI Finder (footprint search) | gedi.umd.edu/data/finder |
| GEDI L4A v2 User Guide | lpdaac.usgs.gov |

### 12.2 Mozambique-Specific Resources

| Resource | Location |
|----------|----------|
| Full methodology document | Mozambique/docs/training/MOZ_SEEA_EA_METHODOLOGY.md |
| Condition SOP | Mozambique/docs/skills/skill_condition_mangrove_mft12_mozambique.md |
| Extent SOP | Mozambique/docs/skills/skill_extent_mangrove_m13_mozambique.md |
| Analysis plan | Mozambique/docs/accounts/mangrove_analysis_plan.md |
| Findings overview | Mozambique/03_outputs/MOZ_FINDINGS_OVERVIEW.md |
| R scripts | Mozambique/02_analysis/ |
| Output CSVs | Mozambique/03_outputs/ |

### 12.3 Mangrove Reference Literature

| Source | Use |
|--------|-----|
| Fatoyinbo et al. (2008) *Global Change Biology* | Mozambique mangrove height/biomass from SRTM/Landsat |
| Lagomasino et al. (2015) *Remote Sensing of Environment* | WIO mangrove height from LiDAR |
| Sitoe et al. (2016) *Forests* | Sofala Bay mangrove biomass (Mozambique) |
| Godoy & De Lacerda (2015) *Wetlands* | Degraded mangrove biomass reference (5-9 Mg/ha) |
| Bunting et al. (2022) | Global Mangrove Watch v4.019 methodology |

### 12.4 Cross-Country Resources

| Country | Ecosystem | Resource |
|---------|-----------|----------|
| Kenya | Mangrove + coral reef + seagrass | Kenya/docs/training/ |
| Madagascar | Coral reef M1.3 | Madagascar/docs/skills/ |

---

*Version: 1.0*
*Created: 2026-03-29*
*Companion documents: MOZ_SEEA_EA_METHODOLOGY.md, MOZ_FACILITATOR_GUIDE.md*
