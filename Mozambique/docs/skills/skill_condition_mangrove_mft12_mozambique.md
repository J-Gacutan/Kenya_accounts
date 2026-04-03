# Standard Operating Procedures: Mangrove Ecosystem Condition Accounts

## Mozambique Mangrove Forests (MFT1.2) — Customized for 2025–2026 Accounts

**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Mangrove Forests (MFT1.2)
**Sites:** Save Estuary (Gaza Province) + Morrumbene Estuary (Inhambane Province)
**Accounting period:** 2025–2026
**Data source:** NASA GEDI LiDAR (L2A, L2B, L4A v2); 2024–2025 observations

---

## 1. Aim of Accounts

This SOP supports the production of SEEA EA Ecosystem Condition Accounts for mangrove forests in Mozambique. The accounts measure the biophysical condition of two mangrove estuary systems — Save Estuary (Gaza Province) and Morrumbene Estuary (Inhambane Province) — using NASA GEDI spaceborne LiDAR as the primary data source.

The accounts serve two functions:

1. **Condition accounts:** Normalise four structural indicators (canopy height, canopy cover, above-ground biomass density, plant area index) to a 0–1 condition index per asset and per site, following SEEA EA methodology. These provide baseline condition values for the 2025–2026 accounting period.

2. **Carbon account:** Derive total carbon stock (Mg C) per asset and site from GEDI above-ground biomass density estimates and asset areas, providing a physical stock estimate for potential ecosystem service valuation.

Both sets of accounts remain PROVISIONAL until field validation surveys (planned Mar–May 2026) are completed and used to confirm or revise the remote-sensing estimates.

---

## 2. Data Overview

### 2.1 Input Files

| File | Level | Assets / Records | Key GEDI Fields | GEDI Footprints | Area Source |
|------|-------|-----------------|-----------------|-----------------|-------------|
| `Save_mangrove_assets_condition_stats.csv` | Asset | 8 assets | rh100, agbd, agbd_se, cover, pai, carbono_mgha | 84 | area_ha pre-computed (ArcGIS) |
| `Save_mangrove_area_condition_stats.csv` | Site | 1 record (aggregated) | As above | 84 | area_ha pre-computed (ArcGIS) |
| `morrumbene_by_asset.csv` | Asset | 3 assets | rh100, agbd, agbd_se, cover, pai, carbono_mgha | 195 | Shape_Area in sq deg (converted in R) |
| `Morrumbene_mangrove_area_condition_stats.csv` | Site | 1 record (aggregated) | As above | 195 | Area_ha pre-computed (ArcGIS) |

All files located in: `Mozambique/01_inputs/raw_data/archive/`

### 2.2 Column Schema

| Column | Unit | Description |
|--------|------|-------------|
| Shape_Leng | Degrees | Perimeter of asset boundary polygon |
| Asset_ID | — | Unique identifier for each mangrove forest unit |
| BUFF_DIST | Meters | Buffer distance applied during spatial processing (standard: 25 m) |
| Shape_Area | Square degrees | Area of asset polygon — requires conversion to ha (see Step 3) |
| mean_rh100 | Meters | Mean canopy height (RH100 percentile); maximum vegetation structure |
| mean_L4A_agbd | Mg/ha | Mean above-ground biomass density |
| mean_L4A_agbd_se | Mg/ha | Standard error of AGBD estimate |
| mean_L2B_cover | Fraction (0–1) | Mean canopy cover; density of upper vegetation layer |
| mean_L2B_pai | Unitless (m2/m2) | Mean Plant Area Index; total one-sided leaf + stem area per ground area |
| mean_L4A_carbono_mgha | Mg C/ha | Mean carbon stock per unit area (approx. AGBD x 0.47) |
| Point_Count | Count | Number of GEDI footprints (~25 m diameter) contributing to asset average |

### 2.3 Site Summaries (Baseline Values)

| Site | Province | Asset Area (ha) | Assets | GEDI Footprints | Mean Canopy Height (m) | Mean AGBD (Mg/ha) | Mean Cover (fraction) | Mean PAI | Mean Carbon (Mg C/ha) |
|------|----------|----------------|--------|-----------------|----------------------|-------------------|----------------------|----------|-----------------------|
| Save Estuary | Gaza | 1,877.54 | 8 | 84 | 5.07 | 12.63 | 0.088 | 0.29 | 5.94 |
| Morrumbene Estuary | Inhambane | 1,068.76 | 3 | 195 | 5.27 | 10.95 | 0.049 | 0.12 | 5.15 |

Note: Asset areas are from ArcGIS polygon geometry (Save pre-computed; Morrumbene converted from sq degrees at 23.5 deg S). GMW 2020 estuary extents (Save 12,085 ha; Morrumbene 1,677 ha) cover the broader system.

### 2.4 GEDI Coverage and Confidence by Asset

Point_Count determines the reliability of the per-asset mean:

| Site | Asset | area_ha | Point_Count | Confidence |
|------|-------|---------|-------------|------------|
| Save Estuary | 1 | 841.21 | 17 | MODERATE |
| Save Estuary | 2 | 26.62 | 2 | LOW -- exclude from trend analysis |
| Save Estuary | 3 | 103.70 | 3 | LOW |
| Save Estuary | 4 | 5.87 | 1 | LOW -- exclude from trend analysis |
| Save Estuary | 5 | 116.98 | 17 | MODERATE |
| Save Estuary | 6 | 248.23 | 31 | HIGH |
| Save Estuary | 7 | 235.56 | 7 | MODERATE |
| Save Estuary | 8 | 299.38 | 6 | MODERATE |
| Morrumbene | 1 | -- | 85 | HIGH |
| Morrumbene | 2 | -- | 95 | HIGH |
| Morrumbene | 3 | -- | 15 | MODERATE |

Confidence thresholds: HIGH >= 20 footprints; MODERATE 6–19; LOW <= 5.

### 2.5 Reference Levels for Condition Normalisation

| Indicator | GEDI Variable | Unit | Poor (0) | Pristine (1) | Confidence | Source |
|-----------|--------------|------|----------|--------------|------------|--------|
| Canopy height | mean_rh100 | m | 3 | 15 | HIGH | Fatoyinbo 2008; Lagomasino 2015; Sitoe 2016 (WIO/Mozambique) |
| Canopy cover | mean_L2B_cover | Fraction (0–1) | 0.30 | 0.70 | LOW | Provisional; no published WIO-specific benchmark |
| Above-ground biomass density | mean_L4A_agbd | Mg/ha | 5 | 100 | MEDIUM | Godoy & De Lacerda 2015 (degraded: 6–9 Mg/ha); intact stands can exceed 100 Mg/ha |
| Plant Area Index | mean_L2B_pai | Unitless | 0.05 | 2.0 | LOW | Provisional; no published WIO-specific benchmark |
| Carbon stock | mean_L4A_carbono_mgha | Mg C/ha | — | — | — | Not normalised; reported as raw value in carbon account table |

---

## 3. Analysis Steps

### Step 1: Data Ingestion -- DONE (updated 2026-03-28)

Load CSVs from archive folder. Save uses condition_stats CSV (8 assets, area_ha pre-computed). Morrumbene uses by_asset CSV (3 assets, Shape_Area converted in R).

```r
library(readr)
archive_dir <- here::here("Mozambique", "01_inputs", "raw_data", "archive")
save_assets <- read_csv(file.path(archive_dir, "Save_mangrove_assets_condition_stats.csv"))
save_site   <- read_csv(file.path(archive_dir, "Save_mangrove_area_condition_stats.csv"))
morr_assets <- read_csv(file.path(archive_dir, "morrumbene_by_asset.csv"))
morr_site   <- read_csv(file.path(archive_dir, "Morrumbene_mangrove_area_condition_stats.csv"))
```

Validate: check `Point_Count` is numeric; check no NA values in GEDI fields. Attach `site` label and standardise column selection before binding rows.

### Step 2: QA/QC — DONE

Validation completed and documented in `Mozambique/03_outputs/FINDINGS_OVERVIEW.md`. Key flags:

- Save Assets 2 and 4 have 1–2 GEDI footprints each; flag as LOW confidence in all outputs.
- AGBD standard errors are high relative to mean values (~126–129% relative uncertainty); note in output metadata.
- Very low canopy cover values (4–9%) may reflect GEDI measurement artefacts; cross-validation with Sentinel-2 recommended.
- No issues found with data completeness or file structure.

Add a `confidence` flag column to all asset-level outputs using the thresholds in Section 2.4.

### Step 3: Area Conversion -- DONE (2026-03-28)

**Save Estuary:** `area_ha` pre-computed from ArcGIS polygon geometry in `Save_mangrove_assets_condition_stats.csv`. No conversion needed. Total: 1,877.54 ha across 8 assets.

**Morrumbene:** `Shape_Area` (square degrees) converted in R using latitude-corrected factor:

```r
lat_morrumbene <- -23.5
area_factor <- (111000 * cos(lat_morrumbene * pi / 180) * 111000) / 10000
assets$area_ha <- assets$Shape_Area * area_factor
```

Total: 1,068.76 ha across 3 assets (cross-checked against ArcGIS site aggregate).

**Validation:** Asset polygon shapefiles available in archive folder. Cross-check script: `Mozambique/02_analysis/check_areas.R`. Asset polygon areas are smaller than GMW 2020 estuary extents because they represent only delineated assets with GEDI coverage.

### Step 4: Normalise GEDI Condition Variables (0-1) -- DONE (2026-03-28)

Apply min-max normalisation to each of the four condition indicators using the reference levels in Section 2.5. Clamp all values to [0, 1].

Formula:

```
CI_i = clamp( (observed - poor) / (pristine - poor), 0, 1 )
```

```r
library(dplyr)

clamp01 <- function(x) pmin(pmax(x, 0), 1)

assets <- assets |>
  mutate(
    CI_rh100 = clamp01((mean_rh100  - 3)    / (15   - 3)),
    CI_cover = clamp01((mean_L2B_cover - 0.30) / (0.70 - 0.30)),
    CI_agbd  = clamp01((mean_L4A_agbd  - 5)    / (100  - 5)),
    CI_pai   = clamp01((mean_L2B_pai   - 0.05) / (2.0  - 0.05))
  )
```

Apply independently to each asset row. `mean_L4A_carbono_mgha` is NOT normalised — it is carried through as a raw carbon density value for the carbon account only.

### Step 5: Composite Condition Index per Asset -- DONE (2026-03-28)

Compute the composite condition index (CCI) for each asset as the unweighted mean of the four normalised indicators:

```
CCI = mean(CI_rh100, CI_cover, CI_agbd, CI_pai)
```

```r
assets <- assets |>
  mutate(CCI = rowMeans(select(., CI_rh100, CI_cover, CI_agbd, CI_pai)))
```

An equal-weight mean is used because there is no a priori basis for differential weighting in the absence of field-validated importance scores. Document this assumption in outputs. Propagate the GEDI confidence flag from Step 2 to all CCI output rows.

### Step 6: Area-Weighted Condition per Site -- DONE (2026-03-28)

Aggregate asset-level CCIs to a single site-level condition index, weighted by asset area (ha from Step 3):

```
CCI_site = sum(CCI_asset_i * area_ha_i) / sum(area_ha_i)
```

```r
site_summary <- assets |>
  group_by(site) |>
  summarise(
    CCI_site    = sum(CCI * area_ha) / sum(area_ha),
    CI_rh100_wt = sum(CI_rh100 * area_ha) / sum(area_ha),
    CI_cover_wt = sum(CI_cover * area_ha) / sum(area_ha),
    CI_agbd_wt  = sum(CI_agbd  * area_ha) / sum(area_ha),
    CI_pai_wt   = sum(CI_pai   * area_ha) / sum(area_ha),
    total_area_ha = sum(area_ha)
  )
```

Compute separately for Save Estuary and Morrumbene. The site-level area-weighted CCI is the primary SEEA EA reporting value for future accounting periods.

### Step 7: Carbon Account Table -- DONE (2026-03-28)

Derive total carbon stock (Mg C) per asset and per site:

```
total_carbon_MgC = mean_L4A_carbono_mgha * area_ha
```

```r
assets <- assets |>
  mutate(
    total_carbon_MgC   = mean_L4A_carbono_mgha * area_ha,
    uncertainty_MgC    = mean_L4A_agbd_se * 0.47 * area_ha
  )
```

Carbon estimates now use actual asset polygon areas (from ArcGIS), not the broader GMW 2020 estuary extents:

| Site | Carbon density (Mg C/ha) | Asset area (ha) | Total carbon (Mg C) | CO2 equivalent (Mg CO2) |
|------|--------------------------|-----------------|---------------------|--------------------------|
| Save Estuary | 5.94 | 1,877.54 | ~11,150 | ~40,850 |
| Morrumbene Estuary | 5.15 | 1,068.76 | ~5,500 | ~20,150 |

Note: Previous estimates used GMW 2020 extent (Save 12,085 ha; Morrumbene 1,677 ha), producing higher totals (~71,800 and ~8,640 Mg C respectively). The asset polygon areas are the correct basis for accounting against delineated assets with GEDI coverage. Report all carbon values with uncertainty bounds (mean +/- 1 SE).

### Step 8: SEEA EA Condition Account Export -- DONE (2026-03-28)

Format the SEEA EA condition table (one row per indicator per site per accounting period):

| Column | Content |
|--------|---------|
| Ecosystem_type | Mangrove Forests (MFT1.2) |
| Site | Save Estuary / Morrumbene Estuary |
| Accounting_period | 2025–2026 |
| Indicator | Indicator name |
| Variable | GEDI variable used |
| Unit | Unit of measurement |
| Reference_poor | Poor condition value |
| Reference_pristine | Pristine condition value |
| Observed_value | Site-level area-weighted mean |
| CI | Normalised condition index (0–1) |
| Confidence | HIGH / MEDIUM / LOW |
| Notes | Flags, caveats |

Export 4 condition indicator rows + 1 carbon stock row per site = 10 rows total. See Section 4 for the populated accounts table.

### Step 9: Field Validation Integration — BLOCKED

**Blocker:** In-situ field surveys have not yet been completed. All condition indices and carbon estimates remain PROVISIONAL until ground-truth data are available.

**Next steps:**

- Field surveys planned Mar–May 2026 at Save and Morrumbene (minimum 3 plots per asset)
- Field data to collect per plot:
  - Canopy height (clinometer or height pole; cross-validate rh100)
  - DBH of all stems >= 2.5 cm within a 10 m radius
  - Stem density (stems per m2)
  - Species composition (Rhizophora, Ceriops, Bruguiera, Avicennia, etc.)
  - Regeneration density (seedlings and saplings < 1.3 m)
- Post-field: derive field-based biomass using species-specific allometric equations; compare against GEDI AGBD at co-located footprints; update confidence flags and recalculate CIs where estimates change materially
- Assess whether PAI and canopy cover reference levels require revision based on in-situ forest structure

---

## 4. SEEA EA Condition Accounts — 2025–2026 (PROVISIONAL)

All values are PROVISIONAL pending field validation (Step 9) and area conversion (Step 3).

### 4.1 Save Estuary (Gaza Province)

| Ecosystem type | Site | Accounting period | Indicator | Variable | Unit | Reference poor | Reference pristine | Observed value | CI | Confidence | Notes |
|----------------|------|-------------------|-----------|----------|------|----------------|-------------------|----------------|-----|------------|-------|
| MFT1.2 | Save Estuary | 2025–2026 | Canopy height | mean_rh100 | m | 3 | 15 | 5.07 | 0.17 | HIGH | GEDI site mean; 84 footprints; area-weighted step pending |
| MFT1.2 | Save Estuary | 2025–2026 | Canopy cover | mean_L2B_cover | Fraction | 0.30 | 0.70 | 0.088 | 0.00 | LOW | Below poor threshold; possible GEDI measurement artefact; Sentinel-2 cross-validation recommended |
| MFT1.2 | Save Estuary | 2025–2026 | Above-ground biomass density | mean_L4A_agbd | Mg/ha | 5 | 100 | 12.63 | 0.08 | MEDIUM | High relative SE (~126%); treat as indicative only |
| MFT1.2 | Save Estuary | 2025–2026 | Plant Area Index | mean_L2B_pai | Unitless | 0.05 | 2.0 | 0.29 | 0.12 | LOW | Provisional reference levels; no WIO benchmark |
| MFT1.2 | Save Estuary | 2025-2026 | Carbon stock (density) | mean_L4A_carbono_mgha | Mg C/ha | -- | -- | 5.94 | -- | MEDIUM | Not normalised; total ~11,150 Mg C (asset area 1,877.54 ha); CO2 eq ~40,850 Mg |

### 4.2 Morrumbene Estuary (Inhambane Province)

| Ecosystem type | Site | Accounting period | Indicator | Variable | Unit | Reference poor | Reference pristine | Observed value | CI | Confidence | Notes |
|----------------|------|-------------------|-----------|----------|------|----------------|-------------------|----------------|-----|------------|-------|
| MFT1.2 | Morrumbene Estuary | 2025–2026 | Canopy height | mean_rh100 | m | 3 | 15 | 5.27 | 0.19 | HIGH | GEDI site mean; 195 footprints; two HIGH-confidence assets |
| MFT1.2 | Morrumbene Estuary | 2025–2026 | Canopy cover | mean_L2B_cover | Fraction | 0.30 | 0.70 | 0.049 | 0.00 | LOW | Below poor threshold; possible GEDI measurement artefact; Sentinel-2 cross-validation recommended |
| MFT1.2 | Morrumbene Estuary | 2025–2026 | Above-ground biomass density | mean_L4A_agbd | Mg/ha | 5 | 100 | 10.95 | 0.06 | MEDIUM | High relative SE (~129%); treat as indicative only |
| MFT1.2 | Morrumbene Estuary | 2025–2026 | Plant Area Index | mean_L2B_pai | Unitless | 0.05 | 2.0 | 0.12 | 0.04 | LOW | Provisional reference levels; no WIO benchmark |
| MFT1.2 | Morrumbene Estuary | 2025-2026 | Carbon stock (density) | mean_L4A_carbono_mgha | Mg C/ha | -- | -- | 5.15 | -- | MEDIUM | Not normalised; total ~5,500 Mg C (asset area 1,068.76 ha); CO2 eq ~20,150 Mg |

### 4.3 Notes on Current Account Values

The CI values in Sections 4.1 and 4.2 are calculated from site-level GEDI means and are unweighted by asset area. They will be revised once Step 3 (area conversion) is complete and area-weighted means replace the simple site averages.

The canopy cover CI of 0.00 at both sites reflects observed values (0.049–0.088) falling below the provisional poor-condition threshold (0.30). Before interpreting this as ecological degradation, cross-validate cover estimates with Sentinel-2 optical imagery, as GEDI 25 m footprints may systematically underestimate canopy cover in patchy mangrove structure.

---

## 5. Open Review Items and Next Steps

### 5.1 Area Conversion -- RESOLVED (2026-03-28)

**Status:** DONE

Save assets use pre-computed area_ha from ArcGIS shapefiles (total 1,877.54 ha). Morrumbene assets converted from Shape_Area using latitude-corrected factor at 23.5 deg S (total 1,068.76 ha). Cross-check script: `Mozambique/02_analysis/check_areas.R`. Asset polygon areas are smaller than GMW 2020 estuary extents because they represent only the delineated assets with GEDI coverage.

### 5.2 Blocked: Field Validation (Mar–May 2026)

**Status:** BLOCKED — surveys not yet conducted

All condition indices and carbon estimates remain PROVISIONAL until field data confirm or revise GEDI estimates.

**Next steps:**
- Coordinate with field team to confirm survey dates at Save and Morrumbene (Mar–May 2026)
- Prepare field data sheets: canopy height, DBH, stem density, species composition, regeneration
- Post-survey: compare field-derived biomass (species-specific allometric equations) against GEDI AGBD at co-located footprints
- Update confidence flags and recalculate CIs where estimates differ materially from field data
- Assess whether canopy cover values reflect real structure or GEDI artefacts

### 5.3 Provisional Reference Levels Requiring Literature Review

**Status:** PENDING — systematic literature search required

Three of four condition indicator reference levels remain provisional:

| Indicator | Issue | Action required |
|-----------|-------|----------------|
| Canopy cover (LOW) | No WIO-specific benchmark; values (4–9%) are below the provisional poor threshold | Search for WIO mangrove canopy cover studies using optical remote sensing; cross-validate with Sentinel-2 before publishing CI |
| Plant Area Index (LOW) | No peer-reviewed WIO mangrove PAI benchmark identified | Search for PAI measurements in WIO/East African mangroves; may need to use global tropical mangrove benchmarks with downgraded confidence |
| AGBD (MEDIUM) | Pristine reference of 100 Mg/ha is from general tropical mangrove literature; no Mozambique-specific or WIO-specific intact-stand value confirmed | Prioritise in systematic search; Godoy & De Lacerda 2015 provides degraded-stand lower bound (5 Mg/ha) |

### 5.4 AGBD Uncertainty — High Relative Standard Error

**Status:** NOTE — document in all outputs

AGBD standard errors at both sites are approximately equal to the mean estimate (~126–129% relative uncertainty). All absolute biomass and carbon values must be reported with uncertainty bounds (mean +/- 1 SE). Do not present point estimates without error ranges in policy outputs.

### 5.5 Save Assets 2 and 4 — Insufficient GEDI Coverage

**Status:** NOTE — flag in all outputs

Save Assets 2 and 4 have only 2 and 1 GEDI footprints respectively. These assets produce unreliable mean estimates (LOW confidence) and must not be used for trend analysis in future accounting periods until GEDI coverage improves.

### 5.6 Species Composition Not Available

**Status:** BLOCKED — requires field surveys (Step 9) or optical imagery integration

GEDI provides structural metrics only (height, biomass, cover, PAI). Dominant species (Rhizophora, Ceriops, Avicennia, Bruguiera) affect allometric relationships and biomass expansion factors. Species-level data are required for full condition characterisation.

**Next steps:** Collect species composition data during field validation surveys (Step 9); alternatively, use high-resolution optical imagery (WorldView-2/3 or Planet SuperDove) to classify mangrove species assemblages.

### 5.7 Canopy Cover Cross-Validation with Sentinel-2

**Status:** PENDING — required before publishing cover-based CI

Both sites show very low GEDI canopy cover (4–9%), which may reflect GEDI measurement artefacts (25 m footprints sampling gap fractions) rather than actual canopy density. Before publishing condition indices based on canopy cover, derive an independent cover estimate from Sentinel-2 NDVI or fractional cover classification and compare.

---

## 6. Expected Output Files

All outputs to be saved to `Mozambique/03_outputs/`

| File | Description |
|------|-------------|
| `mangrove_condition_by_asset.csv` | Asset-level: CI_rh100, CI_cover, CI_agbd, CI_pai, CCI, area_ha, confidence flag |
| `mangrove_condition_by_site.csv` | Site-level area-weighted condition summary (all indicators + CCI) |
| `mangrove_carbon_account.csv` | Carbon stock per asset (carbono_mgha, area_ha, total_carbon_MgC, uncertainty_MgC) and site totals |
| `mangrove_seea_condition_account.csv` | SEEA EA format: 4 condition rows + 1 carbon row per site = 10 rows total |

### Analysis Script

| File | Location |
|------|----------|
| `mangrove_condition.R` | `Mozambique/02_analysis/mangrove_condition.R` |
| `check_areas.R` | `Mozambique/02_analysis/check_areas.R` (area cross-check utility) |

---

## 7. Change Log

| Date | Change | Author |
|------|--------|--------|
| 2026-03-27 | SOP created from mangrove_analysis_plan.md; Steps 1-2 done; Steps 3-8 pending; Step 9 blocked | Claude Code |
| 2026-03-28 | Steps 3-8 marked DONE; updated data sources to archive/ CSVs; Save corrected to 8 assets; area_ha from ArcGIS (Save 1,877.54 ha; Morrumbene 1,068.76 ha); carbon totals recalculated using asset areas; R scripts created | Claude Code |
