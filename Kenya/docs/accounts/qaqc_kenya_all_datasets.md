# QA/QC Checklist — Kenya All Datasets

**Project:** AFRICA — accounts / Kenya
**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Geographic scope:** Kilifi County, Kenya
**Generated:** 2026-03-16

This document lists every data quality issue identified from metadata review, with the exact change required per file and field. Each item is a discrete, implementable task to be checked off in the R analysis scripts before any indicator calculation.

---

## Status Summary

| Dataset | File(s) | Issues | Status |
|---------|---------|--------|--------|
| Coral reef — fish UVC | CCVA-FISH, COMRED-FISH, KLF-consolidated | 7 | PENDING |
| Coral reef — invertebrates | CCVA-INVERTS | 3 | PENDING |
| Coral reef — benthic/coral structure | COMRED-CORAL COVER, COMRED-CORAL-DATA, COMRED-ABUNDANCE, PU-GOAP-CORALDATA | 2 | PENDING |
| Fisheries landings | Fisheries Data | 3 | PENDING |
| Mangrove | All_mangrove_field_data | 4 | PENDING |
| Seagrass | All_seagrass_field_data | 6 | PENDING |
| Cross-file (all datasets) | All | 3 | PENDING |

---

## 1. Coral Reef — Fish UVC

### File: CCVA-SEPT2024-KILIFI-FISH-DATA.xlsx

**QA-FISH-01: Remove duplicate longitude column**
- Issue: Two longitude columns present (`longtitude` and `Longtitude`); one appears to be a copy
- Change: Read both columns; compare values row-by-row; confirm which is correct (cross-check against CCVA-INVERTS Sheet1 site coordinate reference table); drop the duplicate; rename retained column to `longitude`
- Field affected: Column 4 and column 5 (approximate positions)
- Blocking: Yes — any spatial or GPS validation step will use wrong coordinates if duplicate is not resolved

**QA-FISH-02: Standardise species name casing**
- Issue: Mixed case in species names (e.g., `parupeneus macronemus` vs `Parupeneus macronemus`)
- Change: Apply `str_to_sentence()` to Species column (capitalise first letter only); trim leading/trailing whitespace
- Field affected: `Species`
- Blocking: Yes — species-level joins to FishBase a/b parameters will fail on case mismatch

**QA-FISH-03: Standardise location names**
- Issue: `Sultance palace` (Files 1, 2, 7) — likely typo for `Sultan's Palace` or `Sultan Palace`
- Change: Define lookup table mapping raw location strings to canonical names; apply `recode()` or `case_when()` across all fish files before merging
- Canonical name decisions needed: confirm with Dr. Karisa / Dr. Thoya which spelling is official
- Field affected: `Location`
- Blocking: No for single-file analysis; Yes for cross-file merging

**QA-FISH-04: Confirm and document transect width**
- Issue: Transect length is 50 m but width is not specified in the file; width is required to calculate per-hectare densities and biomass
- Change: Confirm with field team (Dr. Karisa / Mohamed Hamisi) whether belt width was 2 m (standard 50x2 = 100 m2) or another width; document confirmed value in this file and in `cond_reef_coral_fish_invert_plan.md`
- Field affected: Transect area assumption (not a column; a metadata parameter)
- Blocking: Yes — all biomass (kg/ha) and abundance (ind/ha) calculations depend on this

**QA-FISH-05: Source and join FishBase allometric parameters (a/b)**
- Issue: No length-weight parameters (`a`, `b`) included in any Kenya fish UVC file (unlike Madagascar dataset which had a/b per row)
- Change: (1) Extract unique species list from all fish UVC files; (2) retrieve a/b from FishBase for each species (see `fishbase_params_kenya.csv` in `01_inputs/metadata/`); (3) left-join to fish data on `Species`; (4) flag any species with no match
- Field affected: New columns `a` and `b` to be added
- Blocking: Yes — fish biomass calculation (W = a x L^b) cannot proceed without these

**QA-FISH-06: Convert fish size range strings to midpoint values**
- Issue: Fish size recorded as range strings (e.g., `5--10`) rather than numeric midpoints
- Change: Parse size range column; extract lower and upper bounds; calculate midpoint (e.g., `(5+10)/2 = 7.5`); store as numeric column `size_midpoint_cm`
- Size class midpoints to use: 5--10 = 7.5, 10--20 = 15, 20--30 = 25, 30--40 = 35, 40--50 = 45, 50--60 = 55
- Field affected: `Fish size (cm)`
- Blocking: Yes — biomass calculation requires numeric size values

**QA-FISH-07: Assign functional/trophic groups**
- Issue: No functional or trophic group assignments in Kenya fish files (unlike Madagascar dataset)
- Change: Join species-level trophic assignments from FishBase or a reference lookup table; minimum required groups: Herbivore, Carnivore, Planktivore, Omnivore, Corallivore, Piscivore, Detritivore
- This can be combined with QA-FISH-05 (FishBase lookup)
- Field affected: New column `functional_group`
- Blocking: Yes for trophic composition indicator; No for total biomass and richness

---

### File: COMRED_OCEANS-JULY2025-FISH-DATA.xlsx

**QA-FISH-08: Flag missing invertebrate data**
- Issue: Inverts sheet is present in the file but is empty (template only); no COMRED July 2025 invertebrate data is available
- Change: Document as a data gap in the analysis script header; do not attempt to read the Inverts sheet; note that CCVA-INVERTS (Oct-Nov 2024) is the only invertebrate source
- Field affected: Sheet `Inverts`
- Blocking: No for invertebrate analysis (CCVA data still usable); note as limitation in condition account

Apply also QA-FISH-05, QA-FISH-06, QA-FISH-07 to this file.

---

### File: KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx (consolidated master)

**QA-FISH-09: Filter out template rows**
- Issue: File contains pre-populated template rows for years 2025-2092 with site coordinates but no observation data (fish counts = blank)
- Change: Filter to rows where `Total number` is not NA and `Date` falls within the actual survey period (Nov 2024 only for this file); discard all future-year template rows
- Field affected: All columns; filter on `Date` and `Total number`
- Blocking: Yes — template rows will inflate site counts and introduce blank records into analysis

**QA-FISH-10: Verify REFERENCE NOTES column before merging**
- Issue: REFERENCE NOTES identifies the source survey programme for each row (`KMFRI CCVA`, `Pwani/KMFRI GOAP`, `COMRED`); this is required to avoid double-counting when this file overlaps with individual programme files
- Change: Before using KLF as the master consolidated file, confirm which rows are unique to KLF (i.e., not already in CCVA-FISH or COMRED-FISH); document consolidation decision (use KLF as master and drop individual files, OR use individual files and ignore KLF)
- Field affected: `REFERENCE NOTES`
- Blocking: Yes — double-counting fish observations will inflate all community metrics

Apply also QA-FISH-03, QA-FISH-05, QA-FISH-06, QA-FISH-07 to this file.

---

## 2. Coral Reef — Invertebrates

### File: CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx

**QA-INV-01: Correct latitude sign error**
- Issue: Row 2 has a positive latitude value (`3.94326`) which places the site north of the equator; all other rows in the dataset have negative latitudes (Kenya south coast is approximately -3 to -4 degrees)
- Change: Inspect row 2; if the site is on the south Kenya coast, apply negative sign (`-3.94326`); cross-check against Sheet1 site coordinate reference table for the same site name
- Field affected: `Latitude`, row 2
- Blocking: Yes for spatial validation and mapping; site would plot in the wrong hemisphere

**QA-INV-02: Cross-check all coordinates against Sheet1 reference table**
- Issue: Sheet1 contains a 22-row site coordinate reference table with GPS positions for named dive sites; the primary data sheet may contain GPS errors correctable against this reference
- Change: Join primary sheet coordinates to Sheet1 on site name; flag rows where lat/lon differs by more than 0.01 degrees from the reference; manually review flagged rows
- Field affected: `Latitude`, `longtitude`
- Blocking: No for analysis; recommended for spatial integrity

**QA-INV-03: Standardise location names**
- Issue: Same naming inconsistencies as fish files (e.g., `Sultance palace`)
- Change: Apply same canonical location name lookup table as defined in QA-FISH-03
- Field affected: `Location`
- Blocking: No for single-file analysis; Yes for cross-file merging

---

## 3. Coral Reef — Benthic / Coral Structure

### Files: COMRED_OCEANS-JULY2025-CORAL COVER-DATA.xlsx and COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx

**QA-CORAL-01: Determine authoritative benthic cover file**
- Issue: CORAL COVER (File 4, 696 rows) appears to be a subset of CORAL-DATA (File 5, 941 rows); both contain the same benthic categories and overlapping sites; reading both would double-count benthic cover data
- Change: Compare site lists and row counts between the two files; if File 4 is confirmed to be a subset of File 5, use File 5 (CORAL-DATA) as the authoritative benthic cover source and do not read File 4 in analysis; document this decision with a comment in the R script
- Field affected: All benthic cover columns
- Blocking: Yes — double-counting will inflate live coral cover percentages

### File: PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx

**QA-CORAL-02: Select one Condition sheet format**
- Issue: Sheets `Condition` and `Condition 1` contain the same coral health data in two different formats (wide vs. long); reading both will duplicate all condition records
- Change: Choose one sheet for analysis; recommended: use `Condition 1` (size class in single column = long format, easier to work with in R); drop `Condition` sheet; document choice in R script header
- Field affected: Coral health counts (Healthy, Pale, Bleached, Diseased, Dead)
- Blocking: Yes — if both sheets are read and bound, all condition records will be doubled

---

## 4. Fisheries Landings

### File: Fisheries Data.xlsx

**QA-FISH-11: Standardise species group names across years**
- Issue: Species group names vary between annual sheets due to spelling differences
- Specific changes required:

| Raw (inconsistent) | Canonical |
|--------------------|-----------|
| `Scarvenger` | `Scavenger` |
| `Littla mackerels` | `Little mackerels` |
| `Dolphin Fish` | `Dolphins` |
| `Steaker` | `Streaker` |

- Change: Apply lookup/recode to species group column in each annual sheet before binding rows into a multi-year panel
- Field affected: `Fish group` (or equivalent column name in each sheet)
- Blocking: Yes for multi-year trend analysis — mismatched names will create spurious new groups

**QA-FISH-12: Flag 2023 values as estimates**
- Issue: 2023 catch and value totals are flagged with asterisk in the source data as estimates, not confirmed figures
- Change: Add a boolean column `is_estimate` (TRUE for 2023 rows, FALSE for all other years) when constructing the multi-year panel; carry this flag into any trend analysis output
- Field affected: Catch (MT) and Value (KES) for year 2023
- Blocking: No; analytical note only

**QA-FISH-13: Convert KES to USD**
- Issue: Value column is in KES (Kenyan Shillings); SEEA EA standard accounts require USD
- Change: Apply a consistent KES/USD exchange rate; recommended approach: use annual average Central Bank of Kenya rate for each year (2020-2024); document the rates used and their source in the R script; add `value_usd` column alongside `value_kes`
- Field affected: `Value (KES '000)` in each annual sheet
- Blocking: Yes for monetary valuation in SEEA EA tables

---

## 5. Mangrove

### File: All_mangrove_field_data.xlsx

**QA-MANG-01: Standardise species names**
- Issue: Species names recorded inconsistently — full scientific names and abbreviations mixed throughout the dataset

| Raw variants | Canonical |
|---|---|
| `RM`, `Rm`, `Rhizophora mucronata` | `Rhizophora mucronata` |
| `AM`, `Am`, `Avicennia marina` | `Avicennia marina` |
| `BG`, `Bg`, `Bruguiera gymnorhiza` | `Bruguiera gymnorhiza` |
| `CT`, `Ct`, `Ceriops tagal` | `Ceriops tagal` |

- Change: Apply lookup/recode to `Species` column; map all abbreviation variants and full name variants to the single canonical scientific name
- Field affected: `Species`
- Blocking: Yes — species-specific allometric equations cannot be applied with mixed formats

**QA-MANG-02: Standardise area names**
- Issue: Area names contain apparent duplicates from different spelling conventions

| Raw variants | Canonical (to confirm) |
|---|---|
| `Debaso`, `Dabaso` | Confirm with Dr. Thoya; one spelling only |
| `Mida`, `Mida Creek` | Confirm if same area or distinct; likely same |
| `Mtongani`, `Mtongani/Kidundu` | Distinct sub-areas; retain as-is or split |
| `Ngomeni`, `Ngomeni Rasi`, `Rasi` | Confirm if `Rasi` is a sub-area of `Ngomeni` |

- Change: After confirmation, apply lookup/recode to `Area` column
- Field affected: `Area`
- Blocking: No for plot-level analysis; Yes for site-level aggregation

**QA-MANG-03: Convert GPS coordinates from DMS to decimal degrees**
- Issue: Eastings and Southings stored as degree-minute-second strings (e.g., `40 degrees 11' 1.01"`) rather than decimal degrees
- Change: Write a parsing function to extract degrees, minutes, seconds from string; convert using `DD = degrees + minutes/60 + seconds/3600`; apply negative sign to Southings (all sites should have negative latitude); store as numeric columns `latitude` and `longitude`
- Field affected: `Eastings`, `Southings`
- Blocking: Yes for any GIS spatial join (e.g., PA overlap with WDPA)

**QA-MANG-04: Source WIO mangrove allometric equations**
- Issue: No allometric parameters (a/b) included in the dataset; biomass estimation from DBH + height requires species-specific equations
- Change: Source WIO-specific allometric equations from literature for all 4 species (Rhizophora mucronata, Avicennia marina, Bruguiera gymnorhiza, Ceriops tagal); recommended sources: Kauffman & Donato (2012) CIFOR; Komiyama et al. (2008) Forest Ecology and Management; document equations with citations in the R script
- Field affected: New derived columns `agb_kg` (aboveground biomass per tree), `bgb_kg` (belowground biomass)
- Blocking: Yes for biomass and carbon stock indicators

---

## 6. Seagrass

### File: All_seagrass_field_data.xlsx (both sheets: SEAGRASS COVER and SEAGRASS HEALTH)

**QA-SG-01: Standardise date formats**
- Issue: Date values use mixed formats (`YYYY-MM-DD` and `DD/MM/YYYY`); some dates are stored as Excel date integers
- Change: Read date column with `readxl::read_excel()`; convert all to `Date` class using `lubridate::parse_date_time()` with multiple format orders (`c("Ymd", "dmy")`); verify all dates fall within May-November 2024; flag any out-of-range values
- Field affected: `Date` (both sheets)
- Blocking: Yes for any temporal filtering or multi-date analysis

**QA-SG-02: Fix species name spelling errors**
- Issue: Systematic misspellings in species names across both sheets

| Raw (incorrect) | Correct |
|---|---|
| `Halophilia ovalis` | `Halophila ovalis` |
| `Halophilia stipulacea` | `Halophila stipulacea` |
| `Thelassia hemprichii` | `Thalassia hemprichii` |
| `Halodulle wrightii` | `Halodule wrightii` |

- Change: Apply lookup/recode to `Substrate type` (Cover sheet) and `Seagrass species` (Health sheet); also check for mixed case variants (e.g., `cymodocea rotundata` vs `Cymodocea rotundata`) and apply `str_to_sentence()`
- Field affected: `Substrate type` (Cover sheet), `Seagrass species` (Health sheet)
- Blocking: Yes — species richness counts and species-level condition indicators will be wrong with misspellings

**QA-SG-03: Standardise substrate type casing**
- Issue: `Sand` and `sand` both present in the `Substrate type` column
- Change: Apply `str_to_sentence()` or explicit recode to the `Substrate type` column; canonical form: `Sand`
- Field affected: `Substrate type` (Cover sheet)
- Blocking: No for seagrass analysis; Yes if sand rows are filtered out — inconsistent casing may cause some to pass the filter

**QA-SG-04: Standardise and verify coordinate formats**
- Issue: Some rows store coordinates in degree-minute format rather than decimal degrees; GPS accuracy is approximately +/-5-10 m
- Change: Inspect `Latitude (S)` and `Longitude (E)` columns; identify rows where values are not already decimal degrees; convert DMS strings to decimal degrees using same approach as QA-MANG-03; confirm all latitude values are negative (south coast Kenya)
- Field affected: `Latitude (S)`, `Longitude (E)` (Health sheet); `Latitude`, `Longitude` (Cover sheet)
- Blocking: Yes for GIS ground-truthing and spatial join

**QA-SG-05: Drop trailing blank columns**
- Issue: SEAGRASS COVER has 16 trailing blank columns; SEAGRASS HEALTH has 15 trailing blank columns
- Change: On read, select only named columns; do not use `col_types = "guess"` without column selection, as blank columns will be read as `lgl` NA columns and clutter the data frame
- Field affected: Columns 10-25 (Cover sheet); columns 11-25 (Health sheet)
- Blocking: No for analysis; good practice to prevent downstream errors

**QA-SG-06: Verify latitude signs (both sheets)**
- Issue: Column is labelled `Latitude (S)` suggesting all values should be negative (south); verify no positive values exist
- Change: After coordinate standardisation (QA-SG-04), check `min(latitude)` and `max(latitude)`; any positive values indicate sign error; apply correction with knowledge of which sites are on the south coast
- Field affected: `Latitude (S)` (Health sheet), `Latitude` (Cover sheet)
- Blocking: Yes for spatial validation

---

## 7. Cross-File (Applies to All Datasets)

**QA-CROSS-01: Build canonical site name lookup table**
- Issue: At least 4 naming variants for the same sites have been identified across the 8 coral reef files alone (e.g., `Wesa` / `Kilifi Wesa` / `Wesa 1` / `Wesa 2`; `Sultan palace` / `Sultance palace`)
- Change: Before any cross-file merge, create a single lookup table (`site_name_crosswalk.csv`) mapping every raw location/site string from every file to a canonical name; store in `01_inputs/metadata/`; apply via left-join in every R script before merging
- Required columns in crosswalk: `raw_file`, `raw_location`, `raw_site`, `canonical_location`, `canonical_site`
- Blocking: Yes for any cross-programme analysis or PA-level condition aggregation

**QA-CROSS-02: Confirm transect dimensions for all survey types**
- Issue: Transect widths are not recorded in the fish UVC files; belt width is required for per-hectare density and biomass scaling

| Survey type | Length recorded | Width needed |
|---|---|---|
| CCVA fish UVC | 50 m | Confirm (likely 2 m = 100 m2) |
| COMRED fish UVC | Variable | Confirm |
| CCVA invertebrate UVC | 25 m | Confirm width |

- Change: Confirm with field supervisors (Dr. Karisa / Mohamed Hamisi); document confirmed transect area in `cond_reef_coral_fish_invert_plan.md` and as a named constant (`TRANSECT_AREA_M2`) at the top of each R script
- Blocking: Yes — all biomass and density per-hectare values scale linearly with transect area

**QA-CROSS-03: Document all data consolidation decisions**
- Issue: Multiple files contain overlapping data (KLF fish file consolidates CCVA + GOAP + COMRED; CORAL-DATA includes CORAL COVER; PU-GOAP has duplicate Condition sheets); without explicit documentation, it is unclear which files feed the final analysis
- Change: Add a consolidation decision table to `cond_reef_coral_fish_invert_plan.md` specifying for each raw file: USE / DO NOT USE / USE FOR X ONLY; sign off on this before any R script is run
- Blocking: Yes — double-counting risk across overlapping files

---

*Last updated: 2026-03-16*
