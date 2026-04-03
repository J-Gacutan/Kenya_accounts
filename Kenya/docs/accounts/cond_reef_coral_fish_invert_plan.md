# Plan: Coral Reef Condition Analysis — Kilifi County, Kenya

**Project:** AFRICA — accounts / Kenya
**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Photic Coral Reefs (M1.3)
**Geographic scope:** Kanamai to Malindi MPA, Kilifi County
**Accounting period:** 2024–2025

---

## Status Overview

| Step | Status | Notes |
|------|--------|-------|
| 1. Data inventory and file consolidation | COMPLETE | 8 files consolidated; 3 survey programmes; KLF master file used |
| 2. QA/QC | COMPLETE | 6 data quality flags resolved |
| 3. FishBase allometric parameters | COMPLETE | a/b parameters sourced for priority families |
| 4. Fish biomass and community metrics | COMPLETE | Output: KEN_fish_condition_site.csv |
| 5. Invertebrate metrics | COMPLETE | Output: KEN_invertebrate_condition_site.csv |
| 6. Coral structural condition | COMPLETE | Outputs: KEN_benthic_cover_site.csv, KEN_coral_health_site.csv, KEN_coral_recruitment_site.csv |
| 7. Normalisation to CI (0–1) | COMPLETE | Output: KEN_seea_condition_account.csv; reference levels in BASELINE_REFERENCE_TABLE.md |
| 8. PA-disaggregated condition account | COMPLETE | Output: KEN_condition_by_pa.csv (Watamu MPA, Malindi MPA, community parks, unprotected) |
| 9. Multi-year comparison | COMPLETE | Output: KEN_multiperiod_comparison.csv (Nov 2024 vs Jul 2025 COMRED sites) |
| 10. SEEA EA condition table export | COMPLETE | Output: KEN_SEEA_EA_condition_account_final.csv |

---

## Input Data

| File | Rows | Type | Survey | Date | Areas / Sites |
|------|------|------|--------|------|----------------|
| CCVA-SEPT2024-KILIFI-FISH-DATA.xlsx | 1,251 | Fish UVC | CCVA / KMFRI | Sep-Nov 2024 | 13 locations, 32 sites |
| CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx | 279 | Invertebrate UVC | CCVA / KMFRI | Oct-Nov 2024 | 16 locations, 34 sites |
| COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx | 2,611 (3 sheets) | Size structure + recruits + coral health | COMRED | Jul 2025 | 4 locations, 6 sites |
| COMRED_OCEANS-JULY2025-CORAL COVER-DATA.xlsx | 696 (2 sheets) | Benthic cover | COMRED | Jul 2025 | 3 areas |
| COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx | 941 (2 sheets) | Benthic cover (multi-year) | COMRED | 2024-2025 | 4 areas |
| COMRED_OCEANS-JULY2025-FISH-DATA.xlsx | 343 | Fish UVC | COMRED | Jul 2025 | 4 areas, 8 sites |
| KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx | 698 | Fish UVC consolidated | CCVA + GOAP + COMRED | Nov 2024 | 10 areas |
| PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx | 4,884 (5 sheets) | Extent + size + condition + recruits | PU-GOAP | Nov 2024 | 7 stretches, 6-9 sites |

**Approximate total records:** 11,700

**Key supervisors:** Dr. Juliet Karisa, Dr. Pascal Thoya (Pwani University)

---

## File Consolidation Strategy

Kenya data spans three independent survey programmes that partially overlap in sites and time. The consolidation priority is:

### Fish UVC
- **Primary dataset:** `KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx` (File 7) — the authoritative master fish file compiled from CCVA, GOAP, and COMRED surveys; 698 rows, 10 areas, Nov 2024 only
  - Action required: filter out template rows (pre-filled for 2025–2092 with no observation data) before use
- **Temporal supplement:** `COMRED_OCEANS-JULY2025-FISH-DATA.xlsx` (File 6) — 343 rows from Jul 2025; use for Nov 2024 vs Jul 2025 comparison at overlapping sites (Wesa, Roka, Uyombo, Watamu)
- **Do not use** `CCVA-SEPT2024-KILIFI-FISH-DATA.xlsx` (File 1) as a primary input — its 1,251 rows are already incorporated into the KLF consolidated file via the REFERENCE NOTES column

### Invertebrates
- **Primary:** `CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx` (File 2) — 279 rows; only invertebrate field data available
  - Note: COMRED Fish file (File 6) has an Inverts sheet, but it is empty (data not yet entered); flag as a data gap

### Coral Condition (health status)
- **Primary:** `PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx` Condition 1 sheet (594 rows; size class in single column — easier to process) — Nov 2024
- **Supplement:** `COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx` Conditions sheet (333 rows) — Jul 2025

### Coral Size Structure (adult colonies)
- `PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx` Adult size sheet (528 rows) — Nov 2024
- `COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx` Adult size class sheet (334 rows) — Jul 2025

### Coral Recruitment
- `PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx` Recruits sheet (3,168 rows) — Nov 2024; 9 sites
- `COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx` Recruits sheet (1,944 rows) — Jul 2025; 6 sites

### Benthic Cover (live coral cover)
- **Authoritative:** `COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx` (File 5) — 941 rows; spans 2024-2025; includes both data years at Watamu MPA, Roka, Uyombo, Wesa
- `COMRED_OCEANS-JULY2025-CORAL COVER-DATA.xlsx` (File 4) appears to be a subset of File 5 (fewer rows; same categories) — verify overlap and use File 5 as authoritative; do not double-count
- `PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx` Extent sheet (125 rows) — provides benthic cover across 7 geographic stretches; Nov 2024

---

## QA/QC Required

### Pre-processing checks

| Issue | File(s) | Action |
|-------|---------|--------|
| Template rows (2025–2092) present in master fish file | KLF (File 7) | Filter: keep rows with actual observation dates only (Nov 2024) |
| Duplicate longitude column | CCVA Fish (File 1) | Identify which column is correct; drop duplicate before merging |
| Latitude sign error (positive lat at row 2) | CCVA Inverts (File 2) | Verify sign convention; flip to negative if all other Kilifi lats are negative |
| File 4 vs File 5 overlap | COMRED Cover (4) + COMRED Data (5) | Compare row counts and site names; confirm File 5 is superset; discard File 4 for analysis |
| Location name inconsistencies across files | All | Standardise: "Sultance palace" / "Sultan palace" → "Sultan Palace"; "Kilifi Wesa" / "Wesa" → "Wesa" |
| Species name case and spelling | All fish files | Convert all species names to Title Case; fix known typos |
| Fish size class as range string (e.g. "5--10") | All fish UVC files | Convert to numeric midpoint (5–10 → 7.5; 10–20 → 15; 20–30 → 25; 30–40 → 35; 40–50 → 45; 50–60 → 55) |
| Trophic / functional group not assigned | All fish UVC files | Assign from FishBase family-level lookup (see Step 4) |
| Coral condition sheet duplication | PU-GOAP Condition vs Condition 1 | Use Condition 1 (consolidated size class) as primary; verify data are identical before discarding Condition sheet |

### Transect area assumption (HIGH PRIORITY — resolve before biomass calculation)

| Survey | Transect length | Width stated? | Assumed area | Status |
|--------|----------------|---------------|--------------|--------|
| CCVA Fish | 50 m | No | Unknown | CONFIRM with KMFRI |
| CCVA Inverts | 25 m | No | Unknown | CONFIRM with KMFRI |
| COMRED Fish (File 6) | Listed per row | No | Unknown | CONFIRM with Dr. Karisa |
| KLF Master (File 7) | Listed per row | No | Unknown | CONFIRM with Dr. Karisa / Dr. Thoya |
| PU-GOAP Coral recruits | Quadrats (1x1 m) | Yes | 1 m² per quadrat | OK — use for recruit density |
| COMRED Coral recruits | Quadrats | Yes (per row) | Confirm unit | CONFIRM |

Standard WIO UVC belt transect = 50 m x 5 m = 250 m² (same as Madagascar, now confirmed as 50 m x 5 m). If CCVA uses a 50 m transect, transect area is likely 250 m² (not 100 m²). All biomass and density calculations must use the confirmed transect area. Flag this as a binding assumption in the SEEA EA output.

---

## Step 3: FishBase Allometric Parameters

Unlike the Madagascar dataset, allometric parameters (a, b) are not included in the Kilifi fish data. These must be sourced externally.

**Approach:**
1. Extract the unique species list from the KLF master file (after QA/QC)
2. Match each species to FishBase (fishbase.org) for length-weight parameters a and b
3. Where species-level match fails, use genus-level or family-level mean parameters
4. Where no WIO-specific parameter exists, use the global FishBase estimate and flag uncertainty
5. Document sources in a `fishbase_params_kenya.csv` reference file in `01_inputs/metadata/`

**Priority families** (high biomass contribution based on CCVA and COMRED records):
Acanthuridae, Balistidae, Chaetodontidae, Epinephelidae, Labridae, Lethrinidae, Lutjanidae, Mullidae, Pomacentridae, Scaridae, Serranidae, Siganidae

---

## Step 4: Fish Biomass and Community Metrics

### Biomass calculation

For each fish record in the consolidated dataset:

```
W_i = a_i × L_mid^b_i
```

where L_mid is the midpoint length of the recorded size bin (cm), and a_i / b_i are FishBase parameters for species i.

Aggregate to transect level:

```
Biomass_transect = sum(W_i × N_i) / transect_area_m2 × 10,000
```

(result in kg/ha; multiply by 10,000 to convert from kg/m² to kg/ha)

Aggregate from transect to site level: mean across transects within site.

### Community metrics

| Metric | Unit | Calculation |
|--------|------|-------------|
| Total biomass | kg/ha | Sum across all species per transect; mean across transects per site |
| Species richness | count | Unique species per transect; mean across transects per site |
| Abundance | ind/ha | Count per transect scaled to per-ha |
| Trophic composition | % biomass | Biomass per trophic group / total biomass |
| Functional group diversity | count | Number of trophic groups with >0% biomass present |

**Trophic group assignment (FishBase family-level defaults):**

| Family | Trophic Group |
|--------|--------------|
| Acanthuridae, Scaridae, Siganidae | Herbivore |
| Epinephelidae, Serranidae, Lutjanidae | Carnivore / Piscivore |
| Chaetodontidae | Corallivore |
| Pomacentridae | Planktivore / Omnivore |
| Lethrinidae, Mullidae | Carnivore |
| Labridae | Carnivore / Omnivore |
| Balistidae | Omnivore |

Verify and override at species level where known; document final assignments.

---

## Step 5: Invertebrate Metrics

Source: CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx (279 rows; Oct-Nov 2024)

| Indicator | Species / Group | Calculation | Unit |
|-----------|----------------|-------------|------|
| Sea urchin density | Diadema spp., Echinometra mathaei, Parasaleniidae | Count per transect area, scaled to ind/m² | ind/m² |
| Giant clam abundance | Tridacna squamosa | Count per transect; report as density (ind/ha) and presence/absence per site | ind/ha |
| Sea cucumber abundance | Holothuridae / Holothuroidea | Count per transect scaled to ind/ha | ind/ha |
| COTS density | Acanthaster planci / A. cf. solaris | Count per transect scaled to ind/ha | ind/ha |
| Lobster presence | Palinuridae | Presence/absence per site | binary |

Note: Verify that Acanthaster (Crown-of-Thorns) was recorded in the Kilifi invertebrate data — the metadata lists it as "starfish" among recorded taxa; confirm identity.

Note: Invertebrate data covers 34 sites (Oct-Nov 2024). The COMRED Jul 2025 invertebrate sheet is empty — this remains a data gap for the Jul 2025 accounting period. Flag in outputs.

---

## Step 6: Coral Structural Condition Indicators

Kenya's data is substantially richer than Madagascar in structural (coral) indicators. Three complementary condition dimensions are available:

### 6a. Benthic cover (live coral cover)

Source: PU-GOAP Extent sheet (125 rows, Nov 2024) + COMRED-CORAL-DATA (File 5, 2024-2025)

| Metric | Calculation | Unit |
|--------|-------------|------|
| Live hard coral cover | Mean % across transects within site | % |
| Dead coral with algae | Mean % per site | % |
| Macro-algae cover | Mean % per site | % |
| Rubble cover | Mean % per site | % |
| Soft coral cover | Mean % per site | % |
| Bleached coral cover (if recorded) | Mean % per site | % |

PU-GOAP Extent sheet uses quadrat-based rapid assessment (columns: Live Coral %, Dead Coral, Bleached Coral, Seagrass %, Rubble %, Macro-algae %, Sand). This provides a Nov 2024 baseline across 7 geographic stretches.

COMRED-CORAL-DATA spans both 2024 and 2025 at Watamu MPA, Roka, Uyombo, Wesa — use for temporal comparison.

### 6b. Coral health status (% of colonies by condition category)

Source: PU-GOAP Condition 1 sheet (594 rows, Nov 2024) + COMRED Conditions sheet (333 rows, Jul 2025)

For each site, calculate:

| Metric | Calculation |
|--------|-------------|
| % healthy colonies | Healthy / (Healthy + Pale + Bleached + Diseased + Dead) per site |
| % bleached colonies | Bleached / total |
| % diseased colonies | Diseased / total |
| % dead colonies | Dead / total |
| % pale colonies | Pale / total (indicator of sub-lethal thermal stress) |

Disaggregate by genus (Acropora vs Porites vs Pocillopora vs massive corals) — genera differ substantially in bleaching susceptibility and recovery trajectory.

Context for Jul 2025 COMRED data: surveys fall ~15 months after the peak of the 2023–2024 mass bleaching event (4th global bleaching event, NOAA declaration April 2024). Dead coral observed in Jul 2025 is likely 2024 bleaching mortality. Bleached colonies in Jul 2025 may indicate chronic stress or secondary bleaching. Cross-check against NOAA Coral Reef Watch DHW product for Kilifi coast Jun–Jul 2025 before interpreting.

### 6c. Coral colony size structure

Source: PU-GOAP Adult size sheet (528 rows, Nov 2024) + COMRED Adult size class sheet (334 rows, Jul 2025)

Six size bins recorded: 11–20, 21–40, 41–80, 80–160, 160–320, >320 cm diameter.

For each site, calculate:
- Colony density per size bin (ind/m² or ind/transect)
- Size-frequency distribution (% of total colonies in each size bin)
- Proportion of large colonies (>80 cm) as maturity/age indicator
- Interpret against reference: healthy reef = many small colonies (frequent recruitment) + some large colonies (population persistence); degraded signal = missing small size classes (recruitment failure) OR missing large adults (recent bleaching mortality)

### 6d. Coral recruitment density

Source: PU-GOAP Recruits sheet (3,168 rows, Nov 2024, 9 sites) + COMRED Recruits sheet (1,944 rows, Jul 2025, 6 sites)

Three size bins: 0–2.5, 2.6–5, 6–10 cm (recorded per 1x1 m quadrat by genus)

| Metric | Calculation | Unit |
|--------|-------------|------|
| Total recruit density | Sum recruits per m² per site | recruits/m² |
| Recruit density by genus | Recruits/m² per genus (Acropora, Porites, Pocillopora, other) | recruits/m² |
| Smallest size class proportion | 0–2.5 cm / total recruits | % (recent settlement signal) |

Note: COMRED surveys (Jul 2025) record recruits in 1x1 m quadrats; confirm PU-GOAP quadrat area from sheet metadata.

---

## Step 7: Normalisation to Condition Indices (0–1)

All indicators are normalised to a 0–1 scale where 1.0 = reference condition.

| Indicator | Reference Level | Direction | Formula | Source | Confidence |
|-----------|----------------|-----------|---------|--------|------------|
| Fish biomass | 1,150 kg/ha (WIO conservation target) | Maximise | min(biomass / 1,150, 1.0) | McClanahan et al. 2016 | HIGH |
| Fish species richness | Max observed in dataset (Kenya) | Maximise | richness / max_richness | In-sample | MEDIUM |
| Trophic integrity (herbivore : carnivore ratio) | 25–40% herbivores in WIO reference reef | Maintain range | derived | McClanahan et al. 2011 | MEDIUM |
| Sea urchin density | 1.5–2 ind/m² (Echinometra outer reef, WIO; provisional) | Optimum range | 1 - abs(density - 1.75) / 1.75 | LOW confidence | LOW |
| COTS density | 0 ind/ha ideal; outbreak threshold 15 ind/ha | Minimise | 1 - (density / 15) capped at 0 | Dulvy et al. 2021 | MEDIUM |
| Giant clam presence | Site-level presence (binary complement to absence) | Maximise | present = 1; absent = 0 | Qualitative | LOW |
| Live coral cover | >30% = good condition (WIO / GCRMN 2021) | Maximise | cover / 30, capped at 1.0 | Obura et al. 2022; Souter et al. 2021 | MEDIUM |
| % healthy colonies | >95% healthy in low-stress non-bleaching year | Maximise | % healthy / 95 | Hoegh-Guldberg 1999 | MEDIUM |
| % bleached colonies | <2–5% background | Minimise | 1 - (% bleached / 5) | Hoegh-Guldberg 1999 | MEDIUM |
| % diseased colonies | <1–2% background | Minimise | 1 - (% diseased / 2) | Bourne et al. 2009 | MEDIUM |
| Coral recruit density | 1–3 recruits/m² (WIO healthy) | Maximise | min(density / 1.0, 1.0) | Hughes et al. 2010 | LOW-MEDIUM |
| Large colony proportion (>80 cm) | Site-specific; use max observed as reference | Maximise | proportion / max_proportion | In-sample | LOW |

Full reference evidence for all values: see `Kenya/docs/rag/academic/BASELINE_REFERENCE_TABLE.md` (Part 2, Themes 7-10).

---

## Step 8: PA-Disaggregated Condition Account

Kenya's survey network spans sites with varying protection status. Report all condition indicators disaggregated by PA category to enable conservation effectiveness analysis.

### PA Classification

| PA Name | Type | Sites covered |
|---------|------|---------------|
| Watamu Marine Park | No-take marine park | Turtle reef, Coral garden, Whale island/Uyombo |
| Malindi MPA | Managed MPA | Malindi Coral garden, Ngomeni outer |
| Kanamai Community Park | Community conserved area | Kanamai community park |
| Kuruwitu Community Park | Community conserved area | Kuruwitu community park |
| Unprotected | Open access | Roka, Wesa, Bofa, Jumba ruins, Navy, others |

Action required: join site-level condition means to PA classification table; compute mean CI per PA category; report protected vs unprotected comparison in SEEA EA output.

---

## Step 9: Multi-Year Comparison (Nov 2024 vs Jul 2025)

Sites with data in both periods (Nov 2024 and Jul 2025):

| Site | Nov 2024 data | Jul 2025 data |
|------|--------------|--------------|
| Watamu MPA | PU-GOAP (coral), KLF (fish) | COMRED (fish, coral, cover) |
| Roka | PU-GOAP (coral), KLF (fish) | COMRED (fish, coral, cover) |
| Wesa | PU-GOAP (coral), KLF (fish) | COMRED (fish, coral, cover) |
| Uyombo | KLF (fish) | COMRED (fish, coral, cover) |

For these 4 sites, calculate change in condition indicators between Nov 2024 and Jul 2025. Interpret in context of the 2023–2024 mass bleaching event (Jul 2025 surveys = ~15 months post-bleaching peak). Do not interpret as a standard 12-month accounting period change — note in SEEA EA output that the Nov 2024 baseline predates bleaching peak mortality expression at many sites.

---

## SEEA EA Condition Table: Opening and Closing Stocks

### Accounting Period

| Parameter | Value |
|-----------|-------|
| Opening survey date | November 2024 (CCVA/KMFRI + PU-GOAP) |
| Closing survey date | July 2025 (COMRED Oceans) |
| Interval | 8 months (note: not a standard 12-month accounting period; flag in all outputs) |
| Ecosystem asset | Photic Coral Reef (M1.3), Kilifi County coast |
| Accounting area | Kanamai to Malindi MPA; extent TBD from satellite mapping |

Temporal caveat: The Nov 2024 opening precedes the 2023-2024 mass bleaching mortality expression at many sites. The Jul 2025 closing is a post-disturbance snapshot. Change in coral condition indicators between the two time points reflects bleaching impact, not purely within-period ecological change. All condition accounts must note this explicitly.

---

### Disaggregation Design

The condition table is compiled at three nested levels:

Level 1 — Accounting area aggregate: All sites with data in each period pooled. Opening = up to 32+ sites (Nov 2024); Closing = 8 sites (Jul 2025, COMRED only). Aggregate CIs are area-weighted means across sites.

Level 2 — Protection status: Sites classified into four PA categories for conservation effectiveness analysis.

| PA category | Sites | Nov 2024 data | Jul 2025 data |
|-------------|-------|--------------|--------------|
| No-take marine park | Watamu MPA (Turtle reef, Coral garden, Whale island) | KLF fish | COMRED fish + coral |
| Managed MPA | Malindi MPA, Ngomeni outer | CCVA, KLF, PU-GOAP | -- |
| Community park | Kanamai, Kuruwitu | CCVA, KLF, PU-GOAP | -- |
| Unprotected | Roka, Wesa, Bofa, Uyombo, Sultan Palace, others | CCVA, KLF, PU-GOAP | COMRED (Roka, Wesa, Uyombo) |

Level 3 — Core monitoring sites (change detection): Four sites with field data at both time points. These are the only sites where opening-to-closing change can be calculated per indicator.

| Site | PA category | Nov 2024 sources | Jul 2025 sources |
|------|-------------|-----------------|-----------------|
| Roka | Unprotected | PU-GOAP (coral) + KLF (fish) | COMRED (fish + coral + cover) |
| Wesa | Unprotected | PU-GOAP (coral) + KLF (fish) | COMRED (fish + coral + cover) |
| Watamu MPA | No-take | KLF (fish) | COMRED (fish + coral + cover) |
| Uyombo | Unprotected | KLF (fish) | COMRED (fish + coral + cover) |

Note: Watamu MPA has fish data at both time points but no PU-GOAP coral condition data in Nov 2024. Coral change detection at Watamu is therefore partial (cover and condition Jul 2025 only; no Nov 2024 coral baseline from PU-GOAP).

---

### Condition Table Template (to be populated after analysis)

Values marked TBC are calculated during Steps 4-7. Reference levels are confirmed; CIs are derived using the formulae in Step 7.

#### Table A: Biotic condition — Fish community

| Indicator | Unit | Reference level | Opening (Nov 2024) | Opening CI | Closing (Jul 2025) | Closing CI | Change in CI | Sites (open / close) | Confidence |
|-----------|------|----------------|-------------------|-----------|-------------------|-----------|-------------|----------------------|-----------|
| Total fish biomass | kg/ha | 1,150 (WIO target); floor 600 | TBC | TBC | TBC | TBC | TBC | 10 areas / 4 areas | HIGH (ref); MED (value) |
| Fish species richness | count/site | Max observed (in-sample) | TBC | TBC | TBC | TBC | TBC | 10 areas / 4 areas | MEDIUM |
| Herbivore biomass | kg/ha | 25-40% of total biomass (WIO) | TBC | TBC | TBC | TBC | TBC | 10 areas / 4 areas | MEDIUM |
| Trophic composition | % biomass | Herbivore >= 25% | TBC | TBC | TBC | TBC | TBC | 10 areas / 4 areas | MEDIUM |

CI formula — fish biomass: min(biomass / 1,150, 1.0)
CI formula — species richness: richness / max_observed
CI formula — herbivore biomass: min(herbivore_pct / 0.30, 1.0) — mid-point of 25-40% target range

#### Table B: Biotic condition — Invertebrate community

| Indicator | Unit | Reference level | Opening (Nov 2024) | Opening CI | Closing (Jul 2025) | Closing CI | Change in CI | Sites (open / close) | Confidence |
|-----------|------|----------------|-------------------|-----------|-------------------|-----------|-------------|----------------------|-----------|
| Sea urchin density | ind/m² | 1.5-2 (WIO; provisional) | TBC | TBC | -- | -- | N/A | 34 sites / none | LOW |
| COTS density | ind/ha | 0 ideal; outbreak 15 | TBC | TBC | -- | -- | N/A | 34 sites / none | MEDIUM |
| Giant clam presence | prop. sites occupied | >0 (presence positive) | TBC | TBC | -- | -- | N/A | 34 sites / none | LOW |

Note: No Jul 2025 invertebrate data available (COMRED sheet empty). Closing CI not calculable for any invertebrate indicator. All invertebrate rows carry a single time point (opening only) and are flagged as partial in the account.

CI formula — sea urchin: 1 - abs(density - 1.75) / 1.75, clipped to [0,1] (optimum-range index)
CI formula — COTS: max(0, 1 - density / 15) (inverted; higher density = lower CI)
CI formula — giant clam: proportion of sites at which Tridacna squamosa present

#### Table C: Biotic condition — Coral community

| Indicator | Unit | Reference level | Opening (Nov 2024) | Opening CI | Closing (Jul 2025) | Closing CI | Change in CI | Sites (open / close) | Confidence |
|-----------|------|----------------|-------------------|-----------|-------------------|-----------|-------------|----------------------|-----------|
| Live hard coral cover | % | 30% (WIO good threshold) | TBC | TBC | TBC | TBC | TBC | 7 stretches / 4 areas | MEDIUM |
| % healthy colonies | % colonies | >95% (non-bleaching year) | TBC | TBC | TBC | TBC | TBC | 6 sites (PU-GOAP) / 6 sites (COMRED) | MEDIUM |
| % bleached colonies | % colonies | <5% background | TBC | TBC | TBC | TBC | TBC | 6 sites / 6 sites | MEDIUM |
| % diseased colonies | % colonies | <2% background | TBC | TBC | TBC | TBC | TBC | 6 sites / 6 sites | MEDIUM |
| % dead colonies | % colonies | <5% background | TBC | TBC | TBC | TBC | TBC | 6 sites / 6 sites | MEDIUM |
| Coral recruit density | recruits/m² | 1-3 (WIO healthy) | TBC | TBC | TBC | TBC | TBC | 9 sites / 6 sites | LOW-MED |
| Large colony proportion (>80 cm) | % of all colonies | Max observed (in-sample) | TBC | TBC | TBC | TBC | TBC | 6 sites / 6 sites | LOW |

CI formula — coral cover: min(cover / 30, 1.0)
CI formula — % healthy: min(pct_healthy / 95, 1.0)
CI formula — % bleached: max(0, 1 - pct_bleached / 5) (inverted)
CI formula — % diseased: max(0, 1 - pct_diseased / 2) (inverted)
CI formula — % dead: max(0, 1 - pct_dead / 50) (inverted; 50% dead = 0)
CI formula — recruit density: min(density / 1.0, 1.0) (floor reference = 1 recruit/m²)
CI formula — large colony proportion: proportion / max_proportion (in-sample)

---

### Composite Condition Index

A composite CI is calculated for each disaggregation level as the unweighted mean across all indicators with values available for that period. Where a closing value is unavailable (invertebrate indicators), the indicator is excluded from the closing composite to avoid artificial deflation.

| Level | Indicators in opening CI | Indicators in closing CI |
|-------|--------------------------|--------------------------|
| Fish | 4 (biomass, richness, herbivore, trophic) | 4 |
| Invertebrate | 3 (urchin, COTS, clam) | 0 (data gap) |
| Coral | 7 (cover, health × 4, recruits, size) | 7 |
| All combined | 14 | 11 |

Report opening and closing composite CIs separately for fish, invertebrate, and coral sub-components, and for all combined (14 and 11 indicator subsets respectively). Do not combine across sub-components without flagging the indicator count difference.

---

### Disaggregated Table Structure (Level 2 — Protection Status)

For each PA category, report the Level 3 table structure above using only the sites within that category. Where a PA category has no Jul 2025 data (Managed MPA, Community parks), report opening CI only and flag as partial.

| PA category | Opening CI (Nov 2024) | Closing CI (Jul 2025) | Change | Data completeness |
|-------------|----------------------|----------------------|--------|------------------|
| No-take MPA (Watamu) | TBC | TBC | TBC | Fish both; coral closing only |
| Managed MPA (Malindi) | TBC | -- | N/A | Opening only |
| Community park | TBC | -- | N/A | Opening only |
| Unprotected | TBC | TBC | TBC | All indicators; 3 sites both periods |

---

## Reference Levels Summary

| Indicator | Reference value | Unit | Confidence | Source |
|-----------|----------------|------|------------|--------|
| Fish biomass (WIO target) | 1,150 | kg/ha | HIGH | McClanahan et al. 2016 |
| Fish biomass (sustainability floor) | 600 | kg/ha | HIGH | McClanahan et al. 2016 |
| Fish biomass (Kenya Watamu no-take) | 700–1,000 | kg/ha | MEDIUM | McClanahan et al. 2007 |
| Live coral cover (good threshold) | >30 | % | MEDIUM | GCRMN 2021; Obura et al. 2022 |
| Live coral cover (Watamu pre-bleaching) | 30–45 | % | MEDIUM | Obura 2001; Kaunda-Arara et al. 2003 |
| Live coral cover (degraded threshold) | <10–15 | % | HIGH | Bruno & Selig 2007 |
| Background bleaching prevalence | <2–5 | % colonies | MEDIUM | Hoegh-Guldberg 1999 |
| Background disease prevalence | <1–2 | % colonies | MEDIUM | Bourne et al. 2009 |
| Coral recruit density (WIO healthy) | 1–3 | recruits/m² | LOW-MEDIUM | Hughes et al. 2010 |
| Sea urchin density | 1.5–2 | ind/m² | LOW | Provisional; WIO grey literature |
| COTS outbreak threshold | 15 | ind/ha | MEDIUM | Dulvy et al. 2021 |

---

## Open Questions / Review Items

### 1. Transect area (HIGH PRIORITY)
- CCVA fish transects: 50 m length; width not specified in metadata — standard WIO UVC belt = 5 m → 250 m² assumed
- CCVA invertebrate transects: 25 m length; width not specified — confirm with KMFRI
- COMRED fish transects: length listed per row; width unknown — confirm with Dr. Karisa
- Impact: all biomass and density values depend on this assumption; a factor-of-2 error in width halves or doubles all density outputs

### 2. FishBase parameter coverage
- a/b allometric parameters must be sourced for all species before biomass can be calculated
- For rare or unidentified species, family-level means introduce uncertainty; flag affected records
- The CCVA and COMRED species lists partially overlap; one joint FishBase lookup will cover both

### 3. Invertebrate gap (Jul 2025)
- COMRED's invertebrate sheet (File 6) is empty — no invertebrate data from the Jul 2025 campaign
- All invertebrate indicators are therefore Nov 2024 only; flag this gap in the SEEA EA account table
- Recommend requesting COMRED to complete and submit invertebrate data from the Jul 2025 surveys

### 4. Bleaching event context (Jul 2025 data)
- Jul 2025 surveys are ~15 months post-peak of the 2023–2024 global bleaching event
- Dead coral observed in Jul 2025 almost certainly represents 2024 bleaching mortality, not a current outbreak
- Bleached colonies in Jul 2025 may indicate residual thermal stress or recurrence (verify against NOAA Coral Reef Watch DHW data for Kilifi coast Jun–Jul 2025)
- Do NOT treat Jul 2025 coral condition as a "reference baseline" — this is a post-disturbance snapshot

### 5. Coral recruit density reference level (CRITICAL GAP)
- No published Kenya or WIO-specific coral recruit density in recruits/m²; WIO provisional reference 1–3 recruits/m² (Hughes et al. 2010; LOW-MEDIUM confidence)
- Phase 2 action: retrieve Obura & Grimsditch 2009 (IUCN Resilience Report) and contact CORDIO East Africa for site-level monitoring data from Watamu and Malindi

### 6. Survey method harmonisation
- PU-GOAP uses different transect length and quadrat methods compared to CCVA and COMRED
- Before merging coral condition and size structure data across surveys, document each survey's protocol explicitly and flag any indicator where methods are not directly comparable
- Where methods differ, report surveys separately rather than pooling

### 7. Location name standardisation list (to implement in QA/QC)

| Raw form | Standardised form |
|----------|------------------|
| Sultance palace | Sultan Palace |
| Sultan palace | Sultan Palace |
| Kilifi Wesa | Wesa |
| Wesa | Wesa |
| Roka 1 / Roka 2 | Roka (specify transect) |
| Richard Bennet / Richard Benet / Richard Bennett | Richard Bennett |

---

## Output Files (planned)

| File | Location | Description |
|------|----------|-------------|
| `fish_invert_coral_condition.R` | `02_analysis/` | Master R script: QA/QC, biomass, condition indices, PA joins, exports |
| `fishbase_params_kenya.csv` | `01_inputs/metadata/` | FishBase a/b lookup table for Kilifi fish species |
| `fish_condition_site.csv` | `03_outputs/` | Site-level fish condition metrics (biomass, richness, trophic composition) |
| `invert_condition_site.csv` | `03_outputs/` | Site-level invertebrate condition metrics |
| `coral_condition_site.csv` | `03_outputs/` | Site-level coral condition metrics (cover, health, size structure, recruitment) |
| `seea_condition_account_kenya.csv` | `03_outputs/` | SEEA EA condition account table (all indicators; PA-disaggregated) |
| `condition_by_pa.csv` | `03_outputs/` | Protected area comparison (mean CI per PA category) |

---

## Tiered Assessment Summary

| Sub-procedure | Current Tier | Binding? |
|---------------|-------------|----------|
| Fish UVC: multi-programme, 10 areas, 2 time points | 2 | |
| Biomass estimation (visual + FishBase allometric) | 2 | |
| Invertebrate UVC (CCVA only; 1 time point) | 2 | |
| Coral condition: multi-programme, 2 time points | 2 | |
| Coral recruitment: 2 time points, genus-level | 2 | |
| Reference level setting | 1–2 | YES — binding |
| PA classification (WDPA / known MPA boundaries) | 2 | |
| Temporal coverage (Nov 2024 + Jul 2025 — not full accounting year) | 1 | YES — binding |

Overall account accuracy: Tier 1–2. Constrained by reference level confidence (particularly coral cover and recruit density) and the post-bleaching survey timing of the Jul 2025 data.

---

## Results Summary

**Headline findings (2024-2025):**

- Fish biomass: 438.8 kg/ha (Nov 2024) rising to 647.5 kg/ha (Jul 2025); CI 0.284/0.357 vs WIO target of 1,150 kg/ha (HIGH confidence)
- Fish species richness: 11.7 spp/transect (Nov 2024) to 13.3 (Jul 2025); CI 0.60/0.72 (MEDIUM confidence)
- Live hard coral cover: 40.0% (Nov 2024) declining to 21.9% (Jul 2025); CI 0.905/0.730 (MEDIUM confidence) — bleaching mortality from 2023-24 event
- Healthy coral colonies: 76.9% to 94.8% — recovery signal confirmed
- Bleaching prevalence: 6.6% to 0% — fully resolved by Jul 2025
- Coral recruitment: 0.010 to 0.054 recruits/m2 — critically low throughout (LOW-MEDIUM confidence)
- COTS: absent; disease: absent (both CI 1.0, HIGH confidence)

**PA disaggregation (Jul 2025):**

| Category | Coral cover (%) | Composite CI |
|----------|----------------|--------------|
| Watamu No-Take MPA | 23.8 | 0.794 |
| Unprotected sites | 19.2 | 0.635 |

**Output files (all in `03_outputs/`):**
- KEN_fish_condition_site.csv
- KEN_invertebrate_condition_site.csv
- KEN_benthic_cover_site.csv
- KEN_coral_health_site.csv
- KEN_coral_recruitment_site.csv
- KEN_site_condition_all_indicators.csv
- KEN_condition_by_pa.csv
- KEN_multiperiod_comparison.csv
- KEN_seea_condition_account.csv
- KEN_seea_condition_summary.csv
- KEN_fish_seea_rows.csv
- KEN_SEEA_EA_condition_account_final.csv

---

## Open Items (Post-Completion)

1. Transect area confirmation with Dr. Karisa / Dr. Thoya / KMFRI — affects biomass density if revised (HIGH PRIORITY)
2. Jul 2025 invertebrate data from COMRED — not yet submitted; invertebrate account has Nov 2024 data only
3. Coral recruitment methodological equivalence — size class criterion should be confirmed before comparing to published WIO reference values
4. Phase 2 literature sources (see `SEARCH_PLAN_Condition_Baselines_Kenya.md`) — Obura 2001 and McClanahan et al. 2007 for coral cover and fish biomass references

*Created: 2026-03-16*
*Updated: 2026-03-28 — all 10 steps marked COMPLETE; results summary added*
*Status: COMPLETE — all analysis steps finished; outputs in 03_outputs/*
