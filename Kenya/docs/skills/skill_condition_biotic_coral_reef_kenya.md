# Skill: Ecosystem Condition — Coral Reef Biotic Indicators (Kenya, M1.3)

**Purpose:** Calculate fish, invertebrate, and coral structural condition indicators for photic coral reef ecosystems (IUCN GET M1.3) from multi-programme field survey data covering Kilifi County, Kenya, and normalise to condition indices for the SEEA EA condition account.

**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Photic Coral Reefs (M1.3)
**Geographic scope:** Kilifi County, Kenya (Kanamai to Malindi MPA)
**Accounting periods:** Opening: Nov 2024 | Closing: Jul 2025
**Analysis script:** `Kenya/02_analysis/coral_reef_condition.R`
**Plan document:** `Kenya/docs/accounts/cond_reef_coral_fish_invert_plan.md`
**Baselines:** `Kenya/docs/rag/academic/BASELINE_REFERENCE_TABLE.md`

---

## 1. Field Survey Data

Three survey programmes contributed data across eight Excel files (~11,700 records).

### Survey Programmes

| Programme | Organisation | Period | Data types |
|---|---|---|---|
| CCVA | KMFRI | Sep-Nov 2024 | Fish UVC, invertebrate UVC |
| PU-GOAP | Pwani University + GOAP | Nov 2024 | Benthic extent (quadrats), coral size structure, coral health, recruits |
| COMRED Oceans | COMRED | Jul 2025 | Fish UVC, coral size structure, coral health, recruits, benthic cover |

**Key supervisors:** Dr. Juliet Karisa (Pwani University), Dr. Pascal Thoya (Pwani University)
**Key collectors:** Mohamed Hamisi, Nancy, Patricia

### Input Files

| File | Rows | Data type | Survey period | Authoritative for |
|---|---|---|---|---|
| `KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx` | 698 | Fish UVC (consolidated master) | Nov 2024 | Fish — opening period |
| `CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx` | 279 | Invertebrate UVC | Oct-Nov 2024 | Invertebrates (only source) |
| `COMRED_OCEANS-JULY2025-FISH-DATA.xlsx` | 343 | Fish UVC | Jul 2025 | Fish — closing period |
| `COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx` | 2,611 | Coral size structure, recruits, health | Jul 2025 | Coral structural — closing |
| `COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx` | 770 | Benthic cover (multi-year) | 2024-2025 | Benthic cover — both periods |
| `PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx` | 4,884 | Benthic extent, size structure, health, recruits | Nov 2024 | Coral structural — opening |

Note: `COMRED_OCEANS-JULY2025-CORAL COVER-DATA.xlsx` is a subset of `COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx`. Use the latter (authoritative, multi-year).

### Transect Design

| Data type | Transect length | Assumed width | Area | Status |
|---|---|---|---|---|
| Fish UVC (CCVA, KLF) | 50 m | 5 m | 250 m² | PENDING field team confirmation |
| Fish UVC (COMRED) | 50 m | 5 m | 250 m² | PENDING field team confirmation |
| Invertebrate UVC (CCVA) | 25 m | variable | Variable | Confirm with KMFRI |
| Coral recruits | 1 m x 1 m quadrats | — | 1 m² | Confirmed from metadata |

TRANSECT_AREA_M2 = 250 assumed throughout. Update `coral_reef_condition.R` CONFIG block once confirmed with Dr. Karisa / Dr. Thoya / KMFRI.

### Protected Areas Covered

| PA name | PA type | Sites |
|---|---|---|
| Watamu Marine Park | No-take MPA | Watamu Coral Garden, Turtle Reef, Whale island/Uyombo, Richard Bennett |
| Malindi MPA | Managed MPA | Malindi Coral Garden, Ngomeni Outer |
| Kanamai Community Park | Community CPA | Kanamai Community Park |
| Kuruwitu Community Park | Community CPA | Kuruwitu Community Park |
| Unprotected | Open access | Roka, Wesa, Uyombo, Bofa, Jumba Ruins, Navy, Takaungu, Marereni, Ngomeni, Sultan Palace |

---

## 2. Field Data QA/QC

```
Raw Excel files (8 files, 3 survey programmes)
    |
    +-- Ingest with readxl::read_excel() + janitor::clean_names()
    |   (standardises column names to snake_case; removes whitespace)
    |
    +-- Fish UVC (KLF + COMRED) — clean_fish_uvc()
    |   +-- Filter: remove template rows (date = NA, species = NA/"0")
    |   |   (KLF file pre-fills 2025-2092 as placeholders — filter to actual data)
    |   +-- GPS: fix_gps() — restore missing decimal points
    |   |   (valid range: lat -5 to -1, lon 38 to 42)
    |   +-- Site names: standardise_site() lookup table
    |   |   "Sultance palace" / "Sultan palace" -> "Sultan Palace"
    |   |   "Kilifi Wesa" -> "Wesa"
    |   |   "Richard Bennet" / "Richard Benet" -> "Richard Bennett"
    |   |   "Watamu marine park" / "Coral garden" -> "Watamu Coral Garden"
    |   +-- Taxonomy: str_to_sentence(species), str_to_title(family)
    |   +-- Fish size: parse_size_mid() — "5--10" -> 7.5 cm midpoint
    |   +-- Columns: any_of("reference_notes") — KLF has it; COMRED does not
    |
    +-- Invertebrate UVC (CCVA) — manual pipeline
    |   +-- GPS: fix_gps() — same valid ranges
    |   +-- Known error: row 2 has positive latitude (3.94326) for Kilifi site;
    |   |   fix_gps() corrects sign; verify manually before publication
    |   +-- Site names: standardise_site()
    |   +-- Taxonomy: str_to_sentence(species), str_to_title(family)
    |
    +-- Coral health condition (PU-GOAP + COMRED) — clean_coral_cond()
    |   +-- Column rename: rename_with() maps both "transect_number" (COMRED)
    |   |   and "transect" (PU-GOAP) to "transect_no"
    |   |   Note: use rename_with(), NOT rename(c(transect_no = "transect_number",
    |   |   transect_no = "transect")); duplicate named-vector keys silently drop
    |   |   all but the last entry in R
    |   +-- Site names: standardise_site()
    |   +-- Genus: str_to_sentence()
    |   +-- Health columns: coerce to numeric (suppress warnings for blanks)
    |
    +-- Coral adult size structure (PU-GOAP + COMRED) — clean_adult_size()
    |   +-- Detect size-bin columns by pattern: ADULT_SIZE_PATTERN
    |   |   "^x[0-9]|^[0-9]|gt_|^x_[0-9]"
    |   +-- Coerce to numeric; standardise site/genus
    |
    +-- Coral recruits (PU-GOAP + COMRED) — clean_recruits()
    |   +-- Detect recruit-bin columns by pattern: RECRUIT_SIZE_PATTERN
    |   |   "^[0-9]|^r_|^x[0-9]"
    |   +-- Fallback if pattern matches nothing: columns starting "^[0-9]"
    |   +-- Coerce to numeric; standardise site/genus
    |
    +-- Benthic cover (COMRED CORAL-DATA, both years)
    |   +-- year column -> survey_period (2024 -> Nov_2024; 2025 -> Jul_2025)
    |   +-- benthic_cat: str_to_upper() for consistent category codes
    |
    +-- Benthic cover (PU-GOAP extent sheet, Nov 2024)
        +-- Quadrat-based rapid assessment across 7 stretches
        +-- Columns: live_coral_pct, dead_coral, bleached_coral,
            macroalgae, rubble (coerce to numeric)
```

### Known Data Quality Flags

| Flag | Files affected | Action |
|---|---|---|
| Template rows for 2025-2092 | KLF consolidated fish | Filter by date (remove NA dates) before analysis |
| Duplicate longitude column | CCVA fish (File 1) | Use first `longtitude` column; verify both match |
| Positive latitude in row 2 | CCVA inverts | fix_gps() corrects; verify manually |
| Column name variation | COMRED vs PU-GOAP coral | rename_with() + any_of() handles transparently |
| COMRED inverts sheet empty | COMRED fish file | No Jul 2025 invertebrate data available; CCVA Nov 2024 only |
| Species name casing | Fish files | str_to_sentence() / str_to_title() normalises |
| Site name inconsistency | Across all files | SITE_NAME_MAP lookup in standardise_site() |

---

## 3. Indicator Calculation

### 3a. Fish Indicators

| Indicator | Calculation | Unit | Direction |
|---|---|---|---|
| Fish biomass | W = a x L^b per size-class midpoint; scaled to per-ha | kg/ha | Higher = better |
| Fish abundance | Count scaled to per-ha | individuals/ha | Higher = better |
| Fish species richness | Unique species per site | count | Higher = better |
| Trophic composition | % biomass per trophic group | % | Balanced = better |

#### Biomass Calculation Detail

FishBase allometric parameters (W = a x L^b) are sourced from:
`Kenya/01_inputs/metadata/fishbase_params_kenya.csv`

Expected CSV columns: `species, family, a, b, source`

If file is absent, Steps 3-4 are skipped with a warning. Steps 5-10 (coral and invertebrate indicators) run unconditionally.

```
Fish size range strings -> midpoint cm:
  "5--10" -> 7.5   "10--20" -> 15   "20--30" -> 25
  "30--40" -> 35   "40--50" -> 45   "50--60" -> 55

For each observation row (species x transect x period):
    L = fish_size_mid_cm
    W = a x L^b          (grams per individual)
    biomass_g = W x total_number

Transect biomass (kg/ha):
    biomass_kg_ha = (sum(biomass_g) / 1000) / TRANSECT_AREA_HA

Parameter matching:
    1. Species-level match (FishBase species name)
    2. Family-level mean (if species not in FishBase)
    3. Record excluded if no family match (warning logged)

Trophic group assignment (TROPHIC_LOOKUP by family):
    Herbivore: Acanthuridae, Scaridae, Siganidae, Kyphosidae
    Piscivore: Epinephelidae, Serranidae, Carangidae
    Carnivore: Lutjanidae, Lethrinidae, Haemulidae, Mullidae, Labridae, Holocentridae
    Corallivore: Chaetodontidae
    Omnivore: Balistidae, Tetraodontidae, Pomacanthidae
    Planktivore: Pomacentridae

Site-level aggregation (per survey_period, site):
    mean_biomass_kg_ha   = mean(transect biomass)
    se_biomass_kg_ha     = sd / sqrt(n_transects)
    mean_abundance_ha    = mean(transect abundance)
    mean_richness        = mean(species_richness per transect)
    n_transects          = count of transects
```

### 3b. Invertebrate Indicators

Data source: CCVA only (Nov 2024). No Jul 2025 invertebrate data available.

| Indicator | Species targeted | Unit | Direction |
|---|---|---|---|
| Sea urchin density | Diadema setosum, Echinometra mathaei, Diadema savignyi, Echinothrix diadema | ind/m² | Context-dependent (optimum range) |
| COTS density | Acanthaster planci, Acanthaster cf. solaris | ind/ha | Higher = worse (inverted) |
| Giant clam (Tridacna) | Tridacna squamosa, Tridacna maxima | presence / ind/ha | Higher = better |
| Sea cucumber abundance | Holothuria spp., Thelenota ananas, Bohadschia argus | ind/ha | Informational |

Species are matched by exact name AND by regex fallback (e.g., `regex("urchin", ignore_case = TRUE)`), providing robustness against minor spelling variation.

### 3c. Coral Structural Indicators

**Benthic cover** (from COMRED CORAL-DATA + PU-GOAP extent sheet):

| Indicator | Benthic category codes | Unit |
|---|---|---|
| Live coral cover | C | % |
| Dead coral with algae | DCA | % |
| Macroalgae | MA | % |
| Rubble / sand | SPR, BS | % |
| Bleached coral cover | DC | % |

Where COMRED and PU-GOAP cover the same site, COMRED takes precedence (LIT/PIT method vs. rapid quadrat assessment).

**Coral health status** (from PU-GOAP Condition 1 + COMRED Conditions sheet):

Per site per period:
```
n_total = sum(healthy + pale + bleached + diseased + dead)
pct_healthy   = 100 * n_healthy   / n_total
pct_bleached  = 100 * n_bleached  / n_total
pct_diseased  = 100 * n_diseased  / n_total
pct_dead      = 100 * n_dead      / n_total
```

**Colony size structure** (from PU-GOAP Adult size + COMRED Adult size class):

Size bins (diameter cm): 11-20, 21-40, 41-80, 80-160, 160-320, >320

Size-bin columns detected by ADULT_SIZE_PATTERN: `"^x[0-9]|^[0-9]|gt_|^x_[0-9]"`

```
Per site per period:
    pct_large_colonies = 100 * n_colonies(>80 cm) / n_colonies(total)
    dominant_size_class = modal size bin
```

Large-adult proportion (>80 cm) = proxy for population persistence and reproductive potential.

**Coral recruitment** (from PU-GOAP Recruits + COMRED Recruits):

Recruit bins (diameter cm): 0-2.5, 2.6-5, 6-10

Bin columns detected by RECRUIT_SIZE_PATTERN: `"^[0-9]|^r_|^x[0-9]"`

```
Per quadrat (1 m²):
    recruits_m2 = total recruit count / RECRUIT_QUADRAT_M2

Per site per period:
    mean_recruits_m2 = mean(recruits_m2 across quadrats)
    se_recruits_m2   = sd / sqrt(n_quadrats)
```

---

## 4. Normalisation to Condition Index (0-1)

### Reference Levels

| Indicator | Reference level | Source | Confidence |
|---|---|---|---|
| Fish biomass | 1,150 kg/ha (conservation target); 600 kg/ha (sustainability floor) | McClanahan et al. (2016) PLOS ONE | HIGH |
| Fish species richness | Max observed in dataset (period-specific relative) | Dataset-internal | MEDIUM |
| Live coral cover | >30% = good condition | GCRMN (2021); Obura et al. (2022) | MEDIUM |
| Bleached colonies | <5% background (non-bleaching year) | Hoegh-Guldberg (1999) | MEDIUM |
| Diseased colonies | <2% background | Bourne et al. (2009) | MEDIUM |
| Healthy colonies | 95% (non-bleaching year baseline) | Hoegh-Guldberg (1999) | MEDIUM |
| Coral recruit density | 1-3 recruits/m² (WIO healthy reef) | Hughes et al. (2010) WIO | LOW-MEDIUM |
| COTS density | Outbreak threshold: 15 ind/ha | Dulvy et al. (2021) | MEDIUM |
| Sea urchin density | Optimum: 1.5-2 ind/m² (Echinometra mathaei, outer reef) | McClanahan (1987+); WIO studies | LOW (provisional) |

### Formulae

**Standard (higher = better) — fish biomass, coral cover, % healthy, recruit density:**
```
CI = min(measured_value / reference_level, 1.0)

Examples:
    CI_fish_biomass  = min(450 kg/ha / 1150 kg/ha, 1) = 0.39
    CI_coral_cover   = min(28% / 30%, 1) = 0.93
    CI_recruitment   = min(0.8 recruits/m² / 1.0 recruits/m², 1) = 0.80
```

**Inverted (higher = worse) — bleaching, disease, COTS:**
```
CI = max(1 - measured_value / reference_level, 0.0)

Examples:
    CI_bleaching = max(1 - 8% / 5%, 0) = 0.0  (>background; poor condition)
    CI_cots      = max(1 - 7 ind/ha / 15 ind/ha, 0) = 0.53
```

**Optimum range — sea urchin density:**
```
CI = max(1 - |measured - optimum| / optimum, 0.0)
     where optimum = 1.75 ind/m² (midpoint of 1.5-2 provisional range)

Example:
    CI_urchin = max(1 - |2.5 - 1.75| / 1.75, 0) = 0.57
```

### Post-bleaching Caution (Jul 2025 Data)

The Jul 2025 COMRED surveys were conducted ~15 months after the peak of the 2023-2024 global mass bleaching event. Bleaching and dead colony percentages in the Jul 2025 data likely reflect mortality from this event, NOT a routine 12-month accounting period change.

- Do NOT compute "change in bleaching" as if the two periods were comparable baselines.
- The `multiperiod` output includes a `bleaching_note` column flagging this interpretation.
- Report opening (Nov 2024) and closing (Jul 2025) separately; annotate closing values.
- Recommended framing: "Jul 2025 closing values reflect reef status ~15 months post-bleaching event."

---

## 5. PA-Disaggregated Condition Account

All site-level condition indicators are joined to PA_CLASSIFICATION using `site_std` as the key.

```
PA types in dataset:
    "No-take MPA"    -> Watamu Marine Park
    "Managed MPA"    -> Malindi MPA
    "Community CPA"  -> Kanamai Community Park, Kuruwitu Community Park
    "Open access"    -> All remaining unprotected sites
```

Sites not matched in PA_CLASSIFICATION receive `pa_name = "Unknown"` and `pa_type = "Unknown"`. Update PA_CLASSIFICATION in the CONFIG block when new sites are added.

PA-level summary output (`condition_by_pa.csv`) provides mean condition index per PA category per period, enabling protected vs. unprotected reef condition comparisons.

---

## 6. Output Files

All outputs written to `Kenya/03_outputs/`.

| File | Contents |
|---|---|
| `seea_condition_account_kenya.csv` | Long-format SEEA EA condition table — one row per site x period x indicator |
| `seea_condition_summary_kenya.csv` | Accounting-area summary — mean ± SE across sites, per period x indicator |
| `site_condition_all_indicators.csv` | Wide-format — all condition indices for each site x period combination |
| `condition_by_pa.csv` | Mean condition index by PA category and period |
| `multiperiod_comparison.csv` | Sites with both periods; absolute changes in cover, bleaching, dead coral |
| `coral_health_site.csv` | Coral health counts and % by site x period |
| `coral_recruitment_site.csv` | Mean recruit density and SE by site x period |
| `benthic_cover_site.csv` | Live coral, dead, macroalgae, rubble % by site x period |
| `invertebrate_condition_site.csv` | Urchin density, COTS density, Tridacna presence by site |
| `fish_condition_site.csv` | Fish biomass, richness, abundance by site x period (if FishBase params available) |

### SEEA EA Condition Table Structure

One row per: `ecosystem_type x geographic_scope x survey_period x site x condition_indicator`

| Column | Description |
|---|---|
| ecosystem_type | "Coral reef (M1.3)" |
| geographic_scope | "Kilifi County, Kenya" |
| survey_period | "Nov_2024" or "Jul_2025" |
| site | Standardised site name |
| pa_name | Protected area name |
| pa_type | PA category |
| condition_indicator | Indicator name (e.g., "Live hard coral cover") |
| unit | Measurement unit |
| measured_value | Raw measured value (rounded to 3 dp) |
| condition_index | Normalised 0-1 condition index |
| reference_level | Text description of reference used |
| confidence | HIGH / MEDIUM / LOW-MEDIUM / LOW |
| note | Caveats (e.g., post-bleaching flag, pending transect area confirmation) |

### SEEA EA Condition Account: Coral Reef (M1.3), Kilifi County

Multi-period condition account: opening (Nov 2024) to closing (Jul 2025).

| Entry | Units | Coral Reef (M1.3) |
| --- | --- | --- |
| Live coral cover -- Opening (Nov 2024) | index (0-1) | 0.905 |
| Live coral cover -- Closing (Jul 2025) | index (0-1) | 0.730 |
| Live coral cover -- Change | index (0-1) | -0.175 |
| Coral bleaching -- Opening (Nov 2024) | index (0-1) | 0.628 |
| Coral bleaching -- Closing (Jul 2025) | index (0-1) | 1.000 |
| Coral bleaching -- Change | index (0-1) | +0.372 |
| Coral health -- Opening (Nov 2024) | index (0-1) | 0.809 |
| Coral health -- Closing (Jul 2025) | index (0-1) | 0.977 |
| Coral health -- Change | index (0-1) | +0.168 |
| Coral recruitment -- Opening (Nov 2024) | index (0-1) | 0.010 |
| Coral recruitment -- Closing (Jul 2025) | index (0-1) | 0.054 |
| Coral recruitment -- Change | index (0-1) | +0.044 |
| Fish biomass -- Opening (Nov 2024) | index (0-1) | 0.300 |
| Fish biomass -- Closing (Jul 2025) | index (0-1) | 0.380 |
| Fish biomass -- Change | index (0-1) | +0.080 |
| Fish richness -- Opening (Nov 2024) | index (0-1) | 0.629 |
| Fish richness -- Closing (Jul 2025) | index (0-1) | 0.728 |
| Fish richness -- Change | index (0-1) | +0.098 |
| Composite -- Opening (Nov 2024) | index (0-1) | 0.547 |
| Composite -- Closing (Jul 2025) | index (0-1) | 0.645 |
| Composite -- Change | index (0-1) | +0.098 |

**Output file:** `KEN_SEEA_EA_condition_account_final.csv`

**Notes:**

- Jul 2025 data collected ~15 months post-2024 bleaching event peak; interpret condition improvement with caution (post-event recovery, not secular trend)
- Fish biomass values are [PENDING] transect area confirmation (250 m2 assumed)
- Composite = unweighted mean of 6 core indicators (coral cover, bleaching, health, recruitment, fish biomass, fish richness)
- Invertebrate indicators (COTS, urchin) excluded from composite due to Nov 2024-only data
- All condition indices normalised 0-1 where 0 = degraded and 1 = reference condition

---

## 7. Data Quality and Limitations

| Issue | Impact | Mitigation |
|---|---|---|
| Three survey programmes with different column naming | QA/QC required per source; risk of mismatch | clean_fish_uvc() and clean_coral_cond() with any_of() and rename_with() |
| No invertebrate data from Jul 2025 (COMRED sheet empty) | Invertebrate condition only available for Nov 2024 | Note in outputs; flag as data gap |
| Transect area unconfirmed (250 m² assumed) | Biomass and density per-ha values scale with this assumption | Confirm with Dr. Karisa / Dr. Thoya / KMFRI; update TRANSECT_AREA_M2 |
| Jul 2025 surveys = post-bleaching event | Bleaching/mortality values not comparable to pre-bleaching baseline | Annotated in multiperiod output; interpret with caution |
| No invertebrate data from PU-GOAP or COMRED | CCVA invertebrate survey is the only source | Single programme invertebrate data; note in methods |
| KLF consolidated file contains template rows (2025-2092) | Date filter required to exclude empty placeholder rows | Filter !is.na(date) in clean_fish_uvc() |
| Sea urchin reference level provisional | LOW confidence; no formal WIO reference published | Flag confidence = "LOW" in SEEA table; note in publication methods |
| Dual-year benthic cover (COMRED CORAL-DATA) | 2024 vs 2025 rows in same file; requires year-based period assignment | Handled in benthic QA/QC via year -> survey_period mapping |
| No stereo-video BRUV validation | Fish size estimates from visual census have known bias | Report as Tier 2 accuracy; recommend BRUV calibration |
| Fish families without trophic lookup | Assigned "Unknown" trophic group | Review TROPHIC_LOOKUP in CONFIG; add missing families |

---

## 8. Implementation Checklist

- [ ] Confirm transect area with Dr. Karisa / Dr. Thoya / KMFRI; update TRANSECT_AREA_M2
- [ ] Create `fishbase_params_kenya.csv` in `Kenya/01_inputs/metadata/` for fish biomass calculation
- [ ] Verify CCVA duplicate longitude column (File 1); confirm both match before use
- [ ] Verify CCVA invertebrate positive latitude error (row 2) is correctly fixed
- [ ] Run `coral_reef_condition.R` end-to-end; check cat() log output for row counts at each step
- [ ] Review `seea_condition_summary_kenya.csv` — check condition index values against expected ranges
- [ ] Review `condition_by_pa.csv` — verify PA classification is correct for all sites
- [ ] Review `multiperiod_comparison.csv` — check cover/bleaching changes; confirm post-bleaching note is present
- [ ] Flag "Unknown" PA sites in `site_condition_all_indicators.csv` for manual assignment
- [ ] Update `Kenya/docs/accounts/cond_reef_coral_fish_invert_plan.md` status tracker
- [ ] Update `change_log.md`

---

## 9. Tiered Assessment

### Sub-procedure Tier Assessment

| Sub-procedure | Tier 1 | Tier 2 | Tier 3 | Current tier |
|---|---|---|---|---|
| Field survey design | Rapid survey, <10 sites, no size data | Replicated transects at 10-30 sites with size classes | >30 sites, stereo-BRUV, permanent transects | 2 (3 programmes, ~30 sites) |
| Biomass estimation | Literature average (no field data) | Allometric W=aL^b from visual size estimates | Stereo-BRUV validated with local L-W calibration | 2 (W=aL^b from FishBase) |
| Coral health data | Presence/absence only | Colony counts by health state per genus | Quantitative photoquadrats + independent checker | 2 (colony counts by health state) |
| Benthic cover | Rapid visual estimate | LIT/PIT transects (COMRED) + quadrat (PU-GOAP) | Permanent photoquadrats, machine-learning classification | 2 |
| Recruit monitoring | None | Quadrat counts per genus (1 m² quadrats) | Permanent recruitment tiles, species ID to lowest level | 2 |
| Reference level setting | Global average | Regional published benchmarks (WIO/Indian Ocean) | Locally derived historical baseline | 2 (WIO references; sea urchin provisional = Tier 1) |
| PA disaggregation | No PA data | Manual site-to-PA classification table | Spatial join to WDPA with verified boundaries | 1-2 (manual lookup table) |
| Temporal monitoring | Single snapshot per period | Two periods enabling change detection | Annual permanent monitoring stations | 2 (Nov 2024 + Jul 2025; caveat: post-bleaching) |

### Binding Constraints

The current assessment is **Tier 2** overall. Binding constraints are:

1. **Transect area unconfirmed** — TRANSECT_AREA_M2 = 250 m² assumed; all biomass and density values pending verification with field team. Update before publishing.

2. **No Jul 2025 invertebrate data** — invertebrate condition indicators (COTS, urchin) cannot be compared across periods; opening baseline only.

3. **Post-bleaching interpretation** — Jul 2025 closing values reflect reef status after the 2023-2024 global bleaching event. Change metrics require contextual framing; not a standard 12-month accounting period change.

4. **Sea urchin reference level (provisional)** — no formal WIO reference published; 1.75 ind/m² provisional; LOW confidence.

5. **Fish biomass (conditional)** — Steps 3-4 require `fishbase_params_kenya.csv`; until created, fish condition indicators are unavailable.

### Progression Pathway

To upgrade **transect area to confirmed**: email Dr. Karisa / Dr. Thoya / KMFRI with specific question about belt width used in CCVA Nov 2024 fish surveys.

To upgrade **invertebrate monitoring to multi-period**: include invertebrate belt transects in next COMRED survey; use same 25 m transect protocol as CCVA.

To upgrade **sea urchin reference to MEDIUM confidence**: consult Tim McClanahan (WCS Kenya) for unpublished long-term urchin density data from Watamu and Malindi MPAs; compare against Kenya-published values.

To upgrade **PA disaggregation from manual to spatial**: use WDPA shapefile for Kenya; spatial join site GPS coordinates to PA polygons using `sf` package; see `skill_extent_protected_areas_m13_reef.md` for spatial join workflow.

To upgrade **temporal monitoring to Tier 3**: resurvey fixed permanent transects annually at minimum 15 sites across PA categories; install permanent markers at high-priority sites inside Watamu MPA and community CPAs.

---

*Derived from: Kenya Coral Reef SEEA EA Condition Accounts — Kilifi County 2024-2025. Aligned with UN SEEA EA (2021) and GOAP technical guidance.*
*Analysis script: `Kenya/02_analysis/coral_reef_condition.R`*
*Reference companion: `Madagascar/docs/skills/skill_condition_biotic_fish_invert.md` — Madagascar M1.3 protocol for cross-pilot comparison.*
