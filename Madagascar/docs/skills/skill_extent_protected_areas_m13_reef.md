# Standard Operating Procedures: Extent & Protected Areas Analysis
## Madagascar Coral Reef (M1.3) — Customized for 2025–2026 Accounts

**Framework:** SEEA EA Ecosystem Extent Accounts (Protected Area Assessment)
**Ecosystem Type:** Photic Coral Reefs (M1.3)
**Geographic Scope:** Southwest Madagascar coastal zone (WDPA-delineated protected areas)
**Accounting Period:** 2025–2026
**Analysis Tool:** ArcGIS Pro (with Excel for summary statistics)

---

## 1. Overview

Protected area extent analysis quantifies the spatial distribution of ecosystem assets (coral reef, seagrass) within and outside designated protected areas (PAs). This SOP identifies:

1. **Which sampling sites** (fish, invertebrate) overlap with WDPA polygons (Protected Areas)
2. **Reef and seagrass extent** disaggregated by individual PA
3. **Total ecosystem extent** across three categories:
   - Within protected areas (true PA coverage, dissolved)
   - Outside protected areas
   - Grand total for the accounting area

**Key Deliverables:**

| Deliverable | Format | Purpose |
|---|---|---|
| Sites in PAs table | CSV | Links fish/invertebrate sample sites to PA names/IDs |
| Extent per PA | CSV | Coral reef and seagrass area (ha) for each overlapping PA |
| Ecosystem extent summary | CSV | Total extent by land cover class and PA status (protected vs. unprotected) |
| Map layers | Shapefile/GeoJSON | Visualizations of sites, extent, and PA boundaries |

**Note:** WDPA polygons often overlap; extent per PA sums to more than total ecosystem extent (they are "per PA," not additive).

---

## 2. Data Sources & Preparation

### 2.1 Input Datasets

| Dataset | Source | Format | Status | Notes |
|---|---|---|---|---|
| **Fish UVC sites** | `Madagascar/01_inputs/metadata/Fishdata_OASIS_M_metadata.md` | CSV (lat/lon) | ✅ Ready | 27 sites, 85 stations; stored as `fish_invert_site_condition.csv` or extract from raw Excel |
| **Invertebrate sites** | `Madagascar/01_inputs/metadata/Invertebrate_0ASIS_M_metadata.md` | CSV (lat/lon) | ✅ Ready | Same 27 sites as fish data; COTS, urchin, clam sampling |
| **Benthic extent** | Yves Amoros shapefile (Sentinel-2 derived) | Shapefile | ⚠️ Confirm with provider | Classified raster or polygon map (coral reef, seagrass, sand, etc.) |
| **WDPA polygons** | WDPA download (https://www.protectedplanet.net/) | Shapefile | ✅ Download before starting | World Database of Protected Areas; filter for Madagascar SW coast |
| **Coastline / bathymetry** | GEBCO 2023 or OSM | Raster/Vector | ✅ Reference | For defining accounting area boundary |

### 2.2 Data Preparation Checklist

**Step 1: Extract and deduplicate site coordinates**
- [ ] Extract fish UVC coordinates (lat/lon) from raw Excel or metadata CSV
- [ ] Extract invertebrate coordinates (lat/lon)
- [ ] **Remove duplicate coordinates:** Many UVC sites have multiple transects at the same location
  - Expected result: ~27 unique site locations (not 85 stations)
  - Method: Use ArcGIS Pro "Delete Identical" tool or spreadsheet pivot/distinct operation

**Step 2: Prepare extent data**
- [ ] Confirm benthic extent shapefile/raster from Yves Amoros Mitondrasoa
- [ ] If raster: convert to polygon and classify by habitat (coral, seagrass, sand, etc.)
- [ ] If polygon: verify habitat attributes (Name field should contain "coral reef" and/or "seagrass")
- [ ] **Add area_ha field:** Create new field to calculate area in hectares for each polygon

**Step 3: Prepare WDPA data**
- [ ] Download WDPA shapefile from Protected Planet (https://www.protectedplanet.net/download)
- [ ] Filter to Madagascar region (attribute query: Country = "Madagascar")
- [ ] Further filter to southwest coastal region (spatial query: intersect with accounting area)
- [ ] Keep fields: WDPAID, NAME, DESIG, IUCN_CAT, STATUS_YR
- [ ] Verify projection: Convert all layers to WGS84 (EPSG:4326) or consistent local zone

**Step 4: Define accounting area boundary**
- [ ] Use 25 m depth contour (from bathymetric data) as seaward limit
- [ ] Use coastline (GEBCO or OSM) as landward limit
- [ ] Create bounding polygon for SW Madagascar accounting area (or use existing project boundary)
- [ ] Clip all datasets to this boundary

---

## 3. Protected Area Site Assignment (ArcGIS Pro Workflow)

### 3.1 Create XY Event Layer from Site Coordinates

**Objective:** Convert site lat/lon into spatial points and assign PA membership.

**Steps in ArcGIS Pro:**

1. **Import site coordinate data**
   - Open ArcGIS Pro → New map project
   - Add data: CSV file with site coordinates (fish_sites.csv, invert_sites.csv, or combined)
   - Columns required: `site_name` (or ID), `latitude`, `longitude` (or `lat`, `lon`)

2. **Create XY Event Layer**
   - Data tab → Display XY Data
   - Select coordinate columns: X = longitude, Y = latitude
   - Coordinate system: WGS84 (EPSG:4326)
   - Output: Event layer (temporary; right-click → Export Feature Class to save as permanent shapefile)
   - Name: `fish_sites_xy.shp` and `invert_sites_xy.shp` (or combined `all_sites_xy.shp`)

3. **Set projection**
   - Verify all layers (XY sites, WDPA, extent) are in WGS84 or same projection
   - Project → Define Projection if needed

4. **Visual check: Display sites**
   - Zoom to SW Madagascar coastline
   - Confirm 27 site points are visible and within expected region
   - Remove obvious errors (e.g., points in ocean > 25 m depth, or on land)

### 3.2 Spatial Join: Sites to WDPA Polygons

**Objective:** For each site, identify which PA(s) it overlaps with (if any).

**Steps in ArcGIS Pro:**

1. **Spatial join (one-to-one)**
   - Select site layer (e.g., `all_sites_xy.shp`)
   - Analysis tab → Spatial Join
   - Target features: Site points
   - Join features: WDPA polygons
   - Join operation: **ONE_TO_MANY** (to capture overlapping PAs)
   - Match option: INTERSECTS
   - Output name: `sites_with_pa.shp`

2. **Output table structure**
   - Expected columns in output:
     - `site_id` / `site_name` (from original site data)
     - `latitude`, `longitude`
     - `WDPAID` (from WDPA)
     - `NAME` (PA name from WDPA)
     - `DESIG` (PA designation from WDPA, e.g., "National Park")
     - `Join_Count` (number of PAs each site intersects; = 0 if outside all PAs)

3. **Export to CSV**
   - Right-click output → Export Table → CSV
   - Save as: `Madagascar/02_analysis/sites_protected_area_assignment.csv`

### 3.3 Summary: Sites in Protected Areas

**Objective:** Identify which sites fall within PA boundaries.

**Steps in spreadsheet (Excel or R):**

1. Open `sites_protected_area_assignment.csv`
2. Create summary:
   - **Total sites sampled:** Row count (should be ~27 unique sites or 85 stations depending on input)
   - **Sites in PAs:** Count rows where `WDPAID` is NOT NULL and `Join_Count` > 0
   - **Sites outside PAs:** Count rows where `WDPAID` is NULL or `Join_Count` = 0

**Example output:**

| Metric | Count |
|---|---|
| Total sites sampled | 27 |
| Sites within ≥1 PA | 18 |
| Sites outside all PAs | 9 |
| Overlap: Sites in multiple PAs | 3 |

**Save as:** `Madagascar/03_outputs/sites_pa_summary.csv`

---

## 4. Reef & Seagrass Extent per Protected Area

### 4.1 Calculate Area Field (Hectares)

**Objective:** Convert extent polygons to a format with area calculations per habitat class and PA.

**Steps in ArcGIS Pro:**

1. **Prepare extent layer**
   - Load benthic extent shapefile/polygons (from Yves Amoros)
   - Verify attribute: `Name` field contains values like "coral reef", "seagrass", "sand", etc.

2. **Add area_ha field**
   - Right-click extent layer → Field Calculator
   - Create new field: `area_ha` (type: Double)
   - Formula: `!SHAPE.area! / 10000` (converts m² to hectares)
   - Calculate

3. **Verify area calculations**
   - Spot-check a few polygons: measure manually in ArcGIS (Draw Measurement tool) vs. calculated area_ha
   - Flag any unrealistic values (e.g., area_ha < 0 or > 50,000 ha for single polygon)

4. **Backup:** Export as shapefile or GeoJSON
   - Save as: `Madagascar/02_analysis/extent_with_area_ha.shp`

### 4.2 Spatial Join: Extent Polygons to WDPA

**Objective:** For each extent polygon (coral, seagrass), identify which PA(s) it overlaps with.

**Steps in ArcGIS Pro:**

1. **Spatial join (one-to-many)**
   - Target features: Extent polygons (coral reef, seagrass)
   - Join features: WDPA polygons
   - Join operation: **ONE_TO_MANY** (extent polygons may intersect multiple PAs)
   - Match option: INTERSECTS
   - Output name: `extent_with_pa.shp`

2. **Intersect operation (optional, for precise area per PA)**
   - If one-to-many spatial join doesn't capture shared areas well, use Intersect tool instead:
     - Analysis tab → Intersect
     - Input features: Extent polygons + WDPA polygons
     - Output: `extent_pa_intersected.shp` (each polygon split at PA boundaries)
     - Then recalculate areas: `area_ha = !SHAPE.area! / 10000`

3. **Export to CSV**
   - Right-click output → Export Table
   - Save as: `Madagascar/02_analysis/extent_per_pa_intersected.csv`
   - Keep columns: `area_ha`, `Name` (habitat type), `WDPAID`, `PA_name` (WDPA NAME field)

### 4.3 Summary Statistics: Extent per PA

**Objective:** Pivot extent data to show area (ha) of each land cover class per PA.

**Steps in Excel or R:**

1. **Create pivot table**
   - Input: `extent_per_pa_intersected.csv`
   - Rows: PA name (from WDPAID + NAME)
   - Columns: Habitat class (coral reef, seagrass, sand)
   - Values: Sum of `area_ha`

2. **Interpret results**
   - Row sums = total habitat area within each PA (overlapping PAs count separately)
   - Note: Column totals will NOT equal total ecosystem extent (because WDPA polygons overlap)
   - Example output:

| PA Name | Coral Reef (ha) | Seagrass (ha) | Sand (ha) | Total (ha) |
|---|---|---|---|---|
| Andohahela NP | 450 | 120 | 300 | 870 |
| Ifaty Community Reserve | 280 | 200 | 250 | 730 |
| Velondriake LMMA | 520 | 180 | 400 | 1,100 |
| **Summary note** | Overlaps exist; sums to > true total | — | — | — |

**Save as:** `Madagascar/03_outputs/extent_per_protected_area.csv`

---

## 5. Total Ecosystem Extent (Protected vs. Unprotected)

### 5.1 Dissolve WDPA Polygons (True PA Coverage)

**Objective:** Merge overlapping WDPA polygons into a single multi-part polygon to calculate true PA coverage (avoiding double-counting).

**Steps in ArcGIS Pro:**

1. **Dissolve WDPA**
   - Select WDPA polygon layer
   - Analysis tab → Dissolve
   - Dissolve fields: None (dissolve all boundaries)
   - Output: `wdpa_dissolved.shp` (single multi-part polygon covering all PAs)

2. **Verify output**
   - Should have exactly 1 feature (multi-part polygon)
   - Visualize: may look like a patchwork of disconnected areas if PAs don't touch

3. **Calculate dissolved PA area**
   - Right-click → Field Calculator
   - Create field: `total_pa_area_ha`
   - Formula: `!SHAPE.area! / 10000`
   - Record the value (e.g., 2,500 ha total PA coverage in SW Madagascar region)

### 5.2 Intersect Extent with Dissolved WDPA

**Objective:** Calculate how much of each habitat type (coral, seagrass) falls within ANY protected area.

**Steps in ArcGIS Pro:**

1. **Intersect extent with dissolved WDPA**
   - Analysis tab → Intersect
   - Input features:
     - Extent polygons (coral reef, seagrass, sand)
     - WDPA dissolved polygon
   - Output: `extent_within_pa_dissolved.shp`
   - This output contains only the portions of extent polygons that overlap with PAs

2. **Calculate area_ha for intersected extents**
   - Right-click → Field Calculator
   - Create field: `area_ha_in_pa`
   - Formula: `!SHAPE.area! / 10000`

3. **Summarize by habitat type**
   - Create pivot/summary:
     - Group by: `Name` (habitat class)
     - Sum: `area_ha_in_pa`
   - Result: Coral reef area in PAs, Seagrass area in PAs, etc.
   - Export: `Madagascar/02_analysis/extent_within_pa.csv`

### 5.3 Calculate Total Extent (Original Extent Layer)

**Objective:** Ensure total habitat extent across entire accounting area (regardless of PA status).

**Steps in Excel or ArcGIS:**

1. **Sum extent_with_area_ha.shp by habitat class**
   - Use Dissolve (no join field) on original extent layer
   - Or use Summarize in ArcGIS
   - Result: Total coral reef area, total seagrass area, etc.
   - Export: `Madagascar/02_analysis/extent_total.csv`

| Habitat Class | Total Area (ha) | Notes |
|---|---|---|
| Coral reef | 3,200 | Entire accounting area (SW Madagascar) |
| Seagrass | 1,500 | Entire accounting area |
| Sand / rubble | 4,100 | Reference (non-ecosystem) |
| **Total accounting area** | **8,800** | 25 m depth contour × coastline |

### 5.4 Calculate Unprotected Extent (Excel)

**Objective:** Determine habitat extent OUTSIDE protected areas.

**Steps in spreadsheet (Excel or R):**

1. **Set up calculation table**

| Habitat Class | Total Area (ha) | Area in PA (ha) | Area NOT in PA (ha) |
|---|---|---|---|
| Coral reef | [Total from step 5.3] | [Protected from step 5.2] | [Total − Protected] |
| Seagrass | [Total from step 5.3] | [Protected from step 5.2] | [Total − Protected] |
| Sand / rubble | [Total from step 5.3] | [Protected from step 5.2] | [Total − Protected] |

2. **Example calculations**
   - Coral reef total: 3,200 ha
   - Coral reef in PA: 2,000 ha (from dissolved WDPA intersection)
   - Coral reef NOT in PA: 3,200 − 2,000 = **1,200 ha**

3. **Create final summary table**

**Save as:** `Madagascar/03_outputs/ecosystem_extent_protected_vs_unprotected.csv`

| Ecosystem Type | Protected (ha) | Unprotected (ha) | Total (ha) | % Protected |
|---|---|---|---|---|
| Coral reef (M1.3) | 2,000 | 1,200 | 3,200 | 62.5% |
| Seagrass (M1.1) | 800 | 700 | 1,500 | 53.3% |
| Total ecosystem | 2,800 | 1,900 | 4,700 | 59.6% |

---

## 6. Output Files & Deliverables

### 6.1 Required Outputs

| File Name | Location | Format | Purpose | Dependencies |
|---|---|---|---|---|
| `sites_protected_area_assignment.csv` | `02_analysis/` | CSV | Site-to-PA mapping | Sites XY + WDPA spatial join (§3.2) |
| `sites_pa_summary.csv` | `03_outputs/` | CSV | Summary: # sites in/out of PAs | Sites PA assignment (above) |
| `extent_with_area_ha.shp` | `02_analysis/` | Shapefile | Extent polygons with area calculations | Extent polygons + field calc (§4.1) |
| `extent_per_pa_intersected.csv` | `02_analysis/` | CSV | Extent by habitat × PA (one-to-many) | Extent XY + WDPA intersect (§4.2) |
| `extent_per_protected_area.csv` | `03_outputs/` | CSV | Pivot: extent (ha) × PA × habitat class | Extent per PA (§4.3) |
| `extent_within_pa_dissolved.shp` | `02_analysis/` | Shapefile | Extent clipped to dissolved WDPA | Extent intersect dissolved WDPA (§5.2) |
| `extent_total.csv` | `02_analysis/` | CSV | Total extent by habitat class | Original extent dissolved (§5.3) |
| `ecosystem_extent_protected_vs_unprotected.csv` | `03_outputs/` | CSV | **Final summary:** extent (ha) by habitat & PA status | Total + protected extents (§5.4) |
| `wdpa_dissolved.shp` | `02_analysis/` | Shapefile | WDPA merged (no overlaps) | WDPA dissolve (§5.1) |

### 6.2 Optional/Supporting Outputs

- `sites_with_pa.shp` — Site points with PA attribute (for visualization)
- `extent_with_pa.shp` — Extent polygons with PA attribute (for visualization)
- Map PDF — Print map showing sites, extent, and WDPA boundaries (for reports)

---

## 7. Quality Assurance Checks

**Before finalizing outputs, verify:**

- [ ] **Site coordinates:** All 27 unique sites fall within accounting area (between 25 m depth contour and coastline)
- [ ] **No negative areas:** All area_ha values ≥ 0
- [ ] **Area consistency:** Sum of protected + unprotected extent = total extent (within ±1% rounding error)
- [ ] **PA overlap:** Dissolved WDPA area < sum of individual PA areas (confirms dissolve worked)
- [ ] **Site-PA assignment:** Visual check on map — confirm sites inside PA boundaries are flagged correctly
- [ ] **Extent coverage:** Visual check on map — confirm extent layer covers expected reef/seagrass areas (compare to satellite imagery or field photos)
- [ ] **Attribute completeness:** No NULL values in key fields (area_ha, PA_name, habitat class)

---

## 8. Data Quality & Known Limitations

### 8.1 Known Issues

1. **WDPA polygon overlaps**
   - Multiple PAs may share boundaries; extent "per PA" sums to more than true total
   - **Mitigation:** Use dissolved WDPA for true PA coverage; use individual PA sums only for reporting per-PA statistics

2. **Site location precision**
   - UVC site coordinates may have ±10–20 m GPS error
   - A site on the boundary of a PA may be misclassified (in vs. out)
   - **Mitigation:** Buffer sites by ±20 m and re-run spatial join to quantify sensitivity

3. **Extent polygon boundaries**
   - Satellite-derived boundaries have ~10 m classification error
   - Small extent polygons (< 1 ha) may be artifacts
   - **Mitigation:** Filter polygons < 0.5 ha before area calculations; note precision limits in report

4. **Temporal mismatch**
   - Extent map is based on 2025 Sentinel-2 imagery
   - WDPA dataset may have outdated PA boundaries (check STATUS_YR field)
   - **Mitigation:** Verify PA boundaries against recent government gazetteers; note data vintage in metadata

### 8.2 Confidence Assessment

| Component | Confidence | Notes |
|---|---|---|
| **Site-to-PA assignment** | High | Direct spatial intersection; limited by GPS error (±20 m) |
| **Extent area calculation** | Moderate | Satellite-derived boundaries; 10 m classification error |
| **Protected vs. unprotected** | Moderate | Depends on both extent precision and PA boundary recency |

---

## 9. Integration with Related Skills

| Related Skill | Link | Purpose |
|---|---|---|
| **skill_extent_measurement_m13_reef.md** | [Local](skill_extent_measurement_m13_reef.md) | Benthic extent mapping (source for extent layer) |
| **skill_condition_measurement_m13_reef.md** | [Local](skill_condition_measurement_m13_reef.md) | UVC site coordinates (source for site locations) |
| **skill_condition_biotic_fish_invert.md** | [Local](skill_condition_biotic_fish_invert.md) | Fish/invertebrate condition metrics (background for biodiversity analysis) |
| **skill_services_regulating_nursery_m13.md** | [Local](skill_services_regulating_nursery_m13.md) | Nursery service valuation may consider PA status in discount/premium |

---

## 10. Workflow & Timeline

| Phase | Activity | Timing | Responsibility |
|---|---|---|---|
| **Phase 1: Data prep** | Extract coordinates, deduplicate, download WDPA | 2026-03 | Data/GIS team |
| **Phase 2: Site–PA assignment** | XY event layer, spatial join, summary | 2026-03 | GIS analyst |
| **Phase 3: Extent–PA analysis** | Area calculations, intersects, extent per PA | 2026-04 | GIS analyst |
| **Phase 4: Summary statistics** | Dissolved WDPA, protected vs. unprotected extent, Excel summary | 2026-04 | Analyst |
| **Phase 5: QA review** | Verify maps, compare with field knowledge | 2026-05 | Field team + GIS lead |
| **Phase 6: Report & delivery** | Final CSV outputs, metadata, methodology document | 2026-05 | Accounting team |

---

## 11. References

1. UNEP-WCMC & IUCN. (2024). *Protected Planet: The World Database of Protected Areas (WDPA).* Retrieved from https://www.protectedplanet.net/
2. UN SEEA EA. (2021). *System of Environmental-Economic Accounting — Ecosystem Accounting.* https://seea.un.org/
3. GEBCO 2023 Bathymetry. https://www.gebco.net/
4. Esri. (2024). *ArcGIS Pro User Guide: Spatial Joins, Intersects, and Dissolve.* https://pro.arcgis.com/
5. Madagascar Ministry of Interior. *District administrative boundaries.* [Contact MINTED for latest shapefiles]

---

**Last updated:** 2026-03-15
**Customised by:** Claude Code for AFRICA–Madagascar project
**Data provider:** WDPA (Protected Planet); Yves Amoros Mitondrasoa (extent); Laza & field team (site coordinates)
