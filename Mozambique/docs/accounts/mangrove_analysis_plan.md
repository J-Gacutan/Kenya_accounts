# Plan: Mangrove Condition Analysis — Mozambique

**Project:** AFRICA — accounts / Mozambique
**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Mangrove Forests (MFT1.2)
**Sites:** Save Estuary (Gaza Province) + Morrumbene Estuary (Inhambane Province)
**Accounting period:** 2025–2026
**Data source:** NASA GEDI LiDAR (L2A, L2B, L4A v2); 2024–2025 observations

---

## Status Overview

| Step | Status | Notes |
|------|--------|-------|
| 1. Data ingestion | DONE | Updated 2026-03-28; 3 assets (Morrumbene), 8 assets (Save); archive CSVs with pre-computed area_ha |
| 2. QA/QC | DONE | Validated in FINDINGS_OVERVIEW.md; flagged Save Assets 2 & 4 (1–2 GEDI footprints) |
| 3. Area conversion | DONE | Save: area_ha pre-computed from ArcGIS shapefiles; Morrumbene: converted from Shape_Area using lat-corrected factor (23.5 deg S) |
| 4. Normalise GEDI condition variables (0-1) | DONE | Canopy height, canopy cover, AGBD, PAI; implemented in mangrove_condition.R |
| 5. Composite condition index per asset | DONE | Equal-weight mean of 4 normalised indicators; implemented in mangrove_condition.R |
| 6. Area-weighted condition per site | DONE | Weight composite CI by asset area (ha); implemented in mangrove_condition.R |
| 7. Carbon account table | DONE | AGBD x area = total Mg C per asset and per site; implemented in mangrove_condition.R |
| 8. SEEA EA condition account export | DONE | Standard SEEA EA condition table format; implemented in mangrove_condition.R |
| 9. Field validation integration | BLOCKED | Field surveys planned Mar-May 2026; ground-truth GEDI with in-situ plots |

---

## Input Data

### Data Inventory

| File | Level | Assets / Records | Key GEDI Fields | GEDI Footprints (total) | Area Source |
|------|-------|-----------------|-----------------|------------------------|-------------|
| `Save_mangrove_assets_condition_stats.csv` | Asset | 8 assets | rh100, agbd, agbd_se, cover, pai, carbono_mgha | 84 | area_ha pre-computed (ArcGIS) |
| `Save_mangrove_area_condition_stats.csv` | Site | 1 record (aggregated) | As above | 84 | area_ha pre-computed (ArcGIS) |
| `morrumbene_by_asset.csv` | Asset | 3 assets | rh100, agbd, agbd_se, cover, pai, carbono_mgha | 195 | Shape_Area in sq deg (converted in R) |
| `Morrumbene_mangrove_area_condition_stats.csv` | Site | 1 record (aggregated) | As above | 195 | Area_ha pre-computed (ArcGIS) |

All files located in: `Mozambique/01_inputs/raw_data/archive/`

### Column Schema

Save condition_stats CSVs use `area_ha` (hectares, pre-computed from ArcGIS polygon geometry). Morrumbene by_asset CSV retains `Shape_Area` (square degrees), converted to hectares in R using a latitude-corrected factor at 23.5 deg S.

| Column | Unit | Description |
|--------|------|-------------|
| Asset_ID | -- | Unique identifier for each mangrove forest unit |
| area_ha | Hectares | Area of asset polygon (Save condition_stats files; ArcGIS-derived) |
| Shape_Area | Square degrees | Area of asset polygon (Morrumbene by_asset file; requires conversion) |
| BUFF_DIST | Meters | Buffer distance applied during spatial processing (standard: 25 m) |
| mean_rh100 | Meters | Mean canopy height (RH100 percentile); maximum vegetation structure |
| mean_L4A_agbd | Mg/ha | Mean above-ground biomass density |
| mean_L4A_agbd_se | Mg/ha | Standard error of AGBD estimate |
| mean_L2B_cover | Fraction (0-1) | Mean canopy cover; density of upper vegetation layer |
| mean_L2B_pai | Unitless (m2/m2) | Mean Plant Area Index; total one-sided leaf + stem area per ground area |
| mean_L4A_carbono_mgha | Mg C/ha | Mean carbon stock per unit area (approx. AGBD x 0.47) |
| Point_Count | Count | Number of GEDI footprints (~25 m diameter) contributing to asset average |

### Site Summaries (Baseline Values)

| Site | Province | Asset Area (ha) | GMW 2020 Extent (ha) | Assets | GEDI Footprints | Mean Canopy Height (m) | Mean AGBD (Mg/ha) | Mean Cover (fraction) | Mean PAI | Mean Carbon (Mg C/ha) |
|------|----------|----------------|---------------------|--------|-----------------|----------------------|-------------------|----------------------|----------|-----------------------|
| Save Estuary | Gaza | 1,877.54 | 12,085 | 8 | 84 | 5.07 | 12.63 | 0.088 | 0.29 | 5.94 |
| Morrumbene Estuary | Inhambane | 1,068.76 | 1,677 | 3 | 195 | 5.27 | 10.95 | 0.049 | 0.12 | 5.15 |

Note: "Asset Area" is the total area of delineated asset polygons (from ArcGIS shapefiles). "GMW 2020 Extent" is the broader satellite-derived mangrove extent for the estuary system. Carbon accounts use asset polygon areas.

### GEDI Coverage and Confidence by Asset

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
| Morrumbene | 1 | — | 85 | HIGH |
| Morrumbene | 2 | — | 95 | HIGH |
| Morrumbene | 3 | — | 15 | MODERATE |

Morrumbene asset areas are derived in R from Shape_Area (sq degrees) using a latitude-corrected conversion factor at 23.5 deg S. Total Morrumbene area: 1,068.76 ha (from ArcGIS site aggregate).

---

## Analysis Methodology

### Step 1: Data Ingestion -- DONE (updated 2026-03-28)

Load CSVs from archive folder. Save uses the new condition_stats CSV (8 assets, area_ha pre-computed from ArcGIS). Morrumbene uses the original by_asset CSV (3 assets, Shape_Area in sq deg converted in R).

```
# R
library(readr)
archive_dir <- here::here("Mozambique", "01_inputs", "raw_data", "archive")
save_assets <- read_csv(file.path(archive_dir, "Save_mangrove_assets_condition_stats.csv"))
save_site   <- read_csv(file.path(archive_dir, "Save_mangrove_area_condition_stats.csv"))
morr_assets <- read_csv(file.path(archive_dir, "morrumbene_by_asset.csv"))
morr_site   <- read_csv(file.path(archive_dir, "Morrumbene_mangrove_area_condition_stats.csv"))
```

Validate: check `Point_Count` is numeric; check no NA values in GEDI fields. Attach `site` label and standardise column selection before binding rows.

### Step 2: QA/QC — DONE

Validation completed as documented in `Mozambique/03_outputs/FINDINGS_OVERVIEW.md`. Key flags:

- Save Assets 2 and 4 have 1–2 GEDI footprints; flag as LOW confidence in all outputs.
- AGBD standard errors are high relative to mean values (~126–129% relative uncertainty); note in output metadata.
- Very low canopy cover values (4–9%) may reflect GEDI measurement artefacts; cross-validation with Sentinel-2 recommended.
- No issues found with data completeness or file structure.

A `confidence` flag column should be added to asset-level outputs:
- HIGH: Point_Count >= 20
- MODERATE: Point_Count 6–19
- LOW: Point_Count <= 5

### Step 3: Area Conversion -- DONE (2026-03-28)

**Save Estuary:** `area_ha` is pre-computed from ArcGIS polygon geometry in `Save_mangrove_assets_condition_stats.csv`. No conversion needed. Total: 1,877.54 ha across 8 assets.

**Morrumbene:** `Shape_Area` (square degrees) is converted in R using a latitude-corrected factor:

```
lat_morrumbene <- -23.5
area_factor <- (111000 * cos(lat_morrumbene * pi / 180) * 111000) / 10000
assets$area_ha <- assets$Shape_Area * area_factor
```

Total: 1,068.76 ha across 3 assets (from ArcGIS site aggregate cross-check).

**Validation:** Asset polygon shapefiles are available in the archive folder (`Save_mangrove_area.shp`, `Morrumbene_mangrove_area.shp`). The pre-computed area_ha values from ArcGIS are authoritative. Cross-check script: `Mozambique/02_analysis/check_areas.R`.

**Note:** Asset polygon areas (Save 1,877.54 ha; Morrumbene 1,068.76 ha) are smaller than the broader GMW 2020 estuary extents (Save 12,085 ha; Morrumbene 1,677 ha) because the asset polygons represent only the specific delineated mangrove units with GEDI coverage, not the full estuary system.

### Step 4: Normalise GEDI Condition Variables (0-1) -- DONE (2026-03-28)

Implemented in `mangrove_condition.R`. For each of the four condition indicators, min-max normalisation using the reference level range (poor = 0, pristine = 1), clamped to [0, 1].

Formula: `CI_i = clamp( (observed - poor) / (pristine - poor), 0, 1 )`

Applied independently to each asset row. `mean_L4A_carbono_mgha` is NOT normalised -- carried through as raw carbon stock for the carbon account only.

### Step 5: Composite Condition Index per Asset -- DONE (2026-03-28)

Implemented in `mangrove_condition.R`. Composite condition index (CCI) per asset is the unweighted mean of four normalised indicators:

`CCI = mean(CI_rh100, CI_cover, CI_agbd, CI_pai)`

Equal-weight mean used because there is no a priori basis for differential weighting without field-validated importance scores. GEDI confidence flag (HIGH / MODERATE / LOW) propagated to all CCI output rows.

### Step 6: Area-Weighted Condition per Site -- DONE (2026-03-28)

Implemented in `mangrove_condition.R`. Asset-level CCIs aggregated to site-level using area_ha as weights:

`CCI_site = sum(CCI_asset_i * area_ha_i) / sum(area_ha_i)`

Computed separately for Save Estuary and Morrumbene. Area-weighted means also computed for each individual normalised indicator. The site-level area-weighted CCI is the primary SEEA EA reporting value.

### Step 7: Carbon Account Table -- DONE (2026-03-28)

Implemented in `mangrove_condition.R`. Total carbon stock (Mg C) per asset and per site:

`total_carbon_MgC = mean_L4A_carbono_mgha * area_ha`

Carbon estimates now use actual asset polygon areas (from ArcGIS shapefiles), not the broader GMW 2020 estuary extents. CO2 equivalent uses factor 3.664 (44/12 molecular weight ratio).

**Note:** Previous estimates used GMW 2020 extent (Save 12,085 ha; Morrumbene 1,677 ha) which produced higher totals. The asset polygon areas (Save 1,877.54 ha; Morrumbene 1,068.76 ha) are the correct basis for carbon accounting against delineated assets with GEDI coverage.

### Step 8: SEEA EA Condition Account Export -- DONE (2026-03-28)

Implemented in `mangrove_condition.R`. SEEA EA condition table structure (one row per asset per accounting period):

| Column | Content |
|--------|---------|
| ecosystem_type | Mangrove Forests (MFT1.2) |
| site | Save Estuary / Morrumbene Estuary |
| asset_id | Asset identifier |
| area_ha | Asset area in hectares |
| ci_canopy_height | Normalised canopy height CI (0-1) |
| ci_canopy_cover | Normalised canopy cover CI (0-1) |
| ci_agbd | Normalised AGBD CI (0-1) |
| ci_pai | Normalised PAI CI (0-1) |
| condition_index_composite | Equal-weight mean of 4 CIs |
| gedi_confidence | HIGH / MEDIUM / LOW |
| year | 2025 |

Export: 11 rows total (8 Save assets + 3 Morrumbene assets). Site-level summaries in separate output file.

### Step 9: Field Validation Integration — BLOCKED

Ground-truthing with in-situ plots is planned for Mar–May 2026 and is a prerequisite for upgrading GEDI-derived estimates from PROVISIONAL to CONFIRMED status.

Field data to collect per plot (minimum 3 plots per asset):
- Canopy height (clinometer or height pole; cross-validate rh100)
- DBH of all stems >= 2.5 cm within a 10 m radius
- Stem density (stems per m2)
- Species composition (Rhizophora, Ceriops, Bruguiera, Avicennia, etc.)
- Regeneration density (seedlings and saplings < 1.3 m)

Post-field:
- Derive field-based biomass using species-specific allometric equations
- Compare against GEDI AGBD estimates at co-located footprints
- Update confidence flags and recalculate condition indices where field data change the estimate materially
- Assess whether PAI and canopy cover reference levels require revision based on in-situ structure

---

## Reference Levels

| Indicator | GEDI Variable | Unit | Poor (0) | Pristine (1) | Confidence | Source(s) |
|-----------|--------------|------|----------|--------------|------------|-----------|
| Canopy height | mean_rh100 | m | 3 | 15 | HIGH | Fatoyinbo 2008; Lagomasino 2015; Sitoe 2016 (WIO/Mozambique mangroves) |
| Canopy cover | mean_L2B_cover | Fraction (0–1) | 0.30 | 0.70 | LOW | Provisional; revised downward from 0.95; no published WIO-specific benchmark |
| Above-ground biomass density | mean_L4A_agbd | Mg/ha | 5 | 100 | MEDIUM | Godoy & De Lacerda 2015 (degraded stands 6–9 Mg/ha); intact stands can exceed 100 Mg/ha; no Mozambique-specific intact-stand value confirmed |
| Plant Area Index | mean_L2B_pai | Unitless | 0.05 | 2.0 | LOW | Provisional; no published WIO-specific benchmark |
| Carbon stock | mean_L4A_carbono_mgha | Mg C/ha | — | — | — | Not normalised; reported as raw value in carbon account table |

**Confidence rating definitions:**
- HIGH: Supported by published WIO or Mozambique-specific field studies
- MEDIUM: Supported by regional tropical mangrove literature; not WIO-specific
- LOW: Provisional estimate; no peer-reviewed benchmark published for this variable in the WIO region

---

## Expected Output Files

All outputs to be saved to `Mozambique/03_outputs/`

| File | Description |
|------|-------------|
| `mangrove_condition_by_asset.csv` | Asset-level normalised condition indicators (CI_rh100, CI_cover, CI_agbd, CI_pai), composite CCI, area_ha, GEDI confidence flag |
| `mangrove_condition_by_site.csv` | Site-level area-weighted condition summary (Save Estuary and Morrumbene; all indicators + CCI) |
| `mangrove_carbon_account.csv` | Carbon stock per asset (mean_L4A_carbono_mgha, area_ha, total_carbon_MgC, uncertainty_MgC) and site totals |
| `mangrove_seea_condition_account.csv` | SEEA EA format condition table (4 condition indicator rows + 1 carbon row per site = 10 rows total) |

### Analysis Script

| File | Location |
|------|----------|
| `mangrove_condition.R` | `Mozambique/02_analysis/mangrove_condition.R` |
| `check_areas.R` | `Mozambique/02_analysis/check_areas.R` (area cross-check utility) |

---

## Open Review Items

### 1. Area conversion -- RESOLVED (2026-03-28)

Save assets now use pre-computed area_ha from ArcGIS shapefiles. Morrumbene assets converted from Shape_Area using latitude-corrected factor at 23.5 deg S. Cross-check script: `Mozambique/02_analysis/check_areas.R`. Asset polygon areas are smaller than GMW 2020 estuary extents because they represent only the delineated assets with GEDI coverage.

### 2. AGBD reference level — PROVISIONAL

The pristine-condition reference of 100 Mg/ha is based on tropical mangrove literature for intact stands. No confirmed Mozambique-specific or WIO-specific intact-stand value has been identified. The poor-condition reference of 5 Mg/ha is supported by Godoy & De Lacerda 2015 (degraded stands 6–9 Mg/ha). Both values should be updated following the systematic literature search and field validation.

### 3. PAI reference level — PROVISIONAL

Both the poor (0.05) and pristine (2.0) PAI reference levels are provisional. No peer-reviewed WIO mangrove PAI benchmark has been identified. Cross-validate against canopy height and cover data from the same sites before applying in condition index calculations.

### 4. Canopy cover reference level — PROVISIONAL

The poor (0.30) and pristine (0.70) canopy cover reference levels are provisional. The very low observed values at both sites (4–9%) may reflect GEDI measurement artefacts where 25 m footprints sample gap fractions rather than closed-canopy fractions. Cross-validation with Sentinel-2 optical imagery is recommended before interpreting cover-based condition indices.

### 5. Save Assets 2 and 4 — LOW confidence flag

Save Assets 2 and 4 have 2 and 1 GEDI footprints respectively. These assets produce unreliable mean estimates and should be flagged as LOW confidence in all outputs. They should not be used for trend analysis in future accounting periods until GEDI coverage improves.

### 6. AGBD uncertainty — HIGH relative standard error

AGBD standard errors at both sites are approximately equal to the mean estimate (~126–129% relative uncertainty). All absolute biomass and carbon values should be reported with uncertainty bounds (mean +/- 1 SE) and interpreted cautiously in policy outputs.

### 7. Species composition not available

GEDI provides structural metrics only (height, biomass, cover, PAI) without species-level data. Dominant species (Rhizophora, Ceriops, Avicennia, Bruguiera) affect allometric relationships and biomass expansion factors. Species mapping requires field surveys (Step 9) or integration with high-resolution optical imagery.

### 8. Field validation (Mar–May 2026)

Ground-truth data from in-situ plots are required to:
- Confirm or revise GEDI canopy height estimates
- Validate AGBD against field-derived biomass using local allometric equations
- Assess whether low canopy cover values reflect real forest structure or GEDI artefacts
- Collect DBH, regeneration density, and disturbance data that cannot be derived remotely

Until field validation is complete, all condition indices and carbon estimates remain PROVISIONAL.

---

## Change Log

| Date | Change | Author |
|------|--------|--------|
| 2026-03-16 | Document created; Steps 1-2 marked DONE; Steps 3-8 PENDING; Step 9 BLOCKED | Claude Code |
| 2026-03-28 | Steps 3-8 marked DONE; updated data sources to archive/ CSVs; Save corrected to 8 assets (was 7); area_ha from ArcGIS shapefiles (Save 1,877.54 ha; Morrumbene 1,068.76 ha); R scripts created (mangrove_condition.R, check_areas.R); area conversion open item RESOLVED | Claude Code |
