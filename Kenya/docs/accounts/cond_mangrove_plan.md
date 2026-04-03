# Plan: Mangrove Condition Analysis — Kilifi County, Kenya

**Project:** AFRICA — accounts / Kenya
**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Intertidal Forests and Shrublands (IUCN GET MFT1.2)
**Geographic scope:** Ngomeni, Marereni, Mida Creek, Kilifi Creek — Kilifi County
**Accounting period:** 2025
**Data submitter:** Dr. Pascal Thoya, Pwani University (pascalthoya at gmail.com)

---

## Status Overview

| Step | Status | Notes |
|------|--------|-------|
| 1. Data inventory and QA/QC | COMPLETE | 2,095 rows, 36 plots, 22 sites, 4 areas; 4 QA flags resolved |
| 2. Species name standardisation | COMPLETE | Lookup table: RM/Rm/rm to full scientific names; 4 species confirmed |
| 3. Area name standardisation | COMPLETE | "Debaso"/"Dabaso" to "Mida Creek"; all 4 canonical areas assigned |
| 4. DMS coordinate conversion | COMPLETE | parse_coord_dd() handles DMS + decimal; negative sign for S latitudes |
| 5. Sub-branch exclusion | COMPLETE | 541 sub-branches excluded from stem density; retained for DBH/height |
| 6. Plot-level metrics | COMPLETE | 36 plots; 5 indicators: stem density, mean DBH, mean height, canopy cover, tree quality |
| 7. Normalisation to CI (0-1) | COMPLETE | Reference levels PROVISIONAL; 4 normalised + 1 already 0-1 |
| 8. Composite condition index | COMPLETE | Equal-weight mean of 5 CIs per plot |
| 9. Site-level aggregation | COMPLETE | 22 sites; 13 flagged low-sample-size (< 2 plots) |
| 10. PA-disaggregated condition account | COMPLETE | Mida Creek MNR (7 sites, CI=0.455) vs Unprotected (15 sites, CI=0.370) |
| 11. SEEA EA condition table export | COMPLETE | seea_condition_account_mangrove_kenya.csv + mangrove_condition_by_pa.csv |

---

## Input Data

| File | Rows | Columns | Type | Survey | Date range | Areas / Sites |
|------|------|---------|------|--------|------------|----------------|
| All_mangrove_field_data.xlsx | 2,095 | 20 | Individual tree records from 10x10m plots | Pwani University / GOAP | Sep-Dec 2025 (primary: 8-12 Dec 2025) | 4 areas, 22 sites, 38 plots |

**Observers:** Patricia and Kisilu (primary), Gilbert, Marvin

**Species recorded:**

| Abbreviation | Full scientific name |
|---|---|
| RM / Rm | Rhizophora mucronata |
| AM / Am | Avicennia marina |
| BG / Bg | Bruguiera gymnorhiza |
| CT / Ct | Ceriops tagal |

**Areas and sites:**
- Ngomeni: Ngomeni Rasi, Rasi, Rasi Msikiti, Pwani toto, Luwahi
- Marereni: Marereni-Kwa Kanyama, Kadzuyuni, Kaogoni, Kwazimba Island, Mwinyihaji, Kachaa
- Mida Creek (Dabaso/Kidundu): Dabaso, Debaso Rock, Fisheries, Boardwalk, Darajani, Kidundu, Mtongani, Mto wa Mawe, Mzodzongoloni
- Kilifi Creek: Kilifi creek, Kwa Douglas, Kwa Nzai, Mandarini, Kurawa-kanagoni

---

## Column Reference

| Column | Description | Units | Notes |
|--------|-------------|-------|-------|
| Observers | Field team | Text | |
| Date | Survey date | Date | Sep 2025 = reconnaissance; Dec 2025 = main survey |
| Area | Broad geographic area (4 values) | Text | Inconsistencies to standardise |
| Site | Site within area (22 values) | Text | |
| Plot no. | Plot identifier | Integer | 38 plots total |
| Eastings | GPS easting (longitude) | DMS string | Convert to decimal degrees |
| Southings | GPS southing (latitude) | DMS string | Convert to decimal degrees; apply negative sign |
| Plot size (m2) | Plot area | m2 | Should be 100 m2 (10x10 m); verify |
| Forest type | Mangrove forest type | Categorical | |
| Inundation class | Tidal zone (1-4) | Categorical | 1 = most inundated |
| Cover | Canopy cover | % class | Convert cover class to numeric midpoint |
| Tree no. | Tree ID within plot | Integer | |
| Sub (Branch) | Sub-branch flag | Flag | Exclude from stem density; retain for basal area |
| Species | Mangrove species | Text | Standardise before analysis |
| P.O.M | Point of measurement height | cm | Usually 30 cm for mangroves; verify |
| Circumference (cm) | Stem circumference at POM | cm | DBH = Circumference / pi |
| DBH (cm) | Diameter at breast height | cm | Pre-calculated in file; verify against circumference |
| Height (m) | Tree height | m | |
| Quality | Structural health (1-3) | Categorical | 1 = healthy; 2 = fair; 3 = poor/damaged |
| Comments | Observer notes | Text | |

---

## Data Quality Flags

| Flag | Description | Action |
|------|-------------|--------|
| DQ-1 | Species names inconsistent: full names and abbreviations (RM, Rm, rm) mixed | Standardise to full scientific names using lookup; flag unrecognised entries |
| DQ-2 | Area names inconsistent: "Debaso" vs "Dabaso"; "Mida" vs "Mida Creek" | Harmonise: map all variants to canonical names; document decisions |
| DQ-3 | Coordinates stored as DMS strings, not decimal degrees | Parse with regex; apply sign convention (S = negative lat, E = positive lon) |
| DQ-4 | Survey dates span Sep-Dec 2025; main survey is Dec 8-12 only | Retain all records; add survey_phase flag ("reconnaissance" vs "main") based on date |

---

## Analysis Steps

### Step 5: Sub-branch treatment

The Sub (Branch) column flags records that are sub-branches of a main stem rather than independent trees. For stem density calculations, exclude sub-branches and count only main stems. For basal area calculations, retain all records (each circumference measurement represents a real stem cross-section). Document the split in the QA/QC log.

### Step 6: Plot-level metrics

Compute the following for each plot (identified by Area + Site + Plot no.):

**Metric 1: Stem density (trees/ha)**
- Count main stems only (Sub (Branch) is NA or empty)
- Scale: density = count / plot_area_m2 * 10000
- All plots are 100 m2; verify from Plot size (m2) column

**Metric 2: Mean DBH (cm)**
- Use DBH column (pre-calculated from circumference)
- Verify: DBH_check = Circumference / pi; flag deviations > 0.5 cm
- Include all stems (main + sub-branches) to represent full basal area structure
- Handle NA DBH by imputing from circumference where available

**Metric 3: Mean height (m)**
- Mean of Height column per plot
- Flag extreme values (height < 0.3 m or > 20 m) as outliers

**Metric 4: Tree quality index (proportion quality-1 stems)**
- Quality 1 = healthy/undamaged; Quality 2 = fair; Quality 3 = poor/damaged
- Index = count(Quality == 1) / total stems per plot
- Ranges 0-1 inherently; no normalisation required

**Metric 5: Canopy cover (%)**
- One cover value per plot (from Cover column)
- Convert cover class strings to numeric midpoint using lookup table
- If cover is already numeric, use directly

### Step 7: Reference levels for normalisation

Formula: CI = (value - poor) / (pristine - poor), clamped to [0, 1]

| Indicator | Poor | Pristine | Units | Confidence | Source |
|-----------|------|----------|-------|------------|--------|
| Stem density | 200 | 3000 | trees/ha | MEDIUM | Kirui et al. 2006 (Kenya); Bosire et al. 2014 (WIO) |
| Mean DBH | 3 | 20 | cm | MEDIUM | Bosire et al. 2014; Kairo et al. 2009 (Kenya) |
| Mean height | 2 | 12 | m | MEDIUM | Fatoyinbo et al. 2008; Lagomasino et al. 2015 (WIO) |
| Canopy cover | 30 | 90 | % | LOW | Provisional expert estimate |
| Tree quality index | 0.2 | 1.0 | proportion | LOW | Provisional; no published WIO standard |

Note: Stem density and DBH reference levels are highly variable by species and inundation zone. Consider computing species-stratified indices as a sensitivity check.

### Step 8: Composite condition index

Equal-weight mean of 5 condition indices. Tree quality index is already 0-1; include directly without normalisation.

### Step 9: Site aggregation

Aggregate plot-level metrics to site level by taking the unweighted mean of plots within each site. Report n_plots per site. Sites with < 2 plots should be flagged as low-sample-size.

---

## Results Summary (2026-03-28)

### Headline findings

- **22 sites, 36 plots, 1,554 main stems** processed from 2,095 individual tree records
- **Overall composite condition index: 0.40** (moderate; scale 0-1)
- **Best-condition area:** Mida Creek (CI = 0.433, 9 sites) -- benefits from MNR protection
- **Lowest-condition area:** Kilifi Creek (CI = 0.266, 2 sites) -- unprotected, high human pressure
- **Protected vs unprotected:** Mida Creek MNR sites (CI = 0.455) outperform unprotected sites (CI = 0.370) across all structural indicators except stem density
- **Dominant species:** Rhizophora mucronata (61% of main stems), Ceriops tagal (33%)
- **13 of 22 sites** have only 1 plot -- condition indices at these sites have low reliability

### Condition by protected area status

| PA status | Sites | Plots | CI stem density | CI DBH | CI height | CI cover | CI quality | CI composite |
|-----------|-------|-------|-----------------|--------|-----------|----------|------------|--------------|
| Mida Creek MNR | 7 | 11 | 0.867 | 0.211 | 0.368 | 0.532 | 0.299 | 0.455 |
| Unprotected | 15 | 25 | 0.930 | 0.151 | 0.241 | 0.230 | 0.299 | 0.370 |

### Condition by area

| Area | Sites | CI density | CI DBH | CI height | CI cover | CI quality | CI composite |
|------|-------|------------|--------|-----------|----------|------------|--------------|
| Kilifi Creek | 2 | 0.622 | 0.228 | 0.282 | 0.000 | 0.199 | 0.266 |
| Marereni | 4 | 0.980 | 0.168 | 0.360 | 0.375 | 0.215 | 0.420 |
| Mida Creek | 9 | 0.897 | 0.175 | 0.300 | 0.432 | 0.361 | 0.433 |
| Ngomeni | 7 | 0.969 | 0.148 | 0.212 | 0.254 | 0.296 | 0.376 |

### Interpretation

- Stem density CIs are universally high (0.6-1.0), suggesting dense regenerating stands across all areas
- DBH CIs are very low (0.1-0.2), indicating small-diameter trees -- consistent with young or heavily harvested forests
- The combination of high stem density + low DBH is a signature of post-disturbance regeneration
- Canopy cover is the weakest indicator at Kilifi Creek (CI = 0.0) and Ngomeni (CI = 0.25)
- Tree quality (proportion of undamaged stems) is low across all areas, especially where selective harvesting occurs

---

## Outputs

| File | Description |
|------|-------------|
| mangrove_condition_by_plot.csv | Plot-level raw metrics + normalised CIs (36 plots) |
| mangrove_condition_by_site.csv | Site-level mean CIs + composite + PA status (22 sites) |
| mangrove_condition_by_pa.csv | PA-disaggregated condition summary (protected vs unprotected) |
| mangrove_species_composition.csv | Species abundance per site (main stems only) |
| mangrove_coords.csv | Plot coordinates in decimal degrees (QA-corrected) |
| seea_condition_account_mangrove_kenya.csv | SEEA EA standard format condition table (includes pa_status) |

---

## Protected Area Integration

- **Mida Creek Marine National Reserve** (IUCN Cat II): Dabaso, Kidundu, Mtongani sites are within or adjacent to the reserve
- **Kilifi Creek:** Unprotected (community and private land mix)
- **Ngomeni / Marereni:** Unprotected (small-scale fisheries areas)

PA status should be assigned using WDPA spatial join (see `skill_extent_protected_areas` workflow). Report protected vs unprotected condition indices as a disaggregated account.

---

## Open Items

| Item | Priority | Notes |
|------|----------|-------|
| Allometric biomass parameters (a, b) for WIO mangrove species | HIGH | Required for biomass/carbon extension; not in current dataset |
| Cover class format | HIGH | Verify exact strings in data before running analysis |
| Sub-branch definition | MEDIUM | Confirm with field team whether Sub column = 1/TRUE or text flag |
| Inundation zone reference levels | LOW | Consider zone-stratified indices (Bosire et al. note strong zone gradients) |
| Species-stratified condition indices | LOW | Sensitivity check: R. mucronata vs A. marina have very different size ranges |
| ~~GMW 2020 extent integration~~ | -- | RESOLVED (2026-03-28): GMW 2020 baseline (6,083.04 ha) integrated into multi-period extent account; change detection complete (589 ha additions, 928 ha reductions, -341 ha net). See `skill_extent_mangrove_kenya.md` and `03_outputs/Mangrove_extent_change_2020_2025.csv` |
