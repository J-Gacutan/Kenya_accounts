# Academic RAG — Quick Reference Guide
**Mozambique Mangrove MFT1.2 Condition Account**

**Sources compiled:** 2026-03-16 (Phase 1 systematic search)
**Total sources:** 13
**Search basis:** See `SEARCH_PLAN_Condition_Baselines.md`
**Reference values:** See `BASELINE_REFERENCE_TABLE.md`

---

## Tier 1: HIGH CONFIDENCE — Peer-reviewed; Mozambique or East Africa field data

### Canopy Height & Biomass (Mozambique-specific)

| Source ID | Authors | Year | Journal | Region | Key Value |
|-----------|---------|------|---------|--------|-----------|
| source_2026_moz_001 | Fatoyinbo et al. | 2008 | *J. Geophys. Res. Biogeosciences* 113:G02S06 | Mozambique national (61 field plots) | Mean height: 5.8 m; Max: 27 m; Range 1–27 m |
| source_2026_moz_002 | Fatoyinbo & Simard | 2013 | *Int. J. Remote Sensing* 34:668–681 | Africa-wide (331 plots; Mozambique 101 plots) | East Africa max ~40 m; RMSE 3.55 m; height-biomass for all African mangroves |
| source_2026_moz_003 | Lagomasino et al. | 2015 | *Remote Sensing in Ecology & Conservation* 1:32–44 | Mozambique: Inhaca Island + Maputo Elephant Reserve | LiDAR-derived; intact conserved sites >20 m; high correlation between LiDAR and field heights |
| source_2026_moz_004 | Sitoe et al. | 2016 | *Wetlands Ecology & Management* 24:173–187 | Mozambique: Zambezi River Delta | 5 height classes; tall class basal area 14–41 m²/ha; all 8 Mozambique species present; overstory ~2000 trees/ha |

### DBH & Forest Structure (East Africa field surveys)

| Source ID | Authors | Year | Journal | Region | Key Value |
|-----------|---------|------|---------|--------|-----------|
| source_2026_moz_005 | Mwihaki et al. | 2024 | *Diversity* (MDPI) 16(3):135 | Kenya: Gazi Bay | Mean DBH: 8.52 ± 0.23 cm; Range: 2.5–31.5 cm; Stand density 2659 stems/ha; 12-yr planted stand: 6.2 cm |
| source_2026_moz_006 | Godoy & De Lacerda | 2015 | *Wetlands Ecology & Management* 23:667–682 | Mozambique: Inhambane Bay (6 sites including Morrumbene) | Morrumbene = highest complexity; Maxixe DBH: 6.94 cm; Guiua: 5.00 cm; high Marrambone density (13,390 ind/0.1 ha); species-specific complexity indices |
| source_2026_moz_007 | De Pous et al. | 2022 | *Forests* (MDPI) 13(9):1466 | Mozambique: Maputo Bay | Mean DBH: 6.98 ± 0.26 cm; Mean height: 1.74 m; 5 species; A. marina dominant; degraded urban benchmark |

---

## Tier 2: MEDIUM CONFIDENCE — Peer-reviewed; indirect or Indo-Pacific analog

### Disturbance Assessment

| Source ID | Authors | Year | Source | Region | Key Value |
|-----------|---------|------|--------|--------|-----------|
| source_2026_moz_008 | Zockler, Wodehouse & Markolf | 2021 | IntechOpen ch.74975 (Mangrove Ecosystem Restoration) | Indo-West Pacific (Myanmar, Madagascar) | Visual scale 1–6: 6 = intact/high-quality; 1 = most degraded; boat/ground-based rapid assessment; applicable to non-arid Indo-W Pacific mangroves |

### Degradation Review

| Source ID | Authors | Year | Journal | Region | Key Value |
|-----------|---------|------|---------|--------|-----------|
| source_2026_moz_010 | Mandlburger et al. | 2025 | *GIScience & Remote Sensing* 62:2491920 | Global review | 42.3% of degradation studies use canopy density/fractional cover as proxy; gap size and frequency used to classify disturbance levels |

### Mozambique Disturbance Events

| Source ID | Authors | Year | Journal | Region | Key Value |
|-----------|---------|------|---------|--------|-----------|
| source_2026_moz_011 | Barbosa et al. | 2024 | *ScienceDirect* (Ocean & Coastal Management) | Mozambique: Maputo River Estuary | Massive dieback case study; 233 plots of 10x10 m assessed; extreme weather impact quantified |

### East Africa Structure (Tanzania disturbance contrast)

| Source ID | Authors | Year | Journal | Region | Key Value |
|-----------|---------|------|---------|--------|-----------|
| source_2026_moz_012 | Bosire et al. | 2022 | *Frontiers in Forests & Global Change* | Tanzania: Rufiji Delta | Undisturbed: lower stems (5–15 cm) = 25% biomass; even size distribution to 42 cm. Disturbed: lower stems = 70% biomass. Tree density 417 trees/ha (20-yr undisturbed stand) |

---

## Tier 3: ANALOG DATA — Indian Ocean reference; lower regional specificity

### Regeneration Density

| Source ID | Authors | Year | Journal | Region | Key Value |
|-----------|---------|------|---------|--------|-----------|
| source_2026_moz_009 | Patel et al. | 2019 | *PMC* (Assessment of natural regeneration) | India: Gulf of Kachchh (Indo-W Pacific analog) | Avicennia marina: 66.86 /m²; Rhizophora mucronata: 0.04 /m²; Ceriops tagal: 0.04 /m²; 1x1 m quadrats; seedlings 1–50 cm, saplings 51–150 cm |

---

## Tier 4: DATASETS — Remote sensing / spatial baselines

| Source ID | Data Product | Year | Source | Region | Key Use |
|-----------|-------------|------|--------|--------|---------|
| source_2026_moz_013 | NASA CMS Mangrove Canopy Height — Tanzania | 1990–2014 | NASA ORNL DAAC | Tanzania: Rufiji Delta | Stand age + height + land cover change; TanDEM-X imagery; benchmark for mature stand height |
| source_2026_moz_014 | NASA CMS Mangrove Canopy Height — Mozambique | 2012 | NASA ORNL DAAC | Mozambique: Inhaca + Maputo Reserve | 0.6 x 0.6 m resolution stereo pairs; validates Fatoyinbo 2008 field plots |

---

## How to Use This RAG System

**For SEEA EA condition account methods sections:**
- Cite Tier 1 sources for all quantitative reference values
- Cite Tier 2 sources for methods comparisons and disturbance classification

**For disturbance assessment:**
- Use source_2026_moz_008 (Zöckler 2021) as the rapid visual assessment reference
- Use source_2026_moz_010 (Mandlburger 2025) for remote sensing validation

**For canopy height indicator:**
- Primary citation: source_2026_moz_001 (Fatoyinbo 2008) for Mozambique national context
- Reference state citation: source_2026_moz_003 (Lagomasino 2015) for intact Mozambique stands
- Revised pristine reference value: **15 m** (see BASELINE_REFERENCE_TABLE.md)

**For DBH indicator:**
- Local context: source_2026_moz_006 (Inhambane Bay including Morrumbene)
- Intact vs. degraded contrast: source_2026_moz_012 (Tanzania Rufiji)
- Reference value retained: **5–20 cm** (SOP values now literature-supported)

**For regeneration density:**
- Only Indo-Pacific analog data available (source_2026_moz_009)
- East Africa data remains a CRITICAL GAP — flag in methods section
- Species-specific caution: cite Patel 2019 for species-level range

**Source IDs to use in publications:**
- Use the source_2026_moz_XXX format when tagging claims in draft text
- Full citations are in BASELINE_REFERENCE_TABLE.md

---

**Document created:** 2026-03-16
**Phase 1 search complete:** 14 sources assessed; 13 included (1 excluded: insufficient detail)
**Phase 2 target:** Full-text access for source_2026_moz_001 to _007 (value extraction); 2026-04-21
**Phase 3 target:** Regional outreach for canopy density and regeneration density gaps; 2026-04-28
