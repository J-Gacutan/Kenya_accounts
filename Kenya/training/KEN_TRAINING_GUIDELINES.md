# Kenya SEEA EA Ecosystem Accounting -- Training Guidelines

**Purpose:** Practical training guide for researchers, statisticians, and practitioners building SEEA EA ecosystem accounts for coastal/marine ecosystems in Kenya and the Western Indian Ocean region.

**Audience:** Field ecologists, data analysts, national statistics office staff, environmental economists, and policy advisors involved in natural capital accounting.

**Prerequisite knowledge:** Basic familiarity with ecological field surveys, spreadsheet data management, and (for analysis modules) introductory R programming.

---

## Table of Contents

1. [Training Overview](#1-training-overview)
2. [Module 1: SEEA EA Foundations](#2-module-1-seea-ea-foundations)
3. [Module 2: Field Data Collection and Standards](#3-module-2-field-data-collection-and-standards)
4. [Module 3: Data Management and QA/QC](#4-module-3-data-management-and-qaqc)
5. [Module 4: Condition Account -- Coral Reefs](#5-module-4-condition-account----coral-reefs)
6. [Module 5: Condition Account -- Mangroves](#6-module-5-condition-account----mangroves)
7. [Module 6: Condition Account -- Seagrass](#7-module-6-condition-account----seagrass)
8. [Module 7: Extent Account -- GIS Workflows](#8-module-7-extent-account----gis-workflows)
9. [Module 8: Ecosystem Service Accounts -- Fisheries](#9-module-8-ecosystem-service-accounts----fisheries)
10. [Module 9: Cross-Ecosystem Integration](#10-module-9-cross-ecosystem-integration)
11. [Module 10: Policy Communication](#11-module-10-policy-communication)
12. [Practical Exercises](#12-practical-exercises)
13. [Assessment Criteria](#13-assessment-criteria)
14. [Resources and Further Reading](#14-resources-and-further-reading)

---

## 1. Training Overview

### 1.1 Learning Objectives

By the end of this training, participants will be able to:

1. Explain the structure and purpose of SEEA EA accounts (extent, condition, services)
2. Apply standardised QA/QC procedures to multi-source ecological field data
3. Calculate condition indicators for coral reef, mangrove, and seagrass ecosystems
4. Normalise raw ecological measurements to condition indices (0-1 scale)
5. Construct multi-period extent accounts using GIS-based change detection
6. Estimate the economic value of ecosystem services using the resource rent method
7. Assemble multi-ecosystem SEEA EA account tables for national reporting
8. Communicate accounting results to policymakers through structured briefs

### 1.2 Training Structure

| Module | Duration (suggested) | Delivery mode | Prerequisites |
|--------|---------------------|---------------|---------------|
| 1. SEEA EA Foundations | 0.5 day | Lecture + discussion | None |
| 2. Field Data Collection | 0.5 day | Lecture + field demo | Basic ecology |
| 3. Data Management and QA/QC | 1 day | Hands-on (R + Excel) | Module 2 |
| 4. Condition -- Coral Reefs | 1 day | Hands-on (R) | Module 3 |
| 5. Condition -- Mangroves | 0.5 day | Hands-on (R) | Module 3 |
| 6. Condition -- Seagrass | 0.5 day | Hands-on (R) | Module 3 |
| 7. Extent -- GIS | 1 day | Hands-on (ArcGIS Pro) | Basic GIS |
| 8. Service Accounts -- Fisheries | 1 day | Hands-on (R + Excel) | Module 4 |
| 9. Cross-Ecosystem Integration | 0.5 day | Workshop | Modules 4-8 |
| 10. Policy Communication | 0.5 day | Workshop + writing | Module 9 |

**Total:** ~7 days (can be delivered as a continuous workshop or split across sessions)

### 1.3 Software Requirements

| Software | Version | Purpose | Modules |
|----------|---------|---------|---------|
| R | 4.3+ | Statistical analysis | 3-6, 8-9 |
| RStudio | 2023+ | IDE for R | 3-6, 8-9 |
| R packages | readxl, dplyr, tidyr, stringr, lubridate, janitor | Data manipulation | 3-6, 8 |
| ArcGIS Pro | 3.0+ | Spatial analysis | 7 |
| Excel / LibreOffice | Any | Data review | All |

---

## 2. Module 1: SEEA EA Foundations

### 2.1 Key Concepts

**Ecosystem asset:** A contiguous area of a specific ecosystem type (e.g., 5,742 ha of mangrove in Kilifi County). Ecosystem assets are measured in hectares (the extent account).

**Ecosystem condition:** The quality of an ecosystem asset relative to a reference state. Measured using biotic, abiotic, and landscape indicators, normalised to a 0-1 scale where 1 = reference condition.

**Ecosystem service:** The contribution of an ecosystem to human welfare. Measured in physical units (e.g., MT of fish per year) and monetary units (e.g., USD resource rent per year).

**Accounting period:** The time interval over which changes in extent, condition, and services are tracked. The Kenya pilot uses 2024-2025 for condition and 2020-2025 for extent.

### 2.2 Account Relationships

```
EXTENT (How much?)
    |
    +--> CONDITION (What quality?)
    |        |
    |        +--> SERVICES (What benefits?)
    |                |
    |                +--> MONETARY VALUATION (What economic value?)
    |
    +--> PROTECTED AREA DISAGGREGATION
             (How does protection affect condition and extent?)
```

Condition depends on extent (condition per unit area requires knowing the area). Services depend on both condition (healthy reefs produce more fish) and extent (more reef area = more total service).

### 2.3 Discussion Questions

- Why do we need both extent AND condition accounts? What does each tell us that the other cannot?
- How does SEEA EA differ from traditional ecological monitoring?
- What policy decisions could ecosystem accounts inform in Kenya?
- How does the IUCN Global Ecosystem Typology (GET) classification help standardise accounts across countries?

---

## 3. Module 2: Field Data Collection and Standards

### 3.1 Survey Design Principles for SEEA EA

SEEA EA does not prescribe specific field methods, but it requires:

- **Spatial coverage:** Sites should represent the range of conditions across the ecosystem asset (not only the best or worst areas)
- **Replication:** Multiple transects/plots per site to estimate within-site variance
- **Standardised indicators:** Indicators should be comparable across sites and over time
- **Temporal repeatability:** Field protocols must be documented precisely enough for future teams to replicate

### 3.2 Kenya Survey Protocols

**Coral reef UVC (Underwater Visual Census):**
- Belt transects (50 m long, assumed 5 m wide = 250 m2)
- Fish: species, family, size class (5 cm bins), count per transect
- Invertebrates: species, count per transect
- Coral: benthic cover (LIT/PIT or quadrat), health status per colony, size class, recruitment per m2 quadrat

**Mangrove plot survey:**
- 10 x 10 m (100 m2) fixed plots
- All trees measured: species, circumference at POM, DBH, height, quality class (1-3)
- Canopy cover estimated per plot (categorical class)
- Sub-branches identified and flagged

**Seagrass quadrat survey:**
- Cover: 50 cm x 50 cm sub-quadrats nested in 5 m x 5 m reference plots; % cover by species
- Health: 15 cm x 15 cm quadrats; shoot count (raw) and canopy height (cm) by species and zone

### 3.3 Data Submission Standards

All field data should be submitted in the standard data submission form with:

- GPS coordinates (decimal degrees preferred; DMS acceptable but must be clearly labelled)
- Survey date in unambiguous format (YYYY-MM-DD preferred)
- Observer name(s) for quality tracking
- Site name matching the project's canonical site list
- Species names matching accepted taxonomy (FishBase for fish; WoRMS for invertebrates; accepted botanical names for mangroves and seagrass)

### 3.4 Common Field Data Issues (Lessons from Kenya)

| Issue | Ecosystem | Prevention |
|-------|-----------|------------|
| Template rows left in Excel (placeholder dates 2025-2092) | Coral reef | Delete unused template rows before submission |
| Species names as abbreviations (RM, Rm, rm for Rhizophora mucronata) | Mangrove | Use full scientific names; provide a lookup if abbreviations are used |
| Mixed date formats in same column | Seagrass | Use a single date format throughout; YYYY-MM-DD preferred |
| GPS coordinates in DMS strings instead of decimal degrees | All | Configure GPS devices to output decimal degrees; label DMS columns clearly |
| Duplicate column headers (e.g., two "Longitude" columns) | Coral reef | Review column headers before submission |
| Positive latitude values for Southern Hemisphere sites | Coral reef | Apply negative sign convention at data entry; QA/QC catches this |

---

## 4. Module 3: Data Management and QA/QC

### 4.1 The QA/QC Pipeline

Every analysis script in this project follows a standardised pipeline:

```
Step 1: INGEST
    Read Excel files with readxl::read_excel()
    Clean column names with janitor::clean_names()

Step 2: STANDARDISE
    Site names --> canonical lookup table
    Species names --> accepted taxonomy lookup
    Dates --> ISO 8601 (YYYY-MM-DD)
    Coordinates --> decimal degrees (negative for S/W)

Step 3: VALIDATE
    Flag out-of-range values (do not silently drop)
    Cross-check derived columns (e.g., DBH vs Circumference/pi)
    Detect duplicates
    Count rows at each step (audit trail)

Step 4: TRANSFORM
    Convert raw measurements to standard units
    Apply scaling factors (e.g., transect area, quadrat area)
    Calculate derived indicators

Step 5: AGGREGATE
    Transect/plot to site level (mean +/- SE)
    Site to accounting area (PA-disaggregated)

Step 6: EXPORT
    CSV files with KEN_ prefix to 03_outputs/
    QA/QC log with row counts
```

### 4.2 Practical Exercise: QA/QC Walkthrough

**Exercise 3.1:** Open the mangrove dataset (All_mangrove_field_data.xlsx) and:

1. Identify how many unique values exist in the Species column
2. Map each variant to its canonical scientific name
3. Count the number of sub-branch records (Sub column is not NA)
4. Verify that DBH = Circumference / pi for 5 random rows
5. Convert 3 DMS coordinate strings to decimal degrees by hand

**Exercise 3.2:** Open the seagrass cover sheet and:

1. Count how many date formats appear in the Date column
2. Identify all spelling variants for seagrass species names
3. Check whether any Percentage Cover values exceed 100%
4. Verify that all latitude values fall within the expected Kilifi County range (-4.5 to -2.5)

### 4.3 Key R Functions for QA/QC

```r
# Column name standardisation
library(janitor)
df <- clean_names(df)

# Site name lookup
standardise_site <- function(x, lookup) {
  lookup[match(tolower(trimws(x)), tolower(names(lookup)))]
}

# GPS decimal point restoration
fix_gps <- function(lat, lon, lat_range = c(-5, -1), lon_range = c(38, 42)) {
  # Detect missing decimal points and restore
  # Flag values outside valid range
}

# Column harmonisation across survey programmes
df <- df %>% rename_with(
  ~ case_when(
    .x == "transect_number" ~ "transect_no",
    .x == "transect" ~ "transect_no",
    TRUE ~ .x
  )
)
```

---

## 5. Module 4: Condition Account -- Coral Reefs

### 5.1 Learning Objectives

- Calculate fish biomass from UVC survey data using allometric relationships
- Derive coral health, recruitment, and benthic cover indicators
- Normalise indicators to condition indices using published reference levels
- Disaggregate condition by protected area category
- Handle multi-period data (opening vs. closing) with post-bleaching caveats

### 5.2 Fish Biomass Calculation

**Step-by-step:**

1. Parse fish size range strings to midpoints (e.g., "10--20" = 15 cm)
2. Join FishBase allometric parameters (a, b) by species, then by family
3. Calculate individual weight: W = a x L^b (grams)
4. Calculate transect biomass: sum(W x count) / 1000 / transect_area_ha
5. Aggregate to site mean +/- SE across transects

**Key decision point:** Transect area assumption (250 m2 in Kenya). This value scales all per-ha outputs linearly. Confirm with the field team before publishing.

### 5.3 Coral Condition Indicators

**Health status per colony:**
```
n_total = sum(healthy + pale + bleached + diseased + dead)
pct_healthy = 100 x n_healthy / n_total
```

**Recruitment density:**
```
recruits_m2 = total_recruit_count / quadrat_area_m2
```

**Size structure (persistence proxy):**
```
pct_large = 100 x n_colonies(>80 cm) / n_colonies(total)
```

### 5.4 Practical Exercise

**Exercise 4.1:** Using the fish condition output (KEN_fish_condition_site.csv):

1. Identify the 3 sites with highest fish biomass (kg/ha)
2. Calculate the condition index for each site using the 1,150 kg/ha reference
3. Compare biomass across PA categories -- does protection correlate with higher biomass?

**Exercise 4.2:** Using the coral health output (KEN_coral_health_site.csv):

1. Calculate the bleaching condition index for each site (inverted formula)
2. Compare Nov 2024 (opening) and Jul 2025 (closing) -- what changed?
3. Discuss: why should we be cautious about interpreting this change?

---

## 6. Module 5: Condition Account -- Mangroves

### 6.1 Learning Objectives

- Calculate 5 structural condition indicators from plot-based tree survey data
- Apply the linear rescaling normalisation formula
- Interpret the combination of high stem density + low DBH as a regeneration signature
- Compare protected vs. unprotected mangrove condition

### 6.2 Key Concepts

**Sub-branch treatment:** Sub-branches share a root system with the main stem. They are excluded from stem density counts (which measure independent trees) but included in DBH and height calculations (which describe the full stand structure).

**Cover class conversion:** Field data records canopy cover as a categorical class (e.g., "40-60"). Convert to the midpoint for analysis (e.g., 50%). Document the lookup table used.

**Species-zone interactions:** Ceriops tagal forms dense, short stands in landward zones. Avicennia marina pioneers disturbed sites with variable density. Rhizophora mucronata dominates seaward fringe with prop roots. Consider whether a single reference level is appropriate across species and zones.

### 6.3 Practical Exercise

**Exercise 5.1:** Using the mangrove condition by site output (KEN_mangrove_condition_by_site.csv):

1. Plot the 5 condition indices as a radar chart for Mida Creek MNR vs. unprotected sites
2. Which indicators show the largest protected-area effect?
3. Why might stem density be higher in unprotected sites? (Hint: regeneration dynamics)

**Exercise 5.2:** Calculate the composite CI for a hypothetical plot:
- Stem density: 2,500 trees/ha
- Mean DBH: 8 cm
- Mean height: 5 m
- Canopy cover: 60%
- Tree quality: 0.7

Walk through each normalisation step and compute the composite.

---

## 7. Module 6: Condition Account -- Seagrass

### 7.1 Learning Objectives

- Distinguish between cover-based and health-based seagrass indicators
- Convert raw shoot counts to per-m2 density using quadrat area
- Apply two-stage aggregation (quadrat to plot to site) for unbiased estimates
- Understand the difference between absolute and relative (in-sample) condition indices

### 7.2 Key Concept: Absolute vs. Relative Indices

**Absolute index:** Normalised against a published reference level (e.g., cover / 60%).
- Comparable across datasets, time points, and regions
- Requires a credible published reference

**Relative index:** Normalised against the maximum observed in the current dataset (e.g., richness / max_richness).
- Provides ranking within the dataset only
- NOT comparable across datasets or time points
- Must be clearly labelled as "relative" in all outputs

The Kenya seagrass account uses absolute indices for total cover and relative indices for shoot density, canopy height, and species richness (where no published Kenyan baseline exists).

### 7.3 Practical Exercise

**Exercise 6.1:** Convert 3 raw shoot density values from the Health sheet:
- Raw count = 12 shoots in a 15 cm x 15 cm quadrat: density = ?
- Raw count = 45 shoots: density = ?
- Raw count = 3 shoots: density = ?
(Answer: 533, 2000, 133 shoots/m2)

**Exercise 6.2:** A site has total seagrass cover = 42% and species richness = 6. The maximum richness observed across all sites is 8.
- Calculate cover CI (reference = 60%): ?
- Calculate richness CI (relative): ?
- Which index type (absolute or relative) carries higher confidence, and why?

---

## 8. Module 7: Extent Account -- GIS Workflows

### 8.1 Learning Objectives

- Calculate ecosystem area from polygon features in ArcGIS Pro
- Handle overlapping protected area boundaries using Dissolve
- Perform change detection using Erase analysis
- Assemble a multi-period SEEA EA extent account table

### 8.2 Seven-Step Workflow

| Step | Tool | Input | Output |
|------|------|-------|--------|
| 1. Total extent | Summary Statistics | mangroveextent_2025 | Total_mangrove_area_statistics.csv |
| 2. Per-WDPA extent | Intersect + Summary Statistics | mangroveextent_2025 + WDPA | Mangrove_WDPA_statistics.csv |
| 3. True protected extent | Dissolve + Intersect | WDPA | True_protected_area_statistics.csv |
| 4. Unprotected extent | Subtraction (Excel) | Steps 1 + 3 | Mangrove_extent_protected_and_non-protected_areas.csv |
| 5. GMW 2020 baseline | Clip + Summary Statistics | GMW v4.019 | gmw_mng_2020_v4019_statistics.csv |
| 6. Change detection | Erase (both directions) | Steps 1 + 5 | Additions + Reductions shapefiles |
| 7. Account assembly | Calculation (Excel) | Steps 1, 5, 6 | Mangrove_extent_change_2020_2025.csv |

### 8.3 Common GIS Pitfalls

| Pitfall | Consequence | Prevention |
|---------|------------|------------|
| Not dissolving WDPA before true PA extent | Double-counting where PAs overlap | Always use Dissolve before computing true protected area |
| Forgetting to recalculate area after Intersect | Using original polygon areas instead of clipped areas | Add new area_ha field and recalculate after every geometry-changing operation |
| Mixing projections (UTM vs WGS 1984) | Incorrect area calculations | Reproject to a consistent CRS before analysis; use geodesic area for WGS 1984 |
| Erase operation slivers | Small residual polygons inflating polygon count | Acceptable if residual < 5% of net change; document in quality notes |

### 8.4 Practical Exercise

**Exercise 7.1:** Given:
- Opening extent (2020): 6,083 ha
- Additions: 589 ha
- Reductions: 928 ha

Calculate:
- Closing extent: ?
- Net change: ?
- Percentage change: ?
- Verify: does Opening + Additions - Reductions = Closing?

---

## 9. Module 8: Ecosystem Service Accounts -- Fisheries

### 9.1 Learning Objectives

- Classify fisheries catch by habitat association using FishBase
- Calculate reef-attributed catch from county-level landings data
- Apply the resource rent method for monetary valuation
- Adjust for inflation and currency conversion using GDP deflators and exchange rates
- Conduct sensitivity analysis across cost ratio bounds

### 9.2 Resource Rent Method

The resource rent represents the economic surplus generated by the ecosystem itself, after deducting human inputs (labour, fuel, gear, capital):

```
Resource Rent = Gross Revenue x (1 - cost_ratio)
```

**Why resource rent (not gross revenue)?**
Gross revenue includes human effort. Resource rent isolates the ecosystem's contribution. SEEA EA requires resource rent for provisioning services to avoid double-counting human capital.

### 9.3 Ecosystem Attribution

The critical analytical step is separating reef-associated catch from the county aggregate:

```
Reef_catch = Total_catch x reef_attribution_fraction
```

Attribution fractions (40-90% depending on species group) are assigned based on:
1. FishBase habitat classification
2. SeaLifeBase for invertebrates
3. Expert validation (Dr. Pascal Thoya)

### 9.4 Practical Exercise

**Exercise 8.1:** Given:
- KeFS 2024 Snapper catch: 500 MT at KES 350/kg
- Reef attribution: 90%
- Unreported adjustment: x 1.25
- Cost ratio: 62%
- Exchange rate: 134.82 KES/USD

Calculate:
- Reef-attributed catch (MT): ?
- Adjusted catch (MT): ?
- Gross revenue (KES): ?
- Gross revenue (USD): ?
- Resource rent (USD): ?

**Exercise 8.2:** Repeat for Cavalla jacks (50% reef attribution) and Sardines (0% reef attribution). Why does attribution matter so much for the final account?

---

## 10. Module 9: Cross-Ecosystem Integration

### 10.1 Learning Objectives

- Assemble multi-ecosystem condition and extent accounts
- Identify sites with overlapping ecosystem data for seascape analysis
- Understand the links between condition, extent, and services accounts

### 10.2 Assembly Process

The assembly script (_assemble_final_accounts.R) reads individual ecosystem outputs and combines them into:

1. **KEN_SEEA_EA_condition_account_final.csv** -- All condition indicators across all 3 ecosystems, with opening/closing/change rows where multi-period data exists

2. **KEN_SEEA_EA_extent_account_final.csv** -- Extent by ecosystem type with opening/additions/reductions/closing structure

### 10.3 Discussion Questions

- Ngomeni has data for all 3 ecosystems. What does the integrated seascape profile tell us that single-ecosystem accounts cannot?
- How should condition account results inform extent account priorities (e.g., where to focus restoration)?
- If mangrove extent declined 5.6% but condition at remaining sites is moderate (0.40), what are the policy implications?

---

## 11. Module 10: Policy Communication

### 11.1 Learning Objectives

- Translate accounting results into policy-relevant messages
- Structure a policy brief for decision-makers
- Distinguish between academic publications (full citations) and policy briefs (plain language, no scholarly apparatus)

### 11.2 Policy Brief Structure

```
1. HEADLINE (regional framing for WIO context)
2. KEY FINDINGS (3-5 bullet points with numbers)
3. SITUATIONAL CONTEXT (why this matters)
4. EVIDENCE (data tables and charts)
5. POLICY ANCHORS (link to national/regional commitments)
6. RECOMMENDATIONS (actionable, time-bound)
```

**Framing guidance:** For multi-country work, frame at the Western Indian Ocean regional level in headline and opening sections. Country-specific details in data sections; regional framing for context and relevance.

### 11.3 Key Messages from Kenya Accounts

**Coral reef:** Composite reef condition improved from 0.55 to 0.65 between Nov 2024 and Jul 2025, but this must be interpreted as post-bleaching recovery, not a secular trend. Fish biomass remains below the 1,150 kg/ha conservation target at all sites.

**Mangrove:** Kilifi County lost 341 ha (5.6%) of mangroves between 2020-2025. Protected sites in Mida Creek MNR show 23% higher structural condition than unprotected sites, suggesting conservation management is effective.

**Seagrass:** Seagrass meadows are in moderate-to-high condition (composite CI 0.69-0.94) across 10 sites, but all reference levels are provisional. Ngomeni stands out with the highest condition and richness.

**Fisheries:** Coral reef-attributed wild fish catch is provisionally estimated at ~6,000 MT/yr with an economic value (resource rent) of USD 2.8-4.1 million/yr for Kilifi County.

### 11.4 Practical Exercise

**Exercise 10.1:** Draft a 200-word executive summary for the Kenya SEEA EA accounts that a County Governor could read and understand. Include:
- One number from each ecosystem type
- One headline finding about protection effectiveness
- One actionable recommendation

---

## 12. Practical Exercises

### Exercise Summary Table

| Exercise | Module | Time | Skills practiced |
|----------|--------|------|-----------------|
| 3.1 Mangrove QA/QC walkthrough | 3 | 45 min | Species lookup, DBH verification, DMS conversion |
| 3.2 Seagrass data validation | 3 | 30 min | Date parsing, range validation, species matching |
| 4.1 Fish biomass by PA | 4 | 45 min | CI calculation, PA comparison |
| 4.2 Coral health trends | 4 | 30 min | Inverted CI, multi-period interpretation |
| 5.1 Mangrove radar chart | 5 | 45 min | Multi-indicator visualisation, PA effect |
| 5.2 Manual CI calculation | 5 | 20 min | Linear rescaling formula |
| 6.1 Shoot density conversion | 6 | 15 min | Quadrat area scaling |
| 6.2 Absolute vs. relative CI | 6 | 20 min | Index type distinction |
| 7.1 Extent account arithmetic | 7 | 15 min | Opening/closing/change |
| 8.1 Resource rent calculation | 8 | 30 min | Attribution, adjustment, valuation |
| 8.2 Attribution sensitivity | 8 | 20 min | Sensitivity analysis |
| 10.1 Policy brief drafting | 10 | 45 min | Communication, synthesis |

### Data Files for Exercises

All exercise data files are in `Kenya/03_outputs/` (read-only copies for training):

- KEN_fish_condition_site.csv
- KEN_coral_health_site.csv
- KEN_mangrove_condition_by_site.csv
- KEN_mangrove_condition_by_pa.csv
- KEN_seagrass_cover_site.csv
- KEN_seagrass_health_site.csv
- KEN_fisheries_supply_physical.csv
- KEN_fisheries_supply_monetary.csv
- KEN_SEEA_EA_condition_account_final.csv
- KEN_SEEA_EA_extent_account_final.csv

---

## 13. Assessment Criteria

### 13.1 Knowledge Assessment

Participants should be able to demonstrate understanding of:

| Topic | Assessment method |
|-------|------------------|
| SEEA EA framework structure | Short-answer quiz (Module 1) |
| QA/QC pipeline steps | Practical data cleaning exercise (Module 3) |
| Condition indicator calculation | Worked calculation with real data (Modules 4-6) |
| Normalisation formula selection | Given an indicator, choose and apply the correct formula (Modules 4-6) |
| Reference level confidence | Explain why confidence matters and what "provisional" means (Module 4-6) |
| Extent account assembly | GIS exercise producing SEEA EA table (Module 7) |
| Resource rent method | Calculate from KeFS data (Module 8) |
| Policy communication | Draft executive summary (Module 10) |

### 13.2 Competency Levels

| Level | Description |
|-------|-------------|
| Awareness | Can describe what SEEA EA accounts are and why they matter |
| Practitioner | Can run the analysis pipeline with guidance, interpret outputs |
| Lead analyst | Can adapt the pipeline to new ecosystems/countries, set reference levels, handle edge cases |
| Technical reviewer | Can critically evaluate account methodology, identify limitations, suggest improvements |

---

## 14. Resources and Further Reading

### 14.1 Core References

| Resource | Access |
|----------|--------|
| UN SEEA EA (2021) -- Full standard | seea.un.org/ecosystem-accounting |
| SEEA EA Technical Guidance on Biophysical Modelling | seea.un.org |
| IUCN Global Ecosystem Typology | global-ecosystems.org |
| GOAP (Global Ocean Accounts Partnership) | oceanaccounts.org |

### 14.2 Kenya-Specific Resources

| Resource | Location |
|----------|----------|
| Full methodology document | Kenya/docs/training/KEN_SEEA_EA_METHODOLOGY.md |
| Skills library (SOPs) | Kenya/docs/skills/ |
| Account status trackers | Kenya/docs/accounts/ |
| Academic evidence base | Kenya/docs/rag/academic/ |
| R analysis scripts | Kenya/02_analysis/ |
| Output CSVs | Kenya/03_outputs/ |

### 14.3 Regional Case Studies

| Country | Ecosystem | Resource |
|---------|-----------|----------|
| Uganda | Forests, wetlands | _shared/literature/ |
| Rwanda | Forests | _shared/literature/ |
| South Africa | Marine (Operation Phakisa) | _shared/literature/ |
| Madagascar | Coral reef M1.3 | Madagascar/docs/ |
| Mozambique | Mangrove MFT1.2 | Mozambique/docs/ |

### 14.4 Technical References

| Topic | Key source |
|-------|-----------|
| Fish biomass allometry | FishBase (fishbase.org) |
| Coral reef condition benchmarks | McClanahan et al. (2016); GCRMN (2021) |
| Mangrove structural reference | Bosire et al. (2014); Kairo et al. (2009) |
| Seagrass ecology -- East Africa | Bandeira et al. (2014) |
| Fisheries cost structures -- Kenya | Munga et al. (2014) WIOJMS |
| Resource rent methodology | UN SNA 2008; Lange et al. (2018) |
| WDPA protected area data | protectedplanet.net |
| Global Mangrove Watch | globalmangrovewatch.org |

---

*Version: 1.0*
*Created: 2026-03-29*
*Companion document: KEN_SEEA_EA_METHODOLOGY.md*
