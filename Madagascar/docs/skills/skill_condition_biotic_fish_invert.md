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
| Fish biomass — WIO conservation target | McClanahan et al. (2016) *PLOS ONE* | Reference level for fish biomass: 1,150 kg/ha (conservation target); 600 kg/ha (sustainability floor) |
| Fish biomass — WIO benchmark (closures) | McClanahan et al. (2020) *Aquatic Conservation* | High-compliance closure benchmark: ~910 kg/ha (95% CI 823–989); remote reefs: ~2,450 kg/ha |
| Fish biomass — unfished B0 (global) | MacNeil et al. (2015) *Nature* | Unfished baseline ~1,000 kg/ha Indo-Pacific (supplementary context; replaced as primary reference) |
| Fish species richness — WIO per-site range | Samoilys et al. (2019) *Ecology and Evolution* | 82–152 spp. per 50 m x 5 m transect across WIO (51 sites, 4 countries incl. Madagascar) |
| Fish species richness — SW Madagascar | Chabanet et al. (2005) *WIOJMS* / Blue Ventures | ~187 spp. per assemblage survey (Andavadoaka); contemporary fished baseline for SW Madagascar |
| COTS density — background level | Dulvy et al. (2021) *Nature Communications*; AIMS | Background / predator-controlled: <1 ind/ha; threshold for concern: 10–15 ind/ha; outbreak: >15–30 ind/ha |
| Sea urchin density — provisional WIO reference | Kenya studies (McClanahan 1987+; Scientific Reports 2024) | Outer reef *Echinometra mathaei*: ~1.5–2 ind/m² (Kenya/WIO); no formal WIO reference published (LOW confidence) |
| Clam abundance — Indian Ocean reference | Apte et al. (2010) *Marine Biodiversity Records* | *Tridacna maxima* at relatively undisturbed Lakshadweep reefs: 122–141 ind/ha (LOW-MEDIUM confidence; no SW Madagascar baseline) |
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

| Indicator | Reference Level | Source | Confidence | Rationale |
|---|---|---|---|---|
| Fish biomass | 1,150 kg/ha (primary); 600 kg/ha (sustainability floor) | McClanahan et al. (2016) *PLOS ONE* | HIGH | WIO-specific conservation target (15 countries); replaces 500 kg/ha global benchmark |
| Fish species richness | 82–152 spp. per site (WIO range) | Samoilys et al. (2019) *Ecol. Evol.* | MEDIUM | WIO per-site range from 51 sites incl. Madagascar; use midpoint ~117 spp. as reference if single value required |
| Trophic composition | Herbivore + invertivore ~56% of standing biomass; piscivore ~13% | Hicks et al. (2023) *Proc. R. Soc. B* | MEDIUM | Best available global reference; no WIO-specific empirical benchmarks published |
| COTS density | Background: <1 ind/ha (ideal); concern: 10–15 ind/ha; outbreak: >15–30 ind/ha | Dulvy et al. (2021) *Nat. Commun.*; AIMS | HIGH | Indo-Pacific consensus; background level predator-controlled; replaces single 30/ha threshold |
| Sea urchin density | Provisional: ~1.5–2 ind/m² outer reef (*Echinometra mathaei*) | Kenya/WIO studies (McClanahan 1987+) | LOW | No formal WIO reference condition published; provisional value from nearest regional analogue |
| Clam abundance | 122–141 ind/ha (*Tridacna maxima*) | Apte et al. (2010) *Marine Biodiversity Records* | LOW-MEDIUM | Indian Ocean reference (Lakshadweep); WIO populations severely depleted (>90% decline); no SW Madagascar baseline |

### Formulae

**Standard (higher = better):**
```
                    Measured Value
Condition Index = ─────────────────    (capped at 1.0)
                   Reference Level

Example: CI_fish_biomass = 690 kg/ha / 1,150 kg/ha = 0.60
         (using WIO conservation target of 1,150 kg/ha)
```

**Inverted (higher = worse, COTS):**
```
                         Measured Value
Condition Index = 1  −  ─────────────────    (capped at [0, 1])
                         Outbreak Threshold

Example: CI_COTS = 1 − (7.4/ha / 15/ha) = 0.51
         (7.4 ind/ha from Madagascar 2025-26; threshold 15 ind/ha)
         (low COTS = high condition)
```

**Note on COTS three-zone interpretation:**

- CI = 1.0 (background <1 ind/ha — predator-controlled)
- CI = 0.5–0.9 (elevated background 1–15 ind/ha — monitor closely)
- CI < 0.5 (near or at outbreak threshold — management intervention warranted)

---

## 6. Ecosystem Asset Representation

```
┌─────────────────────────────────────────────────────────────┐
│  ECOSYSTEM ASSET: Photic Coral Reefs (M1.3)                │
│  Fish & Invertebrate Community Condition                    │
│  Survey coverage: 27 sites across accounting area           │
│                                                             │
│  ┌───────────────────┬──────────────┬──────────┬────────────────┐ │
│  │ Condition         │ Ref. Level   │ Measured │ Condition      │ │
│  │ Indicator         │              │ Value    │ Index (0–1)    │ │
│  ├───────────────────┼──────────────┼──────────┼────────────────┤ │
│  │ Fish biomass      │ 1,150 kg/ha  │ TBD      │ TBD            │ │
│  │                   │ (WIO target) │          │                │ │
│  │ Fish species      │ 82–152 spp.  │ TBD      │ TBD            │ │
│  │ richness          │ (WIO range)  │          │                │ │
│  │ COTS density      │ <1 ind/ha    │ TBD      │ TBD (inv.)     │ │
│  │                   │ (bkg. level) │          │                │ │
│  │ Sea urchin        │ 1.5–2 ind/m² │ TBD      │ TBD            │ │
│  │ density           │ (provisional)│          │                │ │
│  │ Clam abundance    │ 122–141/ha   │ TBD      │ TBD            │ │
│  │ (Tridacna)        │ (Lakshadweep)│          │                │ │
│  └───────────────────┴──────────────┴──────────┴────────────────┘ │
│                                                             │
│  Note: Values calculated by fish_invert_condition.R from    │
│  field survey data; populate this table with script output  │
└─────────────────────────────────────────────────────────────┘
```

---

## 7. Output: SEEA EA Condition Account Tables (Fish & Invertebrate)

Output tables are produced in two forms:
1. **Raw Values Table**: Measured indicator values (biomass in kg/ha, counts in individuals/ha, species counts)
2. **Normalized Values Table**: Condition indices (0–1 scale) derived from raw values against reference levels

Each table presents opening (Year 1, earliest survey) and closing (Year 2, latest survey) values **per site**, with calculated change metrics.

### 7a. Site × Functional Group Summary (per calendar year)

| Calendar Year | Site | Functional Group | Biomass Mean (kg/ha) | Biomass Var | Abundance Mean (ind/ha) | Abundance Var | n Transects |
|---|---|---|---|---|---|---|---|
| TBD | TBD | Carnivore | TBD | TBD | TBD | TBD | TBD |
| TBD | TBD | Herbivore | TBD | TBD | TBD | TBD | TBD |
| ... | ... | ... | ... | ... | ... | ... | ... |

### 7b. Condition Account Table — Raw Values (Opening × Closing per Site)

| Site | Variable | Opening Year | Opening Value | Closing Year | Closing Value | Absolute Change | % Change | Unit |
|---|---|---|---|---|---|---|---|---|
| TBD | Fish biomass (total) | TBD | TBD | TBD | TBD | TBD | TBD | kg/ha |
| TBD | Fish abundance (total) | TBD | TBD | TBD | TBD | TBD | TBD | ind/ha |
| TBD | Fish species richness | TBD | TBD | TBD | TBD | TBD | TBD | count |
| TBD | COTS density | TBD | TBD | TBD | TBD | TBD | TBD | ind/ha |
| TBD | Sea urchin density | TBD | TBD | TBD | TBD | TBD | TBD | ind/m² |
| TBD | Macroinvertebrate richness | TBD | TBD | TBD | TBD | TBD | TBD | count |

### 7c. Condition Account Table — Normalized Values (Opening × Closing per Site)

| Site | Indicator | Opening Year | Condition Index (Opening) | Closing Year | Condition Index (Closing) | Change in CI | Interpretation |
|---|---|---|---|---|---|---|---|
| TBD | Fish biomass | TBD | TBD | TBD | TBD | TBD | improving/stable/declining |
| TBD | Fish species richness | TBD | TBD | TBD | TBD | TBD | improving/stable/declining |
| TBD | COTS density (inverted) | TBD | TBD | TBD | TBD | TBD | improving/stable/declining |
| ... | ... | ... | ... | ... | ... | ... | ... |

*TBD values are populated by the R analysis script (`fish_invert_condition.R`). One row per site per variable.*

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
| Fish biomass reference level (WIO, McClanahan 2016) | Better than global 500 kg/ha benchmark; still not Madagascar-specific | Reference upgraded to WIO conservation target (1,150 kg/ha); recommend further validation against SW Madagascar monitoring data |
| Sea urchin reference level (provisional) | No formal WIO reference published; provisional value from Kenya studies | Report as LOW confidence; flag in publication methods; consult GCRMN East Africa for unpublished long-term data |
| Clam abundance reference level | Lakshadweep reference (Indian Ocean); no SW Madagascar baseline | WIO populations >90% depleted; Lakshadweep reference may overestimate healthy state; report as LOW-MEDIUM confidence |

---

## 9. Implementation Checklist

- [ ] **Ingest** fish and invertebrate Excel data into R
- [ ] **QA/QC** GPS, taxonomy, functional groups, formula strings, null rows
- [ ] **Calculate** fish biomass per species per transect using W = a × L^b
- [ ] **Aggregate** biomass and abundance by site × functional group × calendar year; compute transect-level variance
- [ ] **Calculate** invertebrate indicator values (COTS density, urchin density, clam abundance)
- [ ] **Derive** reference levels (1,150 kg/ha WIO fish biomass target; 82–152 spp. WIO richness range; COTS background <1 ind/ha / outbreak >15 ind/ha; sea urchin provisional 1.5–2 ind/m²; clam 122–141 ind/ha)
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
| Reference level setting | Global average (e.g., MacNeil et al. 2015 500 kg/ha) | Regional published benchmarks from same biogeographic province (this skill's current approach — McClanahan 2016 WIO; Samoilys 2019 WIO richness) | Locally established historical reference from long-term monitoring or paleoecological records | 2 / 2 / 1 |
| Invertebrate indicators | Presence/absence only | Abundance counts with outbreak thresholds (this skill — COTS, urchin density) | Quantitative biomass with validated density–impact relationships | 2 / 1–2 / 2 |
| Temporal monitoring | Single snapshot (this skill) | Biennial surveys at fixed sites | Annual permanent monitoring stations | 1 / 1 / 1 |

### Binding Constraint Analysis

The current fish and invertebrate condition assessment is **Tier 2 on A: Feasibility** (27 sites with replicated UVC and allometric biomass estimation) and **Tier 2 on B: Accuracy** for reference levels (WIO-specific conservation targets from McClanahan et al. 2016, 2020 and Samoilys et al. 2019 now replace the global 500 kg/ha benchmark). Temporal monitoring remains Tier 1 (single snapshot). Sea urchin and clam reference levels are provisional (LOW confidence) and remain a binding constraint on indicator reliability for those two indicators.

The **binding constraint** has shifted from fish biomass reference levels (now Tier 2) to **(1) temporal monitoring** (single-snapshot, Tier 1 for all indicators) and **(2) sea urchin and clam reference levels** (no formal WIO baseline; provisional values only).

### Progression Pathway

To reach **Tier 2 on B-accuracy for sea urchin and clam**: consult GCRMN East Africa (Tim McClanahan, WCS) for unpublished long-term urchin density data; contact MPRH Madagascar and IHSM (University of Toliara) for historical Tridacna records; validate provisional Kenya-derived urchin reference against local SW Madagascar reef zone data.

To reach **Tier 2 on C: Temporal monitoring**: resurvey fixed transects at a minimum subset of sites (10–15) within 18–24 months; use permanent markers at high-priority sites (e.g., inside MPAs and at key OASIS reference sites).

To reach **Tier 3**: implement permanent transect resurveys at >30 stations annually; calibrate species-specific length-weight parameters from local specimens; establish locally derived unfished biomass baselines from fully protected marine reserves within the accounting area; validate invertebrate density–impact relationships through experimental or long-term monitoring data.

---

*Derived from: OASIS Madagascar Project — Coral Reef Fish and Invertebrate Community Assessment. Aligned with UN SEEA EA (2021) and GOAP technical guidance.*
*Companion to: [skill_condition_biotic_coral.md](skill_condition_biotic_coral.md) — coral cover, bleaching, and benthic indicators.*
