# Mozambique SEEA EA Ecosystem Accounting -- Full Methodology

**Project:** AFRICA -- accounts / Mozambique
**Framework:** UN System of Environmental-Economic Accounting -- Ecosystem Accounting (SEEA EA)
**Ecosystem type:** Mangrove Forests (MFT1.2)
**Geographic scope:** Save Estuary (Gaza Province) + Morrumbene Estuary (Inhambane Province)
**Accounting period:** 2025-2026
**Primary data source:** NASA GEDI LiDAR (L2A, L2B, L4A v2); 2024-2025 observations
**Extent baseline:** Global Mangrove Watch v4 (GMW 2020)

---

## Table of Contents

1. [Introduction and Framework](#1-introduction-and-framework)
2. [Study Sites](#2-study-sites)
3. [Data Sources and GEDI Variables](#3-data-sources-and-gedi-variables)
4. [Extent Account](#4-extent-account)
5. [Condition Account -- Remote Sensing Approach](#5-condition-account----remote-sensing-approach)
6. [Carbon Account](#6-carbon-account)
7. [QA/QC and Confidence Framework](#7-qaqc-and-confidence-framework)
8. [Results](#8-results)
9. [Analysis Pipeline](#9-analysis-pipeline)
10. [Outputs and File Structure](#10-outputs-and-file-structure)
11. [Open Items and Limitations](#11-open-items-and-limitations)
12. [References](#12-references)

---

## 1. Introduction and Framework

### 1.1 Mozambique Pilot Scope

The Mozambique pilot produces SEEA EA ecosystem condition, extent, and carbon accounts for mangrove forests at two estuarine sites along the southern Mozambique coast. Unlike the Kenya pilot (which uses field survey data), the Mozambique pilot demonstrates a remote-sensing approach using NASA GEDI spaceborne LiDAR as the primary data source.

This approach is relevant for countries and sites where:
- Field survey access is limited or logistically challenging
- Large spatial coverage is needed across multiple sites
- Structural condition metrics (height, biomass, cover) are the priority
- A baseline must be established before field validation surveys

### 1.2 Account Types

| Account | Status | Data Source |
|---------|--------|-------------|
| Condition (structural) | COMPLETE (PROVISIONAL) | NASA GEDI LiDAR |
| Carbon stock (physical) | COMPLETE (PROVISIONAL) | GEDI AGBD x asset area |
| Extent (per admin unit) | COMPLETE | GMW 2020 + ArcGIS |

All condition and carbon values are PROVISIONAL pending field validation surveys planned for March-May 2026.

### 1.3 Key Distinction: Remote Sensing vs. Field-Based Accounts

| Dimension | Mozambique (GEDI) | Kenya (field surveys) |
|-----------|-------------------|----------------------|
| Spatial coverage | Full estuary system | Site-level plots/transects |
| Indicators | Structural only (height, cover, biomass, PAI) | Biotic (species, health, quality) + structural |
| Species data | Not available | Full species identification |
| Temporal resolution | Satellite overpass windows | Fixed survey dates |
| Validation | Requires field ground-truthing | Self-validating (direct measurement) |
| Cost | Low (open-access satellite data) | High (field team deployment) |

---

## 2. Study Sites

### 2.1 Save Estuary (Gaza Province)

**Location:** Nova Mambone and Bazaruto districts, Gaza Province
**GMW 2020 extent:** ~12,085 ha (full estuary)
**Asset polygon area:** 1,877.54 ha (8 delineated assets with GEDI coverage)
**GEDI footprints:** 84
**Character:** Heterogeneous -- two productive patches (Assets 3 and 8) amid otherwise sparse woodland

### 2.2 Morrumbene Estuary (Inhambane Province)

**Location:** Inhambane District, Inhambane Province
**GMW 2020 extent:** ~1,677 ha (full estuary)
**Asset polygon area:** 1,068.76 ha (3 delineated assets with GEDI coverage)
**GEDI footprints:** 195
**Character:** Uniform -- all three assets show consistent low-density structure

### 2.3 Asset Concept

Each estuary is subdivided into discrete **mangrove assets** -- contiguous polygon units delineated from GMW boundaries. Each asset is characterised independently by GEDI, enabling within-site heterogeneity analysis. Asset areas come from ArcGIS polygon geometry (Save: pre-computed; Morrumbene: converted from square degrees at 23.5 deg S).

---

## 3. Data Sources and GEDI Variables

### 3.1 NASA GEDI

The Global Ecosystem Dynamics Investigation (GEDI) is a spaceborne LiDAR instrument on the International Space Station. It provides:

- **L2A:** Canopy height (RH100 = tallest return within footprint)
- **L2B:** Canopy cover (fraction 0-1) and Plant Area Index (PAI)
- **L4A:** Above-ground biomass density (AGBD, Mg/ha) and carbon density (Mg C/ha)

Each GEDI footprint is approximately 25 m in diameter. Multiple footprints are aggregated per asset to produce mean structural indicators.

### 3.2 Input Files

| File | Level | Assets | GEDI Footprints | Area Source |
|------|-------|--------|-----------------|-------------|
| Save_mangrove_assets_condition_stats.csv | Asset | 8 | 84 | area_ha pre-computed (ArcGIS) |
| Save_mangrove_area_condition_stats.csv | Site | 1 (aggregated) | 84 | area_ha pre-computed (ArcGIS) |
| morrumbene_by_asset.csv | Asset | 3 | 195 | Shape_Area in sq deg (converted in R) |
| Morrumbene_mangrove_area_condition_stats.csv | Site | 1 (aggregated) | 195 | Area_ha pre-computed (ArcGIS) |

All files in: `Mozambique/01_inputs/raw_data/archive/`

### 3.3 Column Schema

| Column | Unit | Description |
|--------|------|-------------|
| Asset_ID | -- | Unique identifier per mangrove forest unit |
| mean_rh100 | m | Mean canopy height (RH100 percentile) |
| mean_L4A_agbd | Mg/ha | Mean above-ground biomass density |
| mean_L4A_agbd_se | Mg/ha | Standard error of AGBD estimate |
| mean_L2B_cover | Fraction (0-1) | Mean canopy cover |
| mean_L2B_pai | Unitless (m2/m2) | Mean Plant Area Index |
| mean_L4A_carbono_mgha | Mg C/ha | Mean carbon stock per unit area (~AGBD x 0.47) |
| Point_Count | Count | Number of GEDI footprints contributing to asset mean |

---

## 4. Extent Account

### 4.1 Method

Mangrove extent is derived from Global Mangrove Watch v4 (GMW 2020, 25 m resolution) intersected with administrative boundaries in ArcGIS/QGIS.

**Three-step GIS workflow:**

1. **Intersect** GMW 2020 mangrove polygons with admin level 3 boundaries
2. **Calculate area** (hectares) for each clipped polygon
3. **Summarise** mangrove area per admin unit (province/district)

### 4.2 Extent Results

| Site | GMW 2020 Extent (ha) | Asset Polygon Area (ha) | Assets |
|------|---------------------|------------------------|--------|
| Save Estuary | 12,085 | 1,877.54 | 8 |
| Morrumbene Estuary | 1,677 | 1,068.76 | 3 |

**Note:** Asset polygon areas are smaller than GMW 2020 extents because they represent only the delineated mangrove units with GEDI coverage, not the full estuary system.

### 4.3 Condition Assessment Linked to Assets

Each asset polygon has GEDI-derived condition indicators. The asset framework enables:
- Per-forest monitoring (tracking individual patches)
- Area-weighted site aggregation (for SEEA EA reporting)
- Heterogeneity analysis (identifying high-value patches for conservation priority)

---

## 5. Condition Account -- Remote Sensing Approach

### 5.1 Four Structural Indicators

| Indicator | GEDI Variable | Unit | What it measures |
|-----------|--------------|------|-----------------|
| Canopy height | mean_rh100 | m | Maximum vegetation structure; proxy for forest maturity |
| Canopy cover | mean_L2B_cover | Fraction (0-1) | Density of upper vegetation layer; canopy closure |
| Above-ground biomass density | mean_L4A_agbd | Mg/ha | Total dry above-ground biomass per hectare |
| Plant Area Index | mean_L2B_pai | Unitless (m2/m2) | Total one-sided leaf + stem area per ground area |

### 5.2 Reference Levels

| Indicator | Poor (CI=0) | Pristine (CI=1) | Confidence | Source |
|-----------|-------------|-----------------|------------|--------|
| Canopy height | 3 m | 15 m | HIGH | Fatoyinbo 2008; Lagomasino 2015; Sitoe 2016 (WIO/Mozambique) |
| Canopy cover | 0.30 | 0.70 | LOW | Provisional; no published WIO-specific benchmark |
| AGBD | 5 Mg/ha | 100 Mg/ha | MEDIUM | Godoy & De Lacerda 2015 (degraded: 6-9 Mg/ha); intact >100 Mg/ha |
| PAI | 0.05 | 2.0 | LOW | Provisional; no published WIO-specific benchmark |

### 5.3 Normalisation Formula

Linear rescaling (same as Kenya mangrove):

```
CI = clamp((observed - poor) / (pristine - poor), 0, 1)
```

Applied independently to each asset. Carbon density is NOT normalised -- reported as a raw value in the carbon account only.

### 5.4 Composite Condition Index

Equal-weight mean of four normalised indicators per asset:

```
CCI = mean(CI_rh100, CI_cover, CI_agbd, CI_pai)
```

### 5.5 Area-Weighted Site Aggregation

Asset-level CCIs are aggregated to site level using asset area (ha) as weights:

```
CCI_site = sum(CCI_asset_i x area_ha_i) / sum(area_ha_i)
```

This is the primary SEEA EA reporting value. Area-weighting ensures that large assets contribute more to the site-level index than small ones.

---

## 6. Carbon Account

### 6.1 Method

Total carbon stock (Mg C) per asset:

```
total_carbon_MgC = mean_L4A_carbono_mgha x area_ha
```

CO2 equivalent:

```
CO2_eq = total_carbon_MgC x 3.664 (44/12 molecular weight ratio)
```

Uncertainty propagation:

```
uncertainty_MgC = mean_L4A_agbd_se x 0.47 x area_ha
```

### 6.2 Results

| Site | Carbon density (Mg C/ha) | Asset area (ha) | Total carbon (Mg C) | CO2 equivalent (Mg CO2) |
|------|--------------------------|-----------------|---------------------|--------------------------|
| Save Estuary | 5.94 | 1,877.54 | ~11,150 | ~40,850 |
| Morrumbene Estuary | 5.15 | 1,068.76 | ~5,500 | ~20,150 |
| **Combined** | **5.64** | **2,946.30** | **~16,650** | **~61,000** |

### 6.3 Carbon Accounting Notes

- Carbon estimates use actual asset polygon areas (from ArcGIS), not broader GMW 2020 estuary extents
- AGBD standard errors are high (~126-129% relative uncertainty); all carbon values must be reported with uncertainty bounds
- Carbon density (~5-6 Mg C/ha) is low compared to intact tropical mangroves (30-100+ Mg C/ha), suggesting either degraded forests or GEDI measurement limitations in sparse canopy
- CO2 equivalent provides a basis for future carbon market valuation

---

## 7. QA/QC and Confidence Framework

### 7.1 GEDI Confidence by Asset

Confidence is determined by GEDI footprint count (Point_Count):

| Threshold | Rating | Use in accounting |
|-----------|--------|-------------------|
| >= 20 footprints | HIGH | Reliable for trend analysis |
| 6-19 footprints | MODERATE | Acceptable for baseline; flag in outputs |
| <= 5 footprints | LOW | Descriptive only; exclude from trend analysis |

**Asset confidence ratings:**

| Site | Asset | Footprints | Confidence |
|------|-------|------------|------------|
| Save | 1 | 17 | MODERATE |
| Save | 2 | 2 | LOW |
| Save | 3 | 3 | LOW |
| Save | 4 | 1 | LOW |
| Save | 5 | 17 | MODERATE |
| Save | 6 | 31 | HIGH |
| Save | 7 | 7 | MODERATE |
| Save | 8 | 6 | MODERATE |
| Morrumbene | 1 | 85 | HIGH |
| Morrumbene | 2 | 95 | HIGH |
| Morrumbene | 3 | 15 | MODERATE |

### 7.2 Known Data Quality Issues

| Issue | Impact | Mitigation |
|-------|--------|------------|
| Very low canopy cover (4-9%) | May be GEDI artefact, not real canopy density | Cross-validate with Sentinel-2 optical imagery |
| AGBD SE ~126-129% of mean | Very high relative uncertainty | Report all biomass/carbon with error bounds |
| Save Assets 2 and 4 (1-2 footprints) | Unreliable estimates | Flag as LOW; exclude from trend analysis |
| No species composition data | Cannot assess biotic condition | Requires field surveys or optical species mapping |
| Single time-point (2024-2025) | No temporal change detection | Baseline only; resurvey needed for trends |
| Asset areas < GMW extent | Delineated assets cover only part of estuary | Document; use asset areas for accounting, GMW for context |

### 7.3 Area Conversion Validation

**Save:** area_ha pre-computed from ArcGIS polygon geometry. Total: 1,877.54 ha.

**Morrumbene:** Shape_Area (square degrees) converted to hectares using latitude-corrected factor:

```
lat = -23.5 deg S
area_factor = (111000 x cos(lat x pi / 180) x 111000) / 10000
area_ha = Shape_Area x area_factor
```

Total: 1,068.76 ha. Cross-checked with ArcGIS site aggregate and `check_areas.R`.

---

## 8. Results

### 8.1 Condition Account -- Site Level (Area-Weighted)

| Site | CI Height | CI Cover | CI AGBD | CI PAI | Composite CCI |
|------|-----------|----------|---------|--------|---------------|
| Save Estuary | 0.187 | 0.018 | 0.095 | 0.171 | 0.118 |
| Morrumbene Estuary | 0.190 | 0.000 | 0.063 | 0.036 | 0.072 |

**Interpretation:** Both sites show low composite condition (CCI < 0.12), driven primarily by:
- Canopy cover below the poor threshold at both sites (CI = 0)
- Very low biomass density relative to intact mangrove reference (CI ~0.06-0.10)
- Low PAI indicating sparse canopy structure

Canopy height is the strongest indicator (CI ~0.19), suggesting that while trees achieve moderate height (5-5.3 m), forest density and biomass are very low.

### 8.2 Site Comparison

| Dimension | Save Estuary | Morrumbene | Difference |
|-----------|-------------|-----------|-----------|
| GEDI footprints | 84 | 195 | Morrumbene: 2.3x more coverage |
| Mean canopy height | 5.07 m | 5.27 m | Similar |
| Mean AGBD | 12.63 Mg/ha | 10.95 Mg/ha | Save: 15% denser |
| Mean canopy cover | 8.8% | 4.9% | Save: 1.8x more closure |
| Mean PAI | 0.29 | 0.12 | Save: 2.4x more leaf area |
| Composite CCI | 0.118 | 0.072 | Save: 64% higher condition |
| Total carbon | ~11,150 Mg C | ~5,500 Mg C | Save: 2.0x more carbon |
| Data confidence | Uneven (1-31 per asset) | Uniform (15-95 per asset) | Morrumbene more reliable |

### 8.3 Within-Site Heterogeneity (Save Estuary)

Save Estuary shows high internal heterogeneity:

| Asset | Composite CCI | Character |
|-------|---------------|-----------|
| Asset 3 | 0.427 | Standout: tallest (7.8 m), densest, highest biomass (27.3 Mg/ha) |
| Asset 8 | 0.279 | Second-highest: taller (6.3 m), 33% canopy cover |
| Asset 5 | 0.126 | Moderate |
| Assets 1,2,4,6,7 | 0.04-0.07 | Sparse woodland; low condition |

Assets 3 and 8 represent mature, productive forest patches within an otherwise degraded landscape -- priority targets for conservation.

### 8.4 Condition Account -- SEEA EA Format

One row per asset per accounting period, with columns: ecosystem_type, site, asset_id, area_ha, ci_canopy_height, ci_canopy_cover, ci_agbd, ci_pai, condition_index_composite, gedi_confidence, year.

Total: 11 rows (8 Save + 3 Morrumbene).

---

## 9. Analysis Pipeline

### 9.1 R Analysis Scripts

| Script | Purpose |
|--------|---------|
| mangrove_condition.R | Main pipeline: ingest, QA/QC, area conversion, normalisation, aggregation, carbon, SEEA EA export |
| check_areas.R | Area cross-check utility |

### 9.2 Pipeline Steps

```
Step 1: INGEST
    Read CSVs from archive folder (readr::read_csv)
    Attach site label; standardise column names

Step 2: QA/QC
    Validate Point_Count (numeric, non-NA)
    Flag Save Assets 2 and 4 (LOW confidence)
    Note high AGBD SE (~126-129%)

Step 3: AREA CONVERSION
    Save: area_ha from ArcGIS (pre-computed)
    Morrumbene: Shape_Area (sq deg) -> ha using lat-corrected factor

Step 4: NORMALISE (0-1)
    CI = clamp((observed - poor) / (pristine - poor), 0, 1)
    Four indicators: rh100, cover, agbd, pai
    Carbon density NOT normalised

Step 5: COMPOSITE PER ASSET
    CCI = equal-weight mean of 4 CIs
    Propagate confidence flag

Step 6: AREA-WEIGHTED SITE AGGREGATION
    CCI_site = sum(CCI x area_ha) / sum(area_ha)
    Per-indicator weighted means also computed

Step 7: CARBON ACCOUNT
    total_carbon = carbon_density x area_ha
    uncertainty = agbd_se x 0.47 x area_ha
    CO2_eq = total_carbon x 3.664

Step 8: SEEA EA EXPORT
    Condition table: 11 rows (per asset)
    Site summary: 2 rows (per site)
    Carbon table: 11 rows (per asset) + site totals
```

---

## 10. Outputs and File Structure

### 10.1 Combined Outputs

All in `Mozambique/03_outputs/` with MOZ_ prefix:

| File | Description |
|------|-------------|
| MOZ_mangrove_condition_by_asset.csv | Asset-level CIs + composite + area + confidence (11 rows) |
| MOZ_mangrove_condition_by_site.csv | Site-level area-weighted condition (2 rows) |
| MOZ_mangrove_seea_condition_account.csv | SEEA EA format (11 rows) |
| MOZ_mangrove_carbon_account.csv | Carbon stock per asset + totals (11 rows) |
| MOZ_FINDINGS_OVERVIEW.md | Full narrative analysis with interpretations |

### 10.2 Per-Site Outputs

In `Mozambique/03_outputs/Save/` and `Mozambique/03_outputs/Morrumbene/`:

- [Site]_mangrove_condition_by_asset.csv
- [Site]_mangrove_condition_by_site.csv
- [Site]_mangrove_seea_condition_account.csv
- [Site]_mangrove_carbon_account.csv

---

## 11. Open Items and Limitations

### 11.1 High Priority

| Item | Status | Impact |
|------|--------|--------|
| Field validation (Mar-May 2026) | BLOCKED | All values remain PROVISIONAL |
| Canopy cover cross-validation (Sentinel-2) | PENDING | Cover CI = 0 at both sites; may be GEDI artefact |
| AGBD reference level (100 Mg/ha) | PROVISIONAL | No Mozambique-specific intact-stand value confirmed |

### 11.2 Medium Priority

| Item | Status | Impact |
|------|--------|--------|
| PAI reference level (0.05-2.0) | PROVISIONAL | No published WIO benchmark |
| Canopy cover reference (0.30-0.70) | PROVISIONAL | No published WIO-specific benchmark |
| Species composition | BLOCKED (requires field) | Cannot assess biotic condition |
| Save Assets 2 and 4 | LOW confidence | Exclude from trend analysis |

### 11.3 Future Work

1. **Field validation:** Minimum 3 plots per asset; collect height, DBH, stem density, species, regeneration
2. **Sentinel-2 cross-check:** Derive independent cover estimate from NDVI/fractional cover
3. **Multi-period analysis:** Future GEDI acquisitions (2026-2027) for change detection
4. **Species mapping:** High-resolution optical imagery (WorldView-2/3 or Planet SuperDove)
5. **Ecosystem services:** Fisheries nursery productivity, coastal protection, carbon market valuation
6. **Extent change:** Update GMW-based extent for 2025-2026 to track area trends

---

## 12. References

Fatoyinbo, T.E., et al. (2008). Landscape-scale extent, height, biomass, and carbon estimation of Mozambique's mangrove forests with Landsat ETM+ and SRTM elevation data. *Global Change Biology*.

Godoy, M.D.P. & De Lacerda, L.D. (2015). Mangroves Response to Climate Change. *Wetlands*, 35, 1-13. Degraded stand biomass reference: 6-9 Mg/ha.

Lagomasino, D., et al. (2015). Measuring mangrove carbon loss and gain in deltas. *Remote Sensing of Environment*.

Sitoe, A.A., et al. (2016). Biomass and carbon stocks of Sofala Bay mangrove forests. *Forests*, 5(7), 1967-1981.

Bunting, P., et al. (2022). Global Mangrove Watch v4.019. GMW / JAXA.

NASA GEDI. Global Ecosystem Dynamics Investigation. Products L2A, L2B, L4A (v2). https://gedi.umd.edu

UN SEEA EA (2021). System of Environmental-Economic Accounting -- Ecosystem Accounting.

---

*Version: 1.0*
*Created: 2026-03-29*
*Status: PROVISIONAL -- all condition and carbon values pending field validation*
*Companion documents: MOZ_FACILITATOR_GUIDE.md, MOZ_TRAINING_GUIDELINES.md*
