# Plan: Coral Reef Fish & Invertebrate Condition Analysis — Madagascar

**Project:** AFRICA — accounts / Madagascar
**Framework:** UN SEEA EA Ecosystem Condition Accounts
**Ecosystem type:** Photic Coral Reefs (M1.3)
**Accounting period:** 2025–2026

---

## Status Overview

| Step | Status | Notes |
|------|--------|-------|
| 1. Data ingestion | DONE | Fish: 5,186 rows; Macroinvert: 442 rows; Urchins: 273 rows |
| 2. QA/QC | DONE | GPS fixes, taxonomy standardisation, formula evaluation |
| 3. Fish biomass calculation | DONE | W = a × L^b across 6 size classes; **review transect area assumption** |
| 4. Fish community metrics | DONE | Abundance, richness, trophic composition |
| 5. Invertebrate metrics | DONE | COTS density, urchin density, clam abundance |
| 6. Normalisation to CI (0–1) | DONE | Fish biomass, richness, COTS — **review reference levels** |
| 7. SEEA EA condition table | DONE | 3 indicator rows exported |
| 8. Review & validation | PENDING | See open questions below |

---

## Input Data

| File | Sheet | Raw Records | Records (post-QA/QC) | Key Fields | Observer(s) |
|------|-------|---------|---------|------------|------------|
| `Fishdata_OASIS_M.xlsx` | Fish_All data | 5,186 | 5,186 | 27 sites, 85 stations, 2 transects, 227 species, 39 families, a/b params, 6 size-class bins | Laza |
| `Invertebrate_0ASIS_M.xlsx` | Macroinvertebrates | 999 | 434 | 27 sites, 81 stations, 3 transects, 59 species, abundance counts | Maka |
| `Invertebrate_0ASIS_M.xlsx` | Sea urchin | 999 | 264 | 27 sites, 79 stations, 2 transects, 8 species, abundance counts | Laza, Maka |

---

## Data Collection Methodology

### Fish Data (Fishdata_OASIS_M.xlsx)

**Primary Collector:** Laza

**Collection Period:** 2025-11-11 to 2026-02-24 (76 unique survey dates)

**Survey Design:**
- **Sites:** 27 locations across South-West Madagascar coast
- **Stations:** 85 distinct survey stations nested within sites
- **Transects:** 2 transects per station (T1, T2)
- **Sampling Method:** Visual underwater census (UVC) of fish along transects
- **Depth Range:** 3.6–16.5 m

**Data Recorded:**
- Species identification (227 unique species, 39 families, 100 genera)
- Size classes: fish counted in 6 size bins (5–10 cm, 10–20 cm, 20–30 cm, 30–40 cm, 40–50 cm, 50–60 cm)
- Allometric parameters (*a*, *b*) for biomass estimation (124 unique *a* values, 55 unique *b* values)
- Functional group assignments (17 raw categories including Carnivore, Herbivore, Corallivore, Planktivore, Omnivore, etc.)

**Data Completeness:**
- 5,186 total data rows with minimal missing values
- Size-class data: sparse for larger fish (e.g., 50–60 cm class: only 1 unique value recorded across entire dataset)

### Invertebrate Data (Invertebrate_0ASIS_M.xlsx)

**Macroinvertebrates Sheet**

**Primary Collector:** Maka

**Collection Period:** 2025-11-11 to 2026-02-01 (47 unique survey dates)

**Survey Design:**
- **Sites:** 27 locations (same geographic coverage as fish)
- **Stations:** 81 distinct survey stations
- **Transects:** 3 transect types (T1, T2, onus rattus [likely data entry error])
- **Sampling Method:** Abundance counts of macroinvertebrates (likely benthic surveys)
- **Depth Range:** 3.6–16.5 m (matching fish surveys)

**Data Recorded:**
- 59 dominant species recorded (molluscs, echinoderms, crustaceans, holothurians, nudibranchs, etc.)
- Abundance values: counts in 19 discrete categories (0–21 individuals)
- 999 initial data rows; 434 rows post-QA/QC

**Sea Urchin Sheet**

**Collectors:** Laza and Maka (mixed)

**Collection Period:** 2025-11-11 to 2026-02-01 (47 unique survey dates)

**Survey Design:**
- **Sites:** 27 locations
- **Stations:** 79 distinct survey stations
- **Transects:** T1, T2
- **Data Recorded:** 8 sea urchin species (including Crown-of-Thorns, *Diadema setosum*, *Echinometra mathaei*, urchins recorded as abundance counts
- Abundance values include some formula strings (e.g., `=(10*48)`) stored as text
- 999 initial rows; 264 rows post-QA/QC
- 90 unique abundance values (range 0–166 individuals)

---

## QA/QC Applied

### Issues Identified & Corrected

**Geospatial data:**
- [x] GPS decimal-point restoration (Fish: 17 lat, 18 lon values; Macroinvert: 17 lat, 18 lon values; Sea urchin: 16 lat, 17 lon values)
  - Examples: `-2303851.0` → `-23.03851`, `4346926.0` → `43.46926`

**Taxonomic standardisation:**
- [x] Functional group harmonisation (Fish: 17 raw → 7 standard: Carnivore, Herbivore, Corallivore, Planktivore, Omnivore, Detritivore, Piscivore)
  - Fixed inconsistent casing and pluralization
- [x] Genus/species whitespace trimming (Fish: 2 entries with trailing spaces)
- [x] Family typo fixes (Fish: `Pomacanthidae+*` entries → `Pomacanthidae`)

**Invertebrate data quality:**
- [x] Macroinvertebrates: Removed transect typo (`"onus rattus"` → NA)
- [x] Macroinvertebrates: Removed rows with Species = 0.0 (1 row)
- [x] Sea urchin: Formula string evaluation (e.g., `=(10*48)` → 480; 36 formula strings corrected)
- [x] Sea urchin: Removed rows with Species = 0.0 (1 row)

**Row removals post-QA/QC:**
- Macroinvertebrates: 999 → 434 rows (565 rows with substantial missing data across Sites, Stations, Latitude, Longitude, Depth, Observer, Date)
- Sea urchin: 999 → 264 rows (728 rows with substantial missing data)

---

## Current Results (Accounting-Area Means)

### SEEA EA Condition Account

| Indicator | Reference Level | Measured Value | CI (0–1) |
|-----------|----------------|----------------|----------|
| Fish biomass | 500 kg/ha | 1,854 kg/ha | 1.00 |
| Fish species richness | 103 (max observed) | 56 species | 0.54 |
| COTS density | 0 ind/ha (ideal) | 7.4 ind/ha | 0.89 (inverted) |

### Trophic Composition (% biomass)

| Group | % |
|-------|---|
| Herbivore | 40.6 |
| Carnivore | 30.0 |
| Planktivore | 15.2 |
| Corallivore | 8.7 |
| Omnivore | 5.5 |
| Piscivore | <0.1 |
| Detritivore | <0.1 |

---

## Open Questions / Review Items

### 1. Transect area (HIGH PRIORITY)
- **Current assumption:** 20 m × 5 m = 100 m² (standard UVC belt)
- **Alternative:** 20 m × 20 m = 400 m² (as stated in coral skill for benthic quadrats)
- **Impact:** If 400 m², all biomass and density values divide by 4 (mean biomass → ~464 kg/ha, CI → 0.93)
- **Action needed:** Confirm with field team (Laza / Maka)

### 2. Fish biomass reference level
- **Current:** 500 kg/ha (MacNeil et al. 2015 — unfished reef, target species)
- **Issue:** UVC includes all species (damselfishes, blennies, etc.), inflating total biomass above the target-species-only benchmark
- **Options:**
  - (a) Filter to target/commercial families only before biomass calculation
  - (b) Use a higher total-reef-fish reference (~1,500–2,000 kg/ha)
  - (c) Keep as-is and note the comparison is conservative

### 3. COTS scaling sensitivity
- Only 3 of 27 sites had any COTS (1–2 individuals each)
- Scaling 1 individual from 200 m² to 1 ha = 50 ind/ha (exceeds 30/ha outbreak threshold)
- **Recommendation:** Report COTS as presence/absence or count per site rather than scaled density, given the small transect area

### 4. Sea urchin reference level
- Mean density: 1.83 ind/m² (range 0–15.6 ind/m² across sites)
- No standard reference level established — left as descriptive for now
- **Action needed:** Literature review for Western Indian Ocean urchin density benchmarks

---

## Output Files

| File | Description |
|------|-------------|
| `fish_invert_condition.R` | R analysis script (reads Excel, runs QA/QC, calculates indicators, exports CSVs) |
| `fish_invert_site_condition.csv` | Site-level condition summary (27 sites × fish + invertebrate indicators) |
| `fish_invert_seea_condition.csv` | SEEA EA condition account rows (3 indicators) |

### Methodology

| File | Location |
|------|----------|
| `skill_condition_biotic_fish_invert.md` | `/Users/z5238824/Documents/GitHub/Accounting bot/` |

---

## Tiered Assessment Summary

| Sub-procedure | Current Tier (A / B / C) | Binding? |
|---------------|--------------------------|----------|
| Field survey design (27 sites, 2 transects) | 2 / 2 / 2 | |
| Biomass estimation (visual + allometric) | 2 / 1–2 / 2 | |
| Reference level setting (global literature) | 1 / 1 / 1 | **YES — binding constraint** |
| Invertebrate indicators (abundance + threshold) | 2 / 1–2 / 2 | |
| Temporal monitoring (single snapshot) | 1 / 1 / 1 | **YES — binding constraint** |

**Overall accuracy limited to Tier 1–2 by global reference levels and single-snapshot temporal coverage.**

---

## Next Steps: Integration with Ecosystem Service Accounts

**Status:** Condition accounts complete; ready for service account integration.

**See:** [`data_flow_condition_to_services.md`](data_flow_condition_to_services.md) for detailed mapping of condition outputs to service inputs.

**Key Linkages:**
1. **Fisheries Nursery Service** — Uses fish biomass + functional groups directly (70% coverage)
2. **Wild Fish Provisioning** — Fish composition establishes baseline; requires external catch data
3. **Coral Reef Recreation** — Fish richness + biomass as tourism attractiveness proxies (40% coverage)
4. **Coastal Protection** — Reef condition informs structural health; requires external GIS morphology data

**Immediate Actions:**
- Acquire market price data from local fish markets (USD/kg by family)
- Request landings data from Madagascar MPRH (catch statistics)
- Obtain tourism data from resorts and dive centres (visitor count, expenditure)

*Last updated: 2026-03-04*
