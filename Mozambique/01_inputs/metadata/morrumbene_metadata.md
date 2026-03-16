# Morrumbene Mangrove GEDI LIDAR Dataset — Metadata

## Dataset Overview

The dataset covers two strategic mangrove ecosystems in Mozambique:
- **Inhambane Bay** (specifically the Morrumbene estuary)
- **Save River Delta**

## Key Variables & Units

| Variable | Unit | Description |
|----------|------|-------------|
| **Canopy Height (RH100)** | Meters (m) | Maximum height of the mangrove structure |
| **Aboveground Biomass Density (AGBD)** | Megagrams per hectare (Mg/ha) | Total above-ground dry biomass per unit area |
| **Canopy Cover** | Percentage (%) or fraction (0–1) | Density of the upper vegetation layer |
| **Plant Area Index (PAI)** | Unitless (m²/m²) | Total one-sided leaf and stem area per unit ground surface area |
| **Carbon Stock** | Megagrams of Carbon per hectare (Mg C/ha) | Estimated carbon content per unit area |

## Dataset Characteristics

- **Data Source:** NASA's Global Ecosystem Dynamics Investigation (GEDI) LIDAR
  - Products: L2A, L2B, and L4A (Version 2)
- **Spatial Resolution:** Circular footprints of approximately 25 meters in diameter
- **Compilation Date:** Early 2026
- **Mission Period:** 2024 and 2025 orbital observations
- **Boundaries:** Data is strictly clipped to the mangrove forest administrative and ecological boundaries of the two study sites, excluding non-vegetated tidal flats and open water

## File Description

**Filename:** `morrumbene_by_asset.csv`

### Column Definitions

| Column | Type | Description |
|--------|------|-------------|
| `Shape_Leng` | Float | Perimeter of the asset polygon (in degrees or map units) |
| `Asset_ID` | Integer | Unique identifier for each mangrove asset |
| `BUFF_DIST` | Integer | Buffer distance applied (25 m) |
| `Shape_Length` | Float | Normalized shape length metric |
| `Shape_Area` | Float | Area of the asset polygon (in square degrees or map units) |
| `mean_rh100` | Float | Mean canopy height (m) for the asset |
| `mean_L4A_agbd` | Float | Mean aboveground biomass density (Mg/ha) from GEDI L4A |
| `mean_L4A_agbd_se` | Float | Standard error of AGBD estimate (Mg/ha) |
| `mean_L2B_cover` | Float | Mean canopy cover (0–1 fraction) from GEDI L2B |
| `mean_L2B_pai` | Float | Mean Plant Area Index (unitless) from GEDI L2B |
| `mean_L4A_carbono_mgha` | Float | Mean carbon stock (Mg C/ha) from GEDI L4A |
| `Point_Count` | Integer | Number of GEDI footprints contributing to each asset average |

## Data Quality Notes

- Estimates include standard errors (AGBD uncertainty)
- Point counts vary by asset (range: 15–95 observations), indicating different coverage densities
- Data filtered to mangrove-only areas; adjacent salt flats and water excluded

## Use Case

This dataset serves as the baseline for the 2026 in-situ validation campaign, enabling comparison between remote-sensed GEDI estimates and ground-truthed measurements for mangrove extent and carbon stock accounting.

---

**Generated:** 2026-03-15
**Framework:** UN SEEA EA Ecosystem Extent & Carbon Accounts (Mangrove Ecosystems)
