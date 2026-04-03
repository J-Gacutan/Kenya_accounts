# Metadata: Seagrass Field Data — Kilifi County, Kenya (2024)

**Generated:** 2026-03-16

## Overview

Quadrat-based seagrass ground-truthing and condition assessment data from 10 coastal sites across Kilifi County, collected in 2024. Two data streams: percentage cover (extent ground-truthing) and shoot-level biotic condition (health indicators).

- **Data file:** `seagrass/All_seagrass_field_data.xlsx`
- **Submission form:** `seagrass/new_data_submission_form34_Seagrass_Conditions.xlsx`
- **Dataset title:** Seagrass Ground-Truthing and Condition Assessment Dataset - Kilifi County, Kenya
- **Source type:** Primary field survey (ecological monitoring and ground-truthing for habitat mapping)
- **County:** Kilifi, Kenya
- **Survey sites:** Takaungu, Bofa, Kikambala, Kuruwitu, Kanamai-Jumba ruins, Wesa, Roka, Malindi marine park, Marereni, Ngomeni
- **Temporal coverage:** May-November 2024 (ground-truthing survey: November 2024; additional surveys from May 2024)
- **Update frequency:** Irregular / project-based
- **Submission date:** 2026-03-13
- **Submitter:** Dr. Pascal Thoya, Pwani University (pascalthoya at gmail.com)
- **Preferred citation:** Musembi, P. and Thoya, P. (2024). Seagrass Ground-Truthing and Condition Assessment Dataset for Kilifi County, Kenya. Field survey data collected across coastal sites including Takaungu, Kikambala, Kanamai, Malindi Marine Park, Marereni, and Ngomeni.
- **Access restrictions:** Requires author approval for publication, reports, or external dissemination; proper acknowledgement required. Currently used for academic research including Masters student analysis.

---

## File 1: All_seagrass_field_data.xlsx

- **Sheets:** SEAGRASS COVER | SEAGRASS HEALTH
- **Total rows:** 3,040 (both sheets combined)
- **CRS:** WGS 84 (EPSG:4326); GPS positional accuracy approximately +/-5-10 m (Garmin handheld devices)

### Sheet: SEAGRASS COVER

- **Rows:** 1,604 | **Columns:** 9 (plus 16 blank trailing columns)
- **Sampling unit:** 50 cm x 50 cm quadrats nested within 5 m x 5 m reference plots
- **Date range:** May-November 2024 (primary ground-truthing survey: November 2024)
- **Areas (n=10):** Bofa, Kanamai-Jumba ruins, Kikambala, Kuruwitu, Malindi marine park, Marereni, Ngomeni, Roka, Takaungu, Wesa

| Column | Description | Units |
| --- | --- | --- |
| Date | Survey date | Date |
| County | Administrative county | Text |
| Area | Site/area name | Text |
| Latitude | GPS latitude of quadrat | Decimal degrees |
| Longitude | GPS longitude of quadrat | Decimal degrees |
| Quadrant 5m x 5m | Reference plot identifier | ID |
| Quadrant 50cm x 50cm | Sub-quadrat identifier | ID |
| Percentage Cover | Seagrass cover within sub-quadrat | % |
| Substrate type | Dominant seagrass species or substrate | Text |

**Substrate/species recorded:** Cymodocea rotundata, Cymodocea serrulata, Enhalus acoroides, Halodule uninervis, Halophilia ovalis, Halophilia stipulacea, Syringodium isoetifolium, Thalassodendron ciliatum, Thelassia hemprichii, Sand

### Sheet: SEAGRASS HEALTH

- **Rows:** 1,436 | **Columns:** 10 (plus 15 blank trailing columns)
- **Sampling unit:** 15 cm x 15 cm quadrats
- **Date range:** June-November 2024
- **Areas (n=11):** Bofa, Jumba ruins, Kanamai, Kikambala, Kuruwitu, Malindi marine park, Marereni, Ngomeni, Roka, Takaungu, Wesa
- **Zones:** Near shore, Middle, Near reef

| Column | Description | Units |
| --- | --- | --- |
| Date | Survey date | Date |
| County | Administrative county | Text |
| Area | Site/area name | Text |
| Zone | Intertidal/depth zone | Categorical |
| Latitude (S) | GPS latitude | Decimal degrees |
| Longitude (E) | GPS longitude | Decimal degrees |
| Quadrant 15cm x 15cm | Quadrat identifier | ID |
| Seagrass species | Species recorded | Text |
| Shoot density | Number of shoots in quadrat | Count |
| Canopy height | Shoot height | cm |

**Species recorded (n=11):** Cymodocea rotundata, Cymodocea serrulata, Enhalus acoroides, Halodule uninervis, Halodule wrightii, Halophilia ovalis, Halophilia stipulacea, Syringodium isoetifolium, Thalassodendron ciliatum, Thelassia hemprichii

## Collection Methodology

Quadrat-based ecological sampling conducted during low tide. Cover sheet: 50 cm x 50 cm sub-quadrats nested within 5 m x 5 m reference plots; visual percentage cover estimates recorded per quadrat; sampling points spaced approximately 100-200 m apart. Health sheet: 15 cm x 15 cm quadrats for shoot density and canopy height measurements. GPS coordinates (WGS84) recorded at each sampling location using handheld Garmin devices.

## SEEA EA Relevance

- **Condition accounts (seagrass):** Shoot density and canopy height are biotic condition indicators directly comparable to SEEA EA standards
- **Extent accounts:** Percentage cover + spatial coordinates support remote sensing ground-truthing and area estimation across all 10 survey sites
- **Multi-species:** 11 species recorded across two sheets; richness and dominant species feed community composition indicators
- **Data gaps:**
  - Single time point (2024); no trend data for change detection
  - No biomass measurements (aboveground/belowground); would require separate destructive sampling

## Data Quality

- **Validated:** Yes — field observations and coordinates checked during data entry; reviewed in GIS and spreadsheet software
- **Fitness for purpose:** High — suitable for seagrass condition assessment, remote sensing ground-truthing, and SEEA EA ecosystem accounting
- **Complies with:** Standard seagrass quadrat-based monitoring methods; SEEA EA and GOAP indicator requirements
- **Known limitations:**
  - Sample-based observations; does not capture full spatial variability of all seagrass meadows in Kilifi County
  - Visual cover estimates introduce observer variability
  - GPS positional accuracy +/-5-10 m
  - Tidal conditions and accessibility constraints influenced site selection
- **Data quality flags:**
  - Date formats inconsistent: mix of YYYY-MM-DD and DD/MM/YYYY formats; standardise before analysis
  - Some dates appear as numbers (e.g., 2024-05-11 stored as date integer); verify parsing in R/Python
  - Species names contain inconsistencies: "Halophilia" (used in data) vs correct spelling "Halophila"; "Thelassia hemprichii" vs correct "Thalassia hemprichii"; "Halodule wrightii" vs "Halodulle wrightii" (typo variant) — standardise taxonomy before analysis
  - "Sand" / "sand" inconsistency in substrate type column (case variation)
  - Coordinates stored as strings in degree-minute format in some rows; verify decimal degree conversion

---

## File 2: new_data_submission_form34_Seagrass_Conditions.xlsx

Completed metadata submission form. Source of dataset title, survey design, collection methodology, spatial extent, quality indicators, contact details, and citation above. Sheets: Submission Form (filled) | Lists (lookup values).
