# Mozambique Mangrove Extent 2020 — Metadata

**Source:** Global Mangrove Watch v4 (GMW v4)
**Year:** 2020
**Geographic Coverage:** Mozambique (all 10 provinces + Maputo City)
**Administrative Level:** Distrito (District / adm3)
**File:** `mangrove_extent_gmw_2020.csv`

## Data Summary

| Metric | Value |
|--------|-------|
| **Records** | 80 administrative divisions |
| **Total Mangrove Area** | ~406,597 ha |
| **Data Source** | Global Mangrove Watch v4 |
| **Classification Method** | Satellite remote sensing (Sentinel-1/2, Landsat) |
| **Spatial Resolution** | ~25 m pixels |

## Variables

- **adm3_name:** Administrative district name (Portuguese)
- **FREQUENCY:** Count of mangrove pixels in district
- **SUM_Area_ha:** Total mangrove area (hectares)

## Top 10 Districts by Mangrove Area

| Rank | District | Area (ha) | Frequency |
|------|----------|-----------|-----------|
| 1 | Chinde | 28,775.72 | 1,024 |
| 2 | Divinhe | 23,557.70 | 1,702 |
| 3 | Micaune | 20,230.70 | 801 |
| 4 | Mualama | 17,786.04 | 224 |
| 5 | Inhassunge | 17,073.52 | 1,326 |
| 6 | Aube | 15,327.36 | 407 |
| 7 | Pebane | 14,905.96 | 212 |
| 8 | Galinha | 14,385.03 | 240 |
| 9 | Bajone | 11,414.58 | 220 |
| 10 | Nova Mambone | 12,044.71 | 494 |

## Geographic Notes

- **Save Estuary:** Mangroves distributed across Nova Mambone (12,044.71 ha) and Bazaruto (40.84 ha); forms boundary between Gaza and Sofala provinces
- **Morrumbene:** 1,676.84 ha (Inhambane Province, south coast)
- **Northern Concentrations:** Highest extent in Sofala Province (Chinde, Divinhe, Pebane districts)

## Data Characteristics

- **Pixel aggregation:** GMW v4 classifies mangrove extent at ~25 m resolution; FREQUENCY represents pixel count per district
- **Classification accuracy:** GMW v4 ~86% overall accuracy (varies by region and coastal complexity)
- **Missing data:** No clouds/gaps in 2020 Mozambique coverage
- **Seasonal bias:** Sentinel imagery integrated across dry + wet seasons to minimize inundation-related misclassification

## Use Cases

- Extent account baseline for SEEA EA (2020 reference year)
- Ecosystem services valuation (fisheries nursery, coastal protection)
- Biodiversity monitoring (mangrove as key habitat)
- Climate change baseline (carbon stock estimation potential)

## Data Limitations

- **Temporal resolution:** Single snapshot (2020); no multi-year trend analysis in this dataset
- **Spatial precision:** ~25 m pixel size; small patches (<1 ha) may be missed or aggregated into neighboring districts
- **Classification challenge:** Mangrove-palm confusion in southern districts; creeks/channels may be over-mapped
- **No species composition:** Data provides extent only, not mangrove species or structural characteristics

## Next Steps

1. Cross-validate against field surveys (Morrumbene, Save estuary priority)
2. Link extent to condition accounts (fish/invertebrate biotic indices)
3. Integrate with ecosystem service valuations (nursery, provisioning, protection)
4. Assess 2025–2026 change vs. 2020 baseline (requires updated GMW or Sentinel processing)

## Data Provider

**Global Mangrove Watch (GMW)** — Wetlands International & University of Twente
[https://www.globalmangrovewatch.org/](https://www.globalmangrovewatch.org/)

---

**Prepared:** 2026-03-15
**Integration Status:** Raw data ingested; metadata auto-generated
