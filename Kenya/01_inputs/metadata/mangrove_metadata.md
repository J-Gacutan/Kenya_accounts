# Metadata: Mangrove Field Data — Kilifi County, Kenya (2025)

**Generated:** 2026-03-16

## Overview

Plot-based mangrove structural field survey data from four sites in Kilifi County, collected Sep-Dec 2025. Individual tree measurements supporting mangrove condition assessment and biomass/carbon stock estimation.

- **Data file:** `mangrove/All_mangrove_field_data.xlsx`
- **Submission form:** `mangrove/new_data_submission_form34_Mangrove_Conditions.xlsx`
- **Dataset title:** Kilifi Mangrove Structural Survey 2025
- **Source type:** Primary field survey (ecological monitoring)
- **County:** Kilifi, Kenya
- **Survey sites:** Ngomeni, Marereni, Mida Creek, Kilifi Creek
- **Temporal coverage:** 2025-09-12 to 2025-12-12 (primary survey: 8-12 Dec 2025)
- **Update frequency:** Irregular / project-based (recommended every 3-5 years)
- **Submission date:** 2026-03-13
- **Submitter:** Dr. Pascal Thoya, Pwani University (pascalthoya at gmail.com)
- **Preferred citation:** Simwa, P. and Thoya, P. (2025). Mangrove Structural Assessment Dataset for Kilifi County, Kenya. Field survey data collected in Ngomeni, Marereni, Mida Creek, and Kilifi Creek to support ecosystem condition assessment and ocean accounting applications.
- **Access restrictions:** Requires author approval for publication, reports, or external dissemination; proper acknowledgement required. Currently used for academic research including Masters student analysis.

---

## File 1: All_mangrove_field_data.xlsx

- **Sheet:** Sheet1
- **Total rows:** 2,095 (data) | **Columns:** 20
- **Plot size:** 10 x 10 m (100 m2)
- **Sampling design:** 38 plots, stratified-random, spaced approximately 500 m to 1 km apart
- **CRS:** WGS 84 (EPSG:4326); GPS positional accuracy approximately +/-5-10 m
- **Bounding box:** South -3.64678, North -2.74392, West 39.79517, East 40.21909

### Areas and sites

- **Areas (n=13):** Dabaso, Debaso, Kidundu, Kilifi creek, Marereni, Marereni-Kwa Kanyama, Mida, Mida Creek, Mtongani, Mtongani/Kidundu, Ngomeni, Ngomeni Rasi, Rasi
- **Sites (n=22):** Boardwalk, Darajani, Debaso Rock, Fisheries, Kachaa, Kadzuyuni, Kaogoni, Kidundu, Kurawa-kanagoni, Kwa Douglas, Kwa Nzai, Kwazimba Island, Luwahi, Mandarini, Mida, Mto wa Mawe, Mtongani, Mwinyihaji, Mzodzongoloni, Pwani toto, Rasi, Rasi Msikiti
- **Observers:** Patricia & Kisilu (primary), Kisilu et al., Gilbert et al., Marvin et al.

### Column summary

| Column | Description | Units |
| --- | --- | --- |
| Observers | Field team names | Text |
| Date | Survey date | Date |
| Area | Broad geographic area | Text |
| Site | Site name within area | Text |
| Plot no. | Plot identifier | Number |
| Eastings | GPS easting coordinate | DMS string |
| Southings | GPS southing coordinate | DMS string |
| Plot size (m2) | Plot area | m2 |
| Forest type | Mangrove forest type classification | Categorical |
| Inundation class | Tidal inundation zone (1-4) | Categorical |
| Cover | Canopy cover class | % range |
| Tree no. | Individual tree identifier within plot | Number |
| Sub (Branch) | Sub-branch indicator | Flag |
| Species | Mangrove species | Text (see species list) |
| P.O.M | Point of measurement height | cm |
| Circumference (cm) | Stem circumference at POM | cm |
| DBH (cm) | Diameter at breast height (calculated) | cm |
| Height (m) | Tree height | m |
| Quality | Structural health/quality category (1-3) | Categorical |
| Comments | Observer notes | Text |

### Species recorded

4 species (recorded as both full scientific names and abbreviations):

| Abbreviation | Full name |
| --- | --- |
| RM / Rm | Rhizophora mucronata |
| AM / Am | Avicennia marina |
| BG / Bg | Bruguiera gymnorhiza |
| CT / Ct | Ceriops tagal |

## Collection Methodology

Structured ecological survey using plot-based sampling (10 x 10 m plots). Within each plot: tree circumference (converted to DBH), tree height, species identification, regeneration count (seedlings/saplings), and disturbance indicators (stumps, dieback, human activity). GPS coordinates recorded for each plot centre in WGS84.

## SEEA EA Relevance

- **Condition accounts (M2.1 mangrove):** DBH, height, canopy cover, and tree quality directly map to biotic condition indicators
- **Extent accounts:** Plot coordinates support spatial integration with satellite imagery (e.g., GMW, Sentinel-2)
- **Biomass/carbon:** DBH + height enable allometric biomass estimation (WIO-specific equations required)
- **Data gaps:** No species-level allometric parameters (a/b) included in dataset; WIO mangrove allometric equations needed for biomass calculation

## Data Quality

- **Validated:** Yes — field measurements reviewed and cleaned; coordinates checked in GIS
- **Fitness for purpose:** High — suitable for mangrove structure, condition, and carbon stock assessment
- **Complies with:** Standard mangrove plot-based assessment methods; SEEA EA and GOAP data requirements
- **Known limitations:**
  - Sample-based coverage; not a full spatial census of all Kilifi mangroves
  - Observer differences, tidal conditions, and accessibility constraints may introduce variability
  - GPS positional accuracy +/-5-10 m (canopy cover may affect signal)
  - Snapshot survey (Dec 2025); no seasonal or interannual change data
- **Data quality flags:**
  - Species names inconsistent: full scientific names (Rhizophora mucronata) and abbreviations (RM, Rm) mixed throughout; standardise before analysis
  - Area names inconsistent: "Debaso" vs "Dabaso"; "Mida" vs "Mida Creek" appear to refer to the same areas
  - Coordinates stored as DMS strings (e.g., 40 degrees 11' 1.01"), not decimal degrees; conversion required for GIS analysis
  - Survey dates extend from Sep 2025 (initial reconnaissance) through Dec 2025 (main survey); primary survey period is 8-12 Dec 2025

---

## File 2: new_data_submission_form34_Mangrove_Conditions.xlsx

Completed metadata submission form. Source of dataset title, survey design, collection methodology, spatial extent, quality indicators, contact details, and citation above. Sheets: Submission Form (filled) | Lists (lookup values).
