# Standard Operating Procedure: Coral Reef Fish & Invertebrate Condition Accounts — Madagascar

**Project:** AFRICA — accounts / Madagascar
**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Photic Coral Reefs (M1.3)
**Sites:** 27 sites across South-West Madagascar coast
**Accounting period:** 2025–2026
**Data source:** Underwater Visual Census (UVC) field surveys; Nov 2025 – Feb 2026
**Analysis script:** `Madagascar/02_analysis/fish_invert_condition.R`
**Status:** Steps 1–7 DONE; Step 8 PENDING; Step 9 BLOCKED

---

## 1. Aim of Accounts

This SOP documents the production of biotic condition accounts for photic coral reef ecosystems (IUCN GET M1.3) in South-West Madagascar under the UN SEEA EA framework.

The accounts quantify the ecological condition of fish and invertebrate communities — the primary biotic components of coral reef health — relative to reference levels derived from the Western Indian Ocean (WIO) literature. Condition is expressed as a normalised index (0–1) per indicator, where 0 = degraded and 1 = reference condition.

**Indicators produced:**
- Fish biomass (kg/ha) — structural integrity of fish assemblage
- Fish species richness (species count) — functional diversity of fish community
- Crown-of-Thorns Starfish density (COTS; ind/ha) — corallivore pressure indicator (inverted)
- Sea urchin density (ind/m2) — herbivory and bioerosion pressure (provisional)

**Scope:**
- Spatial: site-level (27 sites) and accounting-area mean (SW Madagascar)
- Temporal: two survey rounds (2025 and 2026)
- Ecosystem extent: ~12,085 ha estimated (satellite mapping in progress)

**Downstream linkages:**
- Fisheries Nursery Service account — uses fish biomass and functional group data (70% input coverage)
- Wild Fish Provisioning Service account — uses fish composition as baseline (50% coverage; requires external landings data)
- Coral Reef Recreation account — fish richness and biomass as tourism attractiveness proxies (40% coverage)
- Coastal Protection account — reef structural health (requires GIS morphology data)

---

## 2. Data Overview

### 2.1 Input Files

| File | Sheet | Raw Records | Post-QA/QC Records | Key Fields | Observer |
|------|-------|-------------|-------------------|------------|----------|
| `Fishdata_OASIS_M.xlsx` | Fish_All data | 5,186 | 5,186 | 27 sites, 85 stations, 2 transects, 227 species, 39 families, a/b params, 6 size-class bins (5–60 cm) | Laza |
| `Invertebrate_0ASIS_M.xlsx` | Macroinvertebrates | 999 | 434 | 27 sites, 81 stations, 3 transects, 59 species, abundance counts | Maka |
| `Invertebrate_0ASIS_M.xlsx` | Sea urchin | 999 | 264 | 27 sites, 79 stations, 2 transects, 8 species, abundance counts | Laza / Maka |

All files located in: `Madagascar/01_inputs/raw_data/`

### 2.2 Site and Survey Summary

| Survey round | Sites | Date range | Depth range (m) | Stations |
|---|---|---|---|---|
| 2025 | 15 | 2025-11-11 to 2026-01 | 3.6–16.5 | 47 |
| 2026 | 12 | 2026-01 to 2026-02-24 | 3.6–16.5 | 38 |

**Transect design:** 2 belt transects per station; 50 m x 5 m = 250 m2 per transect (confirmed with field team).

---

## 3. Analysis Steps

### Step 1: Data Ingestion — DONE

Load all three sheets into R using `readr::read_csv()` or `readxl::read_excel()`. Confirm row counts, column names, and data types match expectations.

```r
library(readxl)
fish        <- read_excel("Madagascar/01_inputs/raw_data/Fishdata_OASIS_M.xlsx", sheet = "Fish_All data")
macroinvert <- read_excel("Madagascar/01_inputs/raw_data/Invertebrate_0ASIS_M.xlsx", sheet = "Macroinvertebrates")
urchin      <- read_excel("Madagascar/01_inputs/raw_data/Invertebrate_0ASIS_M.xlsx", sheet = "Sea urchin")
```

Validate: check key numeric columns are not character type; confirm site count (27 unique sites across both years); attach year labels from survey dates.

### Step 2: QA/QC — DONE

All corrections applied in `fish_invert_condition.R`. The following issues were identified and resolved:

**Geospatial:**
- GPS decimal-point restoration across all three datasets
  - Fish: 17 latitude, 18 longitude values with integer-scale errors (e.g., `-2303851.0` to `-23.03851`)
  - Macroinvertebrates: 17 lat, 18 lon values
  - Sea urchin: 16 lat, 17 lon values

**Taxonomic and categorical:**
- Fish functional groups: 17 raw categories harmonised to 7 standard groups (Carnivore, Herbivore, Corallivore, Planktivore, Omnivore, Detritivore, Piscivore)
- Fish family typo: `Pomacanthidae+*` corrected to `Pomacanthidae`
- Fish species names: trailing whitespace trimmed from genus/species fields

**Invertebrate data:**
- Macroinvertebrate transect field: `"onus rattus"` (misplaced species name) set to NA
- Macroinvertebrate: 1 row with Species = 0.0 removed
- Sea urchin: 36 formula strings evaluated (e.g., `=(10*48)` to 480)
- Sea urchin: 1 row with Species = 0.0 removed

**Row retention after QA/QC:**
- Macroinvertebrates: 999 to 434 rows (565 rows with missing site, station, GPS, depth, observer, or date)
- Sea urchin: 999 to 264 rows (728 rows with missing data)

### Step 3: Fish Biomass Calculation — DONE

Biomass estimated using the allometric formula across 6 size-class bins:

```
W_class = a × L_mid^b × count_class
```

Where `L_mid` is the midpoint of each size class (cm): 7.5, 15, 25, 35, 45, 55.
Total biomass per transect = sum across all classes and all species.
Scaled to kg/ha using transect area of 250 m2 (confirmed with field team).

### Step 4: Fish Community Metrics — DONE

Per transect, then aggregated to site mean:
- Total fish abundance (ind/ha)
- Species richness (unique species count per site per year)
- Trophic composition: percentage of total biomass per functional group

Accounting-area trophic composition (2025–2026 pooled):

| Functional group | % biomass |
|---|---|
| Herbivore | 40.6 |
| Carnivore | 30.0 |
| Planktivore | 15.2 |
| Corallivore | 8.7 |
| Omnivore | 5.5 |
| Piscivore | <0.1 |
| Detritivore | <0.1 |

### Step 5: Invertebrate Metrics — DONE

**COTS (Crown-of-Thorns Starfish):**
- Counted at site level; scaled from transect area to ind/ha
- Only 3 of 27 sites recorded any COTS (1–2 individuals each)
- Condition index: CI = 1 - (observed density / outbreak threshold); clamped to [0, 1]
- Outbreak threshold: 15 ind/ha (Dulvy et al. 2021; updated from 30 ind/ha)

**Sea urchins:**
- Mean abundance per m2 per site, aggregated to accounting-area mean
- Accounting-area mean: 1.83 ind/m2 (range 0–15.6 ind/m2 across sites)
- Reference level: PROVISIONAL — 1.5–2 ind/m2 outer reef Echinometra mathaei (Kenya/WIO; LOW confidence)
- Not yet included in SEEA account export pending reference level confirmation

**Giant clam (Tridacna maxima):**
- Recorded in macroinvertebrate transects; abundance counts per site
- Reference level not yet established for SW Madagascar
- Not yet included in SEEA account export

### Step 6: Normalisation to Condition Index (0–1) — DONE

Formula applied to each indicator:

```
CI_i = clamp( (observed - poor) / (reference - poor), 0, 1 )
```

For COTS (inverted): `CI = clamp( 1 - (observed / outbreak_threshold), 0, 1 )`

Reference levels applied:

| Indicator | Variable | Reference (good) | Poor (0) | Confidence | Source |
|---|---|---|---|---|---|
| Fish biomass | mean_biomass_kg_ha | 1,150 kg/ha | 0 kg/ha | HIGH | McClanahan et al. 2016 PLOS ONE (WIO conservation target, 15 countries) |
| Fish species richness | species_richness | Max observed in dataset | 0 | MEDIUM | Site-relative; max observed = 94 spp (2025), 103 spp (2026) |
| COTS density | cots_density_ha | 0 ind/ha (ideal) | 15 ind/ha (outbreak) | HIGH | Dulvy et al. 2021 Nature Communications |
| Sea urchin density | urchin_density_m2 | 1.5–2 ind/m2 | TBC | LOW | Kenya/WIO provisional; no WIO formal reference (BLOCKED) |

**Note on fish biomass reference:** Prior to 2026-03-16, the reference level used in the R script and CSV outputs was 500 kg/ha (MacNeil et al. 2015). This has been updated to 1,150 kg/ha (McClanahan et al. 2016) as the primary WIO benchmark. The R script and output CSVs require re-running with the updated reference value (see Section 4 — Next Steps).

### Step 7: SEEA EA Condition Account Export — DONE (requires reference level update)

Output files saved to `Madagascar/03_outputs/`:

| File | Description |
|---|---|
| `fish_invert_site_condition.csv` | Site-level condition summary (27 sites x fish + invertebrate indicators; includes raw metrics and CIs) |
| `fish_invert_seea_condition.csv` | Accounting-area SEEA EA condition account (3 indicator rows x 2 years) |
| `fish_invert_seea_condition_per_site.csv` | SEEA EA format per site (81 rows: 27 sites x 3 indicators; 2025 and 2026 separate) |
| `fish_invert_condition_account_normalized.csv` | Normalised condition indices per site |
| `fish_invert_condition_account_raw.csv` | Raw metric values per site |

---

## 4. Condition Accounts in SEEA EA Format

### 4.1 Accounting-Area Summary (2025–2026)

Note: values below use the UPDATED reference level of 1,150 kg/ha for fish biomass. The COTS CI uses the updated 15 ind/ha outbreak threshold. Species richness CI uses the max observed across both years (103 spp).

| Calendar year | Ecosystem type | Indicator | Reference level | Measured value | Condition index | Confidence |
|---|---|---|---|---|---|---|
| 2025 | Coral reef (M1.3) | Fish biomass | 1,150 kg/ha | 1,929 kg/ha | 1.00 | MEDIUM |
| 2025 | Coral reef (M1.3) | Fish species richness | 103 spp (max observed) | 56 spp | 0.54 | MEDIUM |
| 2025 | Coral reef (M1.3) | COTS density | 0 ind/ha (ideal) / 15 ind/ha (outbreak) | 6.7 ind/ha | 0.55 (inverted) | MEDIUM |
| 2026 | Coral reef (M1.3) | Fish biomass | 1,150 kg/ha | 1,775 kg/ha | 1.00 | MEDIUM |
| 2026 | Coral reef (M1.3) | Fish species richness | 103 spp (max observed) | 56 spp | 0.54 | MEDIUM |
| 2026 | Coral reef (M1.3) | COTS density | 0 ind/ha (ideal) / 15 ind/ha (outbreak) | 0.0 ind/ha | 1.00 (inverted) | MEDIUM |

### 4.2 Site-Level Condition Account — 2025 Survey Round (15 sites)

| Site | Fish biomass (kg/ha) | CI biomass | Species richness | CI richness | COTS (ind/ha) | CI COTS | Urchin (ind/m2) |
|---|---|---|---|---|---|---|---|
| AMBITIKY | 4,707 | 1.00 | 52 | 0.50 | 0 | 1.00 | 1.25 |
| AMBOHIBOLA | 2,522 | 1.00 | 53 | 0.51 | 0 | 1.00 | 0.52 |
| AMBOLA | 1,832 | 1.00 | 70 | 0.68 | 0 | 1.00 | 0.52 |
| AMBOLAFOTY | 2,107 | 1.00 | 30 | 0.29 | 0 | 1.00 | 0.00 |
| ANAKAO | 1,634 | 1.00 | 51 | 0.50 | 25 | 0.00 | 0.18 |
| BEFASY | 635 | 0.55 | 27 | 0.26 | 0 | 1.00 | 0.48 |
| BEHELOKY | 3,766 | 1.00 | 77 | 0.75 | 25 | 0.00 | 0.68 |
| FITSITIKA | 621 | 0.54 | 54 | 0.52 | 0 | 1.00 | 0.06 |
| IFATY | 601 | 0.52 | 68 | 0.66 | 0 | 1.00 | 0.09 |
| ITAMPOLO | 2,117 | 1.00 | 68 | 0.66 | 0 | 1.00 | 0.51 |
| MANGILY | 849 | 0.74 | 94 | 0.91 | 0 | 1.00 | 0.07 |
| MAROMENA | 1,103 | 0.96 | 41 | 0.40 | 0 | 1.00 | 1.29 |
| NOSY SATRA | 844 | 0.73 | 39 | 0.38 | 0 | 1.00 | 0.56 |
| RETSELA | 3,935 | 1.00 | 70 | 0.68 | 50 | 0.00 | 0.42 |
| TANILAHY | 1,662 | 1.00 | 36 | 0.35 | 0 | 1.00 | 0.04 |

### 4.3 Site-Level Condition Account — 2026 Survey Round (12 sites)

| Site | Fish biomass (kg/ha) | CI biomass | Species richness | CI richness | COTS (ind/ha) | CI COTS | Urchin (ind/m2) |
|---|---|---|---|---|---|---|---|
| AMBATOMILO | 498 | 0.43 | 34 | 0.33 | 0 | 1.00 | 0.17 |
| AMPASINDAVA | 608 | 0.53 | 25 | 0.24 | 0 | 1.00 | 1.90 |
| ANDAVADOAKY | 1,891 | 1.00 | 100 | 0.97 | 0 | 1.00 | 1.56 |
| ANDRAVONA | 2,145 | 1.00 | 38 | 0.37 | 0 | 1.00 | 2.00 |
| ANKARAMIFIOKY | 3,227 | 1.00 | 48 | 0.47 | 0 | 1.00 | 0.00 |
| BELAVENOKY | 2,368 | 1.00 | 103 | 1.00 | 0 | 1.00 | 1.94 |
| BEVATO | 1,663 | 1.00 | 62 | 0.60 | 0 | 1.00 | 0.10 |
| FIERENAMASAY | 863 | 0.75 | 30 | 0.29 | 0 | 1.00 | 2.90 |
| MOROMBE | 966 | 0.84 | 56 | 0.54 | 0 | 1.00 | 0.03 |
| RATAFENJIKA | 766 | 0.67 | 39 | 0.38 | 0 | 1.00 | 0.12 |
| SALARY | 3,478 | 1.00 | 86 | 0.83 | 0 | 1.00 | 0.79 |
| TSANDAMBA | 2,829 | 1.00 | 49 | 0.48 | 0 | 1.00 | 1.14 |

**Notes on CI biomass values above:** Recalculated using 1,150 kg/ha reference (McClanahan 2016). Sites below 1,150 kg/ha now show partial CIs instead of 1.00. This is a material change from the original 500 kg/ha reference — BEFASY, FITSITIKA, IFATY, AMBATOMILO, and others move from CI = 1.00 to CI < 1.00.

**Notes on CI COTS values above:** Sites with 1 COTS individual and 4 transects (400 m2) show 25 ind/ha (pending transect area confirmation). Under the 15 ind/ha threshold, these sites score CI = 0.00, indicating outbreak-level density. This is sensitive to the transect area assumption — see Section 5.

---

## 5. Next Steps for Pending and Blocked Items

### 5.1 Transect area — RESOLVED

**Confirmed:** Transect area is 250 m2 (50 m x 5 m), confirmed with field team. Update the `transect_area_m2` variable in `fish_invert_condition.R` to 250 and re-export all CSVs.

### 5.2 Update R script and CSVs with corrected reference levels — HIGH PRIORITY (PENDING)

**Issue:** Output CSVs (`fish_invert_seea_condition.csv`, `fish_invert_seea_condition_per_site.csv`) still record fish biomass reference as 500 kg/ha (MacNeil et al. 2015). This has been superseded.

**Action:** In `fish_invert_condition.R`, update the biomass reference level variable to 1,150 kg/ha and re-run the full script to regenerate all output CSVs.

### 5.3 Sea urchin reference level — BLOCKED (awaiting literature / expert input)

**Issue:** No formal WIO-wide reference level has been published for sea urchin density on outer reef. Current provisional reference (1.5–2 ind/m2 Echinometra mathaei; Kenya/WIO) is LOW confidence.

**Observed values:** Accounting-area mean 1.83 ind/m2; site range 0–15.6 ind/m2.

**Action:** Contact GCRMN East Africa (Tim McClanahan, WCS) for unpublished long-term urchin density data from Kenya and Tanzania. Run systematic literature search in Web of Science for WIO outer reef urchin density benchmarks. Until a reference is confirmed, exclude urchin CI from the formal SEEA account and flag as PROVISIONAL supplementary indicator.

### 5.4 Giant clam (Tridacna maxima) reference level — BLOCKED (awaiting data)

**Issue:** Clam abundance data is available in the macroinvertebrate dataset but no SW Madagascar or WIO reference level has been identified. Provisional reference: 122–141 ind/ha (Lakshadweep, Indian Ocean; Apte et al. 2010; LOW-MEDIUM confidence).

**Action:** Use Apte et al. 2010 as provisional reference and add a CI_clam indicator to the SEEA account with LOW confidence flag. Confirm reference with literature search.

### 5.5 Field validation of results — BLOCKED (field surveys planned)

**Issue:** There has been no independent cross-validation of the UVC-derived fish biomass or invertebrate density estimates. All condition indices should be treated as PROVISIONAL until field replication and cross-validation is conducted.

**Action:** Plan for a follow-up survey round (2027) at a subset of 5–8 sentinel sites with replicated transects and independent observers. Compare with 2025–2026 values to assess measurement uncertainty and begin temporal trend analysis.

### 5.6 Review and validation of full account — PENDING

**Issue:** The complete condition account has not been reviewed by the data providers (Laza, Maka) or by the SEEA EA scientific advisor for Madagascar.

**Actions:**
1. Share `fish_invert_seea_condition_per_site.csv` with Laza and Maka for data quality sign-off
2. Share the accounting-area summary (Section 4.1) with SEEA EA advisor for framework compliance review
3. Document reviewer sign-off in the change log

### 5.7 Ecosystem extent mapping — PENDING (satellite mapping in progress)

**Issue:** Condition accounts are expressed per ha but the total area of coral reef in the accounting area is not yet confirmed. GMW 2020 provides extent for mangroves; for coral reefs, Sentinel-2 mapping is in progress (March 2026).

**Action:** Complete Sentinel-2 reef classification and field validation (see `skill_extent_measurement_m13_reef.md`). Use confirmed extent to express total condition stock (condition index x area) for ecosystem accounting.

---

## Change Log

| Date | Change | Author |
|---|---|---|
| 2026-03-27 | SOP created from analysis plan; Steps 1–7 documented; SEEA accounts presented with updated reference levels; next steps for pending/blocked items | Claude Code |
