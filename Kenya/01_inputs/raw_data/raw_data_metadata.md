# Metadata: Kenya Raw Data Directory

**Generated:** 2026-03-28

## Overview

Kenya pilot raw data covers four ecosystem domains (coral reef, mangrove, seagrass, fisheries) plus mangrove extent statistics derived from GIS analysis. Study area: Kilifi County, Kenya (coastal). Data collected 2020--2025 across multiple survey programmes (CCVA, GOAP, COMRED/Oceans). Principal investigator: Dr Juliet Karisa.

---

## 1. Mangrove Extent Statistics (root-level CSVs + shapefiles)

All CSV and shapefile outputs were produced in ArcGIS Pro 13.5 (ESRI) between 2026-03-23 and 2026-03-28. Source layers: mangrove extent 2025 (classified raster, converted to polygon) and Global Mangrove Watch (GMW) v4.019 (2020 baseline), clipped to Kenya study area.

### 1.1 Total_mangrove_area_statistics.csv

- **Description:** Total mangrove extent from 2025 classification.
- **Rows:** 1
- **Columns:** DN, FREQUENCY, SUM_area_ha
- **Key values:** 914 polygons; total area = 5,741.64 ha
- **GIS tool:** Summary Statistics on mangroveextent_2025

### 1.2 gmw_mng_2020_v4019_statistics.csv

- **Description:** Total mangrove extent from GMW 2020 baseline (clipped to study area).
- **Rows:** 1
- **Columns:** ClassID, FREQUENCY, SUM_area_ha
- **Key values:** 349 polygons; total area = 6,083.04 ha
- **GIS tool:** Summary Statistics on gmw_mng_2020_v4019_clipped

### 1.3 Mangrove_extent_protected_and_non-protected_areas.csv

- **Description:** Mangrove extent (2025) split by protection status.
- **Rows:** 1
- **Columns:** (unnamed index), Total_area, Protected, Not_protected
- **Key values:** Total = 5,741.64 ha; Protected = 3,806.46 ha (66.3%); Not protected = 1,935.18 ha (33.7%)

### 1.4 True_protected_area_statistics.csv

- **Description:** Total mangrove area within WDPA-designated protected areas.
- **Rows:** 1
- **Columns:** FID_WDPA_d, FREQUENCY, SUM_area_ha
- **Key values:** 259 polygons; 3,806.46 ha

### 1.5 Mangrove_WDPA_statistics.csv

- **Description:** Mangrove extent (2025) disaggregated by individual WDPA protected area.
- **Rows:** 8
- **Columns:** SITE_ID, NAME_ENG, DESIG, DESIG_TYPE, FREQUENCY, SUM_area_ha
- **Protected areas covered:**

| SITE_ID | Name | Designation | Area (ha) |
|---------|------|-------------|-----------|
| 7422 | Arabuko Sokoke | Forest Reserve | 33.21 |
| 19566 | Watamu | Marine National Park | 1,763.05 |
| 478054 | Kaya Chonyi | Not Reported | 0.81 |
| 478055 | Kaya Jibana | Not Reported | 2.52 |
| 555555507 | Lower Tana Delta Conservation Trust | Community Nature Reserve | 0.46 |
| 555555582 | Tana River Delta Ramsar Site | Ramsar Site | 1.26 |
| 555621995 | Watamu | Marine National Reserve | 0.74 |
| 555759476 | Mangrove Swamps | Forest Reserve | 29.99 |

### 1.6 Mangrove_additions_2025-2020.shp (shapefile)

- **Description:** Mangrove areas present in 2025 but absent in GMW 2020 (net gain polygons).
- **Records:** 886 polygons
- **CRS:** WGS 1984 (EPSG:4326)
- **Fields:** FID, Shape, fid_1, DN, area_ha
- **GIS method:** Erase(mangroveextent_2025_WGS1984, gmw_mng_2020_v4019_clipped)

### 1.7 Mangrove_reductions_2020-2025.shp (shapefile)

- **Description:** Mangrove areas present in GMW 2020 but absent in 2025 classification (net loss polygons).
- **Records:** 332 polygons
- **CRS:** WGS 1984 (EPSG:4326)
- **Fields:** FID, Shape, ClassID, area_ha
- **GIS method:** Erase(gmw_mng_2020_v4019_clipped, mangroveextent_2025_WGS1984)

---

## 2. coral_reef/ -- Coral Reef Field Surveys

Study area: Kilifi County coast (Watamu MPA, Takaungu, Kanamai, Wesa, Mtwapa). Three survey programmes contribute data: CCVA (Sept/Nov 2024), GOAP (Nov 2024), and COMRED/Oceans (July 2025).

### 2.1 CCVA-SEPT2024-KILIFI-FISH-DATA.xlsx

- **Sheet:** CCVA-SEPT2024-KILIFI-FISHDATA
- **Rows:** 1,251 (data)
- **Columns (26):** Location, site, Latitude, Longitude, Transect no., Transect Length (M), Date, Time In/Out, Depth (m), Underwater Temp, Dive time, Water visibility, Fish common name, Family Name, Species, Total number, Fish size (cm), Reference Notes
- **Date:** 2024-11-09
- **Transect length:** 50 m
- **Reference:** KMFRI CCVA September 2024

### 2.2 CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx

- **Sheet 1:** CCVA INVERTERBRATES DATA
  - **Rows:** 279 (data)
  - **Columns (18):** Location, site, Latitude, Longitude, Transect no., Transect length (25 m), Date, Time In/Out, Depth (m), Underwater Temp, Dive time, Water visibility, Sea animal common name, Family Name, Species, Total number, Reference Notes
  - **Date:** 2024-10-09
  - **Reference:** KMFRI CCVA September 2024
- **Sheet 2:** Sheet1 -- Site coordinate reference table (23 rows)

### 2.3 COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx

Three sheets covering coral abundance by size class, recruit counts, and health condition:

- **Sheet: Adult size class** -- 334 rows, 21 cols
  - Size classes: 11-20, 21-40, 41-80, 80-160, 160-320, >>320 cm
  - Collector: Mohamed Hamisi; Supervisor: Dr Juliet Karisa
- **Sheet: Recruits** -- 1,957 rows, 20 cols
  - Size classes: 0-2.5 cm, 2.6-5 cm, 6-10 cm
  - Includes quadrant-level data per transect
- **Sheet: Conditions** -- 338 rows, 23 cols
  - Health categories: Healthy, Pale, Bleached, Diseased, Dead

- **Date:** 19-07-2025
- **Locations:** Kilifi (Wesa, Watamu MPA)
- **Reference:** COMRED Ecological Surveys

### 2.4 COMRED_OCEANS-JULY2025-CORAL COVER-DATA.xlsx

- **Sheet: Major benthic category** -- 136 rows, 8 cols
  - Columns: Year, Date, County, Area/Location, Site name, Transect no., Major benthic category, % Cover
- **Sheet: Coral Genera** -- 560 rows, 8 cols
  - Columns: Year, Date, County, Area/Location, Site name, Transect no., Coral Genera, % Cover
- **Locations:** Kilifi (Watamu MPA)

### 2.5 COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx

- **Sheet: Major benthic category** -- 170 rows, 9 cols
- **Sheet: Coral Genera** -- 770 rows, 9 cols
- Adds Site detail 2 column compared to CORAL COVER dataset
- **Locations:** Kilifi (Watamu MPA)
- **Note:** Appears to be an expanded version of 2.4 with additional site detail field

### 2.6 COMRED_OCEANS-JULY2025-FISH-DATA.xlsx

- **Sheet: Fish data** -- 343 rows, 20 cols
  - Columns: Date, Area/Location, Site name 1/2, Latitude, Longitude, Transect no., Transect Length (50 m), Time In/Out, Depth, Temp, Dive time, Visibility, Fish common name, Family Name, Species, Total number, Fish size (cm), Reference
- **Sheet: Inverts** -- empty (header only)
- **Date:** 19/7/2025
- **Locations:** Wesa, Watamu MPA
- **Reference:** COMRED Ecological Surveys

### 2.7 KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx

- **Sheet:** KLF-FISH-DATA-CCVA-GOAP-COMRED
- **Rows:** 698 (data)
- **Columns (21):** Date, County, Area/location, Site name 1/2, Latitude, Longitude, Transect no., Transect Length (50 m), Time In/Out, Depth, Temp, Dive time, Visibility, Fish common name, Family Name, Species, Total number, Fish size (cm), Reference Notes
- **Note:** Consolidated fish dataset combining CCVA, GOAP, and COMRED surveys
- **Reference notes include:** KMFRI CCVA September 2024

### 2.8 PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx

Five sheets covering benthic extent, coral adult size, condition, and recruits:

- **Sheet: Extent** -- 163 rows, 18 cols
  - Benthic cover categories: Live Coral %, Dead Coral, Bleached Coral, Seagrass %, Rubble %, Macro-algae %, Sand
  - Locations: Jumba Ruins/Kanamai, Mtwapa, Takaungu
- **Sheet: Adult size** -- 592 rows, 16 cols
  - Size classes: 11-20, 21-40, 41-80, 80-160, 160-320, >>320 cm
- **Sheet: Condition** -- 594 rows, 20 cols
  - Health categories: Healthy, Pale, Bleached, Diseased, Dead
- **Sheet: Condition 1** -- 770 rows, 16 cols
  - Alternate format with Size Class as a single column
- **Sheet: Recruits** -- 3,168 rows, 14 cols
  - Size classes: 0-2.5 cm, 2.6-5 cm, 6-10 cm; includes quadrant detail

- **Date:** Nov 2024
- **Collectors:** Mohamed/Nancy; Supervisor: Dr Juliet

### 2.9 Coral_Reef_Report_Kilifi.docx

- **Description:** Report document for Kilifi coral reef surveys (39 KB)

---

## 3. mangrove/ -- Mangrove Field Survey Data

### 3.1 All_mangrove_field_data.xlsx

- **Sheet:** Sheet1
- **Rows:** 2,095 (data)
- **Columns (20):** Observers, Date, Area, Site, Plot no., Eastings, Southings, Plot size (m2), Forest type, Inundation class, Cover, Tree no., Sub (Branch), Species, P.O.M, Circumference (cm), DBH (cm), Height (m), Quality, Comments
- **Plot size:** 100 m2
- **Date:** 2025-09-12 onward
- **Areas:** Ngomeni and others (Kilifi County)
- **Species observed include:** Rhizophora mucronata
- **Tree-level data:** individual tree measurements (circumference, DBH, height, quality/condition)

### 3.2 new_data_submission_form34_Mangrove_Conditions.xlsx

- **Description:** Data submission form template for mangrove conditions dataset onboarding.

---

## 4. seagrass/ -- Seagrass Field Survey Data

### 4.1 All_seagrass_field_data.xlsx

Two sheets covering cover and health:

- **Sheet: SEAGRASS COVER** -- 1,604 rows, 25 cols
  - Columns: Date, County, Area, Latitude, Longitude, Quadrant 5m x 5m, Quadrant 50cm x 50cm, Percentage Cover, Substrate type
  - Date: 2024-05-11 onward
  - Areas: Kanamai-Jumba Ruins (Kilifi)
  - Species include: Cymodocea rotundata

- **Sheet: SEAGRASS HEALTH** -- 1,436 rows, 25 cols
  - Columns: Date, County, Area, Zone, Latitude, Longitude, Quadrant 15cm x 15cm, Seagrass species, Shoot density, Canopy height
  - Date: 2024-06-11 onward
  - Zones: Near shore
  - Species include: Thalassia hemprichii

### 4.2 new_data_submission_form34_Seagrass_Conditions.xlsx

- **Description:** Data submission form template for seagrass conditions dataset onboarding.

---

## 5. fisheries/ -- Fisheries Catch and Value Data

### 5.1 Fisheries Data.xlsx

Annual fisheries catch and economic value for Kilifi County:

- **Sheet: Fisheries Catches** -- 5 rows, 4 cols
  - Columns: Year, County, Catch (MT), Value (KES million)
  - Years: 2020--2024 (Kilifi)
  - Example: 2020 = 4,452 MT, KES 1,273 million
- **Sheet: 2024** -- 36 rows (fish group breakdown)
- **Sheet: 2023** -- 37 rows
- **Sheet: 2022** -- 37 rows
- **Sheet: 2021** -- 36 rows
- **Sheet: 2020** -- 39 rows
  - All annual sheets have columns: Fish group, Catch (MT), Value (,000 KES)
  - Fish groups include: Rabbit fish, and other species groups

### 5.2 new_data_submission_form34_Fisheries_Data.xlsx

- **Description:** Data submission form template for fisheries dataset onboarding.

---

## 6. _misc/ -- Supporting Documents

| File | Description |
|------|-------------|
| Copy of new_data_submission_form_required_per_dataset.xlsx | Blank data submission template |
| JULIET METADATA.xlsx | Completed metadata submission form (Dr Juliet Karisa) |
| Ground truthing extent and condition of ecosystems - coral reefs and seagrass.xlsx | Field campaign budget and schedule (Nov 2024, 15 days) |
| Juliet Karisa_Progress report 3 - Monitoring the socio-ecological resilience-23rd-sept-2025.docx | Progress report (16 MB) |

---

## Summary Statistics

| Domain | Files | Total data rows (approx.) | Survey periods |
|--------|-------|--------------------------|----------------|
| Coral reef | 8 xlsx + 1 docx | ~12,600 | Sept 2024, Nov 2024, July 2025 |
| Mangrove (field) | 1 xlsx | ~2,095 | Sept 2025 |
| Seagrass | 1 xlsx | ~3,040 | May--June 2024 |
| Fisheries | 1 xlsx | ~195 | 2020--2024 |
| Mangrove extent (GIS) | 5 CSV + 2 shapefiles | 1,218 polygons | GMW 2020 vs 2025 classification |

## Notes

- CRS for all spatial data: WGS 1984 (EPSG:4326)
- GIS processing performed in ArcGIS Pro 13.5.3 (user z5035059)
- Mangrove extent 2025 was originally projected in UTM Zone 37S, then reprojected to WGS 1984 for change analysis
- Coral reef datasets have overlapping fish records across CCVA, GOAP, and COMRED surveys; KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx appears to consolidate these
- COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx and COMRED_OCEANS-JULY2025-CORAL COVER-DATA.xlsx share similar structure; the former adds a Site detail 2 field
