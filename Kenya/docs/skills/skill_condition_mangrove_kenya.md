# Skill: Ecosystem Condition — Biotic Indicators: Mangrove Forests (Kenya, Kilifi County)

**Purpose:** Calculate mangrove structural condition indicators from plot-based field survey data collected across four sites in Kilifi County, Kenya (Dec 2025), and normalise to condition indices for the UN SEEA EA ecosystem condition account.

**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Intertidal Forests and Shrublands (IUCN GET MFT1.2)
**Spatial scope:** Plot-level (38 plots; 22 sites; 4 areas — Ngomeni, Marereni, Mida Creek, Kilifi Creek)
**Analysis script:** `Kenya/02_analysis/mangrove_condition.R`
**Plan document:** `Kenya/docs/accounts/cond_mangrove_plan.md`
**Companion skills:** skill_extent_mangrove_kenya.md — mangrove extent by PA status + multi-period change detection (GMW 2020 to 2025)

---

## 1. Field Survey Data

| Source | Records | Key Fields |
|---|---|---|
| All_mangrove_field_data.xlsx (Sheet 1) | 2,095 rows; 36 plots; 22 sites; 4 areas | Date, Area, Site, Plot no., Eastings, Southings, Plot size (m2), Forest type, Inundation class, Cover, Tree no., Sub (Branch), Species, Circumference (cm), DBH (cm), Height (m), Quality |

**File:** `Kenya/01_inputs/raw_data/mangrove/All_mangrove_field_data.xlsx`

### Survey Design

Individual tree records from 10 x 10 m (100 m2) plots. Within each plot: all trees measured for circumference at POM (point of measurement), height, and assigned a quality class. Species identified and canopy cover estimated per plot. Plots spaced approximately 500 m to 1 km apart.

**Survey period:** Sep-Dec 2025 (reconnaissance: Sep; main survey: 8-12 Dec 2025)

**Observers:** Patricia and Kisilu (primary), Kisilu et al., Gilbert et al., Marvin et al.

**Submitter:** Dr. Pascal Thoya, Pwani University

### Survey Areas and Sites

| Area (canonical) | Sites | Notes |
|---|---|---|
| Ngomeni | Ngomeni Rasi, Rasi, Rasi Msikiti, Pwani toto, Luwahi | Northern sites; generally unprotected |
| Marereni | Marereni-Kwa Kanyama, Kadzuyuni, Kaogoni, Kwazimba Island, Mwinyihaji, Kachaa | Central coast; unprotected |
| Mida Creek | Dabaso, Debaso Rock, Fisheries, Boardwalk, Darajani, Kidundu, Mtongani, Mto wa Mawe, Mzodzongoloni | Within or adjacent to Mida Creek Marine National Reserve; most protected area overlap |
| Kilifi Creek | Kilifi creek, Kwa Douglas, Kwa Nzai, Mandarini, Kurawa-kanagoni | Southern sites; unprotected (community/private land) |

### Species Recorded

| Abbreviation(s) in data | Full scientific name | WIO ecology |
|---|---|---|
| RM / Rm / rm | Rhizophora mucronata | Dominant pioneer/fringe species; prop roots; high stem density in intact stands |
| AM / Am / am | Avicennia marina | Pioneer; pneumatophores; colonises bare substrate and disturbed areas |
| BG / Bg / bg | Bruguiera gymnorhiza | Interior/back-mangrove species; large trees; indicator of mature stands |
| CT / Ct / ct | Ceriops tagal | Landward zone; dense stands; lower stature; often harvested for poles |

Note: Species names are inconsistently recorded as full names (Rhizophora mucronata) and abbreviations (RM, Rm, rm). Standardise to full scientific names before analysis using the lookup in the R script.

---

## 2. Condition Indicators

Five biotic condition indicators are derived from the field data. Together they represent structural integrity, canopy structure, and health status of the mangrove stand.

### Indicator 1: Stem Density (trees/ha)

**What it measures:** Stand density — the number of independent main stems per hectare. Low density indicates heavy harvesting, storm damage, or regeneration failure.

**Calculation:**
- Count main stems per plot (exclude sub-branches: Sub (Branch) flag is truthy)
- Scale: stem_density_ha = n_stems / (plot_area_m2 / 10000)
- Plot area = 100 m2 (verify from Plot size (m2) column)

**Reference levels (provisional):**

| Level | Value (trees/ha) | Source |
|---|---|---|
| Pristine | 3,000 | Kirui et al. 2006 (Kenya: Mida Creek intact stands); Bosire et al. 2014 (WIO) |
| Poor | 200 | Heavily logged/degraded mangroves (Bosire et al. 2006) |
| Confidence | MEDIUM | Reference is appropriate for mixed-species stands; species-stratified thresholds more precise |

Note: Stem density is strongly species- and zone-dependent. Ceriops tagal and Avicennia marina stands can exceed 5,000 trees/ha in intact fringe zones; Bruguiera gymnorhiza stands rarely exceed 1,500 trees/ha. Consider species-stratified sensitivity checks.

### Indicator 2: Mean DBH (cm)

**What it measures:** Average tree diameter — proxy for structural maturity and biomass. Larger mean DBH indicates an older, more mature stand less affected by selective harvesting of large poles.

**Calculation:**
- Use DBH column (pre-calculated in data as Circumference / pi)
- Cross-check: DBH_check = Circumference_cm / pi; flag rows where deviation > 0.5 cm
- Include all stems (main + sub-branches) to represent full basal area structure
- Compute mean DBH per plot across all valid stems

**Reference levels (provisional):**

| Level | Value (cm) | Source |
|---|---|---|
| Pristine | 20 | Bosire et al. 2014; Kairo et al. 2009 (Kenya, Gazi Bay undisturbed plots) |
| Poor | 3 | Heavily harvested stands; seedling/sapling-dominated (Bosire et al. 2006) |
| Confidence | MEDIUM | Kenya-specific reference; appropriate for mixed WIO mangrove stands |

### Indicator 3: Mean Canopy Height (m)

**What it measures:** Average tree height — reflects vertical structural complexity and the influence of light environment, species composition, and long-term stand development.

**Calculation:**
- Mean of Height (m) column per plot
- Exclude outliers: height < 0.3 m or > 20 m (flag and review before exclusion)

**Reference levels (provisional):**

| Level | Value (m) | Source |
|---|---|---|
| Pristine | 12 | Fatoyinbo et al. 2008 (WIO intact mangroves); Lagomasino et al. 2015 |
| Poor | 2 | Heavily degraded or pioneer-only stands |
| Confidence | MEDIUM | WIO reference appropriate; Kenya canopy heights typically 4-10 m in intact stands |

Note: Height reference is lower than global maxima (which reach 30+ m in humid tropical sites) because East African mangroves are height-constrained by seasonal aridity and limited freshwater input.

### Indicator 4: Canopy Cover (%)

**What it measures:** Proportion of sky blocked by canopy — indicates closure of the forest canopy and indirectly reflects stand health, density, and resilience.

**Calculation:**
- One cover value per plot from the Cover column (stored as a class string)
- Convert class to numeric midpoint using lookup:

| Class string | Midpoint (%) |
|---|---|
| <10 / <10% / 0-10 | 5 |
| 10-25 / 10-25% | 17.5 |
| 25-50 / 25-50% | 37.5 |
| 50-75 / 50-75% | 62.5 |
| 75-90 / 75-90% | 82.5 |
| >90 / >90% / 90-100 / dense | 95 |

Run `unique(raw$cover)` after data ingestion to verify actual class values in the data and adjust lookup if needed.

**Reference levels (provisional):**

| Level | Value (%) | Source |
|---|---|---|
| Pristine | 90 | Expert estimate; intact mangrove canopy closure |
| Poor | 30 | Heavily degraded or gappy stands |
| Confidence | LOW | No published WIO standard; provisional only |

### Indicator 5: Tree Quality Index (proportion quality-1 stems)

**What it measures:** Proportion of trees classified as structurally healthy (Quality = 1). Quality 2 indicates minor damage or stress; Quality 3 indicates severe damage, dieback, or dead stems.

**Calculation:**
- Quality values: 1 = healthy/undamaged; 2 = fair/minor stress; 3 = poor/dead or severely damaged
- Index = count(Quality == 1) / total stems per plot
- Ranges 0-1 inherently; no min-max normalisation required
- Clamp to [0, 1] to handle any edge cases

**Reference levels:**

| Level | Value | Notes |
|---|---|---|
| Pristine | 1.0 | All stems structurally sound |
| Poor | 0.2 | 80%+ of stems damaged or dead — effectively a degraded stand |
| Confidence | LOW | No published WIO standard for this metric |

Confirm with the field team how the Quality column is coded before running the analysis (numeric 1/2/3, text "Good/Fair/Poor", or other).

---

## 3. QA/QC Protocol

### DQ-1: Species name standardisation

Species are recorded as abbreviations (RM, Rm, rm) and full names. Map all variants to full scientific names using the lookup:

| Input variant | Canonical name |
|---|---|
| RM / Rm / rm | Rhizophora mucronata |
| AM / Am / am | Avicennia marina |
| BG / Bg / bg | Bruguiera gymnorhiza |
| CT / Ct / ct | Ceriops tagal |

Flag any unrecognised values for manual review. Do not impute species for unflagged ambiguous entries.

### DQ-2: Area name standardisation

Area names are inconsistently recorded. Map to canonical names:

| Input variant(s) | Canonical name |
|---|---|
| Dabaso / Debaso / Mida / Mida Creek / Kidundu / Mtongani / Mtongani/Kidundu | Mida Creek |
| Ngomeni / Ngomeni Rasi / Rasi | Ngomeni |
| Marereni / Marereni-Kwa Kanyama | Marereni |
| Kilifi creek | Kilifi Creek |

### DQ-3: Coordinate conversion

Eastings and Southings are stored as DMS strings (e.g., "40 degrees 11' 1.01\""). Parse with regex to extract degrees, minutes, and seconds. Apply negative sign to latitude (Kenya is in the Southern Hemisphere). Compute plot centroids as the mean of individual tree coordinates within each plot.

### DQ-4: Survey phase

Dates span Sep-Dec 2025. Flag rows where date < 2025-12-01 as "reconnaissance"; remaining rows as "main". All records are included in the analysis; the phase flag allows stratified inspection.

### DQ-5: Sub-branch identification

The Sub (Branch) column flags sub-branches (not independent stems). Identify truthy values (Y, yes, TRUE, 1, x) as sub-branches. Exclude from stem density counts. Retain for structural metric calculations (height, DBH).

### DQ-6: DBH cross-check

DBH is pre-calculated in the data file. Cross-check: DBH_check = Circumference_cm / pi. Flag rows where |DBH - DBH_check| > 0.5 cm. Replace flagged DBH values with the circumference-derived calculation.

---

## 4. Normalisation

Formula: CI = (value - poor) / (pristine - poor), clamped to [0, 1]

Applied to Indicators 1-4. Indicator 5 (tree quality index) is already 0-1 and is used directly.

| Indicator | CI column | Poor | Pristine | Confidence |
|---|---|---|---|---|
| Stem density (trees/ha) | ci_stem_density | 200 | 3,000 | MEDIUM |
| Mean DBH (cm) | ci_mean_dbh | 3 | 20 | MEDIUM |
| Mean height (m) | ci_mean_height | 2 | 12 | MEDIUM |
| Canopy cover (%) | ci_canopy_cover | 30 | 90 | LOW |
| Tree quality index (proportion) | ci_quality_index | — | — | LOW |

---

## 5. Composite Condition Index

Equal-weight mean of the five condition indices. Computed per plot, then averaged to site level. NA values are excluded from the mean (plots missing one indicator still receive a composite from available indicators; n_indicators is reported).

CI_composite = mean(ci_stem_density, ci_mean_dbh, ci_mean_height, ci_canopy_cover, ci_quality_index)

---

## 6. Aggregation

**Plot to site:** Unweighted mean of all plots within each site. Sites with fewer than 2 plots are flagged as low-sample-size.

**Site to area:** Not computed in the base script. If required, compute the unweighted mean of site-level CIs within each area (Ngomeni, Marereni, Mida Creek, Kilifi Creek).

---

## 7. SEEA EA Condition Account Format

One row per accounting unit (site). Standard columns:

| Column | Content |
|---|---|
| ecosystem_type | Intertidal Forests and Shrublands (MFT1.2) |
| country | Kenya |
| area | Canonical area name |
| accounting_unit | Site name |
| n_plots | Number of plots aggregated |
| ci_stem_density | Normalised stem density CI |
| ci_mean_dbh | Normalised DBH CI |
| ci_mean_height | Normalised height CI |
| ci_canopy_cover | Normalised cover CI |
| ci_quality_index | Tree quality index (direct) |
| ci_composite | Equal-weight composite CI |
| low_sample | TRUE if n_plots < 2 |
| year | 2025 |

### SEEA EA Condition Account: Mangrove (MFT1.2), Kilifi County

Single-period condition account (2025). All values are condition indices normalised 0-1.

| Entry | Units | Mangrove (MFT1.2) |
| --- | --- | --- |
| Stem density (2025) | index (0-1) | 0.910 |
| Mean DBH (2025) | index (0-1) | 0.170 |
| Mean height (2025) | index (0-1) | 0.281 |
| Canopy cover (2025) | index (0-1) | 0.326 |
| Tree quality (2025) | index (0-1) | 0.299 |
| Composite (2025) | index (0-1) | 0.397 |

**Output file:** `KEN_SEEA_EA_condition_account_final.csv`

**Notes:**

- Composite = unweighted mean of 5 indicators (density, DBH, height, cover, quality)
- Single period only; opening/closing/change structure will apply when resurvey data are available
- Canopy cover reference (30-90%) and tree quality reference (0.2-1.0) are LOW confidence
- 22 sites across 4 areas (Ngomeni, Marereni, Mida Creek, Kilifi Creek); 36 plots total

---

## 8. Protected Area Disaggregation

**Status:** COMPLETE (2026-03-28). Implemented in mangrove_condition.R; output: `mangrove_condition_by_pa.csv`.

**Mida Creek Marine National Reserve** (IUCN Cat II, WDPA) overlaps with the Mida Creek sites. Sites assigned via lookup table in mangrove_condition.R:

| PA status | Sites | n_plots |
|-----------|-------|---------|
| Mida Creek MNR | Boardwalk, Dabaso, Debaso Rock, Kachaa, Kidundu, Kwazimba Island, Luwahi, Mida | 11 |
| Unprotected | All Ngomeni, Marereni, Kilifi Creek sites + Fisheries, Mto wa Mawe, Mtongani, Mwinyihaji, Mzodzongoloni, Darajani | 25 |

### Results

| PA status | Sites | Plots | CI composite | CI stem density | CI DBH | CI height | CI cover | CI quality |
|-----------|-------|-------|-------------|-----------------|--------|-----------|----------|------------|
| Mida Creek MNR | 7 | 11 | 0.455 | 0.867 | 0.211 | 0.368 | 0.532 | 0.299 |
| Unprotected | 15 | 25 | 0.370 | 0.930 | 0.151 | 0.241 | 0.230 | 0.299 |

**Interpretation:** Protected sites within Mida Creek MNR have a 23% higher composite condition index (0.455 vs 0.370) than unprotected sites. The strongest differences are in canopy cover (CI 0.53 vs 0.23) and tree height (CI 0.37 vs 0.24), suggesting that protection allows canopy recovery. Stem density is slightly lower in MNR sites, consistent with more mature stands with fewer but larger trees. Tree quality index is identical (0.30) across both groups.

---

## 9. Biomass and Carbon Extension (Pending)

The current dataset supports structural condition indices only. Aboveground biomass estimation requires species-specific allometric parameters (a, b in W = a × DBH^b). These are not included in the field dataset and must be sourced separately.

**Recommended allometric equations for WIO mangroves:**

| Species | Source |
|---|---|
| Rhizophora mucronata | Comley and McGuinness (2005); Kairo et al. 2009 |
| Avicennia marina | Comley and McGuinness (2005); East Africa monitoring literature |
| Bruguiera gymnorhiza | Comley and McGuinness (2005) |
| Ceriops tagal | Bosire et al. 2012; Kairo et al. 2009 |

Once allometric parameters are obtained, biomass can be estimated per tree and aggregated to plot and site levels. Carbon stock = AGB (Mg/ha) × 0.451 (IPCC default carbon fraction for mangrove wood).

---

## 10. Reference Literature

| Source | Use |
|---|---|
| Bosire et al. (2006) *Forest Ecol. Manag.* | Degraded mangrove structure reference levels (Kenya, Mida Creek) |
| Bosire et al. (2014) *Wetlands Ecol. Manage.* | WIO mangrove structural condition reference |
| Kairo et al. (2009) *Forest Ecol. Manag.* | Kenya mangrove DBH, height, allometric reference (Gazi Bay) |
| Kirui et al. (2006) *Wetlands Ecol. Manage.* | Stem density reference levels for Kenya mangroves (Mida Creek intact stands) |
| Fatoyinbo et al. (2008) *Global Change Biol.* | WIO mangrove canopy height from SRTM/field data |
| Lagomasino et al. (2015) *Remote Sens. Environ.* | WIO/Mozambique mangrove height from LiDAR |
| Comley and McGuinness (2005) *Aust. J. Bot.* | Allometric equations for WIO/Indo-Pacific mangrove species |
| IUCN GET | Ecosystem type classification MFT1.2 |

---

## 11. Open Items

| Item | Priority | Status | Notes |
|---|---|---|---|
| Allometric parameters for biomass | HIGH | OPEN | Required for carbon extension; not in dataset |
| Species-stratified condition indices | MEDIUM | OPEN | Sensitivity check: R. mucronata vs A. marina reference levels differ substantially |
| Inundation-zone stratification | LOW | OPEN | Bosire et al. note strong inundation gradients in condition; consider zone-stratified CI |
| ~~Verify cover class strings~~ | -- | RESOLVED | Cover classes found: "0-20", "20-40", "21-40", "40-60", "41-60", "60-80", "61-80"; mapped to midpoints in cover_to_pct() |
| ~~Confirm Quality column coding~~ | -- | RESOLVED | Part 1: numeric 1/2/3; Part 2: free-text; both harmonised to quality_num (1/2/3) in mangrove_condition.R |
| ~~Confirm Sub (Branch) column format~~ | -- | RESOLVED | Sub-branches labelled with letters (a/A, b/B, c/C); main stems have NA; 541 sub-branches identified |
| ~~GMW 2020 extent linkage~~ | -- | RESOLVED | GMW 2020 baseline (6,083 ha) integrated; multi-period extent account complete; see skill_extent_mangrove_kenya.md |
| ~~PA disaggregation~~ | -- | RESOLVED | 7 sites assigned to Mida Creek MNR (CI = 0.455); 15 unprotected (CI = 0.370); output: mangrove_condition_by_pa.csv |
