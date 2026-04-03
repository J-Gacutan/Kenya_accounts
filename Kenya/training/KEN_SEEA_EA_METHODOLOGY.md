# Kenya SEEA EA Ecosystem Accounting -- Full Methodology

**Project:** AFRICA -- accounts / Kenya
**Framework:** UN System of Environmental-Economic Accounting -- Ecosystem Accounting (SEEA EA)
**Geographic scope:** Kilifi County, Kenya (Kanamai to Malindi MPA)
**Accounting periods:** 2024-2025 (condition); 2020-2025 (extent)
**Data providers:** Pwani University, KMFRI, COMRED Oceans, Kenya Fisheries Service
**Key supervisors:** Dr. Juliet Karisa, Dr. Pascal Thoya (Pwani University)

---

## Table of Contents

1. [Introduction and Framework](#1-introduction-and-framework)
2. [Ecosystem Types and Coverage](#2-ecosystem-types-and-coverage)
3. [Account Structure](#3-account-structure)
4. [Coral Reef (M1.3) Condition Account](#4-coral-reef-m13-condition-account)
5. [Mangrove (MFT1.2) Condition Account](#5-mangrove-mft12-condition-account)
6. [Seagrass (M1.1) Condition Account](#6-seagrass-m11-condition-account)
7. [Mangrove Extent Account](#7-mangrove-mft12-extent-account)
8. [Wild Fish Provisioning Service Account](#8-wild-fish-provisioning-service-account)
9. [Cross-Ecosystem Integration](#9-cross-ecosystem-integration)
10. [Data Quality and QA/QC](#10-data-quality-and-qaqc)
11. [Reference Levels and Normalisation](#11-reference-levels-and-normalisation)
12. [Tiered Assessment Framework](#12-tiered-assessment-framework)
13. [Outputs and File Structure](#13-outputs-and-file-structure)
14. [Open Items and Limitations](#14-open-items-and-limitations)
15. [References](#15-references)

---

## 1. Introduction and Framework

### 1.1 What is SEEA EA?

The UN System of Environmental-Economic Accounting -- Ecosystem Accounting (SEEA EA) is an international statistical standard adopted by the UN Statistical Commission in 2021. It provides a structured framework for measuring:

- **Ecosystem extent** -- the size and location of ecosystem assets (hectares)
- **Ecosystem condition** -- the quality or health of ecosystems (normalised indices 0-1)
- **Ecosystem services** -- the contributions of ecosystems to human welfare (physical and monetary units)

SEEA EA enables governments to integrate natural capital into national accounts alongside GDP, providing evidence for environmental policy, spatial planning, and investment decisions.

### 1.2 Kenya Pilot Scope

The Kenya pilot covers three coastal/marine ecosystem types along the Kilifi County coastline:

| Ecosystem | IUCN GET Code | Account Types | Status |
|-----------|---------------|---------------|--------|
| Photic Coral Reefs | M1.3 | Condition + Services | Complete |
| Intertidal Forests (Mangroves) | MFT1.2 | Condition + Extent | Complete |
| Seagrass Meadows | M1.1 | Condition | Complete |

All three ecosystem types are assessed using field survey data collected by Kenyan research institutions (Pwani University, KMFRI, COMRED Oceans) between 2024-2025, supplemented by official Kenya Fisheries Service (KeFS) landings statistics (2020-2024) and Global Mangrove Watch satellite data (2020-2025).

### 1.3 Why Kilifi County?

Kilifi County spans approximately 120 km of Kenya's central coast, from Kanamai in the south to Ngomeni in the north. It encompasses:

- Watamu Marine National Park (no-take MPA)
- Malindi Marine National Park (no-take MPA)
- Kanamai and Kuruwitu Community Parks (community CPAs)
- Mida Creek Marine National Reserve (mangrove protection)
- Extensive unprotected reef, mangrove, and seagrass habitats

This mix of protection levels enables conservation effectiveness comparisons within the SEEA EA framework.

---

## 2. Ecosystem Types and Coverage

### 2.1 Coral Reefs (M1.3)

**Survey programmes:** Three independent programmes contributed data across two periods:

| Programme | Organisation | Period | Data types |
|-----------|-------------|--------|------------|
| CCVA | KMFRI | Sep-Nov 2024 | Fish UVC, invertebrate UVC |
| PU-GOAP | Pwani University + GOAP | Nov 2024 | Benthic cover, coral size, coral health, recruits |
| COMRED Oceans | COMRED | Jul 2025 | Fish UVC, coral size, coral health, recruits, benthic cover |

**Sites:** ~20 sites across 4 PA categories (no-take MPA, managed MPA, community CPA, open access)

**Total records:** ~11,700 across 8 Excel input files

### 2.2 Mangroves (MFT1.2)

**Survey programme:** Pwani University / GOAP field survey (Sep-Dec 2025)

**Survey design:** Individual tree measurements in 10 x 10 m (100 m2) plots

**Coverage:** 2,095 tree records across 36 plots, 22 sites, 4 areas (Ngomeni, Marereni, Mida Creek, Kilifi Creek)

**Species:** Rhizophora mucronata, Avicennia marina, Bruguiera gymnorhiza, Ceriops tagal

**Remote sensing:** Global Mangrove Watch v4.019 (2020) + project classification (2025) for extent change detection

### 2.3 Seagrass (M1.1)

**Survey programme:** PU-GOAP / Pwani University (May-Nov 2024)

**Two complementary datasets:**
- Cover sheet: 1,604 rows across 10 areas (50 cm x 50 cm sub-quadrats nested in 5 m x 5 m plots)
- Health sheet: 1,436 rows across 11 areas (15 cm x 15 cm quadrats; shoot density + canopy height)

**Species:** 10 seagrass species identified (Thalassia hemprichii, Cymodocea rotundata, C. serrulata, Enhalus acoroides, Halodule uninervis, H. wrightii, Halophila ovalis, H. stipulacea, Syringodium isoetifolium, Thalassodendron ciliatum)

---

## 3. Account Structure

The SEEA EA framework organises accounts into three layers:

```
EXTENT ACCOUNT
    How much ecosystem do we have? (hectares, by protection status)
    Opening extent --> Additions / Reductions --> Closing extent

CONDITION ACCOUNT
    What quality is the ecosystem in? (normalised index 0-1)
    Opening condition --> Change --> Closing condition
    Disaggregated by: site, protected area, indicator

SERVICE ACCOUNT
    What benefits does the ecosystem provide? (physical + monetary)
    Physical supply (MT/yr) + Economic value (USD/yr via resource rent)
```

### Account Period Structure

| Account | Opening Period | Closing Period | Change? |
|---------|---------------|----------------|---------|
| Coral reef condition | Nov 2024 | Jul 2025 | Yes (2 periods) |
| Mangrove condition | Dec 2025 | -- | No (single period) |
| Seagrass condition | 2024 | -- | No (single period) |
| Mangrove extent | 2020 (GMW) | 2025 (project) | Yes (5-year change) |
| Wild fish provisioning | 2020 | 2024 | Yes (5-year time series) |

---

## 4. Coral Reef (M1.3) Condition Account

### 4.1 Indicator Suite

The coral reef condition account uses 10 indicators across 3 biotic groups:

**Fish indicators (from UVC surveys):**

| Indicator | Calculation | Unit | Direction |
|-----------|------------|------|-----------|
| Fish biomass | W = a x L^b per size-class midpoint; scaled to per-ha | kg/ha | Higher = better |
| Fish abundance | Count scaled to per-ha | individuals/ha | Higher = better |
| Fish species richness | Unique species per site | count | Higher = better |
| Trophic composition | % biomass per trophic group | % | Balanced = better |

Fish size ranges are converted to midpoints (e.g., "5--10" = 7.5 cm), then allometric parameters from FishBase (W = a x L^b) are applied to estimate individual weight. Biomass is aggregated per transect and scaled to kg/ha using the assumed transect area (250 m2).

Trophic groups are assigned by family:
- Herbivore: Acanthuridae, Scaridae, Siganidae, Kyphosidae
- Piscivore: Epinephelidae, Serranidae, Carangidae
- Carnivore: Lutjanidae, Lethrinidae, Haemulidae, Mullidae, Labridae, Holocentridae
- Corallivore: Chaetodontidae
- Omnivore: Balistidae, Tetraodontidae, Pomacanthidae
- Planktivore: Pomacentridae

**Invertebrate indicators (from CCVA UVC, Nov 2024 only):**

| Indicator | Target species | Unit | Direction |
|-----------|---------------|------|-----------|
| Sea urchin density | Diadema setosum, Echinometra mathaei, others | ind/m2 | Context-dependent (optimum range) |
| COTS density | Acanthaster planci / cf. solaris | ind/ha | Higher = worse (inverted) |
| Giant clam (Tridacna) | T. squamosa, T. maxima | presence / ind/ha | Higher = better |
| Sea cucumber abundance | Holothuria spp. | ind/ha | Informational |

**Coral structural indicators (from PU-GOAP + COMRED surveys):**

| Indicator | Data source | Unit |
|-----------|------------|------|
| Live coral cover | Benthic LIT/PIT + quadrats | % |
| Coral health status | Colony counts by health state (healthy, pale, bleached, diseased, dead) | % healthy |
| Colony size structure | Size-bin counts (11-20 cm to >320 cm) | % large colonies (>80 cm) |
| Coral recruitment | Recruit counts in 1 m2 quadrats (bins: 0-2.5, 2.6-5, 6-10 cm) | recruits/m2 |

### 4.2 Normalisation Formulae

**Standard (higher = better):**
```
CI = min(measured_value / reference_level, 1.0)
```

**Inverted (higher = worse):**
```
CI = max(1 - measured_value / reference_level, 0.0)
```

**Optimum range (sea urchin density):**
```
CI = max(1 - |measured - optimum| / optimum, 0.0)
where optimum = 1.75 ind/m2 (midpoint of 1.5-2 provisional range)
```

### 4.3 Reference Levels

| Indicator | Reference level | Source | Confidence |
|-----------|----------------|--------|------------|
| Fish biomass | 1,150 kg/ha (conservation target) | McClanahan et al. (2016) PLOS ONE | HIGH |
| Live coral cover | >30% = good condition | GCRMN (2021); Obura et al. (2022) | MEDIUM |
| Bleached colonies | <5% background | Hoegh-Guldberg (1999) | MEDIUM |
| Diseased colonies | <2% background | Bourne et al. (2009) | MEDIUM |
| Healthy colonies | 95% (non-bleaching year) | Hoegh-Guldberg (1999) | MEDIUM |
| Coral recruit density | 1-3 recruits/m2 (WIO) | Hughes et al. (2010) | LOW-MEDIUM |
| COTS density | Outbreak: 15 ind/ha | Dulvy et al. (2021) | MEDIUM |
| Sea urchin density | Optimum: 1.5-2 ind/m2 | McClanahan (1987+); WIO studies | LOW (provisional) |

### 4.4 Results

| Entry | Units | Coral Reef (M1.3) |
|-------|-------|-------------------|
| Live coral cover -- Opening (Nov 2024) | index (0-1) | 0.905 |
| Live coral cover -- Closing (Jul 2025) | index (0-1) | 0.730 |
| Live coral cover -- Change | index (0-1) | -0.175 |
| Coral health -- Opening | index (0-1) | 0.809 |
| Coral health -- Closing | index (0-1) | 0.977 |
| Fish biomass -- Opening | index (0-1) | 0.300 |
| Fish biomass -- Closing | index (0-1) | 0.380 |
| Composite -- Opening | index (0-1) | 0.547 |
| Composite -- Closing | index (0-1) | 0.645 |
| Composite -- Change | index (0-1) | +0.098 |

**Post-bleaching caution:** Jul 2025 data collected ~15 months after the 2023-2024 global mass bleaching event. Interpret condition changes with caution -- not a routine accounting period.

### 4.5 PA Disaggregation

| PA type | Sites |
|---------|-------|
| No-take MPA | Watamu Coral Garden, Turtle Reef, Whale Island/Uyombo, Richard Bennett |
| Managed MPA | Malindi Coral Garden, Ngomeni Outer |
| Community CPA | Kanamai Community Park, Kuruwitu Community Park |
| Open access | Roka, Wesa, Uyombo, Bofa, Jumba Ruins, Navy, Takaungu, Marereni, Ngomeni, Sultan Palace |

Condition by PA output provides mean CI per PA category per period, enabling protected vs. unprotected reef condition comparisons.

---

## 5. Mangrove (MFT1.2) Condition Account

### 5.1 Indicator Suite

Five biotic condition indicators from plot-based structural surveys:

| Indicator | What it measures | Calculation | Reference levels |
|-----------|-----------------|-------------|-----------------|
| Stem density (trees/ha) | Stand density | Count main stems (exclude sub-branches) / plot area x 10,000 | Pristine: 3,000; Poor: 200 |
| Mean DBH (cm) | Structural maturity | Mean diameter at breast height across all stems | Pristine: 20; Poor: 3 |
| Mean canopy height (m) | Vertical complexity | Mean of tree heights per plot | Pristine: 12; Poor: 2 |
| Canopy cover (%) | Forest closure | Convert cover class to numeric midpoint | Pristine: 90; Poor: 30 |
| Tree quality index | Structural health | Proportion of quality-1 (healthy) stems | Already 0-1 |

### 5.2 Normalisation

For Indicators 1-4:
```
CI = (value - poor) / (pristine - poor), clamped to [0, 1]
```

Indicator 5 (tree quality) is inherently 0-1 and used directly.

Composite = equal-weight mean of all 5 indicators per plot, then averaged to site level.

### 5.3 QA/QC Procedures

| Step | Description |
|------|-------------|
| DQ-1 | Species name standardisation: RM/Rm/rm to Rhizophora mucronata, etc. |
| DQ-2 | Area name standardisation: "Debaso"/"Dabaso" to Mida Creek |
| DQ-3 | DMS coordinate conversion to decimal degrees |
| DQ-4 | Survey phase tagging: "reconnaissance" (Sep) vs "main" (Dec) |
| DQ-5 | Sub-branch identification and exclusion from stem density |
| DQ-6 | DBH cross-check: DBH_check = Circumference / pi; flag deviations > 0.5 cm |

### 5.4 Results

**Overall:** 22 sites, 36 plots, 1,554 main stems. Composite CI = 0.40 (moderate).

| PA status | Sites | Plots | CI composite |
|-----------|-------|-------|-------------|
| Mida Creek MNR | 7 | 11 | 0.455 |
| Unprotected | 15 | 25 | 0.370 |

**Interpretation:** Protected sites within Mida Creek MNR have a 23% higher composite condition than unprotected sites. The strongest differences are in canopy cover (CI 0.53 vs 0.23) and tree height (CI 0.37 vs 0.24). The combination of high stem density + low DBH across all areas is a signature of post-disturbance regeneration.

---

## 6. Seagrass (M1.1) Condition Account

### 6.1 Cover Indicators

Calculated from the SEAGRASS COVER sheet (50 cm x 50 cm sub-quadrats nested in 5 m x 5 m plots):

| Indicator | Calculation | Unit |
|-----------|------------|------|
| Total seagrass cover | Sum of mean cover across all species per site | % |
| Species cover | Mean % cover per species per site | % |
| Species richness | Count of distinct species with cover > 0 per site | count |
| Meadow composition | Species cover / total cover x 100 | % |

**Aggregation hierarchy:** Sub-quadrat to plot mean, then plot mean to site mean. This two-stage approach avoids unbalanced sub-quadrat counts biasing site estimates.

### 6.2 Health Indicators

Calculated from the SEAGRASS HEALTH sheet (15 cm x 15 cm quadrats):

| Indicator | Calculation | Unit |
|-----------|------------|------|
| Shoot density | Raw count / 0.0225 m2; mean across quadrats per site | shoots/m2 |
| Canopy height | Mean height per species per site | cm |

Zone breakdown (Near shore, Middle, Near reef) provides additional spatial resolution.

### 6.3 Reference Levels

| Indicator | Reference level | Confidence |
|-----------|----------------|------------|
| Total cover | 60% = good condition | MEDIUM |
| Thalassia hemprichii density | 800 shoots/m2 | LOW-MEDIUM |
| Cymodocea serrulata density | 500 shoots/m2 | LOW |
| Halodule uninervis density | 1,000 shoots/m2 | LOW |
| Enhalus acoroides density | 100 shoots/m2 | LOW |
| Species richness | Max observed (in-sample) | LOW |
| Canopy height | Max observed per species (in-sample) | LOW |

All reference levels are PROVISIONAL. No formally published Kenya- or WIO-specific baselines exist.

### 6.4 Results

| Site | Composite CI | Notes |
|------|-------------|-------|
| Ngomeni | 0.942 | Highest; 8 species; 90.75% total cover |
| Roka | 0.833 | |
| Malindi Marine Park | 0.826 | Protected (no-take) |
| Kanamai-Jumba ruins | 0.805 | |
| Wesa | 0.805 | |
| Kuruwitu | 0.738 | Community conserved area |
| Kikambala | 0.730 | |
| Bofa | 0.728 | |
| Marereni | 0.707 | |
| Takaungu | 0.692 | Lowest composite CI |

---

## 7. Mangrove (MFT1.2) Extent Account

### 7.1 Method

The extent account uses a 7-step GIS workflow in ArcGIS Pro:

1. **Total mangrove extent** -- Calculate area (ha) of all 2025 mangrove polygons
2. **Extent per WDPA site** -- Intersect mangroves with WDPA boundaries; summarise by PA name
3. **True protected area extent** -- Dissolve overlapping WDPA polygons; re-intersect for de-duplicated protected area
4. **Unprotected extent** -- Total minus true protected
5. **GMW 2020 baseline** -- Clip Global Mangrove Watch v4.019 to study area
6. **Change detection** -- Erase analysis: Additions = 2025 minus 2020; Reductions = 2020 minus 2025
7. **SEEA EA extent account assembly** -- Opening/Additions/Reductions/Closing table

### 7.2 Results

| Entry | Units | Mangrove (MFT1.2) |
|-------|-------|-------------------|
| Opening (2020) | ha | 6,083.04 |
| Additions | ha | 589.10 |
| Reductions | ha | -927.84 |
| Closing (2025) | ha | 5,741.64 |
| Net change | ha | -341.40 |
| Net change (%) | % | -5.6 |

**Protection status (2025):**

| Category | Area (ha) | % of total |
|----------|-----------|-----------|
| Total mangroves | 5,741.64 | 100.0 |
| Within protected areas | 3,806.46 | 66.3 |
| Outside protected areas | 1,935.18 | 33.7 |

**Headline:** Kenya's mangrove extent declined by ~341 ha (5.6%) between 2020 and 2025. Gross change is larger (589 ha gain alongside 928 ha loss), suggesting dynamic processes of both regeneration and clearing.

---

## 8. Wild Fish Provisioning Service Account

### 8.1 Conceptual Framework

The provisioning service measures actual wild fish catch extracted from coral reef ecosystems, valued using the resource rent method (gross revenue minus fishing costs).

**Data advantage:** Kenya has official county-level fisheries landings data from KeFS (2020-2024) including catch volume (MT) and ex-vessel value (KES '000) by species group. This enables a Tier 1 resource rent calculation without new primary surveys.

### 8.2 Ecosystem Catch Attribution

KeFS data is a county aggregate across all ecosystems. Reef-associated catch is separated using a habitat classification table verified against FishBase:

- **Reef-associated (70-90% attribution):** Snapper, Scavenger, Parrot fish, Surgeon fish, Rock cod, Rabbit fish, Goat fish, Lobsters, Octopus
- **Partial reef (40-70%):** Barracuda, Cavalla jacks, Beche-de-mer, Squids
- **Non-reef (0%):** Cat fish, Prawns, Crabs, Oysters, Mullets, Sardines, Tunas, Sail fish

An unreported catch adjustment of 25% (range 20-40%) is applied based on McClanahan and Mangi (2004) and Samoilys et al. (2017).

### 8.3 Resource Rent Calculation

```
Resource Rent = Gross Revenue x (1 - cost_ratio)
```

**Tier 1 cost ratio:** 55-70% (central: 62%), from WIO artisanal fisheries literature (Munga et al. 2014; Mills et al. 2011; Cinner et al. 2009).

All monetary values expressed in constant 2024 KES (using GDP deflators) and converted to USD (using World Bank WDI annual average exchange rates).

### 8.4 Provisional Estimates (2024 Reference Year)

| Component | Value |
|-----------|-------|
| Total KeFS catch (2024) | 12,094 MT |
| Reef-attributed catch (40% central) | 4,838 MT |
| Adjusted for unreported (x1.25) | ~6,047 MT |
| Reef-attributed landed value | KES 1,240 million |
| Reef-attributed value in USD | USD 9.2 million |
| Resource rent (Tier 1, 62% cost) | USD 3.5 million/yr |
| Resource rent range (55-70% cost) | USD 2.8-4.1 million/yr |

---

## 9. Cross-Ecosystem Integration

### 9.1 Multi-Ecosystem Condition Summary

The final assembled condition account covers all three ecosystem types in a single table:

**Output file:** `KEN_SEEA_EA_condition_account_final.csv`

Structure: one row per ecosystem_type x indicator x survey_period, with columns for measured value, condition index, reference level, confidence, and notes.

### 9.2 Multi-Ecosystem Extent Summary

**Output file:** `KEN_SEEA_EA_extent_account_final.csv`

Currently mangrove only; seagrass and coral reef extent mapping not yet available.

### 9.3 Seascape Integration at Ngomeni

Ngomeni is the only site with seagrass, coral reef, mangrove, and fisheries data all present. It serves as the priority site for demonstrating integrated seascape condition assessment across ecosystem types.

Nine sites have both seagrass and coral reef data: Wesa, Roka, Malindi MPA, Kuruwitu, Bofa, Takaungu, Kanamai/Jumba ruins, Marereni, Ngomeni.

---

## 10. Data Quality and QA/QC

### 10.1 General QA/QC Principles

All analysis scripts follow a standardised QA/QC pipeline:

1. **Ingest** -- readxl::read_excel() + janitor::clean_names()
2. **GPS fixes** -- Correct decimal point errors, DMS conversion, sign conventions
3. **Name standardisation** -- Site names, species names via lookup tables
4. **Taxonomy** -- str_to_sentence() / str_to_title() normalisation
5. **Column harmonisation** -- rename_with() + any_of() for multi-programme data
6. **Numeric validation** -- Flag out-of-range values; do not silently drop
7. **Duplicate detection** -- Flag exact duplicates for manual review
8. **QA/QC log export** -- Row counts at each step for audit trail

### 10.2 Ecosystem-Specific QA/QC

**Coral reef:**
- KLF consolidated fish file contains template rows for 2025-2092 (filter by date)
- CCVA invertebrate file has positive latitude in row 2 (corrected by fix_gps())
- Column naming varies across 3 survey programmes (handled by rename_with())

**Mangrove:**
- Species recorded as abbreviations (RM, Rm, rm) and full names (standardised via lookup)
- Coordinates stored as DMS strings (parsed with regex)
- Sub-branch records identified and excluded from stem density

**Seagrass:**
- Date formats mixed (YYYY-MM-DD, DD/MM/YYYY, Excel integers)
- Species spelling errors (Halophilia, Thelassia, Halodulle)
- Health sheet shoot density is raw count (divide by 0.0225 m2 for per-m2 density)

---

## 11. Reference Levels and Normalisation

### 11.1 Normalisation Approaches

Three normalisation formulae are used across the Kenya accounts:

**1. Standard (higher = better):**
```
CI = min(measured / reference, 1.0)
```
Used for: fish biomass, coral cover, coral health, recruitment, seagrass cover, shoot density, stem density (after linear rescaling)

**2. Inverted (higher = worse):**
```
CI = max(1 - measured / reference, 0.0)
```
Used for: bleaching %, disease %, COTS density

**3. Linear rescaling (poor-to-pristine):**
```
CI = (value - poor) / (pristine - poor), clamped to [0, 1]
```
Used for: mangrove structural indicators (stem density, DBH, height, cover)

**4. Optimum range:**
```
CI = max(1 - |measured - optimum| / optimum, 0.0)
```
Used for: sea urchin density

### 11.2 Confidence Ratings

Each reference level carries a confidence rating:

| Rating | Meaning |
|--------|---------|
| HIGH | Kenya-specific or strong WIO published reference |
| MEDIUM | Regional (WIO/Indian Ocean) published benchmark |
| LOW-MEDIUM | Provisional from nearest regional literature |
| LOW | In-sample relative only; no published baseline |

---

## 12. Tiered Assessment Framework

### 12.1 Tier Definitions

| Tier | Description |
|------|-------------|
| Tier 1 | Basic: literature-based, modelled, or indirect estimates |
| Tier 2 | Intermediate: field-based with regional reference levels |
| Tier 3 | Advanced: long-term monitoring with locally calibrated baselines |

### 12.2 Kenya Current Tiers

| Account | Current Tier | Binding Constraint |
|---------|-------------|-------------------|
| Coral reef condition | 2 | Transect area unconfirmed; post-bleaching interpretation |
| Mangrove condition | 2 | Canopy cover and quality reference levels (LOW confidence) |
| Seagrass condition | 1-2 | No published WIO shoot density baselines; single time point |
| Mangrove extent | 2 | Classification method comparison not fully documented |
| Wild fish provisioning | 1-2 | Ecosystem attribution fraction pending expert validation |

### 12.3 Progression Pathways

**To Tier 3 condition monitoring:**
- Install permanent transect markers at priority sites
- Resurvey at minimum annual frequency
- Stereo-BRUV validation for fish size estimates
- Locally derived historical baselines from long-term monitoring

**To Tier 2 provisioning service:**
- Fisher cost survey at Kilifi landing sites (30-50 interviews)
- Gear-type disaggregated catch data from KeFS raw CAS worksheets

---

## 13. Outputs and File Structure

### 13.1 Analysis Scripts

| Script | Ecosystem | Location |
|--------|-----------|----------|
| coral_reef_coral_invert_condition.R | Coral reef (coral + inverts) | Kenya/02_analysis/ |
| coral_reef_fish_condition.R | Coral reef (fish) | Kenya/02_analysis/ |
| mangrove_condition.R | Mangrove condition | Kenya/02_analysis/ |
| seagrass_condition.R | Seagrass condition | Kenya/02_analysis/ |
| fisheries_provisioning.R | Wild fish provisioning | Kenya/02_analysis/ |
| _assemble_final_accounts.R | Multi-ecosystem assembly | Kenya/02_analysis/ |

### 13.2 Output Files

All outputs in `Kenya/03_outputs/` with KEN_ prefix:

**Multi-ecosystem assembled accounts:**
- KEN_SEEA_EA_condition_account_final.csv
- KEN_SEEA_EA_extent_account_final.csv

**Coral reef:**
- KEN_fish_condition_site.csv, KEN_fish_seea_rows.csv
- KEN_invertebrate_condition_site.csv
- KEN_benthic_cover_site.csv, KEN_coral_health_site.csv
- KEN_coral_recruitment_site.csv
- KEN_site_condition_all_indicators.csv
- KEN_seea_condition_account.csv
- KEN_condition_by_pa.csv
- KEN_multiperiod_comparison.csv

**Mangrove:**
- KEN_mangrove_condition_by_plot.csv, KEN_mangrove_condition_by_site.csv
- KEN_mangrove_condition_by_pa.csv
- KEN_seea_condition_account_mangrove.csv
- KEN_mangrove_species_composition.csv, KEN_mangrove_coords.csv

**Mangrove extent:**
- KEN_Total_mangrove_area_statistics.csv
- KEN_Mangrove_WDPA_statistics.csv
- KEN_True_protected_area_statistics.csv
- KEN_Mangrove_extent_protected_and_non-protected_areas.csv
- KEN_Mangrove_extent_change_2020_2025.csv
- KEN_Mangrove_extent_account_by_area.csv

**Seagrass:**
- KEN_seagrass_cover_site.csv
- KEN_seagrass_health_site.csv, KEN_seagrass_health_zone.csv
- KEN_seea_condition_account_seagrass.csv
- KEN_seea_condition_summary.csv

**Fisheries:**
- KEN_fisheries_supply_physical.csv
- KEN_fisheries_supply_monetary.csv
- KEN_fisheries_attribution_table.csv
- KEN_fisheries_sensitivity_resource_rent_2024.csv

---

## 14. Open Items and Limitations

### 14.1 High Priority

| Item | Ecosystem | Impact |
|------|-----------|--------|
| Confirm transect area (250 m2) with Dr. Karisa / KMFRI | Coral reef | All fish biomass and density values |
| Expert validation of habitat attribution table | Fisheries | All provisioning service values |
| Create fishbase_params_kenya.csv | Coral reef | Fish biomass calculation |
| Allometric parameters for mangrove biomass | Mangrove | Carbon extension |
| Confirm seagrass quadrat dimensions (0.0225 m2) | Seagrass | All shoot density values |

### 14.2 Medium Priority

| Item | Ecosystem | Impact |
|------|-----------|--------|
| No Jul 2025 invertebrate data | Coral reef | Invertebrate indicators single-period only |
| Post-bleaching framing for Jul 2025 coral data | Coral reef | Interpretation of condition change |
| 13 of 22 mangrove sites have only 1 plot | Mangrove | Low reliability at those sites |
| All seagrass reference levels PROVISIONAL | Seagrass | LOW confidence on all CIs |
| Fisher cost survey for Tier 2 resource rent | Fisheries | Currently Tier 1 from literature |

### 14.3 Data Source Limitations

- Three independent survey programmes with different field protocols and column naming
- No stereo-video BRUV validation for fish size estimates
- KeFS landings data is county aggregate only; no ecosystem or gear disaggregation
- Subsistence/unreported catch estimated at 20-40% (not directly measured)
- Global Mangrove Watch and project classification use different methods; some observed change may be methodological artefact
- Single time-point surveys for mangrove and seagrass (no temporal trend possible)

---

## 15. References

Bandeira, S.O., et al. (2014). Seagrasses of the East African Coast. Regional reference for seagrass species composition and density baselines.

Bosire, J.O., et al. (2006). Forest Ecology and Management. Degraded mangrove reference levels, Mida Creek.

Bosire, J.O., et al. (2014). Wetlands Ecology and Management. WIO mangrove structural condition reference.

Bourne, D.G., et al. (2009). Coral disease baseline: <2% diseased colonies in non-outbreak conditions.

Cinner, J.E., et al. (2009). Marine Ecology Progress Series, 370, 1-10. WIO reef fisheries cost structures.

Duarte, C.M. (1991). Marine Ecology Progress Series. Seagrass cover reference (60% = good condition).

Dulvy, N.K., et al. (2021). COTS outbreak threshold: 15 ind/ha.

Fatoyinbo, T.E., et al. (2008). Global Change Biology. WIO mangrove canopy height reference.

GCRMN (2021). Status of Coral Reefs of the World. Coral cover reference (>30% = good).

Hoegh-Guldberg, O. (1999). Bleaching/health baseline: <5% bleaching, 95% healthy in non-bleaching years.

Hughes, T.P., et al. (2010). Coral recruitment reference: 1-3 recruits/m2 for WIO.

Kairo, J.G., et al. (2009). Forest Ecology and Management. Kenya mangrove structural reference, Gazi Bay.

Kenya Fisheries Service (KeFS). Annual Statistics Bulletins (2020-2024).

Kirui, B., et al. (2006). Wetlands Ecology and Management. Stem density reference, Mida Creek.

McClanahan, T.R., et al. (2016). PLOS ONE. Fish biomass reference: 1,150 kg/ha conservation target.

Mills, D.J., et al. (2011). Ambio, 40(7), 747-756. Kenya fisheries cost-to-revenue ratios.

Munga, C.N., et al. (2014). WIOJMS, 13(1), 57-70. Kilifi artisanal fisheries cost structures.

Obura, D.O., et al. (2022). WIO coral reef condition reference.

Samoilys, M.A., et al. (2017). Marine Policy, 77, 64-74. Kenya coral reef fisheries review.

UN SEEA EA (2021). System of Environmental-Economic Accounting -- Ecosystem Accounting.

World Bank (2025). World Development Indicators. Exchange rates and GDP deflators.

---

*Version: 1.0*
*Created: 2026-03-29*
*Companion document: KEN_TRAINING_GUIDELINES.md*
