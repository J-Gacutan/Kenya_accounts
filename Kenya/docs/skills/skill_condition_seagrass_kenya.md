# Skill: Ecosystem Condition — Biotic Indicators: Seagrass Meadows (Kenya, Kilifi County)

**Purpose:** Calculate seagrass community condition indicators for seagrass meadow ecosystems (IUCN GET M1.1) from field survey data collected across Kilifi County, Kenya (2024), and normalise to condition indices for the SEEA EA condition account.

**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Seagrass meadows (IUCN GET M1.1)
**Spatial scope:** Site-level (10 survey areas across Kilifi County); no satellite extrapolation for shoot density or health indicators
**Companion skills:** skill_extent_seagrass_kenya.md (when created) — provides seagrass extent mapping; skill_condition_by_protected_area_kenya.md (when created) — condition disaggregated by protected area including Malindi Marine Park

---

## 1. Field Survey Data

| Source | Records | Key Fields |
|---|---|---|
| Seagrass Cover (Sheet 1) | 1,604 rows; 10 survey areas | Date, County, Area, Latitude, Longitude, Quadrant 5m x 5m, Quadrant 50cm x 50cm, Percentage Cover, Substrate type; species: 9 seagrass spp. + Sand |
| Seagrass Health (Sheet 2) | 1,436 rows; 11 survey areas | Date, County, Area, Zone, Latitude (S), Longitude (E), Quadrant 15cm x 15cm, Seagrass species, Shoot density, Canopy height |

**File:** `Kenya/01_inputs/raw_data/seagrass/All_seagrass_field_data.xlsx`

### Survey Design

**Cover sheet:** Percentage cover was recorded in 50 cm x 50 cm sub-quadrats nested within 5 m x 5 m reference plots. Sub-quadrat observations are the fundamental sampling unit; reference plots represent the spatial cluster.

**Health sheet:** Shoot density (count of shoots) and canopy height were recorded in 15 cm x 15 cm quadrats. Quadrat area = 0.15 m x 0.15 m = 0.0225 m². Multiple quadrats were placed across three intertidal/subtidal zones (Near shore, Middle, Near reef) within each survey area.

**Survey period:** May–November 2024 (Cover); June–November 2024 (Health)

**Survey areas (n = 10/11):**

| Area | Notes |
|---|---|
| Bofa | Present in both Cover and Health sheets |
| Kanamai-Jumba ruins / Kanamai / Jumba ruins | Site naming varies between sheets — standardise during QA/QC |
| Kikambala | Present in both sheets |
| Kuruwitu | Community conservancy; present in both sheets |
| Malindi marine park | Protected area; present in both sheets |
| Marereni | Present in both sheets |
| Ngomeni | Present in both sheets |
| Roka | Present in both sheets |
| Takaungu | Present in both sheets |
| Wesa | Present in both sheets |

Note: "Jumba ruins" appears as a distinct area in the Health sheet alongside "Kanamai"; the Cover sheet lists "Kanamai-Jumba ruins" as a combined area (n = 10 areas). Confirm with field team whether these should be treated as one area or two for aggregation purposes.

### Species Recorded

| Species | Sheet(s) | Notes |
|---|---|---|
| Cymodocea rotundata | Cover, Health | Pioneer species; indicative of disturbed or sandy substrates |
| Cymodocea serrulata | Cover, Health | Common mixed-meadow species |
| Enhalus acoroides | Cover, Health | Slow-growing climax species; large shoots; low density reference |
| Halodule uninervis | Cover, Health | Pioneer/disturbance-tolerant; fine leaves |
| Halodule wrightii | Health only | Fine-leaf pioneer; WIO occurrence occasional |
| Halophila ovalis | Cover, Health | Opportunistic; fast coloniser; small leaves |
| Halophila stipulacea | Cover, Health | Invasive in some WIO regions; monitor prevalence |
| Syringodium isoetifolium | Cover, Health | Cylindrical leaves; mid-succession |
| Thalassodendron ciliatum | Cover, Health | Structural climax species; carbonate-secreting rhizomes; indicator of healthy reef-fringe |
| Thalassia hemprichii | Cover, Health | Dominant climax species in Indo-Pacific mixed meadows; primary density reference |
| Sand | Cover only | Substrate category; excluded from species-level calculations |

### Reference Literature

| Type | Source | Use |
|---|---|---|
| Seagrass cover — good condition threshold | Duarte (1991) *Mar. Ecol. Prog. Ser.*; Orth et al. (2006) *BioScience*; regional WIO assessments | 60% cover considered indicative of good seagrass condition; adopted as reference for this account (MEDIUM confidence) |
| Shoot density — Thalassia hemprichii | Bandeira et al. (2014) *Seagrasses of the East African Coast*; regional WIO monitoring data | 800 shoots/m² (PROVISIONAL; LOW-MEDIUM confidence; no Kenya-specific published baseline) |
| Shoot density — Cymodocea serrulata | Bandeira et al. (2014); East Africa seagrass monitoring literature | 500 shoots/m² (PROVISIONAL; LOW confidence) |
| Shoot density — Halodule uninervis | Bandeira et al. (2014); regional WIO values | 1,000 shoots/m² (PROVISIONAL; LOW confidence) |
| Shoot density — Enhalus acoroides | East Africa monitoring literature | 100 shoots/m² (PROVISIONAL; LOW confidence; large-shoot species; inherently sparse) |
| Shoot density (mixed / all species) | In-sample maximum; used where published baselines unavailable | CI = density / max observed across sites (LOW confidence; relative ranking only) |
| Canopy height | In-sample maximum per species | CI = height / max observed per species (LOW confidence; relative ranking only) |
| Species richness | In-sample maximum across sites | CI = richness / max observed (LOW confidence; relative ranking only) |
| Seagrass ecology — East Africa | Bandeira & Gell (2003) *Aquat. Conserv.*; Nordlund et al. (2014) *Estuarine Coast. Shelf Sci.* | Contextual ecology; WIO seagrass distribution and stressors |
| IUCN Global Ecosystem Typology | IUCN | Ecosystem type classification M1.1 |

All shoot density and canopy height reference levels are PROVISIONAL. No formally published Kenya- or WIO-specific seagrass shoot density baseline exists as of the accounting period (2024). These reference values must be validated against Bandeira et al. (2014) and East Africa seagrass monitoring literature (including SEAWATCH East Africa programme data) before use in a final SEEA EA account or associated publication.

---

## 2. Field Data QA/QC

```
Raw Excel: All_seagrass_field_data.xlsx (Sheets: SEAGRASS COVER, SEAGRASS HEALTH)
    |
    +-- 2.1 Date standardisation
    |       Detect date format: YYYY-MM-DD | DD/MM/YYYY | Excel date integer
    |       Excel integers: convert using as.Date(x, origin = "1899-12-30")
    |       DD/MM/YYYY strings: parse with lubridate::dmy()
    |       YYYY-MM-DD strings: parse with lubridate::ymd()
    |       Output: single Date column in ISO 8601 (YYYY-MM-DD)
    |       Flag rows with unparseable dates; do not drop — inspect manually
    |
    +-- 2.2 Coordinate cleaning
    |       Check Latitude and Longitude columns for degree-minute format strings
    |           (e.g., "3° 30.5' S" or "3 30.5 S")
    |       Convert degree-minute strings to decimal degrees:
    |           DD = degrees + minutes/60; apply negative sign for S and W
    |       Check for integer-scale GPS errors (e.g., -330 instead of -3.30)
    |           Flag values outside plausible Kilifi County bounding box:
    |               Latitude: -4.5 to -2.5 (decimal degrees, S hemisphere)
    |               Longitude: 39.5 to 41.0
    |       Log flagged rows; attempt automated fix; verify against known area centroids
    |
    +-- 2.3 Species name standardisation
    |       Apply lookup table to Seagrass species / Substrate type column:
    |           "Halophilia ovalis"      -> "Halophila ovalis"
    |           "Halophilia stipulacea"  -> "Halophila stipulacea"
    |           "Thelassia hemprichii"   -> "Thalassia hemprichii"
    |           "Halodulle wrightii"     -> "Halodule wrightii"
    |           "Halodulle uninervis"    -> "Halodule uninervis"  (check for this variant)
    |       Trim leading/trailing whitespace from all species name fields
    |       Standardise capitalisation: sentence case (first letter upper, rest lower)
    |           except genus (upper) + specific epithet (lower)
    |       Flag any species names not matched in the accepted species list (9 seagrass spp.)
    |           for manual review — do not silently drop
    |
    +-- 2.4 Substrate type / Sand harmonisation (Cover sheet)
    |       Standardise "Sand" / "sand" / "SAND" -> "Sand" (title case)
    |       Create logical flag: is_sand = (Substrate type == "Sand")
    |       Rows with is_sand == TRUE are excluded from species-level cover calculations
    |       but are retained to compute bare substrate (sand) proportion per site
    |
    +-- 2.5 Site name harmonisation (both sheets)
    |       Standardise area names to a canonical lookup table:
    |           "Kanamai-Jumba ruins" / "Jumba ruins" / "Kanamai" ->
    |               flag for confirmation; provisionally treat as separate until confirmed
    |       Check for leading/trailing spaces, case variants
    |       Output: single area_canonical column used in all downstream aggregations
    |
    +-- 2.6 Numeric field validation
    |       Percentage Cover (Cover sheet):
    |           Must be numeric; valid range 0–100
    |           Flag rows with values > 100 or < 0; do not drop — inspect manually
    |           Rows with Percentage Cover == 0 and species != "Sand": review
    |               (zero cover records may be valid absence observations)
    |       Shoot density (Health sheet):
    |           Must be numeric (raw count of shoots per 15 cm x 15 cm quadrat)
    |           Flag non-numeric entries (formula strings, text) — evaluate manually
    |           Valid range: 0–500 shoots per quadrat (flag values above as suspect)
    |       Canopy height (Health sheet):
    |           Must be numeric (cm)
    |           Valid range: 0–200 cm (Enhalus acoroides can exceed 1 m; flag > 200 cm)
    |           Flag negative values
    |
    +-- 2.7 Duplicate detection
    |       Check for exact duplicate rows (all columns identical)
    |           in both sheets independently
    |       Flag; do not drop automatically — confirm with field team
    |
    +-- 2.8 QA/QC log
            Generate summary table: n rows input, n rows flagged by issue type,
            n rows output post-cleaning for both sheets
            Save as: Kenya/03_outputs/qaqc_seagrass_log.csv
```

---

## 3. Indicator Calculation

### 3.1 Cover Indicators (from SEAGRASS COVER sheet)

All cover calculations exclude rows where is_sand == TRUE.

| Indicator | Grouping | Calculation | Unit |
|---|---|---|---|
| Total seagrass cover | Site | Sum of mean cover across all species per site | % |
| Species cover | Site x Species | Mean Percentage Cover across sub-quadrats and plots | % |
| Species composition | Site x Species | Species cover / Total cover x 100 | % of total |
| Species richness | Site | Count of distinct species with cover > 0 | count |
| Bare substrate (sand) fraction | Site | Mean Percentage Cover of Sand rows / total possible cover | % |

#### Cover Calculation Detail

```
For each site s and species sp (excluding Sand):

    sub_quadrat observations: rows where Area == s AND Seagrass species == sp

    species_cover[s, sp] = mean(Percentage Cover) across all sub-quadrat rows
                           (mean within plots, then mean across plots)

    total_cover[s]        = sum over all sp of species_cover[s, sp]

    composition[s, sp]    = species_cover[s, sp] / total_cover[s] * 100

    richness[s]           = count of sp where species_cover[s, sp] > 0

Notes:
- Sub-quadrats are the replicate units; reference plots (5 m x 5 m) are the spatial cluster
- If plot-level means are required before site aggregation, compute
  plot_mean[s, plot, sp] = mean(Percentage Cover within plot)
  then site_mean[s, sp]  = mean(plot_mean[s, *, sp]) across plots
  This two-stage mean avoids unbalanced sub-quadrat counts driving the site estimate
- Report n sub-quadrats and n plots contributing to each site estimate
```

### 3.2 Health Indicators (from SEAGRASS HEALTH sheet)

| Indicator | Grouping | Calculation | Unit |
|---|---|---|---|
| Shoot density (shoots/m²) | Site x Species | Raw shoot count / 0.0225 m²; then mean across quadrats | shoots/m² |
| Shoot density by zone | Site x Species x Zone | Mean shoots/m² within each zone (Near shore, Middle, Near reef) | shoots/m² |
| Canopy height (mean) | Site x Species | Mean canopy height across all quadrats at site | cm |
| Canopy height by zone | Site x Species x Zone | Mean canopy height within each zone | cm |
| Site-level shoot density | Site | Mean shoots/m² across all species and quadrats at site | shoots/m² |

#### Shoot Density Calculation Detail

```
Quadrat area = 0.15 m x 0.15 m = 0.0225 m²

For each row r:
    shoot_density_per_m2[r] = Shoot density (raw count) / 0.0225

For each site s and species sp:

    quadrat_observations: rows where Area == s AND Seagrass species == sp

    site_sp_density_mean[s, sp] = mean(shoot_density_per_m2) across quadrat_observations
    site_sp_density_se[s, sp]   = sd(shoot_density_per_m2) / sqrt(n quadrat_observations)
    n_quadrats[s, sp]            = count(quadrat_observations)

For zone-level breakdown (Near shore, Middle, Near reef):
    zone_sp_density_mean[s, sp, z] = mean(shoot_density_per_m2) where Area == s
                                     AND Seagrass species == sp AND Zone == z

Site-level summary (all species pooled per site):
    site_density_mean[s] = mean(shoot_density_per_m2) across all species and quadrats at s
    site_density_se[s]   = sd(shoot_density_per_m2) / sqrt(n total quadrats at s)
```

#### Canopy Height Calculation Detail

```
For each site s and species sp:
    site_sp_height_mean[s, sp] = mean(Canopy height) across all quadrats
    site_sp_height_se[s, sp]   = sd(Canopy height) / sqrt(n quadrats)

For zone-level breakdown:
    zone_sp_height_mean[s, sp, z] = mean(Canopy height) where Zone == z

Site-level canopy height (all species pooled):
    site_height_mean[s] = mean(Canopy height) across all species and quadrats
```

### 3.3 Cross-Sheet Integration

The Cover and Health sheets use different quadrat sizes and are analysed independently. They are linked by Area (site) and Species name at the aggregation stage to produce a combined site-level summary. Coordinates from both sheets should be reviewed for consistency; where they differ for the same area, flag and use the centroid or most common coordinate as the representative site location.

---

## 4. Spatial Context

**Not applicable for shoot density or canopy height indicators.**

Seagrass shoot density and canopy height are point-quadrat measurements that cannot be reliably extrapolated to unmeasured areas using spectral imagery at available resolutions. These indicators remain at the survey site level.

Seagrass percentage cover (from the Cover sheet) has some potential for spatial extrapolation using drone or Sentinel-2 imagery at meadow scale, but this is not part of the current skill scope. Refer to the companion extent skill (when created) for spatial mapping methodology.

For the SEEA EA condition account, site-level values are aggregated to an accounting-area mean across Kilifi County. Where sites differ substantially in meadow area, an area-weighted mean is preferred over a simple mean; without extent estimates, a simple mean across sites is used as a provisional approach and flagged as such.

Malindi Marine Park is the one formally designated protected area among the survey sites. Where feasible, condition metrics should be reported separately for Malindi Marine Park vs. unprotected sites to provide a preliminary conservation effectiveness contrast (see companion skill when created).

---

## 5. Normalisation to Condition Index

### Reference Levels

| Indicator | Reference Value | Source | Confidence | Rationale |
|---|---|---|---|---|
| Total seagrass cover | 60% | Duarte (1991); Orth et al. (2006); WIO regional assessments | MEDIUM | Widely used good-condition threshold across Indo-Pacific and WIO seagrass monitoring programmes; no Kenya-specific published threshold found |
| Shoot density — Thalassia hemprichii | 800 shoots/m² | Bandeira et al. (2014); East Africa monitoring literature | LOW-MEDIUM | Most common dominant species in WIO mixed meadows; provisional value from nearest regional literature; no Kilifi-specific published baseline |
| Shoot density — Cymodocea serrulata | 500 shoots/m² | Bandeira et al. (2014); East Africa literature | LOW | Provisional; East Africa values range widely (200–800 shoots/m²); use with caution |
| Shoot density — Halodule uninervis | 1,000 shoots/m² | Bandeira et al. (2014); East Africa literature | LOW | Pioneer species with naturally high density; provisional value; sensitive to eutrophication gradient |
| Shoot density — Enhalus acoroides | 100 shoots/m² | East Africa monitoring literature | LOW | Climax species with inherently low shoot density; large leaf area compensates; provisional |
| Shoot density — all species (site mean) | Max observed across sites | In-sample reference | LOW | Used where no published species-specific baseline exists; produces relative ranking only, not absolute condition |
| Canopy height | Max observed per species | In-sample reference | LOW | No published Kenya- or WIO-specific canopy height reference condition; relative ranking only |
| Species richness | Max observed across sites | In-sample reference | LOW | No published Kenya-specific reference richness for seagrass meadow condition; relative ranking only |

### Formulae

**Standard indicators (higher measured value = better condition):**
```
                    Measured Value
Condition Index = ─────────────────    (capped at 1.0; cannot exceed 1.0)
                   Reference Level

Examples:
    CI_cover[s]             = min(total_cover[s] / 60, 1.0)
    CI_density_Th[s]        = min(density_Thalassia[s] / 800, 1.0)
    CI_density_Cs[s]        = min(density_Cymodocea_serrulata[s] / 500, 1.0)
    CI_density_Hu[s]        = min(density_Halodule_uninervis[s] / 1000, 1.0)
    CI_density_Ea[s]        = min(density_Enhalus[s] / 100, 1.0)
```

**In-sample relative indices (where no published reference exists):**
```
                    Measured Value
Condition Index = ─────────────────    (capped at 1.0)
                   Max(Measured Value across all sites)

Examples:
    max_density = max(site_density_mean across all s)
    CI_density_relative[s] = site_density_mean[s] / max_density

    max_richness = max(richness[s] across all s)
    CI_richness[s] = richness[s] / max_richness

    max_height[sp] = max(site_sp_height_mean[s, sp] across all s)
    CI_height[s, sp] = site_sp_height_mean[s, sp] / max_height[sp]
```

**Important note on in-sample indices:** Relative indices (CI = value / max observed) are not equivalent to absolute condition against an ecological reference state. A site scoring CI = 0.5 on a relative index may still be in excellent condition if all surveyed sites are healthy. These indices should be labelled clearly as "relative" in all outputs and distinguished from indices normalised against published reference levels.

### Composite Condition Index (optional)

Where a single site-level score is required for reporting, a simple unweighted mean of the available condition indices can be computed. Given the unequal confidence levels across indicators, a weighted mean (weights proportional to confidence tier) is preferred where feasible. Do not compute a composite index until the provisional reference levels have been reviewed and confidence ratings updated.

---

## 6. Ecosystem Asset Representation

```
ECOSYSTEM ASSET: Seagrass Meadows (IUCN GET M1.1)
Seagrass Community Condition Account
Survey coverage: 10-11 areas across Kilifi County, Kenya; survey period 2024

Condition Indicator      Ref. Level         Source            Conf.    Measured   CI (0-1)
--------------------     -----------------  ----------------  -------  ---------  --------
Total cover (%)          60% (good)         Duarte 1991;      MEDIUM   TBD        TBD
                                            Orth et al. 2006
T. hemprichii density    800 shoots/m²      Bandeira et al.   LOW-MED  TBD        TBD
  (shoots/m²)                               2014
C. serrulata density     500 shoots/m²      Bandeira et al.   LOW      TBD        TBD
  (shoots/m²)                               2014
H. uninervis density     1,000 shoots/m²    Bandeira et al.   LOW      TBD        TBD
  (shoots/m²)                               2014
E. acoroides density     100 shoots/m²      East Africa lit.  LOW      TBD        TBD
  (shoots/m²)
Site shoot density       Max observed       In-sample         LOW      TBD        TBD
  (relative, all spp.)
Canopy height            Max observed       In-sample         LOW      TBD        TBD
  (relative)
Species richness         Max observed       In-sample         LOW      TBD        TBD
  (relative)

Note: TBD values are populated by the R analysis script (seagrass_condition.R).
      Provisional reference levels must be validated before use in final account.
```

---

## 7. Output: SEEA EA Condition Account Tables (Seagrass)

Output tables are produced in three forms:
1. **Cover site table:** Site x species cover matrix with species richness and total cover
2. **Health site table:** Site x species shoot density and canopy height with zone breakdown
3. **SEEA EA condition table:** Standard opening/closing format with condition indices

### 7a. Cover Site Table — seagrass_cover_site.csv

| area | species | n_subquadrats | n_plots | cover_mean_pct | cover_se | total_cover_pct | species_richness | composition_pct | survey_year |
|---|---|---|---|---|---|---|---|---|---|
| Bofa | Thalassia hemprichii | TBD | TBD | TBD | TBD | TBD | TBD | TBD | 2024 |
| Bofa | Cymodocea rotundata | TBD | TBD | TBD | TBD | TBD | TBD | TBD | 2024 |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

One row per site x species combination. The total_cover_pct and species_richness columns repeat the site-level aggregate on every row for that site (for convenience); alternatively provide a separate site-level summary table.

### 7b. Health Site Table — seagrass_health_site.csv

| area | species | zone | n_quadrats | density_mean_shoots_m2 | density_se | height_mean_cm | height_se | survey_year |
|---|---|---|---|---|---|---|---|---|---|
| Bofa | Thalassia hemprichii | Near shore | TBD | TBD | TBD | TBD | TBD | 2024 |
| Bofa | Thalassia hemprichii | Middle | TBD | TBD | TBD | TBD | TBD | 2024 |
| Bofa | Thalassia hemprichii | Near reef | TBD | TBD | TBD | TBD | TBD | 2024 |
| ... | ... | ... | ... | ... | ... | ... | ... | ... |

One row per site x species x zone combination. Include a zone == "All" row with the site x species aggregate (all zones pooled) for condition index calculation.

### 7c. SEEA EA Condition Account Table — seea_condition_account_seagrass_kenya.csv

Standard SEEA EA format: one row per site x indicator x survey period.

| area | indicator | ref_level | ref_source | ref_confidence | survey_year | measured_value | unit | condition_index | index_type | notes |
|---|---|---|---|---|---|---|---|---|---|---|
| Bofa | Total seagrass cover | 60 | Duarte 1991; Orth et al. 2006 | MEDIUM | 2024 | TBD | % | TBD | absolute | |
| Bofa | T. hemprichii shoot density | 800 | Bandeira et al. 2024 | LOW-MEDIUM | 2024 | TBD | shoots/m2 | TBD | absolute | Provisional reference |
| Bofa | Site shoot density (relative) | max_observed | in-sample | LOW | 2024 | TBD | shoots/m2 | TBD | relative | Not comparable across datasets |
| Bofa | Canopy height (relative) | max_observed | in-sample | LOW | 2024 | TBD | cm | TBD | relative | Not comparable across datasets |
| Bofa | Species richness (relative) | max_observed | in-sample | LOW | 2024 | TBD | count | TBD | relative | Not comparable across datasets |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

**Column definitions:**
- index_type: "absolute" (normalised against published reference level) or "relative" (normalised against in-sample maximum)
- condition_index: 0–1 scale; 1.0 = reference condition; < 1.0 = below reference

*Note: This dataset constitutes a single time-point survey (2024). Opening and closing values in the SEEA EA sense require a second survey period. Until resurvey data are available, the 2024 values serve as the opening (baseline) values only. The condition_account table structure should include opening_year, opening_value, opening_ci columns populated from 2024 data, with closing columns left as NA pending resurvey.*

### SEEA EA Condition Account: Seagrass Meadows (M1.1), Kilifi County

Single-period condition account (2024). All values are condition indices normalised 0-1.

| Entry | Units | Seagrass (M1.1) |
| --- | --- | --- |
| Total cover (2024) | index (0-1) | 0.963 |
| Species richness (2024) | index (0-1) | 0.537 |
| Composite (2024) | index (0-1) | 0.781 |

**Output file:** `KEN_SEEA_EA_condition_account_final.csv`

**Notes:**

- Composite = unweighted mean of cover CI, richness CI, and mean shoot density CI (where available)
- Single period only; opening/closing/change structure will apply when resurvey data are available
- ALL reference levels marked PROVISIONAL (LOW confidence); confirm against WIO seagrass literature before publication
- 10 survey areas across Kilifi County; 1,604 cover records + 1,436 health records

---

## 8. Data Quality and Limitations

| Issue | Impact | Mitigation |
|---|---|---|
| Inconsistent date formats (YYYY-MM-DD, DD/MM/YYYY, Excel integers) | Incorrect temporal ordering; impossible seasonal analysis | Multi-format date parsing in QA/QC step; flag unresolved rows |
| Species spelling errors (Halophilia, Thelassia, Halodulle) | Species misidentified; incorrect species-level aggregation | Lookup table standardisation in QA/QC; flag unmatched names |
| Sand/sand case inconsistency | Sand rows not excluded from cover calculations | Case-insensitive filter in QA/QC; standardise to "Sand" |
| Degree-minute coordinate strings in some rows | Incorrect site geolocation; misassignment to wrong area | Decimal degree conversion in QA/QC; verify against Kilifi County bounding box |
| Kanamai / Jumba ruins / Kanamai-Jumba ruins naming inconsistency | Incorrect site aggregation; apparent loss of sites | Confirm with field team; provisional lookup table in QA/QC |
| Two different quadrat sizes across sheets (50 cm x 50 cm cover; 15 cm x 15 cm health) | Cover and health sheets cannot be directly combined at quadrat level | Treated as independent sampling designs; linked only at site aggregate level |
| No published Kenya- or WIO-specific shoot density reference levels | Condition indices for density indicators are provisional; cannot confirm absolute condition | Report all density CIs as provisional LOW confidence; validate against Bandeira et al. 2014 and SEAWATCH East Africa data before finalising account |
| In-sample richness, density, and canopy height references | CI values are relative to this dataset only; not comparable across time or other datasets | Label clearly as "relative" in all outputs; do not use for cross-dataset or temporal comparisons until absolute references established |
| Single time-point survey (2024) | No temporal change assessment possible; cannot compute opening-to-closing change | 2024 values serve as baseline only; resurvey required within 2–3 years for a complete SEEA EA condition account |
| No stereo-video or permanent transect markers documented | Site relocation uncertainty for future resurveys | Recommend installing permanent quadrat markers at a subset of high-priority sites (Malindi Marine Park, Kuruwitu conservancy) during next field visit |
| No information on observer identity or within-site replication count in available schema | Cannot assess observer bias or quantify within-site variance from metadata alone | Check raw data for observer columns; report n quadrats per site x species as proxy for replication intensity |
| Halophila stipulacea present in dataset | Potential invasive or range-expanding species in WIO; elevated occurrence may indicate ecosystem change | Track prevalence and composition fraction across sites; flag if dominant at any site |

---

## 9. Implementation Checklist

- [ ] Ingest both sheets from `All_seagrass_field_data.xlsx` into R using `readxl::read_excel()`
- [ ] QA/QC dates: detect format, parse to ISO 8601 using `lubridate`; flag unresolved rows
- [ ] QA/QC coordinates: detect degree-minute strings; convert to decimal degrees; validate against Kilifi County bounding box; flag outliers
- [ ] QA/QC species names: apply lookup table for known misspellings; trim whitespace; flag unmatched names
- [ ] QA/QC Sand: standardise case; create is_sand flag; exclude Sand rows from cover calculations
- [ ] QA/QC site names: standardise Area column using canonical lookup; confirm Kanamai/Jumba ruins treatment with field team
- [ ] QA/QC numeric fields: validate Percentage Cover 0–100; Shoot density non-negative; Canopy height non-negative; flag outliers
- [ ] Calculate cover indicators: species cover mean per site; total cover per site; species composition; species richness
- [ ] Calculate health indicators: shoots/m² per quadrat; site x species mean density and SE; zone-level breakdown; site x species canopy height mean and SE
- [ ] Derive reference levels: confirm published values from Bandeira et al. 2014; compute in-sample maxima for relative indices
- [ ] Normalise to condition indices: apply formulae from Section 5; cap at 1.0; label index_type as "absolute" or "relative"
- [ ] Compile SEEA EA condition table: one row per site x indicator; populate all columns including confidence ratings
- [ ] Export outputs: `seagrass_cover_site.csv`, `seagrass_health_site.csv`, `seea_condition_account_seagrass_kenya.csv` to `Kenya/03_outputs/`
- [ ] Export QA/QC log: `qaqc_seagrass_log.csv` to `Kenya/03_outputs/`
- [ ] Review provisional reference levels with Kenya seagrass monitoring specialists before finalising account

---

## 10. Open Questions and Priority Actions

| Question | Priority | Action Required |
|---|---|---|
| Are Kanamai and Jumba ruins the same or separate survey areas? | HIGH | Confirm with field team before aggregation; affects site count and spatial coverage |
| What is the transect or plot layout within each 5 m x 5 m reference plot (Cover sheet)? | HIGH | Required to determine whether two-stage (plot then site) mean is needed or single-stage mean is appropriate |
| How many quadrats per zone per site (Health sheet)? | HIGH | Required to compute correct SE; check from raw data |
| Are permanent markers installed at any survey sites? | HIGH | Required for resurvey; recommend installation at Malindi Marine Park and Kuruwitu before next field season |
| What published shoot density baselines are available for Kilifi County or WIO? | HIGH | Conduct literature search against Bandeira et al. 2014, SEAWATCH programme, and KMFRI (Kenya Marine and Fisheries Research Institute) grey literature before finalising condition indices |
| Does the Health sheet record observer identity? | MEDIUM | Required to assess between-observer consistency; check raw data column headers |
| Is Halophila stipulacea present at elevated proportions at any site? | MEDIUM | Flag if present; compare with regional invasion literature |
| Should a bare substrate (sand) fraction indicator be included in the condition account? | MEDIUM | Increasing sand fraction may indicate seagrass loss; discuss with project team |
| What is the seagrass extent (ha) per site? | MEDIUM | Required for area-weighted aggregation and for condition-to-services linkages; commission extent mapping (drone or Sentinel-2) |
| What is the timing of SEAWATCH East Africa or KMFRI monitoring at any of these sites? | LOW | Would provide independent validation of field data and access to longer time series |

---

## 11. Tiered Assessment

### Sub-procedure Tier Assessment

| Sub-procedure | Tier 1 | Tier 2 | Tier 3 | Current tier |
|---|---|---|---|---|
| Field survey design | Opportunistic single-visit; <5 sites; no replication | Replicated quadrats at 5–15 sites with species identification; cover and health measured (this skill — 10-11 sites, multiple quadrats) | Permanent fixed transects at >15 sites; stratified by zone and depth; biennial minimum resurvey | 2 |
| Cover estimation method | Presence/absence or single quadrat | Percentage cover in replicated sub-quadrats within reference plots (this skill) | Photographic quadrat analysis with image-based cover estimation; spectral calibration | 2 |
| Shoot density method | Presence/absence or density class | Replicated quadrat counts scaled to shoots/m² (this skill) | Permanent marked quadrats with shoot counting; validated against biomass harvest | 2 |
| Reference level quality | Global average or in-sample relative only | Regional published benchmarks (WIO / East Africa) with acknowledged uncertainty (this skill's cover indicator: MEDIUM confidence) | Locally established reference condition from historical monitoring or pristine reference site | 1–2 (cover: 2; density: 1) |
| Temporal monitoring | Single snapshot (this skill) | Biennial surveys at fixed sites | Annual permanent monitoring stations | 1 |

### Binding Constraint Analysis

The current seagrass condition assessment is **Tier 2 on field design** (replicated quadrats across 10-11 sites with species-level identification) and **Tier 2 on cover estimation** (percentage cover in replicated sub-quadrats). The binding constraint is **reference level quality for shoot density and health indicators**, which are at Tier 1 (no formally published Kenya- or WIO-specific density baselines; provisional values only from regional literature). Temporal monitoring is also Tier 1 (single snapshot).

The account can be reported as a baseline (opening year) at this tier, but temporal change — the core of the SEEA EA condition account — requires at least one resurvey.

### Progression Pathway

To reach **Tier 2 on reference level quality for density indicators:** conduct a systematic review of KMFRI published reports, SEAWATCH East Africa programme data, and Bandeira et al. (2014) to identify Kilifi County or regional East African seagrass shoot density reference values. Consult with KMFRI Mombasa and international seagrass ecologists (e.g., contributors to the East African Seagrass Network) for unpublished long-term monitoring data.

To reach **Tier 2 on temporal monitoring:** resurvey a minimum subset of 5–7 sites (including Malindi Marine Park and Kuruwitu) within 2–3 years (by 2026–2027). Install permanent markers at these priority sites during the next field visit.

To reach **Tier 3:** establish permanent fixed transects at >15 sites resurveyed at least biennially; use photographic quadrat analysis for cover estimation; develop locally calibrated shoot density reference conditions from KMFRI long-term monitoring; implement biomass harvest calibration at a subset of sites; integrate spectral mapping for spatial extrapolation.

---

*Derived from: Kenya Kilifi County Seagrass Survey (2024). Aligned with UN SEEA EA (2021) and GOAP technical guidance.*
*Reference skill for format: Madagascar/docs/skills/skill_condition_biotic_fish_invert.md*
*Companion skills: skill_extent_seagrass_kenya.md (to be created); skill_condition_by_protected_area_kenya.md (to be created)*
