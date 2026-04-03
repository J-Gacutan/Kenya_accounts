# Standard Operating Procedures: Measuring Mangrove Ecosystem Extent & Condition

## Mozambique Mangrove Forests (MFT1.2) — Customized for 2025–2026 Accounts

**Framework:** SEEA EA Ecosystem Extent & Condition Accounts
**Ecosystem Type:** Mangrove Forests (MFT1.2)
**Geographic Scope:** Mozambique (admin level 3: provinces/districts)
**Study Areas:** Morrumbene and Save Estuary
**Accounting Period:** 2025–2026

---

## 1. Overview

This SOP provides standardized procedures for measuring mangrove ecosystem extent (area in hectares) and condition (biotic health indices) across Mozambique administrative boundaries. The workflow integrates GIS spatial analysis with condition assessment to support SEEA EA ecosystem accounting at provincial and district scales.

**Key Outputs:**

- Provincial mangrove extent table (area per admin level 3 unit, hectares)
- Condition values for mangrove assets in Morrumbene and Save Estuary
- Asset-level summary statistics (mean condition variables per mangrove polygon)
- Total area summary combining all assets

---

## 2. Extent Mapping: Mangrove Area per Province (Admin Level 3)

### 2.1 Data Sources

| Dataset | Source | Format | Resolution | Coverage | Notes |
| --- | --- | --- | --- | --- | --- |
| **GMW 2020** | Global Mangrove Watch | Raster/Vector | 25 m cells | Global | Primary mangrove extent layer |
| **Admin boundaries** | Mozambique national GIS | Polygon shapefile | Variable | Admin L0–L3 | Province, district, ward boundaries |
| **Field validation** | Project field surveys (2025–2026) | Point/polygon | Field-scale | Morrumbene, Save | Ground truth for condition subset |

### 2.2 Step 1: Intersect Mangroves with Admin Boundaries

**Objective:** Clip mangrove polygons by administrative level 3 (province/district) boundaries to isolate area within each admin unit.

**Process:**

1. **Load layers in GIS software** (QGIS, ArcGIS, or equivalent):
   - Layer 1: GMW 2020 mangrove dataset (already converted to vector polygons if raster source)
   - Layer 2: Administrative level 3 boundary shapefile

2. **Run Intersect tool:**
   - **Tool name:** Intersect (ArcGIS) / Intersection (QGIS Vector → Geoprocessing Tools)
   - **Input 1:** Mangrove vector layer
   - **Input 2:** Admin level 3 shapefile
   - **Output:** New shapefile containing **only mangrove polygons (or polygon segments) that fall within admin boundaries**

3. **Output specification:**
   - **Layer name:** `mangroves_intersect_adminL3.shp`
   - **Attributes retained:**
     - From mangrove layer: original GMW attributes (if present)
     - From admin layer: admin_code, admin_name, province, district
   - **Geometry:** Multipart polygons (one row per admin unit containing mangrove)

**Quality check:**

- Verify edge cases: mangroves along admin boundaries should appear in only one admin unit
- Check for overlaps or gaps (should be none; intersection is exact)
- Count number of output polygons (should be ≤ number of admin units with mangroves)

---

### 2.3 Step 2: Calculate Mangrove Area per Polygon

**Objective:** Add a new area field and calculate the area (hectares) for each polygon.

**Process:**

1. **Add new field to attribute table:**
   - Field name: `Area_ha`
   - Data type: Decimal (Float, 10.2 precision)

2. **Calculate geometry (area in hectares):**
   - **Tool name:** Calculate Geometry (ArcGIS Field Calculator) / Field Calculator (QGIS)
   - **Field:** Area_ha
   - **Expression (ArcGIS):** `[Shape_Area] / 10000` (converts m² to ha)
   - **Expression (QGIS):** `$area / 10000` (converts m² to ha)
   - **Run calculation** on all rows

3. **Validate:**
   - Check min/max values (spot-check against visual inspection)
   - Verify units: all values should be in hectares (ha)
   - Sum should be ≤ total GMW 2020 mangrove extent globally

**Output specification:**

- Updated shapefile: `mangroves_intersect_adminL3_area.shp`
- New column `Area_ha` populated with area values

---

### 2.4 Step 3: Summarize Mangrove Area by Admin Unit

**Objective:** Aggregate mangrove area by admin level 3 (province/district name) to produce summary table.

**Process:**

1. **Run Summary Statistics tool:**
   - **Tool name:** Summary Statistics (ArcGIS Analysis Tools → Summarize) / Summarize tool (QGIS)
   - **Input table:** `mangroves_intersect_adminL3_area.shp` (attribute table)
   - **Summarize field:** `Area_ha`
   - **Statistic type:** **SUM**
   - **Case field (Group By):** `admin_name` (or `district`, `province` — choose appropriate admin level)
   - **Output table:** `mangrove_extent_by_adminL3_summary.csv` (or `.dbf`)

2. **Output structure:**
   - Column 1: `admin_name` (e.g., "Inhambane Province", "Morrumbene District")
   - Column 2: `AREA_HA_SUM` (total mangrove area in hectares)
   - Column 3: `COUNT` (number of mangrove polygons in that admin unit)
   - One row per admin level 3 unit **where mangroves are present**

3. **Example output:**

| admin_name | AREA_HA_SUM | COUNT |
| --- | --- | --- |
| Inhambane Province | 24,567.3 | 145 |
| Morrumbene District | 8,234.5 | 42 |
| Save District | 5,612.1 | 38 |
| Gaza Province | 18,345.2 | 98 |

**Validation:**

- Sum of all AREA_HA_SUM should equal total mangrove extent in study area
- No admin units with zero area (these are automatically excluded)

**Output file:** `mangrove_extent_by_adminL3_summary.csv`

---

## 3. Condition Assessment: Mangrove Assets in Morrumbene & Save

### 3.1 Overview of Asset-Based Condition Approach

**Concept:** Mangrove ecosystems in Morrumbene and Save Estuary are subdivided into discrete **mangrove assets** (contiguous polygon units) based on GMW boundaries. Condition variables (health indicators) are measured at nearby field points and aggregated per asset.

**Condition variables** (collected at field points):

- Canopy density (% cover)
- Canopy height (m)
- Tree diameter at breast height (DBH, cm)
- Regeneration density (saplings/m²)
- Disturbance indicators (e.g., logging scars, erosion extent)
- Species composition (% by species)

---

### 3.2 Step 1a: Create Shapefile of Mangrove Assets

**Objective:** Export GMW mangrove polygons in Morrumbene and Save study areas, label each polygon as a discrete asset (Asset_1, Asset_2, etc.), and prepare for condition point aggregation.

**Process:**

1. **Clip GMW layer to study areas:**
   - Load GMW 2020 mangrove layer (vector polygons)
   - Create bounding box or polygon for Morrumbene study area
   - Create bounding box or polygon for Save study area
   - **Tool:** Clip (Vector → Geoprocessing)
   - Output: `mangroves_morrumbene.shp` and `mangroves_save.shp`

2. **Merge and assign asset IDs:**
   - Merge the two clipped layers (if maintaining separate or combine into single layer):
     - **Tool:** Merge Shapefiles (or manually: keep separate files and reference as Asset_1–N per area)
   - Add new field: `Asset_ID` (text, e.g., "MOZ_Asset_001")
   - Populate sequentially (Asset_1, Asset_2, ..., Asset_N) or use unique polygon identifier

3. **Output specification:**
   - Layer name: `mangrove_assets_morrumbene_save.shp`
   - Attributes:
     - `Asset_ID` (unique identifier, e.g., MOZ_Asset_001)
     - `Area_ha` (mangrove area in hectares, calculated as in Step 2.3)
     - `region` (Morrumbene or Save)
     - Any retained GMW attributes

**Validation:**

- Each polygon has unique Asset_ID
- Total area matches clipped GMW extent for Morrumbene + Save
- Geometries are valid (no overlaps, self-intersections)

---

### 3.3 Step 2: Calculate Average Condition Variables per Asset

**Objective:** For each mangrove asset, calculate the mean value of condition variables using field points within 25 m distance (matching spatial resolution of condition dataset).

**Process:**

1. **Prepare condition point data:**
   - Load field condition points (collected during 2025–2026 field surveys)
   - Attributes should include: point_id, latitude, longitude, canopy_density, canopy_height, DBH, regeneration_density, disturbance_indicators, species_composition
   - File format: Shapefile or GeoJSON with geographic coordinates
   - Projection: **Must match asset shapefile projection** (typically WGS84 or local UTM zone)

2. **Run Summarize Nearby tool:**
   - **Tool name:** Summarize Nearby (ArcGIS Analysis Tools → Proximity) / Spatial Join with aggregation (QGIS)
   - **Input summary features:** Field condition points
   - **Input reference features:** Mangrove assets (`mangrove_assets_morrumbene_save.shp`)
   - **Distance:** 25 m (spatial resolution of condition dataset)
   - **Summary statistics:**
     - **canopy_density:** Mean, Count
     - **canopy_height:** Mean, Min, Max
     - **DBH:** Mean, Std Dev
     - **regeneration_density:** Mean
     - **disturbance_indicators:** Count (of disturbed points)
   - **Output table:** `condition_by_asset_summary.csv`

3. **Alternative (if Summarize Nearby unavailable):**
   - Use **Spatial Join** (ArcGIS) or **Distance to nearest** (QGIS):
     - Join condition points to nearest asset (within 25 m buffer)
     - Manually aggregate statistics in spreadsheet or database (e.g., Excel pivot table, R/Python)

4. **Output specification:**

| Asset_ID | Area_ha | n_points | canopy_density_mean | canopy_height_mean | DBH_mean | regeneration_density_mean | disturbance_count |
| --- | --- | --- | --- | --- | --- | --- | --- |
| MOZ_Asset_001 | 42.3 | 5 | 0.72 | 8.5 | 15.2 | 0.18 | 1 |
| MOZ_Asset_002 | 28.1 | 3 | 0.65 | 7.2 | 12.8 | 0.12 | 0 |
| MOZ_Asset_003 | 15.7 | 2 | 0.80 | 9.1 | 17.5 | 0.22 | 2 |

**Quality checks:**

- All assets represented (no missing Asset_IDs)
- n_points > 0 for each asset (if any asset has 0 points, flag for follow-up field work)
- Canopy density values between 0–1 (or 0–100% depending on units)
- Count of disturbed points ≤ n_points

---

### 3.4 Step 3: Calculate Average Condition per Total Area (Morrumbene + Save)

**Objective:** Merge all mangrove assets in both study areas and calculate ecosystem-wide condition indices.

**Process:**

1. **Dissolve/Merge all assets:**
   - Load `mangrove_assets_morrumbene_save.shp`
   - **Tool:** Dissolve (ArcGIS) / Dissolve (QGIS Vector → Geoprocessing)
   - **Dissolve field:** Leave blank (merge all polygons into single multipart polygon)
   - **Aggregate statistics:**
     - `Area_ha`: SUM
   - Output: `mangrove_assets_morrumbene_save_total.shp` (single polygon/multipart)

2. **Aggregate condition statistics:**
   - From `condition_by_asset_summary.csv`, calculate weighted means across all assets:
     - **Weighted canopy density:** Σ(canopy_density_mean × Area_ha) / Σ(Area_ha)
     - **Weighted canopy height:** Σ(canopy_height_mean × Area_ha) / Σ(Area_ha)
     - **Weighted DBH:** Σ(DBH_mean × Area_ha) / Σ(Area_ha)
     - **Weighted regeneration density:** Σ(regeneration_density_mean × Area_ha) / Σ(Area_ha)
   - Total points sampled: Σ(n_points across all assets)
   - Total disturbed points: Σ(disturbance_count)

3. **Output summary table:**

| Metric | Value | Unit |
| --- | --- | --- |
| **Total area** | 8,845.3 | ha |
| **Total field points** | 127 | count |
| **Canopy density (weighted mean)** | 0.71 | (0–1) |
| **Canopy height (weighted mean)** | 8.2 | m |
| **DBH (weighted mean)** | 14.9 | cm |
| **Regeneration density (weighted mean)** | 0.17 | plants/m² |
| **Disturbance frequency** | 18 / 127 = 14.2% | % |

---

## 4. Condition Index Normalization (0–1 Scale)

### 4.1 Standardization Formula

Convert raw condition variables to normalized indices (0 = poor; 1 = pristine) for SEEA EA reporting.

**Formula for each variable:**

```text
Normalized Index = (Value − Minimum) / (Maximum − Minimum)
```

**Reference values (updated 2026-03-16 following Phase 1 literature search; see `docs/rag/academic/BASELINE_REFERENCE_TABLE.md`):**

| Variable | Poor (Min) | Pristine (Max) | Unit | Confidence | Key Source |
| --- | --- | --- | --- | --- | --- |
| **Canopy density** | 0.3 | 0.70 | (0–1) | LOW — no East Africa empirical data found | Expert estimate (provisional; revised downward from 0.95) |
| **Canopy height** | 3.0 | **15.0** | m | HIGH | Fatoyinbo et al. 2008; Lagomasino et al. 2015; Sitoe et al. 2016 |
| **DBH (mean)** | 5.0 | 20.0 | cm | HIGH | Mwihaki et al. 2024 (Kenya); Godoy & De Lacerda 2015 (Morrumbene); Bosire et al. 2022 (Tanzania) |
| **Regeneration density** | 0.0 | 0.50 | plants/m² | LOW — species-specific (Rhizophora: 0.04–0.30/m²; Avicennia: 1–5/m²) | Patel et al. 2019 (Indo-Pacific analog) |
| **Disturbance frequency** | 0.50 | 0.0 | (inverted: 1 − raw frequency) | MEDIUM | Zockler et al. 2021 (visual scale 1–6 for Indo-W Pacific) |

**Notes:**
- Canopy height pristine reference revised from 12 m to **15 m** (Mozambique national max 27 m; Zambezi Delta tall class; Maputo Reserve LiDAR intact sites >20 m)
- DBH values are confirmed by literature: most degraded/urban Mozambique/Kenya stands average 6–9 cm; undisturbed Tanzania stands show distribution to 42 cm
- Regeneration density is highly species-dependent; apply species-specific ranges where stand composition is known
- Disturbance frequency: Score 6 on Zockler 2021 rapid visual scale corresponds to <5% plots disturbed; Score 1–2 to >50% disturbed

### 4.2 Example Normalization

**For Morrumbene + Save total area:**

| Variable | Raw Value | Min | Max | Normalized Index |
| --- | --- | --- | --- | --- |
| Canopy density | 0.71 | 0.3 | 0.70 | (0.71 − 0.3) / (0.70 − 0.3) = 1.025 → clamped to **1.00** |
| Canopy height | 8.2 | 3.0 | 15.0 | (8.2 − 3.0) / (15.0 − 3.0) = **0.43** |
| DBH | 14.9 | 5.0 | 20.0 | (14.9 − 5.0) / (20.0 − 5.0) = **0.66** |
| Regeneration density | 0.17 | 0.0 | 0.50 | (0.17 − 0.0) / (0.50 − 0.0) = **0.34** |
| Disturbance frequency | 0.142 | 0.0 | 0.50 | 1 − (0.142 / 0.50) = **0.72** |

**Composite Condition Index (mean of normalized variables):**

```text
Condition = (0.65 + 0.43 + 0.66 + 0.34 + 0.72) / 5 = 0.56
```

---

## 5. SEEA EA Condition Account Output

### 5.1 Condition Account Table

| Ecosystem Type | Geographic Unit | Condition Index | Year | Unit |
| --- | --- | --- | --- | --- |
| Mangrove Forest (MFT1.2) | Morrumbene District | 0.56 | 2025 | (0–1 scale) |
| Mangrove Forest (MFT1.2) | Save District | 0.52 | 2025 | (0–1 scale) |
| Mangrove Forest (MFT1.2) | Inhambane Province | 0.55 | 2025 | (0–1 scale) |
| Mangrove Forest (MFT1.2) | Mozambique (total) | 0.56 | 2025 | (0–1 scale) |

---

## 6. Multi-Period Extent Account (Change Detection)

### 6.1 Overview

To produce a SEEA EA multi-period extent account, compare mangrove extent between two time points (e.g., GMW 2020 baseline vs. a closing-period classification). This requires identifying areas of gain (additions) and loss (reductions) between periods.

### 6.2 Step 1: Baseline Extent (Opening Period)

**Objective:** Calculate total mangrove area from the opening-period dataset (e.g., GMW 2020), clipped to the Mozambique study area.

**Process:**

1. Clip GMW 2020 mangrove layer to study area boundary (Morrumbene + Save, or national extent)
2. Add field `area_ha` (Double); calculate geodesic area in hectares
3. Run Summary Statistics: SUM of `area_ha`
4. Output: `gmw_2020_baseline_statistics.csv`

### 6.3 Step 2: Change Detection (Erase Analysis)

**Objective:** Identify mangrove gain and loss polygons between opening and closing periods.

**Process:**

1. **Additions (areas gained by closing period):**
   - Run Erase: Input = closing-period extent; Erase feature = opening-period extent
   - Output: `Mangrove_additions.shp`
   - Add field `area_ha`; calculate geodesic area in hectares

2. **Reductions (areas lost by closing period):**
   - Run Erase: Input = opening-period extent; Erase feature = closing-period extent
   - Output: `Mangrove_reductions.shp`
   - Add field `area_ha`; calculate geodesic area in hectares

**Quality check:** Opening + Additions - Reductions should approximate Closing extent. Flag residual > 5% of net change for investigation (slivers from Erase operation and geodesic rounding).

### 6.4 Step 3: Disaggregate Additions and Reductions by Area

**Objective:** Determine where gains and losses occurred by intersecting change polygons with administrative or study area boundaries.

**Process:**

1. Intersect `Mangrove_additions.shp` with admin L3 boundaries (or study area polygons)
2. Intersect `Mangrove_reductions.shp` with admin L3 boundaries (or study area polygons)
3. Recalculate `area_ha` on intersected fragments
4. Run Summary Statistics grouped by admin unit / study area name
5. Output: `additions_by_area.csv`, `reductions_by_area.csv`

### 6.5 SEEA EA Extent Account Table

**If only one time period is available (single-period, no change detection):**

| Entry | Units | Morrumbene | Save Estuary | Totals |
| --- | --- | --- | --- | --- |
| Extent (YYYY) | ha | [value] | [value] | [value] |

**If multiple time periods are available (multi-period, with change detection):**

**Example format (single ecosystem type, multiple areas):**

| Entry | Units | Morrumbene | Save Estuary | Totals |
| --- | --- | --- | --- | --- |
| Opening (YYYY) | ha | [value] | [value] | [value] |
| Additions | ha | [value] | [value] | [value] |
| Reductions | ha | -[value] | -[value] | -[value] |
| Closing (YYYY) | ha | [value] | [value] | [value] |
| Net change | ha | [value] | [value] | [value] |
| Net change (%) | % | [value] | [value] | [value] |

**Example format (multiple ecosystem types, single area -- matches SEEA EA standard):**

| Entry | Units | Mangrove | Seagrass | Coral Reef | Other Substrate | Totals |
| --- | --- | --- | --- | --- | --- | --- |
| Opening (YYYY) | ha | [value] | [value] | [value] | [value] | [value] |
| Additions | ha | [value] | [value] | [value] | [value] | [value] |
| Reductions | ha | -[value] | -[value] | -[value] | -[value] | -[value] |
| Closing (YYYY) | ha | [value] | [value] | [value] | [value] | [value] |
| Net change | ha | [value] | [value] | [value] | [value] | [value] |
| Net change (%) | % | [value] | [value] | [value] | [value] | [value] |

**Notes:**
- Reductions are shown as negative values
- Opening + Additions + Reductions = Closing (accounting identity)
- Column structure depends on disaggregation: by ecosystem type (standard SEEA EA) or by geographic area
- Opening and closing years must be clearly labelled in row headers

### 6.6 Output Files (Multi-Period)

| File | Source step | Description |
| --- | --- | --- |
| gmw_2020_baseline_statistics.csv | Step 1 | Opening-period mangrove area (ha) |
| Mangrove_additions.shp | Step 2 | Gain polygons (areas in closing but not opening) |
| Mangrove_reductions.shp | Step 2 | Loss polygons (areas in opening but not closing) |
| additions_by_area.csv | Step 3 | Additions disaggregated by admin unit / study area |
| reductions_by_area.csv | Step 3 | Reductions disaggregated by admin unit / study area |
| mangrove_extent_change.csv | Step 3 | Multi-period SEEA EA extent account table |

Store outputs in: `Mozambique/03_outputs/` (CSVs) and `Mozambique/01_inputs/raw_data/` (shapefiles).

---

## 7. GIS Workflow Summary

### 7.1 Extent Analysis (Section 2)

```text
GMW 2020 mangrove layer
    │
    ├── Step 1: Intersect with Admin L3 boundaries
    │   └── Output: mangroves_intersect_adminL3.shp
    │
    ├── Step 2: Calculate Area_ha for each polygon
    │   └── Output: mangroves_intersect_adminL3_area.shp
    │
    └── Step 3: Summarize by Admin Unit
        └── Output: mangrove_extent_by_adminL3_summary.csv
```

**Final extent output (single-period, by admin unit):**

| Province/District | Area (ha) |
| --- | --- |
| Inhambane | 24,567 |
| Gaza | 18,345 |
| Sofala | 12,456 |
| **Total** | **55,368** |

### 7.2 Condition Analysis (Section 3)

```text
Field condition points (2025–2026 survey)
    │
    ├── Step 1a: Create asset shapefile (GMW polygons)
    │   └── Output: mangrove_assets_morrumbene_save.shp
    │
    ├── Step 2: Summarize nearby (25 m buffer)
    │   └── Output: condition_by_asset_summary.csv
    │
    └── Step 3: Aggregate to total area
        └── Output: condition_total_area_summary.csv
              (weighted by asset area)
```

**Final condition output (normalized 0–1):**

| Area | Canopy Density | Canopy Height | DBH | Regeneration | Disturbance | Composite |
| --- | --- | --- | --- | --- | --- | --- |
| Morrumbene + Save | 0.65 | 0.43 | 0.66 | 0.34 | 0.72 | **0.56** |

---

## 8. Data Quality & Limitations

### 8.1 Known Limitations

| Issue | Mitigation |
| --- | --- |
| **GMW 2020 resolution (25 m)** | Small mangrove patches (<0.25 ha) may be omitted; validate with Sentinel-2 imagery |
| **Field point distribution** | Uneven sampling across assets; use area-weighted aggregation for ecosystem-level indices |
| **Seasonal variation in canopy** | Collect field data in consistent season (dry season preferred); note survey dates |
| **Admin boundary discrepancies** | Verify boundary files with national GIS authority; flag disputed/overlapping boundaries |
| **Condition reference levels** | Min/Max values (Section 4.1) are provisional; calibrate with expert consensus |

### 8.2 Data Lineage

| Dataset | Source | Version | Access Date | Notes |
| --- | --- | --- | --- | --- |
| GMW 2020 | Global Mangrove Watch | v4.0 | 2026-03 | Primary extent source; 25 m Landsat-derived |
| Admin boundaries | Mozambique Ministry of Interior | TBD | 2026-03 | Confirm with national authority |
| Field condition points | Project surveys (2025–2026) | v1.0 | 2026-03 | 127 points in Morrumbene & Save; spatial resolution 25 m |

---

## 9. File Organization

```text
Mozambique/
├── 01_inputs/
│   ├── raw_data/
│   │   ├── GMW_2020_mangroves_raster.tif
│   │   ├── mozambique_admin_boundaries_L0-L3.shp
│   │   └── field_condition_points_2025-2026.shp
│   └── metadata/
│       └── mangrove_GIS_analysis_metadata.md
├── 02_analysis/
│   └── mangrove_extent_condition_gis.qgis  (QGIS project file)
└── 03_outputs/
    ├── mangrove_extent_by_adminL3_summary.csv
    ├── mangrove_assets_morrumbene_save.shp
    ├── condition_by_asset_summary.csv
    ├── condition_total_area_summary.csv
    └── mangrove_seea_condition_account.csv
```

---

## 10. Software Requirements

| Tool | Version | Purpose | License |
| --- | --- | --- | --- |
| **QGIS** | 3.28+ | Spatial analysis, intersect, dissolve, summarize | Open source (GPL) |
| **ArcGIS Desktop** | 10.7+ | Alternative: spatial analysis, summarize nearby | Commercial (Esri) |
| **R (optional)** | 4.0+ | Statistical aggregation, data validation | Open source |
| **Spreadsheet** (Excel, Calc) | Any | Summary table assembly, normalization | Standard |

---

## 11. Workflow Timeline & Responsibility

| Phase | Activity | Timeline | Responsibility | Deliverables |
| --- | --- | --- | --- | --- |
| **Phase 1: Data prep** | Acquire GMW, admin boundaries, field points | 2026-03 | GIS team | Input shapefiles validated |
| **Phase 2: Extent analysis** | Intersect, calculate area, summarize by admin | 2026-04 | GIS analyst | `mangrove_extent_by_adminL3_summary.csv` |
| **Phase 3: Asset creation** | Clip & label mangrove assets (Morrumbene, Save) | 2026-04 | GIS analyst | `mangrove_assets_morrumbene_save.shp` |
| **Phase 4: Condition aggregation** | Summarize nearby, calculate weighted means | 2026-05 | GIS analyst + field team | `condition_by_asset_summary.csv` |
| **Phase 5: Normalization** | Normalize to 0–1 scale, compile condition account | 2026-05 | Accounting team | `mangrove_seea_condition_account.csv` |
| **Phase 6: Reporting** | Finalize outputs, document metadata | 2026-06 | Project manager | Final SOP + data lineage |

---

## 12. References

1. Giri, C., et al. (2011). Status and distribution of mangroves of the world using earth observation satellite data. *Global Ecology and Biogeography*, 20(1), 154–159.
2. Global Mangrove Watch (2020). Mangrove extent dataset, version 4.0. [https://www.globalmangrovewatch.org/](https://www.globalmangrovewatch.org/)
3. UN SEEA EA. (2021). System of Environmental-Economic Accounting — Ecosystem Accounting. [https://seea.un.org/](https://seea.un.org/)
4. QGIS Documentation. (2024). User Guide & Processing Toolbox. [https://docs.qgis.org/](https://docs.qgis.org/)
5. Mozambique Ministry of Interior. (TBD). Administrative boundaries, levels 0–3. [Confirm source and access]

---

## 13. Technical Guidance & Best Practices

### 13.1 Projection & Coordinate System Best Practices

**Critical issue:** All spatial layers **MUST use the same coordinate reference system (CRS)** before any geoprocessing operation.

**Recommended CRS for Mozambique:**

- **WGS84 (EPSG:4326):** For global data sharing, metadata, integration with web mapping services
- **UTM Zone 36S (EPSG:32736):** For local analysis requiring precise distance/area calculations (Mozambique mainland lies primarily in UTM zones 35–37)
- **UTM Zone 37S (EPSG:32737):** For Mozambique's eastern (coastal) provinces

**Workflow:**

1. Load all input layers (GMW, admin boundaries, field points)
2. Check CRS of each layer: **Layer properties → CRS tab** (QGIS) or **Properties → Spatial Reference** (ArcGIS)
3. If CRS differs:
   - **Reproject to UTM Zone 36S** for analysis (native to Mozambique coast)
   - Export final outputs in both **UTM Zone 36S** (analysis) and **WGS84** (sharing)
4. Document CRS in all metadata files

**Validation command (QGIS Python console):**

```python
for layer in QgsProject.instance().mapLayers().values():
    print(f"{layer.name()}: {layer.crs().authid()}")
```

Expected output: All layers should show same EPSG code (e.g., EPSG:32736)

---

### 13.2 Attribute Table Naming Conventions

Follow consistent naming to avoid errors in summarization and reporting:

| Field | Data Type | Example Values | Notes |
| --- | --- | --- | --- |
| `Asset_ID` | Text (max 20 chars) | MOZ_Asset_001, MOZ_Asset_002 | Unique per mangrove polygon; prefix with region code |
| `Area_ha` | Decimal (10.2) | 42.3, 28.1 | Calculated from geometry; always positive |
| `admin_name` | Text (50 chars) | "Inhambane Province", "Morrumbene District" | Full administrative unit name |
| `admin_code` | Text (10 chars) | "MOZ_10_01" | Standardized code per national authority |
| `region` | Text (20 chars) | "Morrumbene", "Save" | Study area identifier |
| `point_count` | Integer | 5, 3, 0 | Number of condition points within 25 m |
| `canopy_density_mean` | Decimal (5.3) | 0.715, 0.642 | 0 = bare; 1 = fully closed |
| `canopy_height_mean` | Decimal (5.2) | 8.5, 7.2 | Meters above ground |
| `DBH_mean` | Decimal (5.2) | 15.2, 12.8 | Diameter at breast height, centimeters |

**Data entry checklist:**

- [ ] No spaces in field names (use underscores: `canopy_density_mean`, not `canopy density mean`)
- [ ] No special characters (@, #, $, etc.)
- [ ] Consistent decimal separator (period: 0.72, not comma: 0,72)
- [ ] All numeric fields use same precision (e.g., all areas to 2 decimal places)

---

### 13.3 Handling Common GIS Issues

#### Issue 1: "Shapefile has invalid geometry"

**Symptom:** Intersect or dissolve fails with error about self-intersecting polygons or invalid topology

**Root cause:** Mangrove or boundary polygon has overlapping edges or internal holes

**Solution:**

1. Run **Check Geometry** (QGIS Vector → Check Validity) to identify invalid features
2. Fix with **Fix Geometries** tool (QGIS) or **Repair Geometry** (ArcGIS)
3. Remove/exclude invalid polygons if unfixable
4. Re-run geoprocessing operation

**Prevention:** Always validate input shapefiles before processing

```sql
-- Validation query (if using PostGIS database):
SELECT ogc_fid FROM mangroves WHERE NOT ST_IsValid(geometry);
```

---

#### Issue 2: "Intersect output is empty"

**Symptom:** Running intersect between mangrove layer and admin boundaries produces empty result

**Root cause:** Layer CRS mismatch, or layers have no spatial overlap

**Solution:**

1. Check CRS of both inputs (must match)
2. Verify bounding boxes overlap visually: Zoom to extent of each layer in map
3. If overlap exists but output empty: run **Buffer** (QGIS) with 0.0001 degree buffer on one layer to fix minor coordinate precision errors
4. Re-run intersect

---

#### Issue 3: "Area calculations are wrong or missing"

**Symptom:** Some Area_ha values are 0 or NULL after field calculation

**Root cause:** Geometry invalid, or polygon has no area (line or point mistakenly in polygon layer)

**Solution:**

1. Filter for rows where `Area_ha = 0` or `Area_ha IS NULL`
2. Inspect geometries of those records: Right-click row → **Zoom to feature**
3. Delete invalid features or fix geometry
4. Recalculate Area_ha on corrected layer

---

### 13.4 Validation Checklist for Each Step

#### Step 1: Intersect Mangroves with Admin Boundaries

- [ ] Input mangrove layer has valid polygons (run Check Geometry)
- [ ] Input admin boundary layer has valid polygons
- [ ] Both layers in same CRS (verified with layer properties)
- [ ] Output shapefile created without errors
- [ ] Output polygon count is non-zero (expect 30–200 polygons for Mozambique)
- [ ] Spot-check: Load both input layers + output together; verify output polygons fall within boundaries
- [ ] No overlaps in output (each mangrove polygon segment assigned to exactly one admin unit)

#### Step 2: Calculate Area_ha

- [ ] New field `Area_ha` created with correct data type (Decimal)
- [ ] Calculate Geometry expression uses correct unit conversion (÷10,000 for m² → ha)
- [ ] All output rows have non-zero Area_ha values (no NULLs)
- [ ] Min area > 0.01 ha (reasonable minimum for 25 m resolution)
- [ ] Max area < 5,000 ha (sanity check; likely max single polygon is 1,000–2,000 ha)
- [ ] Sum of all Area_ha ≈ Total Mozambique mangrove extent (≈55,000–60,000 ha from GMW)

#### Step 3: Summary Statistics

- [ ] Summary Statistics tool ran without errors
- [ ] Output CSV has one row per admin unit with mangroves (not all admin units)
- [ ] Column names: `admin_name`, `AREA_HA_SUM`, `COUNT`
- [ ] AREA_HA_SUM values all positive and realistic (>10 ha for meaningful units)
- [ ] COUNT matches number of polygons per admin (spot-check 2–3 rows manually)
- [ ] Total AREA_HA_SUM across all rows matches input layer total

#### Steps 2a–2b: Asset Creation & Condition Summary

- [ ] Mangrove assets shapefile created with unique Asset_ID for each polygon
- [ ] Field condition points layer loaded and verified (n ≈ 100–150 expected)
- [ ] Spatial join or summarize nearby executed without errors
- [ ] Output table has one row per asset with condition statistics
- [ ] For each asset: `n_points > 0` (if any asset has 0 points, flag for follow-up field work)
- [ ] Mean values are within expected range (e.g., canopy density 0–1, height 2–15 m)
- [ ] No NULLs in summary fields

---

### 13.5 Documenting Your Analysis

**For reproducibility, save the following with final outputs:**

**GIS Project File:**

- Save QGIS project (.qgis file) or ArcGIS map document (.mxd/.aprx) with:
  - All layers, their CRS, and styling
  - Geoprocessing tool parameters (tool history or script)
  - Annotation of key analysis steps

**Processing Log (plain text or markdown):**

```markdown
# Mangrove Extent & Condition Analysis Log

## Date: 2026-04-15
## Analyst: [Your name]

### Step 1: Intersect
- Tool: QGIS Vector → Geoprocessing → Intersection
- Input 1: mangroves_gmw_2020.shp (n=4,562 polygons)
- Input 2: mozambique_admin_L3.shp (n=85 admin units)
- CRS: EPSG:32736 (UTM Zone 36S)
- Output: mangroves_intersect_adminL3.shp (n=1,247 polygons)
- Time: 12 min 34 sec
- Memory: Peak 1.2 GB

### Step 2: Area Calculation
- Field added: Area_ha (Decimal, 10.2)
- Expression: $area / 10000
- Output: mangroves_intersect_adminL3_area.shp
- Validation: Min=0.02 ha, Max=1,845.3 ha, Sum=55,234.6 ha

### Step 3: Summary Statistics
- Tool: QGIS Vector → Geoprocessing → Dissolve (with SUM aggregation)
- Group by: admin_name
- Output rows: 47 (admin units with mangroves)
- Output: mangrove_extent_by_adminL3_summary.csv

[Continue for remaining steps...]

## Issues Encountered
- None

## Validation Status
- [x] All steps completed
- [x] Output files validated
- [x] Metadata documented
```

**README file for outputs:**

```markdown
# Mangrove Extent & Condition Analysis Outputs

## Files
- mangrove_extent_by_adminL3_summary.csv — Main extent output
- mangrove_assets_morrumbene_save.shp — Asset shapefile
- condition_by_asset_summary.csv — Condition statistics per asset
- condition_total_area_summary.csv — Ecosystem-level condition

## Projections
- All shapefiles in EPSG:32736 (UTM Zone 36S)
- CSV files reference geographic location by admin_name, not coordinates

## Data Quality
- Extent data: Confidence HIGH (GMW 2020 is standard reference)
- Condition data: Confidence MODERATE (127 field points; see point_count column)

## How to Use
1. For reporting mangrove area by province: Use mangrove_extent_by_adminL3_summary.csv
2. For detailed asset-level condition: Use condition_by_asset_summary.csv
3. For spatial mapping: Use mangrove_assets_morrumbene_save.shp in QGIS/ArcGIS
```

---

## 14. Troubleshooting & Common Questions

**Q: How do I know if my admin boundary file is correct?**

A: Download official boundaries from [Mozambique Ministry of Interior](http://www.moci.gov.mz). Cross-reference with existing national maps (e.g., OpenStreetMap or Mapit). Compare polygon counts and names with official administrative divisions.

**Q: Can I use raster GMW (not vector polygons)?**

A: Yes, but requires extra step:

1. Rasterize admin boundaries to 25 m grid (matching GMW resolution)
2. Use raster calculator to sum mangrove pixels per admin unit
3. Convert back to vector for reporting

(Vector approach in this SOP is simpler and preferred.)

**Q: The "Summarize Nearby" tool isn't available in my QGIS version.**

A: Use alternative:

1. Run **Spatial Join** (QGIS Vector → Spatial Join) to attach nearest asset to each condition point
2. In spreadsheet, pivot table to summarize by Asset_ID and calculate means

**Q: My field condition points are GPS coordinates (lat/lon) in a CSV file. How do I convert to shapefile?**

A: In QGIS:

1. Vector → Create Layer → Delimited Text (or use Menu → Layer → Create Layer from Text)
2. Load CSV, specify X field (longitude), Y field (latitude)
3. Set CRS to WGS84 (EPSG:4326)
4. Right-click layer → Export as Shapefile (reproject to UTM Zone 36S if needed)

**Q: Should I use 25 m or 100 m buffer for "Summarize Nearby"?**

A: Use 25 m (matches GMW raster resolution; condition points should fall near asset boundaries). If field team reports GPS uncertainty >25 m, increase to 50 m but document in metadata.

---

## 15. Integration with Madagascar Skills Library

This Mozambique SOP follows the same methodology structure as:

- **skill_condition_measurement_m13_reef.md** (Madagascar coral reef condition)
- **skill_extent_measurement_m13_reef.md** (Madagascar coral reef extent)

**Key differences:**

- Madagascar focus: Coral reef (M1.3, submarine)
- Mozambique focus: Mangrove forest (MFT1.2, intertidal)
- Both use 25 m spatial resolution for condition points
- Both normalize condition to 0–1 scale
- Both integrate extent + condition into SEEA EA accounting tables

**Cross-project learning:**

- Use same projection standards (UTM local zone + WGS84 export)
- Use same attribute naming conventions
- Use same validation checklists

---

## 16. Change Log

| Date | Version | Changes | Author |
| --- | --- | --- | --- |
| 2026-03-15 | 1.0 | Initial SOP draft | Claude Code |
| 2026-03-15 | 1.1 | Expanded with technical guidance, troubleshooting, validation checklists | Claude Code |
| 2026-03-15 | 1.2 | Fixed markdown formatting, corrected section numbering, wrapped URLs | Claude Code |
| 2026-03-16 | 1.3 | Updated canopy height pristine max 12.0 m → 15.0 m (Phase 1 literature: Fatoyinbo 2008, Lagomasino 2015, Sitoe 2016); recalculated example normalization (0.58 → 0.43) and composite index (0.59 → 0.56) in Sections 4.2, 5.1, 6.2; updated validation checklist height range | Claude Code |
| 2026-03-28 | 1.4 | Added Section 6: Multi-period extent account (change detection workflow, Erase analysis, additions/reductions by area); added SEEA EA extent account table format (single-period and multi-period templates); renumbered sections 7-16 | Claude Code |

---

**Last updated:** 2026-03-15
**Customised by:** Claude Code for AFRICA–Mozambique project
**Geographic focus:** Mangrove forests (MFT1.2); Morrumbene & Save Estuary (condition subset); provincial extent (admin level 3)
**Framework:** UN SEEA EA Ecosystem Accounting
**Recommended tools:** QGIS 3.28+ (open source) or ArcGIS 10.7+ (commercial)
**Typical analysis time:** 4–6 weeks (data prep + analysis + validation)
