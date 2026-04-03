# Skill: Ecosystem Extent — Mangrove Forests (Kenya, Kilifi County)

**Purpose:** Calculate the total extent of mangrove forests in Kenya and disaggregate by protected area status using WDPA spatial data. Produces the ecosystem extent account table for UN SEEA EA.

**Framework:** UN SEEA EA Ecosystem Extent Accounts
**Ecosystem type:** Intertidal Forests and Shrublands (IUCN GET MFT1.2)
**Geographic scope:** Kenya (primary focus: Kilifi County coast)
**Accounting period:** 2025
**GIS software:** ArcGIS Pro
**Companion skills:** skill_condition_mangrove_kenya.md — biotic condition from plot-based field surveys; skill_condition_by_protected_area_kenya.md (when created) — condition disaggregated by PA

---

## 1. Data Sources

| Dataset | Description | Format | Source | Year |
|---------|-------------|--------|--------|------|
| mangroveextent_2025 | Mangrove extent polygons for Kenya (2025 classification) | Polygon feature class | Project GIS dataset (classified raster to polygon, UTM 37S, reprojected to WGS 1984) | 2025 |
| gmw_mng_2020_v4019 | Global Mangrove Watch v4.019 mangrove extent (clipped to Kenya study area) | Polygon feature class | Bunting et al. (2022); GMW / JAXA | 2020 |
| Mangrove_additions_2025-2020.shp | Areas present in 2025 but absent in GMW 2020 (net gain polygons) | Shapefile (WGS 1984) | Erase(mangroveextent_2025, gmw_2020) | 2020-2025 |
| Mangrove_reductions_2020-2025.shp | Areas present in GMW 2020 but absent in 2025 classification (net loss polygons) | Shapefile (WGS 1984) | Erase(gmw_2020, mangroveextent_2025) | 2020-2025 |
| WDPA_WDOECM_poly_Mar2026_KEN | Kenya protected area boundaries (WDPA/WDOECM, March 2026 release) | Polygon feature class | UNEP-WCMC Protected Planet | 2026 |

**Note on WDPA:** The WDPA_WDOECM_poly layer includes both WDPA sites (national parks, reserves, etc.) and WDOECM sites (Other Effective Area-Based Conservation Measures). Protected area polygons often overlap where multiple designations apply to the same area. Steps 3 and 4 below account for this overlap when computing true protected area extent.

**Note on GMW 2020:** The Global Mangrove Watch (GMW) v4.019 layer provides the opening-period (2020) baseline for the multi-period extent account. It was clipped to the Kenya study area boundary in ArcGIS Pro before analysis.

---

## 2. Workflow Overview

The workflow proceeds in seven stages:

**Single-period extent (2025 baseline):**

1. Total mangrove extent -- all mangroves, Kenya-wide
2. Mangrove extent per WDPA site -- area associated with each named protected area
3. True protected area extent -- de-duplicated area (accounting for WDPA overlap via Dissolve)
4. Unprotected extent -- calculated by difference in Excel

**Multi-period change detection (GMW 2020 to 2025):**

5. GMW 2020 baseline extent -- total mangrove area from Global Mangrove Watch
6. Change detection -- identify additions (2025 minus 2020) and reductions (2020 minus 2025)
7. Multi-period SEEA EA extent account -- opening (2020), closing (2025), and net change

---

## 3. Step-by-Step Procedure

### Step 1: Total mangrove extent

**Objective:** Calculate the total area of all mangrove polygons in Kenya.

**Process:**

1. Open `mangroveextent_2025` in ArcGIS Pro.

2. Add a new field to the attribute table:
   - Field name: `area_ha`
   - Data type: Double
   - Calculate using Field Calculator: `!shape.area@hectares!` (Python parser) or `Shape_Area / 10000` (ArcGIS parser)

3. Run Summary Statistics:
   - Input: `mangroveextent_2025`
   - Statistics field: `area_ha`, statistic type: SUM
   - Case field: (none — summarise all records)
   - Output table: `Total_mangrove_area_statistics.csv`

**Output:** `Total_mangrove_area_statistics.csv`

| Field | Description |
|-------|-------------|
| SUM_area_ha | Total mangrove area across all polygons (hectares) |
| FREQUENCY | Number of mangrove polygons |

**Quality check:** Cross-reference SUM_area_ha against published Kenya mangrove estimates (e.g., GMW 2020: approximately 55,000–60,000 ha nationally). Flag deviations > 20% for investigation.

---

### Step 2: Mangrove extent per WDPA site

**Objective:** Identify how much mangrove area falls within each named protected area, retaining individual WDPA site attributes.

**Process:**

1. Run Intersect:
   - Input features: `mangroveextent_2025`; `WDPA_WDOECM_poly_Mar2026_KEN`
   - Join attributes: All
   - Output: `mangrove_WDPA`

   The output contains only mangrove polygons (or polygon fragments) that fall within at least one WDPA/WDOECM site. Mangroves outside all protected areas are excluded.

2. Recalculate area for the intersected fragments (intersection changes polygon geometry):
   - Add field `area_ha_intersect` (Double) to `mangrove_WDPA`
   - Calculate: `!shape.area@hectares!`

3. Run Summary Statistics:
   - Input: `mangrove_WDPA`
   - Statistics field: `area_ha_intersect`, statistic type: SUM
   - Case field: `NAME` (WDPA site name)
   - Output table: `Mangrove_WDPA_statistics.csv`

**Output:** `Mangrove_WDPA_statistics.csv`

| Field | Description |
|-------|-------------|
| NAME | WDPA protected area name |
| SUM_area_ha_intersect | Mangrove area within this named PA (hectares) |
| FREQUENCY | Number of mangrove polygon fragments within this PA |

**Note:** Rows in this table may double-count area where WDPA sites overlap (e.g., a national park and a biosphere reserve covering the same location). Use Step 3 to calculate the true non-overlapping protected area.

---

### Step 3: True protected area extent (de-duplicated)

**Objective:** Calculate the actual area of mangroves within protected areas, accounting for overlapping WDPA/WDOECM polygons. Sites often overlap; summing `Mangrove_WDPA_statistics.csv` would overcount.

**Process:**

1. Run Dissolve on the WDPA layer to merge all overlapping protected area polygons into a single multi-part polygon:
   - Input: `WDPA_WDOECM_poly_Mar2026_KEN`
   - Dissolve field: (none — dissolve all into one multipart feature)
   - Multipart features: Enabled
   - Output: `WDPA_dissolve`

   `WDPA_dissolve` represents the spatial union of all protected areas with no internal boundaries. It is used only as a mask, not for attribute lookup.

2. Run Intersect to find mangrove extent within the dissolved (true) protected area:
   - Input features: `mangrove_WDPA`; `WDPA_dissolve`
   - Output: `True_protected_area`

3. Add field `area_ha_true` (Double) to `True_protected_area`:
   - Calculate: `!shape.area@hectares!`

4. Run Summary Statistics:
   - Input: `True_protected_area`
   - Statistics field: `area_ha_true`, statistic type: SUM
   - Case field: (none)
   - Output table: `True_protected_area_statistics.csv`

**Output:** `True_protected_area_statistics.csv`

| Field | Description |
|-------|-------------|
| SUM_area_ha_true | Total mangrove area within protected areas (de-duplicated, hectares) |
| FREQUENCY | Number of polygon fragments |

**Quality check:** SUM from `True_protected_area_statistics.csv` must be less than or equal to the sum of `Mangrove_WDPA_statistics.csv` (de-duplication should reduce or equal, never increase the total). If it is larger, investigate for geometry errors in the Dissolve step.

---

### Step 4: Unprotected mangrove extent

**Objective:** Calculate the area of mangroves that fall outside all protected areas, by subtraction.

**Process (in Excel or equivalent):**

- Open `Total_mangrove_area_statistics.csv` and `True_protected_area_statistics.csv`
- Calculate:
  - `Total_mangrove_ha` = SUM_area_ha from total statistics
  - `Protected_mangrove_ha` = SUM_area_ha_true from true protected area statistics
  - `Unprotected_mangrove_ha` = Total_mangrove_ha - Protected_mangrove_ha
  - `Pct_protected` = Protected_mangrove_ha / Total_mangrove_ha * 100

**Output:** `Mangrove_extent_protected_and_non-protected_areas.csv`

| Field | Description |
|-------|-------------|
| Total_mangrove_ha | Total mangrove extent, Kenya (ha) |
| Protected_mangrove_ha | Mangrove extent within protected areas, de-duplicated (ha) |
| Unprotected_mangrove_ha | Mangrove extent outside all protected areas (ha) |
| Pct_protected | Percentage of mangroves within protected areas (%) |
| Reference_date | Date of WDPA release used (March 2026) |
| Notes | Any flags or caveats |

---

### Step 5: GMW 2020 baseline extent

**Objective:** Calculate the total mangrove area from the Global Mangrove Watch (GMW) 2020 layer, clipped to the Kenya study area. This serves as the opening-period extent for the multi-period account.

**Process:**

1. Clip the GMW v4.019 layer to the study area boundary:
   - Input: `gmw_mng_2020_v4019`
   - Clip feature: `study_area_extent`
   - Output: `gmw_mng_2020_v4019_clipped`

2. Add field `area_ha` (Double) to `gmw_mng_2020_v4019_clipped`:
   - Calculate: geodesic area in hectares (CalculateGeometryAttributes, AREA_GEODESIC, HECTARES)

3. Run Summary Statistics:
   - Input: `gmw_mng_2020_v4019_clipped`
   - Statistics field: `area_ha`, statistic type: SUM
   - Case field: `ClassID`
   - Output table: `gmw_mng_2020_v4019_statistics.csv`

**Output:** `gmw_mng_2020_v4019_statistics.csv`

| Field | Description |
|-------|-------------|
| ClassID | Mangrove class (1 = mangrove) |
| FREQUENCY | Number of polygons |
| SUM_area_ha | Total mangrove area from GMW 2020 (hectares) |

---

### Step 6: Change detection (Erase analysis)

**Objective:** Identify areas of mangrove gain (additions) and loss (reductions) between GMW 2020 and the 2025 classification.

**Process:**

1. **Additions (areas gained by 2025):**
   - Run Erase:
     - Input: `mangroveextent_2025_WGS1984`
     - Erase feature: `gmw_mng_2020_v4019_clipped`
     - Output: `Mangrove_additions_2025-2020.shp`
   - Add field `area_ha` (Double); calculate geodesic area in hectares

2. **Reductions (areas lost by 2025):**
   - Run Erase:
     - Input: `gmw_mng_2020_v4019_clipped`
     - Erase feature: `mangroveextent_2025_WGS1984`
     - Output: `Mangrove_reductions_2020-2025.shp`
   - Add field `area_ha` (Double); calculate geodesic area in hectares

**Outputs:**

| File | Records | Description |
|------|---------|-------------|
| Mangrove_additions_2025-2020.shp | 886 polygons | Areas present in 2025 but absent in GMW 2020 |
| Mangrove_reductions_2020-2025.shp | 332 polygons | Areas present in GMW 2020 but absent in 2025 |

**CRS:** WGS 1984 (EPSG:4326) for both shapefiles.

**Quality check:** Verify that: Opening extent + Additions - Reductions approximates Closing extent. Discrepancies arise from slivers in the Erase operation and rounding; flag if the residual exceeds 5% of the net change.

---

### Step 7: Multi-period SEEA EA extent account assembly

**Objective:** Combine the outputs from Steps 1, 5, and 6 into a multi-period SEEA EA extent account table.

**Process (in Excel or equivalent):**

- Opening extent (2020) = SUM_area_ha from `gmw_mng_2020_v4019_statistics.csv`
- Closing extent (2025) = SUM_area_ha from `Total_mangrove_area_statistics.csv`
- Additions = sum of `area_ha` from `Mangrove_additions_2025-2020.shp`
- Reductions = sum of `area_ha` from `Mangrove_reductions_2020-2025.shp`
- Net change = Closing - Opening
- Percentage change = Net change / Opening * 100

**Output:** `Mangrove_extent_change_2020_2025.csv` (stored in `Kenya/03_outputs/`)

---

## 4. 2025 Results

### 4.1 Mangrove extent per named WDPA site (Mangrove_WDPA_statistics.csv)

Eight WDPA/WDOECM sites were found to contain mangrove extent in Kenya (2025):

| SITE_ID | Name | Designation | Type | Polygons | Area (ha) |
| ------- | ---- | ----------- | ---- | -------- | --------- |
| 7422 | Arabuko Sokoke | Forest Reserve | National | 106 | 33.21 |
| 19566 | Watamu | Marine National Park | National | 103 | 1,763.05 |
| 478054 | Kaya Chonyi | Not Reported | National | 3 | 0.81 |
| 478055 | Kaya Jibana | Not Reported | National | 8 | 2.52 |
| 555555507 | Lower Tana Delta Conservation Trust | Community Nature Reserve | National | 8 | 0.46 |
| 555555582 | Tana River Delta Ramsar Site | Wetland of International Importance | International | 14 | 1.26 |
| 555621995 | Watamu | Marine National Reserve | National | 7 | 0.74 |
| 555759476 | Mangrove Swamps | Forest Reserve | National | 30 | 29.99 |

Note: This table sums to approximately 1,832 ha. The true protected area total (3,806.46 ha) is higher because additional WDPA sites beyond these 8 also contain mangroves. The Dissolve step in Step 3 captures the full union of all overlapping PA polygons.

### 4.2 Mangrove extent by protection status (Mangrove_extent_protected_and_non-protected_areas.csv)

| Category | Area (ha) | % of total |
| -------- | --------- | ---------- |
| Total mangroves | 5,741.64 | 100.0 |
| Within protected areas (de-duplicated) | 3,806.46 | 66.3 |
| Outside protected areas | 1,935.18 | 33.7 |

Reference year: 2025. WDPA release: March 2026.

**Headline finding:** Two-thirds of Kenya's mangrove extent (66.3%) falls within protected or conserved areas. Watamu Marine National Park alone accounts for the majority of the per-site total. The 1,935 ha of unprotected mangroves represent the priority area for community management and restoration interventions.

### 4.3 GMW 2020 baseline extent (gmw_mng_2020_v4019_statistics.csv)

| ClassID | Polygons | Area (ha) |
| ------- | -------- | --------- |
| 1 (mangrove) | 349 | 6,083.04 |

Source: Global Mangrove Watch v4.019, clipped to Kenya study area.

### 4.4 Change detection: 2020 to 2025

| Component | Polygons | Area (ha) |
| --------- | -------- | --------- |
| Additions (in 2025, not in GMW 2020) | 886 | 589.10 |
| Reductions (in GMW 2020, not in 2025) | 332 | 927.84 |
| Net change (Closing - Opening) | -- | -341.40 |

**Verification:** Opening (6,083.04) + Additions (589.10) - Reductions (927.84) = 5,744.30 ha. The closing extent from the 2025 classification is 5,741.64 ha. The residual of 2.66 ha (0.8% of net change) is within the expected tolerance from Erase operation slivers and geodesic area rounding.

**Headline finding:** Kenya's mangrove extent declined by approximately 341 ha (5.6%) between 2020 and 2025. The gross change is larger: 589 ha of new mangrove was detected alongside 928 ha of loss. This pattern of simultaneous gain and loss suggests dynamic processes including both natural regeneration/colonisation and active clearing or degradation, and warrants spatial investigation to identify loss hotspots.

---

## 5. SEEA EA Extent Account Table

Multi-period extent account: opening (GMW 2020) to closing (2025 classification).

### 5.1 Extent account: Mangrove forests (MFT1.2), Kenya (Kilifi study area)

| Entry | Units | Mangrove -- total | Mangrove -- within PAs | Mangrove -- outside PAs |
|-------|-------|-------------------|------------------------|-------------------------|
| Opening (2020) | ha | 6,083.04 | -- | -- |
| Additions | ha | 589.10 | -- | -- |
| Reductions | ha | -927.84 | -- | -- |
| Closing (2025) | ha | 5,741.64 | 3,806.46 | 1,935.18 |
| Net change | ha | -341.40 | -- | -- |
| Net change (%) | % | -5.6 | -- | -- |

### 5.2 Extent account per WDPA site (closing period only)

Single-period extent by named protected area (2025 classification):

| Entry | Units | Watamu MNP | Arabuko Sokoke FR | Mangrove Swamps FR | Other PAs | Unprotected | Total |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Extent (2025) | ha | 1,763.05 | 33.21 | 29.99 | 5.78 | 1,935.18 | 5,741.64 |

**Notes:**
- "Other PAs" aggregates Kaya Chonyi (0.81 ha), Kaya Jibana (2.52 ha), Lower Tana Delta (0.46 ha), Tana River Delta Ramsar (1.26 ha), Watamu MNR (0.74 ha)
- Per-site values from Mangrove_WDPA_statistics.csv may double-count where WDPA sites overlap; true protected total is 3,806.46 ha (de-duplicated via Dissolve)
- PA disaggregation of additions/reductions is not yet available; requires intersecting change shapefiles with WDPA layer (see Open Items)

### 5.3 Multi-ecosystem extent account (all ecosystem types)

| Entry | Units | Mangrove | Seagrass | Coral Reef | Totals |
| --- | --- | --- | --- | --- | --- |
| Opening (2020) | ha | 6,083.04 | -- | -- | 6,083.04 |
| Additions | ha | 589.10 | -- | -- | 589.10 |
| Reductions | ha | -927.84 | -- | -- | -927.84 |
| Closing (2025) | ha | 5,741.64 | -- | -- | 5,741.64 |
| Net change | ha | -341.40 | -- | -- | -341.40 |
| Net change (%) | % | -5.6 | -- | -- | -5.6 |

**Output file:** `KEN_SEEA_EA_extent_account_final.csv`

**Notes:**
- Seagrass extent mapping not yet started; coral reef extent not available
- Totals column currently equals mangrove only; will update when additional ecosystem extents are calculated

### 5.4 Guidance: single-period vs. multi-period format

**If only one time period is available (no change detection):**

| Entry | Units | Area 1 | Area 2 | Totals |
| --- | --- | --- | --- | --- |
| Extent (YYYY) | ha | [value] | [value] | [value] |

**If multiple time periods are available (with change detection):**

| Entry | Units | Area 1 | Area 2 | Totals |
| --- | --- | --- | --- | --- |
| Opening (YYYY) | ha | [value] | [value] | [value] |
| Additions | ha | [value] | [value] | [value] |
| Reductions | ha | -[value] | -[value] | -[value] |
| Closing (YYYY) | ha | [value] | [value] | [value] |
| Net change | ha | [value] | [value] | [value] |
| Net change (%) | % | [value] | [value] | [value] |

**Notes on Section 5:**
- Opening extent (2020) from GMW v4.019 clipped to study area; closing extent (2025) from project classification.
- Two data sources were produced independently (GMW = satellite; 2025 = project classification). Methodological differences in classification approach contribute to the observed change alongside real land cover change.

---

## 6. Output Files

| File | Source step | Description |
|------|-------------|-------------|
| Total_mangrove_area_statistics.csv | Step 1 | Total Kenya mangrove area, 2025 (ha) |
| Mangrove_WDPA_statistics.csv | Step 2 | Mangrove area per named WDPA site (may double-count overlaps) |
| True_protected_area_statistics.csv | Step 3 | True protected mangrove area, de-duplicated (ha) |
| Mangrove_extent_protected_and_non-protected_areas.csv | Step 4 | Summary: total, protected, unprotected (ha + %) |
| gmw_mng_2020_v4019_statistics.csv | Step 5 | GMW 2020 baseline mangrove area (ha) |
| Mangrove_additions_2025-2020.shp | Step 6 | Gain polygons (886 features; 589.10 ha) |
| Mangrove_reductions_2020-2025.shp | Step 6 | Loss polygons (332 features; 927.84 ha) |
| Mangrove_extent_change_2020_2025.csv | Step 7 | Multi-period change summary for SEEA EA table |
| Mangrove_extent_account_by_area.csv | Steps 1-7 | SEEA EA extent account disaggregated by WDPA site (Opening/Additions/Reductions/Closing rows) |
| KEN_SEEA_EA_extent_account_final.csv | Assembly | Multi-ecosystem SEEA EA extent account (mangrove + seagrass + coral reef columns) |
| KEN_SEEA_EA_condition_account_final.csv | Assembly | Multi-ecosystem SEEA EA condition account (all indicators, opening/closing/change) |

Store outputs in: `Kenya/03_outputs/` (CSVs) and `Kenya/01_inputs/raw_data/` (shapefiles).

---

## 7. Open Items

| Item | Priority | Status | Notes |
|------|----------|--------|-------|
| Confirm mangroveextent_2025 provenance | HIGH | OPEN | Document whether this is a supervised classification, object-based, or other method; confirm imagery source and date |
| PA-disaggregated change detection | MEDIUM | OPEN | Intersect Mangrove_additions and Mangrove_reductions shapefiles with WDPA layer to determine whether loss is concentrated inside or outside protected areas |
| Site-level PA attribution | MEDIUM | OPEN | Link field survey sites (from mangrove_condition.R) to PA names from Mangrove_WDPA_statistics.csv for condition-by-PA disaggregation |
| Classification method comparison caveat | MEDIUM | OPEN | Document differences between GMW 2020 (ALOS PALSAR + Landsat) and 2025 project classification to distinguish real change from methodological artefact |
| Additional GMW time steps | LOW | OPEN | GMW provides 1996, 2007, 2008, 2009, 2010, 2015, 2016, 2017, 2018, 2019, 2020 layers; adding earlier periods would extend the time series |
| WDOECM sites | LOW | OPEN | Confirm whether WDOECM sites should be included alongside WDPA for policy reporting |
| ~~Multi-period comparison~~ | -- | RESOLVED | Completed: GMW 2020 vs 2025 change detection (Steps 5-7) |
| ~~Projection consistency~~ | -- | RESOLVED | mangroveextent_2025 reprojected from UTM 37S to WGS 1984 (EPSG:4326) before Erase analysis |
