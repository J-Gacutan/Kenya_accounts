# Standard Operating Procedures: Measuring Ecosystem Condition
## Madagascar Coral Reef (M1.3) — Customized for 2025–2026 Accounts

**Framework:** SEEA EA Ecosystem Condition Accounts
**Ecosystem Type:** Photic Coral Reefs (M1.3)
**Geographic Scope:** Southwest Madagascar (27 sites, 85 stations)
**Accounting Period:** 2025–2026
**Lead Observer:** Laza
**Data Provider (Benthic habitat):** Yves Amoros Mitondrasoa (University of Toliara / IHSM)

---

## 1. Overview

This SOP describes the measurement and assessment of ecosystem condition for photic coral reefs (IUCN GET M1.3) in southwest Madagascar. The condition account synthesises:

1. **Fish and invertebrate community indicators** (field UVC surveys)
2. **Benthic coral and habitat indicators** (satellite-derived habitat mapping)
3. **Normalised condition indices** (0–1 scale, where 1 = reference condition)

### Ecosystem Type Definition

| Property | Value |
|----------|-------|
| IUCN GET Code | M1.3 (Photic coral reefs) |
| Accounting extent | ~27 surveyed sites within SW Madagascar coastal zone |
| Depth range | 3–16 m (as measured in field data: 3.6–16.5 m) |
| Dominant coral genera | Porites, Acropora, Pocillopora (inferred from regional context) |
| Reference condition | Regional benchmarks: ~40% live hard coral cover; unfished reef fish biomass ~500 kg/ha |

---

## 2. Spatial Framework

### 2.1 Survey Design — Fish & Invertebrate Indicators

| Component | Specification |
|-----------|----------------|
| **Number of sites** | 27 sites across SW Madagascar |
| **Site names** | AMBATOMILO, AMBITIKY, AMBOHIBOLA, ... TSANDAMBA (see metadata) |
| **Transects per station** | 2 transects (T1, T2) |
| **Total stations** | 85 stations (implies ~3 stations/site on average) |
| **Transect dimensions** | 20 m × 5 m (100 m² area) — *[CONFIRM with field team: spec says 20×5 vs. 20×20]* |
| **Depth range** | 3.6–16.5 m as observed in 2025–2026 surveys |
| **Survey date range** | 2025-11-11 to 2026-02-24 (Nov–Feb field campaign) |

### 2.2 Site-Level Spatial Units

All condition indicators are reported **at site level** (27 sites) to reflect the spatial resolution of the field campaign. No satellite-based spatial extrapolation is attempted for fish/invertebrate indicators (which lack spectral signature).

---

## 3. Fish & Invertebrate Community Condition

### 3.1 Indicators Measured

#### Fish Community (Underwater Visual Census)

| Indicator | Unit | Reference Level | Expected Value (2025) | Notes |
|-----------|------|-----------------|----------------------|-------|
| **Total biomass** | kg/ha | 500 (MacNeil et al. 2015) | ~1,929 | Measured from 5,186 records across 227 species |
| **Species richness** | count | 103 (regional reference) | 55 (mean per site) | Range: 32–68 species per site |
| **Abundance** | ind/ha | — | ~3,500–5,000 (estimated) | Derived from 6 size-class counts |
| **Trophic composition** | % biomass | — | Herbivore 40.6%, Carnivore 30%, Planktivore 15.2% | 7 functional groups recorded |
| **Functional group diversity** | count | 7 (target) | 7 groups present | All key trophic roles represented |

**Functional Groups Standardised (as per QA/QC in skill_condition_biotic_fish_invert.md):**
- Herbivore (algal grazers: Acanthuridae, Scaridae, etc.)
- Carnivore (piscivores + zoobenthivores)
- Planktivore (zooplanktophages)
- Corallivore (obligate coral feeders)
- Omnivore (mixed diet)
- Piscivore (fish eaters)
- Detritivore (detritus feeders)

#### Invertebrate Community (Belt Transects + Quadrats)

| Indicator | Unit | Measured Value (Mean 2025) | Condition Interpretation |
|-----------|------|---------------------------|--------------------------|
| **Crown-of-thorns (COTS) density** | ind/ha | 6.7 (low) | Inverted CI: 0.82 (healthy; <0.3 outbreak threshold) |
| **Sea urchin density** | ind/m² | 1.83 | Descriptive; range 0–15.6 across sites |
| **Macroinvertebrate richness** | species count | ~15–20 (59 species pool) | Indicates ecosystem complexity |
| **Giant clam (Tridacna) presence** | presence/absence | Low (descriptive) | Not yet quantified as formal indicator |

---

## 4. Data Collection Methods

### 4.1 Fish Community Survey

**Method:** Underwater Visual Census (UVC) using belt transects

**Protocol:**
1. Deploy transect line marked at 20 m; observer swims along centerline (2.5 m on each side = 5 m width)
2. Record all fish observed within transect, identified to species level
3. Estimate total length (TL) in cm for each individual using size-class bins:
   - 5–10 cm, 10–20 cm, 20–30 cm, 30–40 cm, 40–50 cm, 50–60 cm
4. Record functional group (herbivore, carnivore, planktivore, etc.)
5. Record depth (m) and time at each transect

**Data Fields (from Fishdata_OASIS_M.xlsx):**
- Site, Station, Latitude, Longitude, Date, Observer (Laza)
- Transect (T1 or T2)
- Family (39 families recorded), Genus, Species (227 spp.)
- Functional Group, Secondary Group
- Length-weight parameters: a, b (for biomass calculation: W = a × L^b)
- Size-class counts: 5_10, 10_20, 20_30, 30_40, 40_50, 50_60

**Effort:**
- 5,186 records (individual fish observations)
- 2 transects per station × 85 stations = 170 transects total
- 100 m² area per transect (2.5 m × 2 transects × 20 m = 100 m²)
- Total surveyed area: 17,000 m² (1.7 ha) over Nov 2025–Feb 2026

### 4.2 Invertebrate Survey

**Method:** Belt transects (same spatial footprint as fish) + fixed-area quadrats

**COTS (Crown-of-thorns Starfish):**
- Counted during 20 m × 5 m belt transect (same as fish transect)
- Inverted indicator: lower density = better condition
- Outbreak threshold: >0.3 individuals per 100 m² transect

**Sea Urchins:**
- Counted in belt transect
- Key species: *Diadema setosum*, *Echinometra mathaei*
- Density expressed as ind/m²

**Giant Clams (Tridacna spp.):**
- Presence/absence recorded; abundance not quantified in current dataset
- Positive indicator of reef health

**Macroinvertebrates (59 species pool):**
- Belt transect counts
- Richness = number of distinct species per site

---

## 5. Fish Biomass Calculation

### 5.1 Allometric Conversion

Fish biomass (g) is estimated from total length (TL, cm) using the allometric equation:

$$W = a \times L^b$$

where:
- **W** = weight (grams)
- **L** = total length (cm)
- **a**, **b** = species-specific parameters from literature or FishBase

**Data quality:**
- 124 unique *a* values (range: 0.00034–0.138)
- 55 unique *b* values (range: 0.00387–3.554)
- Some species have missing *a* or *b*; use family-level or genus-level defaults

### 5.2 Biomass Per Site

1. For each fish in each size class, calculate individual weight: $W_i = a \times \text{mid\_length}^b$
   - Use midpoint of size-class bin (e.g., 7.5 cm for 5–10 cm class)
2. Multiply by count in that size class
3. Sum by species, then by functional group, then by site
4. Normalise to per-hectare (kg/ha):
   $$\text{Biomass (kg/ha)} = \frac{\text{Total biomass (kg)}}{\text{Transect area (m²)}} \times 10,000$$
   - Example: If total biomass in 1.7 ha surveyed = 3,279 kg → 1,929 kg/ha (2025 mean)

---

## 6. Reference Levels & Condition Indices

### 6.1 Fish Biomass Reference Level

**Reference (unfished reef fish biomass):** 500 kg/ha (MacNeil et al. 2015, *Nature*)

**Caveat:** This reference may underestimate total reef fish biomass for Madagascar reefs; confirmation with regional literature recommended.

**Condition Index (CI) — Fish Biomass:**
$$CI_{\text{biomass}} = \min\left(\frac{\text{Measured biomass}}{500}, 1.0\right)$$

- 2025 mean: 1,929 / 500 = 3.86 → **capped at 1.0** (indicates very healthy fish biomass relative to reference)
- Interpretation: Reef is above reference condition; suggests either high productivity or low fishing pressure

### 6.2 COTS (Inverted) Reference Level

**Outbreak threshold:** >0.3 ind/100 m² (AIMS Long-Term Monitoring Programme)

**Condition Index (CI) — COTS Density (inverted):**
$$CI_{\text{COTS}} = 1 - \frac{\text{COTS density (ind/ha)}}{\text{Outbreak threshold (ind/ha)}}$$

Clipped to [0, 1]:
$$CI_{\text{COTS}} = \max\left(0, 1 - \frac{\text{COTS}}{3,000}\right)$$

- 2025 mean: 6.7 ind/ha → CI = 1 − (6.7/3,000) = **0.98** (healthy; far below outbreak)

### 6.3 Species Richness Reference Level

**Regional reference:** 103 species (Indo-Pacific coral reef regional pool)

**Condition Index (CI) — Richness:**
$$CI_{\text{richness}} = \frac{\text{Measured richness}}{103}$$

- 2025 mean: 55 / 103 = **0.53** (moderate; indicates some species losses from reference condition)

---

## 7. SEEA EA Condition Account Compilation

**Output table format:** `fish_invert_seea_condition.csv`

| Ecosystem Asset | Indicator | 2025 Value | Unit | Condition Index |
|---|---|---|---|---|
| Photic Coral Reef (M1.3) | Fish biomass | 1,929 | kg/ha | 1.0 (capped) |
| Photic Coral Reef (M1.3) | Species richness | 55 | count (mean/site) | 0.53 |
| Photic Coral Reef (M1.3) | COTS density | 6.7 | ind/ha | 0.98 (inverted) |

**Composite condition index (unweighted mean):**
$$CI_{\text{composite}} = \frac{1.0 + 0.53 + 0.98}{3} = 0.84$$

---

## 8. Temporal Accounting

| Component | Value |
|-----------|-------|
| **Opening year** | 2025 |
| **Closing year** | 2026 |
| **Accounting period** | Single 12-month period (Nov 2025–Feb 2026) |
| **Accounting scope** | Opening condition statement (baseline 2025) → closing condition statement (end 2026) — *trend assessment pending 2026 data* |

---

## 9. Data Quality & Limitations

### Known Data Quality Issues (from metadata):

1. **GPS coordinates:** 17 latitude and 18 longitude values missing decimal points
   - **Fix:** Examine coordinates visually; correct values that fall outside realistic range (e.g., -28.83 vs. -2883450.0)

2. **Functional groups:** Inconsistent casing/pluralisation
   - **Fix:** See QA/QC harmonisation in skill_condition_biotic_fish_invert.md (7 standard categories)

3. **Genus fields:** 2 values with trailing whitespace ('Abudefduf ', 'Acanthurus ')
   - **Fix:** Trim whitespace during data cleaning

4. **Family field:** Suspect entries ('Pomacanthidae+', 'Pomacanthidae+H128:M128')
   - **Fix:** Standardise to valid family names; review original data entry

5. **Transect area assumption:** Currently 100 m² (20 m × 5 m)
   - **Confirm with field team:** Is this correct, or should it be 20 m × 20 m = 400 m²? This affects all biomass per-hectare calculations.

### Confidence Assessment:

| Indicator | Confidence | Notes |
|-----------|-----------|-------|
| **Fish biomass** | Moderate–High | 5,186 records, 227 species; GPS and taxonomic fixes needed; reference level may underestimate for Madagascar |
| **Species richness** | Moderate | 227 species recorded; completeness depends on observer skill and survey effort balance |
| **COTS density** | Low | Only 6.7 ind/ha mean; low sample size for rare events; outbreak threshold may not apply to Madagascar reefs |
| **Sea urchin density** | Low | High variability (0–15.6 ind/m²); no reference level established for Madagascar; descriptive only |

---

## 10. Integration with Related Skills

| Related Skill | Link | Purpose |
|---|---|---|
| **skill_condition_biotic_fish_invert.md** | [Local](skill_condition_biotic_fish_invert.md) | Detailed QA/QC, indicator calculation, R code |
| **skill_extent_measurement_m13_reef.md** | [Local](skill_extent_measurement_m13_reef.md) | Benthic habitat mapping; ecosystem extent account |
| **skill_services_regulating_nursery_m13.md** | [Local](skill_services_regulating_nursery_m13.md) | Fisheries nursery service valuation using fish biomass + LRR |

---

## 11. References

1. MacNeil, M. A., et al. (2015). Recovery potential of the world's coral reef fishes. *Nature*, 520(7547), 341–344. https://doi.org/10.1038/nature14358
2. IUCN Global Ecosystem Typology. (2022). Photic coral reefs (M1.3). https://www.iucnget.org/
3. UN SEEA EA. (2021). System of Environmental-Economic Accounting — Ecosystem Accounting. https://seea.un.org/
4. Rahayu, S., et al. (2024). Marine Basic Spatial Units for SEEA EA. *Journal of Coastal Conservation*, [volume], [pages].

---

**Last updated:** 2026-03-04
**Customised by:** Claude Code for AFRICA–Madagascar project
**Data provider:** Laza (fish/invertebrate observer), Yves Amoros Mitondrasoa (benthic habitat)
