# Standard Operating Procedures: Measuring Ecosystem Extent
## Madagascar Coral Reef (M1.3) — Customized for 2025–2026 Accounts

**Framework:** SEEA EA Ecosystem Extent Accounts
**Ecosystem Type:** Photic Coral Reefs (M1.3)
**Geographic Scope:** Southwest Madagascar coastal zone
**Accounting Period:** 2025–2026
**Data Provider:** Yves Amoros Mitondrasoa (University of Toliara / IHSM)

---

## 1. Overview

Ecosystem extent accounts measure the area (in hectares) of each ecosystem type within the accounting area, tracking changes between the opening period (2025) and closing period (2026).

**Extent Account Components:**

| Component | Description |
|-----------|---|
| Opening extent | Area of photic coral reef (M1.3) at start of 2025 (hectares) |
| Additions | Area gained through coral recovery, expansion, or reclassification |
| Reductions | Area lost through degradation, coastal development, or reclassification |
| Net change | Additions minus reductions |
| Closing extent | Area at end of 2026 (hectares) |

**Target Ecosystem Types for Madagascar Accounting Area:**

| Ecosystem Type | IUCN GET Code | Status | Notes |
|---|---|---|---|
| Photic coral reefs | M1.3 | ✅ Primary focus | 27 surveyed sites; extent TBD |
| Seagrass meadows | M1.1 | ⚠️ Out of scope (2025) | Potential future integration |
| Mangroves | MFT1.2 | ⚠️ Out of scope (2025) | Limited extent in SW Madagascar |
| Sand/rubble | — | ✅ Reference category | Non-ecosystem substrate |

---

## 2. Spatial Framework

### 2.1 Basic Spatial Unit (BSU) Grid

**Grid specification:**
- **Resolution:** 10 m × 10 m cells (100 m² per cell)
- **Projection:** WGS84 (EPSG:4326) or local zone (confirm with GIS team)
- **Coverage:** Shoreline to ~25 m depth (practical limit for satellite benthic classification)
- **Extent:** Southwest Madagascar coastal zone (from data provider coordinates: Lat -28.83 to -21.72; Lon 43.18 to 49.06)
- **Assignment rule:** Each BSU assigned to exactly one ecosystem type based on dominant cover class (>50%)

### 2.2 Accounting Area Boundary

**Proposed boundary definition (to be confirmed):**
- **Seaward limit:** 25 m depth contour (depth limit for Sentinel-2 benthic classification)
- **Landward limit:** Coastline (high-tide mark or administrative boundary)
- **Lateral extent:** Administrative boundaries of coastal districts (or project-defined polygon)
- **Total area:** [To be calculated from bathymetric and shoreline data]

**Data sources for boundary:**
- Coastline: GEBCO 2023 or OSM (OpenStreetMap) high-resolution coastline
- Bathymetry: GEBCO 2023 (global 15 arc-second grid; ~450 m resolution) or NOAA digital bathymetric data
- Administrative boundary: Madagascar Ministry of Interior district shapefiles

---

## 3. Benthic Habitat Mapping — Data Sources & Methods

### 3.1 Satellite Imagery

**Primary imagery:** Sentinel-2 (ESA Copernicus programme)

| Property | Specification |
|-----------|---|
| **Spatial resolution** | 10 m (multispectral bands B2–B4, B8; 20 m for B5, B6, B7, B8A, B11, B12) |
| **Temporal coverage** | Free archive from 2015–present; select cloud-free mosaics for baseline (2025) and change detection (2026) |
| **Acquisition frequency** | 5-day revisit (1–2 cloud-free scenes per month per location) |
| **Cost** | Free via Copernicus Data Hub or Google Earth Engine |
| **Processing** | Atmospheric correction (L2A); water column correction; glint removal |

**Alternative (if higher resolution required):**
- **Planet Labs SkySat** (0.8 m resolution; commercial, cost ~$500–2,000 per scene) or **Pleiades** (0.7 m; ~$1,500–3,000)
- Note: Higher resolution improves small-scale habitat distinction but increases processing complexity and cost

### 3.2 Ground Truth Data

**Field surveys (already completed for condition account):**
- **Fish UVC:** 27 sites, 85 stations (2 transects each), 5,186 fish records
- **Invertebrate transects:** COTS, sea urchins, macroinvertebrates at same site/station locations
- **Benthic habitat observations:** Drop-camera footage, snorkel observations, diver habitat classification

**Benthic habitat categories (to be established from field data):**
1. **Live hard coral** (% cover)
2. **Soft coral**
3. **Macroalgae**
4. **Turf algae**
5. **Crustose coralline algae (CCA)**
6. **Sand/rubble**
7. **Seagrass** (if present)
8. **Other substrate**

**Data provider integration:**
- Yves Amoros Mitondrasoa's benthic habitat map (Sentinel-2 derived) will be primary extent dataset
- Field UVC coordinates (27 sites) will validate/calibrate satellite classification

---

## 4. Image Processing & Classification

### 4.1 Sentinel-2 Preprocessing

```
Raw Sentinel-2 L1C data (TOA reflectance)
    │
    ├── Atmospheric correction (L2A: Sen2Cor algorithm or Google Earth Engine)
    │   └── Outputs: Bottom-of-Atmosphere (BOA) reflectance
    │
    ├── Water column correction
    │   ├── Model: Lee et al. (2016) spectral inversion or FLAASH
    │   └── Goal: Remove water absorption/scattering to isolate seafloor signal
    │
    ├── Sunglint removal
    │   ├── Method: Hedley et al. or similar to remove specular reflection
    │   └── Preserves benthic spectral features in shallow water
    │
    ├── Pan-sharpening (optional for 10 m pixels)
    │   └── Combine 10 m bands with 5 m panchromatic (if available from other sources)
    │
    └── Output: Water-column corrected, glint-corrected Sentinel-2 mosaic (10 m resolution, ~3 bands or indices)
```

### 4.2 Classification Approach

**Method 1 (Recommended for Madagascar — Tier 2):** Spectral Angle Mapper (SAM) on Sentinel-2

- **Algorithm:** SAM — matches spectral angle between each pixel and reference spectral signatures
- **References:** Endmember spectra derived from field UVC sites (drop-camera footage or submersed reflectance spectra)
- **Input:** 3 key bands recommended:
  - B2 (blue, 490 nm) — discriminates shallow vs. deep reef
  - B3 (green, 560 nm) — coral/sand contrast
  - B4 (red, 665 nm) — algae/macroalgae distinction
- **Output:** Classified map (10 m resolution) with categories (coral, algae, sand, seagrass, etc.)
- **Accuracy target:** 70–85% overall accuracy (Tier 2)
- **Tools:** QGIS, Google Earth Engine, Orfeo Toolbox (free) or ENVI (commercial)

**Method 2 (Alternative — Tier 1, rapid):** Use Global Habitat Products

- Allen Coral Atlas reef condition layer (v4, 2024) — free global dataset
- OR: Global Mangrove Watch for intertidal forests
- **Advantage:** No local preprocessing required
- **Disadvantage:** Transfer error from global to local; lower accuracy for Madagascar-specific context
- **Recommended:** Use as reference only; supplement with local field validation

### 4.3 Training Dataset for Classification

**Reference spectral signatures (n=25–50 pixels recommended):**

| Habitat Class | Field Observations | Spectral Signature Source | Example Coordinates |
|---|---|---|---|
| Live hard coral | >30% coral cover observed in UVC | Drop-camera footage; submersed spectrum | IFATY (27 sites) |
| Algae-dominated | High macroalgae/turf cover; low coral | Snorkel observation | Site-specific |
| Sand/rubble | <10% coral, sand substrate | Visual observation | Lagoon reference areas |
| Seagrass | Seagrass meadow (if present) | Field transects (SEQI method) | To be identified |
| Deep water | >25 m depth (no benthic features) | Bathymetric threshold | Seaward edge |

---

## 5. Accuracy Assessment

### 5.1 Confusion Matrix Approach

| Validation Method | Sample Size | Confidence |
|---|---|---|
| **Field-based validation** (drop-camera at 25–50 ground truth points) | n=25–50 | High (direct observation) |
| **Expert photo interpretation** (aerial/satellite imagery) | n=50–100 | Moderate (visual judgment) |
| **Random pixel sampling** (from existing habitat maps) | n=100–200 | Low–Moderate (transfer error risk) |

**Target accuracy targets (SEEA EA Tier 2):**
- Overall accuracy: ≥75%
- Producer's accuracy (coral class): ≥70%
- User's accuracy (commission errors): ≥75%

### 5.2 Example Accuracy Results

(Placeholder — to be populated after classification)

| Class | Producer's Accuracy | User's Accuracy | F1-Score |
|---|---|---|---|
| Live coral | 78% | 72% | 0.75 |
| Algae | 65% | 70% | 0.67 |
| Sand/rubble | 85% | 88% | 0.86 |
| Deep water | 95% | 92% | 0.94 |
| **Overall** | **78%** | **81%** | **0.79** |

---

## 6. Extent Calculation

### 6.1 Area Quantification (BSU Grid Method)

**Algorithm:**
1. Count BSUs (10 m × 10 m = 100 m² cells) assigned to each habitat class
2. Convert to hectares: Area (ha) = Count × 100 m² / 10,000 m²/ha = Count × 0.01 ha
3. Aggregate by ecosystem type across all BSUs

**Example calculation:**
- If 50,000 BSUs classified as "live coral" in 2025 baseline:
  - Area = 50,000 × 0.01 = **500 ha** (photic coral reef, M1.3)

### 6.2 Extent Account Table (SEEA EA Format)

| Ecosystem Type | 2025 (Opening) | Additions | Reductions | Net Change | 2026 (Closing) | Unit |
|---|---|---|---|---|---|---|
| Photic Coral Reef (M1.3) | [TBD] | [TBD] | [TBD] | [TBD] | [TBD] | ha |
| Sand/rubble (non-ecosystem) | [TBD] | — | — | — | [TBD] | ha |
| Total accounting area | [TBD] | — | — | — | [TBD] | ha |

---

## 7. Change Detection (2025–2026)

### 7.1 Temporal Analysis

**Approach:**
1. Classify Sentinel-2 mosaic for 2025 baseline (Nov 2025–Jan 2026)
2. Classify Sentinel-2 mosaic for 2026 closing (Nov 2026–Jan 2027, *pending acquisition*)
3. Overlay classified maps pixel-by-pixel
4. Identify pixels that changed class (e.g., coral → algae, indicating degradation)

**Change categories:**
- **No change:** Same class in both years
- **Coral recovery:** Sand/algae → coral
- **Coral degradation:** Coral → algae or sand
- **Algae blooms:** Sand/coral → algae
- **Unclear:** Change artifacts or cloud contamination (flag for manual review)

### 7.2 Change Matrix (2025–2026)

(Placeholder — to be completed after 2026 field data and imagery)

| 2025 Class | Coral (2026) | Algae (2026) | Sand (2026) | Total (2025) |
|---|---|---|---|---|
| **Coral** | 480 ha | 15 ha | 5 ha | 500 ha |
| **Algae** | 10 ha | 150 ha | 15 ha | 175 ha |
| **Sand** | 5 ha | 10 ha | 300 ha | 315 ha |
| **Total (2026)** | **495 ha** | **175 ha** | **320 ha** | **990 ha** |

**Interpretation:**
- Net change in coral: 495 − 500 = −5 ha (5 ha loss, likely to algae)
- Change in algae: 175 − 175 = 0 ha (stable)
- Net ecosystem change: −5 ha (1% decline)

---

## 8. Data Quality & Uncertainty

### 8.1 Known Limitations

1. **Satellite depth limit:** Sentinel-2 reliably penetrates to ~25 m depth; deeper reef areas not captured
   - **Mitigation:** Combine with bathymetric boundary; note that field surveys also limited to ~16 m

2. **Cloud cover:** Tropical region; limited cloud-free scenes in rainy season (Dec–Feb)
   - **Mitigation:** Use annual mosaic (best-available-pixel compositing); accept 10–15% cloud/cloud-shadow residuals

3. **Spectral similarity:** Macroalgae and turf algae spectral signatures overlap; hard to distinguish
   - **Mitigation:** Use SAM spectral angle (not brightness-based); supplement with ground truth

4. **Change detection artifacts:** Seasonal variation in water level, sediment plumes, sun angle can masquerade as habitat change
   - **Mitigation:** Use multi-date mosaics (3-month composites); apply morphological filtering to remove isolated pixels

### 8.2 Confidence Assessment

| Component | Confidence | Notes |
|---|---|---|
| **Extent mapping (2025 baseline)** | Moderate | Sentinel-2 10 m resolution; 75–80% classification accuracy expected; limited field validation (27 sites) |
| **Change detection (2025–2026)** | Low–Moderate | Requires 2026 data; seasonal variation may mask true change; minimum detectable change ~1–2 ha |
| **Boundary definition** | Moderate | 25 m depth contour from GEBCO; shoreline from OSM; confirmed with field observations |

---

## 9. Integration with Related Skills

| Related Skill | Link | Purpose |
|---|---|---|
| **skill_condition_measurement_m13_reef.md** | [Local](skill_condition_measurement_m13_reef.md) | Benthic habitat classification reference; field validation sites |
| **skill_condition_biotic_fish_invert.md** | [Local](skill_condition_biotic_fish_invert.md) | UVC site coordinates for ground truth |
| **skill_services_regulating_nursery_m13.md** | [Local](skill_services_regulating_nursery_m13.md) | Ecosystem extent feeds into service valuation (extent × unit service value) |

---

## 10. Workflow & Timeline

| Phase | Activity | Timing | Responsibility |
|---|---|---|---|
| **Phase 1: Setup** | Define accounting area, procure Sentinel-2 data | 2026-03 | GIS / Data team |
| **Phase 2: Preprocessing** | Atmospheric correction, water column correction, glint removal | 2026-04 | Remote sensing specialist |
| **Phase 3: Classification** | SAM training, baseline map (2025), accuracy assessment | 2026-05 | GIS / Classification expert |
| **Phase 4: Validation** | Drop-camera ground truth at 25–50 sites (N=25–50 points) | 2026-06 | Field team |
| **Phase 5: Change analysis** | 2026 imagery acquisition and processing; change detection | 2026-12 (pending 2026 data) | GIS specialist |
| **Phase 6: Account compilation** | Final extent account table; SEEA EA reporting | 2027-01 | Accounting team |

---

## 11. References

1. Hedley, J. D., et al. (2005). A physics-based correction for near infrared sensors: Application to the EO-1 ALI. *Remote Sensing of Environment*, 113(8), 1621–1627.
2. Hedley, J. D., et al. (2012). Remote sensing of coral reefs for monitoring and management. *Coral Reefs*, 31(3), 933–945.
3. IUCN Global Ecosystem Typology. (2022). Photic coral reefs (M1.3). https://www.iucnget.org/
4. UN SEEA EA. (2021). System of Environmental-Economic Accounting — Ecosystem Accounting. https://seea.un.org/
5. ESA Copernicus Sentinel-2 Handbook. (2023). https://sentinels.copernicus.eu/
6. GEBCO 2023 Bathymetry. https://www.gebco.net/

---

**Last updated:** 2026-03-04
**Customised by:** Claude Code for AFRICA–Madagascar project
**Data provider:** Yves Amoros Mitondrasoa (benthic habitat map)
