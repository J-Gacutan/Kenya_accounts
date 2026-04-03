# Mozambique Mangrove Ecosystem Findings Overview

**Study Period:** 2024–2025 GEDI LIDAR observations
**Compilation Date:** March 2026
**Framework:** UN SEEA EA Ecosystem Extent & Carbon Accounts
**Sites:** Save River Delta (Gaza Province) & Morrumbene Estuary (Inhambane Province)

---

## 1. Data Structure & Column Reference

All GEDI-derived datasets use the same column schema, sourced from NASA's Global Ecosystem Dynamics Investigation (GEDI) L2A, L2B, and L4A products. The data can be analyzed at two levels:

- **Asset-level** (`*_by_asset.csv`): Individual mangrove forest units within each site
- **Aggregated site-level** (`*_all_mangroves.csv`): Combined statistics across all forests at each site

### Column Definitions

| Column | Unit | Description | Data Type |
|--------|------|-------------|-----------|
| **Asset_ID** | — | Unique identifier for each mangrove forest (site-level aggregations use ID=1) | Integer |
| **Shape_Leng** | Degrees or map units | Perimeter of the asset boundary polygon | Float |
| **BUFF_DIST** | Meters | Buffer distance applied during spatial processing (standard: 25 m) | Integer |
| **Shape_Length** | Normalized units | Normalized shape length metric (derived from boundary) | Float |
| **Shape_Area** | Square degrees or map units | Total area of the asset polygon | Float |
| **mean_rh100** | Meters (m) | Mean canopy height (RH100 percentile) — maximum vegetation structure | Float |
| **mean_L4A_agbd** | Megagrams per hectare (Mg/ha) | Mean above-ground biomass density — total dry above-ground biomass | Float |
| **mean_L4A_agbd_se** | Megagrams per hectare (Mg/ha) | Standard error of AGBD estimate — uncertainty quantification | Float |
| **mean_L2B_cover** | Fraction (0–1) | Mean canopy cover — density of the upper vegetation layer (0 = none, 1 = full) | Float |
| **mean_L2B_pai** | Unitless (m²/m²) | Mean Plant Area Index — total one-sided leaf + stem area per ground area | Float |
| **mean_L4A_carbono_mgha** | Megagrams of Carbon per hectare (Mg C/ha) | Mean carbon stock — estimated carbon content per unit area (≈ AGBD × 0.47) | Float |
| **Point_Count** | Count | Number of GEDI footprints (~25 m diameter) contributing to asset average | Integer |

**Note:** All GEDI-derived metrics (RH100, AGBD, cover, PAI, carbon) are estimates with associated uncertainty. The `mean_L4A_agbd_se` field quantifies confidence in biomass estimates.

---

## 2. Save Estuary Analysis

**Location:** Gaza Province, Mozambique
**Administrative Boundary:** Nova Mambone & Bazaruto districts
**Global Extent (2020 baseline):** ~12,085 ha (GMW v4)
**GEDI Coverage Period:** 2024–2025

### 2.1 Site-Level Summary (Aggregated)

Across all Save River Delta mangroves combined:

| Metric | Value | Interpretation |
|--------|-------|-----------------|
| **GEDI Footprints (Point_Count)** | 84 | Moderate coverage; representative sampling across the delta |
| **Mean Canopy Height (RH100)** | 5.07 m | Short to mid-story mangroves; typical of mature, structurally simple stands |
| **Mean Biomass Density (AGBD)** | 12.63 Mg/ha | Moderate density; consistent with tropical mangrove baselines |
| **AGBD Uncertainty (SE)** | 15.96 Mg/ha | High relative uncertainty (±126% of estimate); caution when citing absolute values |
| **Mean Canopy Cover** | 8.8% | Very sparse canopy closure; suggests fragmented or low-density forest patches |
| **Mean PAI** | 0.29 m²/m² | Low leaf area index; light woodland structure, not dense closed-canopy forest |
| **Mean Carbon Stock** | 5.94 Mg C/ha | Moderate carbon content; translates to ~12.6 Mg CO₂ eq/ha using standard conversion |

### 2.2 Asset-Level Breakdown (Individual Mangrove Forests)

Save Estuary is divided into **8 distinct mangrove forest assets**. Below is analysis for each:

#### Asset 1
- **Canopy Height:** 4.96 m | **Biomass:** 11.89 ± 17.14 Mg/ha | **Canopy Cover:** 2.4% | **PAI:** 0.049 m²/m²
- **Carbon Stock:** 5.59 Mg C/ha | **GEDI Footprints:** 17
- **Character:** Low-density, sparse woodland; minimal canopy closure

#### Asset 2
- **Canopy Height:** 4.28 m | **Biomass:** 12.33 ± 17.14 Mg/ha | **Canopy Cover:** 8.0% | **PAI:** 0.167 m²/m²
- **Carbon Stock:** 5.80 Mg C/ha | **GEDI Footprints:** 2
- **Character:** Sparse, scrubby mangrove; very few observations (low confidence)

#### Asset 3
- **Canopy Height:** 7.80 m | **Biomass:** 27.33 ± 17.13 Mg/ha | **Canopy Cover:** 43.4% | **PAI:** 1.742 m²/m²
- **Carbon Stock:** 12.85 Mg C/ha | **GEDI Footprints:** 3
- **Character:** **Standout asset** — tallest, densest, highest biomass in Save estuary; likely mature forest patch; high productivity

#### Asset 4
- **Canopy Height:** 4.59 m | **Biomass:** 12.67 ± 17.14 Mg/ha | **Canopy Cover:** 7.3% | **PAI:** 0.153 m²/m²
- **Carbon Stock:** 5.96 Mg C/ha | **GEDI Footprints:** 1
- **Character:** Sparse, low-biomass patch; single observation (very low confidence)

#### Asset 5
- **Canopy Height:** 5.38 m | **Biomass:** 14.60 ± 17.14 Mg/ha | **Canopy Cover:** 14.3% | **PAI:** 0.449 m²/m²
- **Carbon Stock:** 6.86 Mg C/ha | **GEDI Footprints:** 17
- **Character:** Moderate density, reasonable canopy structure; better-represented asset

#### Asset 6
- **Canopy Height:** 4.64 m | **Biomass:** 9.08 ± 13.95 Mg/ha | **Canopy Cover:** 1.5% | **PAI:** 0.032 m²/m²
- **Carbon Stock:** 4.27 Mg C/ha | **GEDI Footprints:** 31
- **Character:** Low-density, poorly vegetated; well-sampled by GEDI (high confidence for low values)

#### Asset 7
- **Canopy Height:** 4.55 m | **Biomass:** 12.17 +/- 17.14 Mg/ha | **Canopy Cover:** 7.8% | **PAI:** 0.165 m2/m2
- **Carbon Stock:** 5.72 Mg C/ha | **GEDI Footprints:** 7 | **Area:** 235.56 ha
- **Character:** Moderate-density sparse woodland; similar structure to Assets 1 and 5

#### Asset 8
- **Canopy Height:** 6.26 m | **Biomass:** 20.75 +/- 17.14 Mg/ha | **Canopy Cover:** 32.8% | **PAI:** 1.293 m2/m2
- **Carbon Stock:** 9.75 Mg C/ha | **GEDI Footprints:** 6 | **Area:** 299.38 ha
- **Character:** **Second-highest productivity** -- denser, taller forest; moderate GEDI coverage

### 2.3 Key Findings — Save Estuary

1. **High heterogeneity:** Biomass ranges from 9.1 to 27.3 Mg/ha (3-fold variation). Two standout patches (Assets 3 and 8) show mature forest character; remainder are sparse woodlands.

2. **Canopy structure:** Most assets have <10% canopy closure (sparse). Assets 3 and 8 exceed 30% closure, indicating denser, more productive stands.

3. **GEDI coverage imbalance:** Assets 2 and 4 have only 1-2 observations each; Asset 6 is well-sampled (31 footprints). Large measurement uncertainty in sparsely-sampled assets.

4. **Productivity gradient:** Canopy height correlates with biomass; taller trees (6-8 m) accumulate 20-27 Mg/ha biomass; shorter trees (4-5 m) hold 9-12 Mg/ha.

5. **Carbon baseline:** Site-level aggregation = **5.94 Mg C/ha**. Using delineated asset polygon area of 1,877.54 ha, total Save estuary carbon stock (assets only) = **~11,150 Mg C (11.2 Gg C)** or **~40,850 Mg CO2 eq**. Note: previous estimates using full GMW 2020 extent (12,085 ha) yielded ~71,700 Mg C; the asset polygon areas are the correct basis for accounting against delineated units with GEDI coverage.

---

## 3. Morrumbene Estuary Analysis

**Location:** Inhambane Province, Mozambique (southern coast)
**Administrative Boundary:** Inhambane District
**Global Extent (2020 baseline):** 1,677 ha (GMW v4)
**GEDI Coverage Period:** 2024–2025

### 3.1 Site-Level Summary (Aggregated)

Across all Morrumbene mangroves combined:

| Metric | Value | Interpretation |
|--------|-------|-----------------|
| **GEDI Footprints (Point_Count)** | 195 | Excellent coverage; dense, well-distributed sampling |
| **Mean Canopy Height (RH100)** | 5.27 m | Low to mid-story mangroves; slightly taller than Save estuary |
| **Mean Biomass Density (AGBD)** | 10.95 Mg/ha | Slightly lower density than Save; more open woodland structure |
| **AGBD Uncertainty (SE)** | 14.16 Mg/ha | High relative uncertainty (±129% of estimate); comparable to Save estuary |
| **Mean Canopy Cover** | 4.9% | Very sparse canopy closure; more fragmented than Save estuary |
| **Mean PAI** | 0.120 m²/m² | Extremely low leaf area; very open woodland character |
| **Mean Carbon Stock** | 5.15 Mg C/ha | Slightly lower than Save; ≈ 10.9 Mg CO₂ eq/ha |

### 3.2 Asset-Level Breakdown (Individual Mangrove Forests)

Morrumbene is divided into **3 distinct mangrove forest assets**, all with good GEDI coverage:

#### Asset 1
- **Canopy Height:** 5.16 m | **Biomass:** 11.26 ± 15.14 Mg/ha | **Canopy Cover:** 4.6% | **PAI:** 0.115 m²/m²
- **Carbon Stock:** 5.29 Mg C/ha | **GEDI Footprints:** 85
- **Character:** Sparse woodland; well-sampled; low-density mangrove

#### Asset 2
- **Canopy Height:** 5.29 m | **Biomass:** 10.79 ± 14.01 Mg/ha | **Canopy Cover:** 5.1% | **PAI:** 0.124 m²/m²
- **Carbon Stock:** 5.07 Mg C/ha | **GEDI Footprints:** 95
- **Character:** **Best-sampled asset** (95 footprints); consistent low-density structure across the forest

#### Asset 3
- **Canopy Height:** 5.77 m | **Biomass:** 10.21 ± 9.59 Mg/ha | **Canopy Cover:** 4.9% | **PAI:** 0.125 m²/m²
- **Carbon Stock:** 4.80 Mg C/ha | **GEDI Footprints:** 15
- **Character:** Tallest canopy in Morrumbene; lowest biomass; sparse structure

### 3.3 Key Findings — Morrumbene

1. **Consistent structure:** All three assets are remarkably uniform: biomass 10.2–11.3 Mg/ha, cover 4.6–5.1%, canopy height 5.2–5.8 m. Very little internal heterogeneity.

2. **Inferior to Save estuary:** Morrumbene biomass (~11 Mg/ha) is ~13% lower than Save (~12.6 Mg/ha). Canopy cover is ~45% lower than Save's sparse forests and much lower than Save's dense patches (Assets 3 & 7).

3. **Excellent GEDI coverage:** 195 total footprints across a smaller area (1,677 ha) than Save; higher confidence in these estimates.

4. **Very open woodland:** PAI ≈ 0.12 m²/m² indicates extremely light canopy; consistent with degraded or naturally low-density mangrove.

5. **Carbon baseline:** Site-level aggregation = **5.15 Mg C/ha**. Using delineated asset polygon area of 1,068.76 ha, total Morrumbene carbon stock (assets only) = **~5,500 Mg C (5.5 Gg C)** or **~20,150 Mg CO2 eq**. Note: previous estimates using full GMW 2020 extent (1,677 ha) yielded ~8,630 Mg C.

---

## 4. Comparative Summary

| Dimension | Save Estuary | Morrumbene | Difference |
|-----------|--------------|-----------|-----------|
| **GEDI Footprints** | 84 | 195 | Morrumbene: 2.3× more coverage |
| **Mean Canopy Height** | 5.07 m | 5.27 m | Morrumbene: 4% taller (ns) |
| **Mean Biomass** | 12.63 Mg/ha | 10.95 Mg/ha | Save: 15% denser |
| **Mean Canopy Cover** | 8.8% | 4.9% | Save: 1.8× more closure |
| **Mean PAI** | 0.286 m²/m² | 0.120 m²/m² | Save: 2.4× more leaf area |
| **Mean Carbon Stock** | 5.94 Mg C/ha | 5.15 Mg C/ha | Save: 15% more carbon |
| **Asset Polygon Area** | 1,877.54 ha | 1,068.76 ha | Save: 1.8x larger |
| **Total Carbon Stock (asset polygons)** | ~11,150 Mg C | ~5,500 Mg C | Save: 2.0x more total carbon |
| **Data Quality** | Uneven (1-31 observations/asset) | Homogeneous (15-95 observations/asset) | Morrumbene: more reliable estimates |

**Overall Assessment:** Save estuary is larger, denser, and more carbon-rich in aggregate, but internally heterogeneous (some patches highly productive, others degraded). Morrumbene is smaller, more uniform, and sparser throughout, but better-measured by GEDI. Carbon totals use delineated asset polygon areas (not full GMW 2020 estuary extent).

---

## 5. Monitoring Flexibility: Per-Forest vs. Aggregated Analysis

Both datasets support **two analytical approaches** for ongoing monitoring:

### 5.1 Per-Forest (Asset-Level) Monitoring

**Use when:** Tracking individual mangrove patches, assessing patch-scale degradation, or linking to site-specific management interventions.

**Approach:**
- Extract asset-level statistics from `*_by_asset.csv` files
- Monitor trends in canopy height, biomass, canopy cover, PAI independently for each Asset
- Useful for detecting localized change (e.g., Asset 3 in Save degrading from 27 → 20 Mg/ha biomass over time)

**Limitations:**
- Uneven GEDI coverage by asset (Save assets 2–4 have <6 observations each → high uncertainty)
- Small patches may not accumulate sufficient GEDI footprints for robust trending
- Requires multi-year GEDI revisit data (not yet available; 2024–2025 is baseline)

### 5.2 Aggregated Site-Level Monitoring

**Use when:** Reporting ecosystem extent & condition accounts to SEEA EA frameworks, tracking overall ecosystem health, or assessing carbon change at the site level.

**Approach:**
- Use `*_all_mangroves.csv` files for aggregated Save Estuary & Morrumbene summaries
- Monitor trends in site-level mean biomass, carbon stock, canopy cover (single metric per site)
- Combine with GMW extent data to calculate total ecosystem carbon stocks (Mg C; scales with area changes)

**Advantages:**
- Pooled GEDI samples (84 + 195) increase statistical confidence
- Reduces noise from patch-scale heterogeneity
- Aligns with SEEA EA reporting (site-level condition accounts)
- Simpler for policy communication

**Recommended tracking:**
- **Save Estuary:** 5.94 Mg C/ha x 1,877.54 ha (asset polygons) = baseline carbon stock ~11,150 Mg C
- **Morrumbene:** 5.15 Mg C/ha x 1,068.76 ha (asset polygons) = baseline carbon stock ~5,500 Mg C

---

## 6. Data Quality & Confidence Assessment

### Measurement Uncertainty

All GEDI-derived biomass estimates carry standard errors. Notable patterns:

- **Save estuary:** AGBD SE ≈ ±15.96 Mg/ha (129% relative uncertainty) — high variability, likely due to sparse asset-level sampling
- **Morrumbene:** AGBD SE ≈ ±14.16 Mg/ha (129% relative uncertainty) — similar high uncertainty despite more GEDI footprints
- **Interpretation:** Absolute biomass values should be treated as **±15 Mg/ha**, especially at asset level

### GEDI Coverage & Confidence by Asset

**High confidence (>20 footprints):**
- Save Asset 6 (31 observations)
- Morrumbene Assets 1–2 (85, 95 observations)

**Moderate confidence (6–20 footprints):**
- Save Assets 1, 5, 7
- Morrumbene Asset 3 (15 observations)

**Low confidence (<6 footprints):**
- Save Assets 2, 4 (2, 1 observations respectively) — use only for descriptive purposes, not trend analysis

### Known Limitations

1. **Single-year baseline:** 2024–2025 GEDI snapshot is a baseline, not a trend. Multi-year comparisons require future GEDI acquisitions or alternative remote-sensing (Sentinel-1/2, LiDAR flights).

2. **Canopy cover uncertainty:** The very low canopy cover values (4–9%) may reflect GEDI's sensitivity to gaps and sparse vegetation. Cross-validation with optical remote sensing or field photos recommended.

3. **Spatial scale mismatch:** GEDI footprints (~25 m diameter) are large relative to mangrove patch sizes in southern Mozambique. Footprints may include water, salt flats, or non-mangrove vegetation.

4. **No species composition:** Data provides structure (height, biomass, cover, PAI) but not mangrove species ID (Rhizophora, Ceriops, etc.), limiting ecological interpretation.

---

## 7. Next Steps

1. **Field validation (Recommended: Mar–May 2026):** Ground truth GEDI estimates with in-situ plots (height, DBH, basal area) at Save & Morrumbene. Refine biomass expansion factors if needed.

2. **Sentinel-1/2 canopy cover cross-check:** Validate low canopy cover estimates using optical remote sensing and manual inspection of high-resolution imagery.

3. **Repeat GEDI acquisitions (2026–2027):** Plan for future GEDI passes to enable change detection (biomass gain/loss, carbon sequestration rates).

4. **Species mapping (Optional):** Integrate with field surveys to assign species composition and ecological status (healthy vs. degraded) to each asset.

5. **Extent trend analysis:** Update GMW or Sentinel-based mangrove extent for 2025–2026 to track area loss/gain alongside condition change.

6. **Ecosystem services linkage:** Use biomass and canopy structure as proxies for fisheries nursery productivity (fish abundance/biomass relationships) and coastal protection (canopy roughness, root depth).

---

## 8. References & Data Sources

- **GEDI Data:** NASA's Global Ecosystem Dynamics Investigation, Products L2A, L2B, L4A (v2)
- **Extent baseline:** Global Mangrove Watch v4 (GMW v4) — 2020 reference year
- **Accuracy note:** GMW v4 ~86% overall accuracy; pixel size ~25 m
- **Study design:** 25 m buffer applied to mangrove administrative boundaries; data filtered to vegetation-only areas

---

**Prepared:** 2026-03-16 | **Updated:** 2026-03-28
**Framework:** UN SEEA EA Ecosystem Extent & Carbon Accounts (Mangrove Ecosystems)
**Prepared by:** Claude Code Analysis
**Next Review:** Post-field validation (estimated May 2026)

**2026-03-28 update:** Save corrected to 8 assets (was 7); carbon totals recalculated using ArcGIS-derived asset polygon areas (Save 1,877.54 ha; Morrumbene 1,068.76 ha) instead of GMW 2020 estuary extents. Previous carbon estimates (Save ~71,700 Mg C; Morrumbene ~8,630 Mg C) were based on full GMW extent and are superseded.
