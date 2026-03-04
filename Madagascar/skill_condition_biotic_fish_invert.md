# Skill: Ecosystem Condition — Biotic Indicators: Fish & Invertebrate Communities

**Purpose:** Calculate fish and invertebrate community condition indicators for photic coral reef ecosystems (IUCN GET M1.3) from Underwater Visual Census (UVC) field survey data, and normalise to condition indices for the SEEA EA condition account.

**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Photic Coral Reefs (M1.3)
**Spatial scope:** Site-level (no satellite extrapolation — fish/invertebrate indicators lack spectral signal)
**Companion skill:** [skill_condition_biotic_coral.md](skill_condition_biotic_coral.md) — provides coral cover and bleaching indicators for the same ecosystem asset

---

## 1. Field Survey Data

| Source | Records | Key Fields |
|---|---|---|
| Fish UVC | 27 sites, 85 stations, 2 transects/station | Species (227 spp.), family (39), genus (100), functional group, secondary trophic group, length-weight parameters (a, b), size-class abundance bins (5–10, 10–20, 20–30, 30–40, 40–50, 50–60 cm) |
| Macroinvertebrate belt transect | 27 sites, ~81 stations, 2 transects/station | Species (59 spp.), abundance counts |
| Sea urchin quadrat | 27 sites, ~79 stations, 2 transects/station | Species (7 spp.), abundance counts |

### Size-Class Abundance Bins (Fish)

Columns `5_10`, `10_20`, `20_30`, `30_40`, `40_50`, `50_60` record the **count of individuals** observed in each total-length size class (cm). These counts, combined with the species-level length-weight parameters (`a`, `b`), allow biomass estimation via allometric conversion.

### Key Invertebrate Indicator Species

| Species | Ecological Role | Condition Relevance |
|---|---|---|
| *Acanthaster planci* (Crown-of-thorns starfish) | Corallivore | Outbreaks indicate reef degradation; density is an inverted condition indicator |
| *Tridacna maxima* (Giant clam) | Filter feeder, reef consolidation | Presence indicates healthy reef; abundance is a positive indicator |
| *Diadema setosum* | Herbivorous urchin (algal grazer) | Moderate density = healthy algal control; very high density = overgrazing |
| *Echinometra mathaei* | Bio-eroder | High density can indicate bioerosion pressure |

### Reference Data

| Type | Source | Use |
|---|---|---|
| Unfished reef fish biomass | MacNeil et al. (2015) *Nature* | Reference level for fish biomass (~500 kg/ha) |
| COTS outbreak threshold | AIMS Long-Term Monitoring Programme | Outbreak density >0.3 individuals per survey tow |
| IUCN Global Ecosystem Typology (GET) | IUCN | Ecosystem type classification code M1.3 |

---

## 2. Field Data QA/QC

```
Raw field sheets / tablets
    │
    ├── Validate GPS coordinates against accounting area boundary
    │   └── Fix missing decimal points (17 lat, 18 lon values with integer-scale errors)
    │
    ├── Standardise taxonomic names
    │   ├── Trim whitespace from genus/species fields
    │   ├── Fix family typos (e.g., "Pomacanthidae+" → "Pomacanthidae")
    │   └── Remove rows where Species = 0.0 or NA
    │
    ├── Harmonise functional groups (17 raw → 7 standard categories)
    │   ├── Carnivore / Carnivores / carnivore / carnivores / Carnivore 1er ordre / Carnivore 2nd ordre → Carnivore
    │   ├── Herbivore / herbivores → Herbivore
    │   ├── Corallivore / corallivores → Corallivore
    │   ├── Omnivore / omnivores → Omnivore
    │   ├── Planctonophage / planctonophages / Planktivore → Planktivore
    │   ├── Détritivores → Detritivore
    │   └── piscivores → Piscivore
    │
    ├── Harmonise secondary trophic groups (16 raw → ~10 standard)
    │   └── Fix casing: Omnivore / Omnivores / omnivore → Omnivore; Invertvore → Invertivore
    │
    ├── Fix invertebrate transect errors
    │   └── "onus rattus" in Transects column → likely "Conus rattus" misplaced from Species
    │
    ├── Evaluate sea urchin formula strings
    │   └── Parse and compute abundance formulas (e.g., "=(10*48)" → 480)
    │
    └── Calculate transect-level and site-level means ± SE
```

---

## 3. Indicator Calculation

### Fish Indicators

| Indicator | Grouping | Calculation | Unit | Direction |
|---|---|---|---|---|
| Fish biomass | Site × Functional group × Calendar year | W = a × L^b for each size-class midpoint; sum across size classes and species per transect; scale to per-hectare | kg/ha | Higher = better |
| Fish abundance | Site × Functional group × Calendar year | Total count of individuals across all size classes per transect; scale to per-hectare | individuals/ha | Higher = better |
| Fish species richness | Site × Calendar year | Count of unique species per site | count | Higher = better |
| Trophic integrity | Site × Calendar year | Proportion of biomass in each functional group (carnivore, herbivore, corallivore, planktivore, omnivore, detritivore, piscivore) | % | Balanced = better (qualitative) |

#### Biomass Calculation Detail

```
Size-class midpoints (cm): 7.5, 15, 25, 35, 45, 55

For each row (species × station × transect × calendar year):
    For each size class k:
        W_k = a × midpoint_k^b          (grams per individual)
        biomass_k = count_k × W_k        (grams)

    row_biomass = Σ biomass_k             (grams)

Transect biomass by functional group:
    transect_fg_biomass = Σ row_biomass   (grams, summed within functional group)
    transect_fg_biomass (kg/ha) = transect_fg_biomass / 1000 / transect_area_ha

Transect abundance by functional group:
    transect_fg_abundance = Σ individual counts across size classes (within functional group)
    transect_fg_abundance (individuals/ha) = transect_fg_abundance / transect_area_ha

Site-level aggregation (per functional group, per calendar year):
    site_fg_biomass_mean = mean(transect_fg_biomass[1..n])
    site_fg_biomass_var  = var(transect_fg_biomass[1..n])    (variance across transects)
    site_fg_abundance_mean = mean(transect_fg_abundance[1..n])
    site_fg_abundance_var  = var(transect_fg_abundance[1..n]) (variance across transects)
    n_transects = count of transects at site for that year
```

### Invertebrate Indicators

| Indicator | Calculation | Unit | Direction |
|---|---|---|---|
| COTS density | Count of *Acanthaster planci* per transect; scale to per-hectare or per-tow equivalent | individuals/ha | Higher = worse (invert) |
| Sea urchin density | Total count of all urchin species per transect; scale to per-m² | individuals/m² | Context-dependent |
| Giant clam abundance | Count of *Tridacna maxima* per transect | individuals/transect | Higher = better |
| Macroinvertebrate richness | Count of unique macroinvertebrate species per site | count | Higher = better |

### Site-Level Aggregation

All aggregation is performed **per site, per calendar year**. Fish biomass and abundance are further split by **functional group**.

```
──── Fish (per site × functional group × calendar year) ────

site_fg_biomass_mean     = mean(transect_fg_biomass[1..n])
site_fg_biomass_var      = var(transect_fg_biomass[1..n])
site_fg_abundance_mean   = mean(transect_fg_abundance[1..n])
site_fg_abundance_var    = var(transect_fg_abundance[1..n])
n_transects              = number of transects at site in that year

Site totals (all functional groups combined):
site_total_biomass_mean  = Σ site_fg_biomass_mean   (across functional groups)
site_total_abundance_mean = Σ site_fg_abundance_mean (across functional groups)

──── Fish richness (per site × calendar year) ────

site_fish_richness       = count(unique species across all transects at site in that year)

──── Invertebrates (per site × calendar year) ────

site_cots_density_mean   = mean(transect_cots_density[1..n])
site_cots_density_var    = var(transect_cots_density[1..n])
site_urchin_density_mean = mean(transect_urchin_density[1..n])
site_urchin_density_var  = var(transect_urchin_density[1..n])
site_clam_abundance_mean = mean(transect_clam_count[1..n])
site_clam_abundance_var  = var(transect_clam_count[1..n])
```

---

## 4. Spatial Extrapolation

**Not applicable for fish and invertebrate indicators.**

Fish and mobile invertebrate communities cannot be reliably predicted from satellite-derived spectral reflectance. Unlike coral cover or seagrass extent, there is no optical signal correlated with fish biomass at the spatial resolution of available imagery.

Condition indicators remain at the **site level** (27 sites). For the SEEA EA condition account, site-level values are aggregated to an **accounting-area mean** (area-weighted if site representativeness varies, or simple mean if sites are treated as a random sample of the reef asset).

For spatial context within the BSU framework, see [skill_condition_biotic_coral.md](skill_condition_biotic_coral.md) §4.

---

## 5. Normalisation to Condition Index

### Reference Levels

| Indicator | Reference Level | Source | Rationale |
|---|---|---|---|
| Fish biomass | 500 kg/ha | MacNeil et al. (2015) *Nature* | Median unfished reef biomass across Indo-Pacific sites; widely used benchmark |
| COTS density | 0 individuals/ha (ideal); outbreak = >30/ha | AIMS LTMP; Moran & De'ath (1992) | Healthy reefs have low COTS density; outbreaks cause mass coral mortality |
| Sea urchin density | Regional healthy-reef mean (TBD from data) | Literature review required | Moderate urchin density maintains algal control; very high = bioerosion |
| Fish species richness | Regional species pool estimate (TBD from data) | Site with highest richness as proxy | Proportion of regional pool present |

### Formulae

**Standard (higher = better):**
```
                    Measured Value
Condition Index = ─────────────────    (capped at 1.0)
                   Reference Level

Example: CI_fish_biomass = 150 kg/ha / 500 kg/ha = 0.30
```

**Inverted (higher = worse):**
```
                         Measured Value
Condition Index = 1  −  ─────────────────    (capped at [0, 1])
                         Maximum Value

Example: CI_COTS = 1 − (5/ha / 30/ha) = 0.83
         (low COTS = high condition)
```

---

## 6. Ecosystem Asset Representation

```
┌─────────────────────────────────────────────────────────────┐
│  ECOSYSTEM ASSET: Photic Coral Reefs (M1.3)                │
│  Fish & Invertebrate Community Condition                    │
│  Survey coverage: 27 sites across accounting area           │
│                                                             │
│  ┌───────────────────┬────────┬──────────┬────────────────┐ │
│  │ Condition         │ Ref.   │ Measured │ Condition      │ │
│  │ Indicator         │ Level  │ Value    │ Index (0–1)    │ │
│  ├───────────────────┼────────┼──────────┼────────────────┤ │
│  │ Fish biomass      │ 500    │ TBD      │ TBD            │ │
│  │                   │ kg/ha  │          │                │ │
│  │ Fish species      │ max    │ TBD      │ TBD            │ │
│  │ richness          │ obs.   │          │                │ │
│  │ COTS density      │ 0/ha   │ TBD      │ TBD (inv.)    │ │
│  │ Sea urchin        │ TBD    │ TBD      │ TBD            │ │
│  │ density           │        │          │                │ │
│  └───────────────────┴────────┴──────────┴────────────────┘ │
│                                                             │
│  Note: Values calculated by fish_invert_condition.R from    │
│  field survey data; populate this table with script output  │
└─────────────────────────────────────────────────────────────┘
```

---

## 7. Output: SEEA EA Condition Account Table (Fish & Invertebrate)

Output tables are produced **per calendar year** present in the survey data. Each year generates its own set of rows.

### 7a. Site × Functional Group Summary (per calendar year)

| Calendar Year | Site | Functional Group | Biomass Mean (kg/ha) | Biomass Var | Abundance Mean (ind/ha) | Abundance Var | n Transects |
|---|---|---|---|---|---|---|---|
| TBD | TBD | Carnivore | TBD | TBD | TBD | TBD | TBD |
| TBD | TBD | Herbivore | TBD | TBD | TBD | TBD | TBD |
| ... | ... | ... | ... | ... | ... | ... | ... |

### 7b. Condition Account Table (per calendar year)

| Calendar Year | Ecosystem Type | Condition Indicator | Reference Level | Measured Value | Condition Index (0–1) |
|---|---|---|---|---|---|
| TBD | Coral reef (M1.3) | Fish biomass (total) | 500 kg/ha | TBD | TBD |
| TBD | Coral reef (M1.3) | Fish species richness | max observed | TBD | TBD |
| TBD | Coral reef (M1.3) | COTS density | 0/ha (ideal) | TBD | TBD (inverted) |
| TBD | Coral reef (M1.3) | Sea urchin density | TBD | TBD | TBD |

*TBD values are populated by the R analysis script (`fish_invert_condition.R`). One set of rows per calendar year.*

---

## 8. Data Quality and Limitations

| Issue | Impact | Mitigation |
|---|---|---|
| GPS coordinate errors (17 lat, 18 lon values with missing decimal points) | Incorrect site locations | Automated decimal restoration in QA/QC; manual verification against known site locations |
| Inconsistent functional group naming (17 variants for ~7 groups) | Trophic analysis errors if not harmonised | Lookup table standardisation in QA/QC step |
| Only 2 transects per station | Limited within-station replication; higher SE | Report SE alongside means; note in uncertainty assessment |
| Single observer per dataset (fish: Laza; invertebrates: Maka) | Potential observer bias | Cannot be mitigated post-hoc; note as limitation |
| High null counts in invertebrate data (557–753 nulls per column) | Many rows are empty/padding | Filter to rows with non-null species and abundance before analysis |
| Sea urchin abundance stored as formula strings | Values not computed in spreadsheet | Parse and evaluate formulas in R during QA/QC |
| No stereo-video (BRUV) validation | Fish size estimates from visual census have known bias | Report as Tier 2 accuracy limitation; recommend BRUV calibration |
| Global reference level for fish biomass | May not reflect local baseline | Binding constraint on accuracy tier; recommend regional calibration |

---

## 9. Implementation Checklist

- [ ] **Ingest** fish and invertebrate Excel data into R
- [ ] **QA/QC** GPS, taxonomy, functional groups, formula strings, null rows
- [ ] **Calculate** fish biomass per species per transect using W = a × L^b
- [ ] **Aggregate** biomass and abundance by site × functional group × calendar year; compute transect-level variance
- [ ] **Calculate** invertebrate indicator values (COTS density, urchin density, clam abundance)
- [ ] **Derive** reference levels (500 kg/ha fish biomass; max observed richness; COTS outbreak threshold)
- [ ] **Normalise** measured values against reference levels to condition indices (0–1)
- [ ] **Compile** fish and invertebrate rows in SEEA EA condition account table
- [ ] **Export** site-level summary and condition account tables as CSV

---

## 10. Tiered Assessment

### Sub-procedure Tier Assessment

| Sub-procedure | Tier 1 | Tier 2 | Tier 3 | Current tier (A / B / C) |
|---|---|---|---|---|
| Field survey design (UVC) | Rapid survey, <10 sites, no size-class data | Replicated transects at 10–30 sites with size-class bins (this skill — 27 sites, 2 transects/station) | Permanent monitoring with >30 sites, stereo-video BRUVs, >3 transects/station | 2 / 2 / 2 |
| Biomass estimation method | Literature-based average biomass (no field data) | Allometric conversion from visual size estimates (this skill — W = aL^b) | Stereo-BRUV validated length estimates with species-specific L-W from local calibration | 2 / 1–2 / 2 |
| Reference level setting | Global average (500 kg/ha from MacNeil et al., this skill's current approach) | Regional published benchmarks from same biogeographic province | Locally established historical reference from long-term monitoring or paleoecological records | 1 / 1 / 1 |
| Invertebrate indicators | Presence/absence only | Abundance counts with outbreak thresholds (this skill — COTS, urchin density) | Quantitative biomass with validated density–impact relationships | 2 / 1–2 / 2 |
| Temporal monitoring | Single snapshot (this skill) | Biennial surveys at fixed sites | Annual permanent monitoring stations | 1 / 1 / 1 |

### Binding Constraint Analysis

The current fish and invertebrate condition assessment is **Tier 2 on A: Feasibility** (27 sites with replicated UVC and allometric biomass estimation) but **Tier 1 on B: Accuracy** for reference levels (global 500 kg/ha benchmark does not account for local species composition, reef geomorphology, or fishing pressure history). Temporal monitoring is also Tier 1 (single snapshot).

The **reference level sub-procedure (B=1) is the binding constraint** on accuracy. The global 500 kg/ha benchmark from MacNeil et al. (2015) applies broadly to unfished Indo-Pacific reefs but may overestimate or underestimate the appropriate reference for southwest Madagascar's reef systems, which have distinct biogeographic affinities (Western Indian Ocean province) and varying fishing pressure gradients.

### Progression Pathway

To reach **Tier 2 on B-accuracy**: derive regional fish biomass reference levels from Western Indian Ocean monitoring programmes (e.g., WCS Madagascar reef monitoring, CORDIO East Africa); validate visual size estimates against stereo-BRUV measurements at a subset of stations; establish COTS density thresholds calibrated to local coral mortality data.

To reach **Tier 3 on B-accuracy**: implement permanent transect resurveys at >30 stations annually; calibrate species-specific length-weight parameters from local specimens; establish locally derived unfished biomass baselines from fully protected marine reserves within the accounting area; validate invertebrate density–impact relationships through experimental or long-term monitoring data.

---

*Derived from: OASIS Madagascar Project — Coral Reef Fish and Invertebrate Community Assessment. Aligned with UN SEEA EA (2021) and GOAP technical guidance.*
*Companion to: [skill_condition_biotic_coral.md](skill_condition_biotic_coral.md) — coral cover, bleaching, and benthic indicators.*
