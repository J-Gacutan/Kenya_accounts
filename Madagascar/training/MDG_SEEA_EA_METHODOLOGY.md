# Madagascar SEEA EA Ecosystem Accounting -- Full Methodology

**Project:** AFRICA -- accounts / Madagascar
**Framework:** UN System of Environmental-Economic Accounting -- Ecosystem Accounting (SEEA EA)
**Ecosystem type:** Photic Coral Reefs (IUCN GET M1.3)
**Geographic scope:** Southwest Madagascar barrier reef, Morombe to Ambohibola
**Accounting period:** 2025-2026
**Data providers:** OASIS-M programme (Laza, Maka); University of Toliara / IHSM (Yves Amoros Mitondrasoa)
**Analysis script:** Madagascar/02_analysis/fish_invert_condition.R

---

## Table of Contents

1. [Introduction and Framework](#1-introduction-and-framework)
2. [Study Area and Survey Design](#2-study-area-and-survey-design)
3. [Data Sources](#3-data-sources)
4. [Fish Biomass and Community Indicators](#4-fish-biomass-and-community-indicators)
5. [Invertebrate Indicators](#5-invertebrate-indicators)
6. [Normalisation and Reference Levels](#6-normalisation-and-reference-levels)
7. [SEEA EA Condition Account](#7-seea-ea-condition-account)
8. [Trophic Composition](#8-trophic-composition)
9. [Extent Account (Pending)](#9-extent-account-pending)
10. [Ecosystem Service Accounts](#10-ecosystem-service-accounts)
11. [QA/QC Pipeline](#11-qaqc-pipeline)
12. [Outputs and File Structure](#12-outputs-and-file-structure)
13. [Open Items and Limitations](#13-open-items-and-limitations)
14. [References](#14-references)

---

## 1. Introduction and Framework

### 1.1 Madagascar Pilot Scope

The Madagascar pilot produces SEEA EA ecosystem condition accounts for photic coral reefs (M1.3) along the SW Madagascar barrier reef system. It is the most advanced pilot in the AFRICA-accounts project, with complete fish and invertebrate condition accounts derived from 5,186 fish UVC records and 698 invertebrate/urchin records across 27 sites.

### 1.2 Account Types

| Account | Status | Data Source |
|---------|--------|-------------|
| Condition (fish + invertebrate) | COMPLETE (Steps 1-7) | OASIS-M field UVC surveys |
| Extent (satellite mapping) | IN PROGRESS | Sentinel-2 + field validation |
| Fisheries nursery service | PRELIMINARY | Fish biomass + LRR method |
| Wild fish provisioning service | PRELIMINARY | Catch estimates + resource rent |

### 1.3 Key Distinction from Other Pilots

Madagascar is the only pilot with:
- Multi-year fish UVC data (2025 opening + 2026 closing)
- Allometric biomass calculation from species-level size data (W = a x L^b)
- Trophic composition analysis (7 functional groups)
- Preliminary ecosystem service valuations (nursery ~$61K/yr; provisioning ~$88K/yr)

---

## 2. Study Area and Survey Design

### 2.1 Site Network

**27 sites** across the SW Madagascar barrier reef, from Morombe (north) to Ambohibola (south):

Ambitiky, Ambohibola, Ambola, Ambolafoty, Ambatomilo, Ampasindava, Andavadoaky, Anakao, Andravona, Ankaramifioky, Befasy, Beheloky, Belavenoky, Bevato, Fierenamasay, Fitsitika, Ifaty, Itampolo, Mangily, Maromena, Morombe, Nosy Satra, Ratafenjika, Retsela, Salary, Tanilahy, Tsandamba

**85 survey stations**, 2 transects per station = 170 transects total.

**Depth range:** 3.6-16.5 m.

### 2.2 Transect Design

| Parameter | Value | Status |
|-----------|-------|--------|
| Transect length | 50 m | Confirmed |
| Transect width | 5 m | Confirmed |
| Transect area | 250 m2 | Confirmed with field team |

**NOTE:** Transect dimensions confirmed as 50 m x 5 m = 250 m2 with field observers (Laza, Maka).

### 2.3 Survey Periods

| Period | Sites | Dates | Role |
|--------|-------|-------|------|
| 2025 | 15 sites | Nov 2025 - Jan 2026 | Opening values |
| 2026 | 12 sites | Jan - Feb 2026 | Closing values |

---

## 3. Data Sources

### 3.1 Fish Data (Fishdata_OASIS_M.xlsx)

- **Records:** 5,186 rows
- **Observer:** Laza
- **Species:** 227 unique species, 39 families, 100 genera
- **Size classes:** 6 bins (5-10, 10-20, 20-30, 30-40, 40-50, 50-60 cm)
- **Allometric parameters:** 124 unique a values, 55 unique b values (embedded in dataset)
- **Functional groups:** 17 raw variants harmonised to 7 standard categories

### 3.2 Macroinvertebrate Data (Invertebrate_0ASIS_M.xlsx, Sheet 1)

- **Records:** 999 raw, 434 post-QA/QC (565 rows with missing core fields removed)
- **Observer:** Maka
- **Species:** 59 unique species
- **Key indicators:** Crown-of-Thorns (Acanthaster planci), giant clam (Tridacna maxima)

### 3.3 Sea Urchin Data (Invertebrate_0ASIS_M.xlsx, Sheet 2)

- **Records:** 999 raw, 264 post-QA/QC (728 rows with missing core fields removed)
- **Observers:** Laza and Maka
- **Species:** 8 sea urchin species (Diadema setosum, Echinometra mathaei, etc.)
- **Data quality issue:** 36 formula strings evaluated (e.g., "=(10*48)" converted to 480)

---

## 4. Fish Biomass and Community Indicators

### 4.1 Biomass Calculation

```
For each fish observation:
    L = size class midpoint (cm)
        5-10 = 7.5, 10-20 = 15, 20-30 = 25, 30-40 = 35, 40-50 = 45, 50-60 = 55
    W = a x L^b  (grams per individual; a and b from FishBase/dataset)
    biomass_g = W x count

Per transect:
    biomass_kg_ha = (sum(biomass_g) / 1000) / (TRANSECT_AREA_M2 / 10000)

Per site (mean +/- SE across transects):
    mean_biomass_kg_ha = mean(transect biomass values)
    se_biomass = sd / sqrt(n_transects)
```

### 4.2 Community Metrics

| Indicator | Calculation | Unit |
|-----------|------------|------|
| Fish biomass | Allometric W = a x L^b, scaled to per-ha | kg/ha |
| Fish abundance | Count scaled to per-ha | individuals/ha |
| Species richness | Unique species per site per year | count |
| Trophic composition | % biomass per functional group | % |

### 4.3 Results

| Metric | 2025 (Opening) | 2026 (Closing) |
|--------|----------------|----------------|
| Mean biomass | 1,929 kg/ha | 1,775 kg/ha |
| Biomass range | 498-4,707 kg/ha | Variable |
| Mean species richness | 56 species | 56 species |
| Richness range | 27-94 species | 25-103 species |

---

## 5. Invertebrate Indicators

### 5.1 Crown-of-Thorns Starfish (COTS)

| Metric | 2025 | 2026 |
|--------|------|------|
| Sites with COTS | 3 of 27 | 0 of 12 |
| Mean density (accounting area) | 6.7 ind/ha | 0.0 ind/ha |
| Individual counts | 1-2 per site | None |

**Scaling sensitivity:** 1 COTS individual on a 250 m2 transect = 40 ind/ha when scaled up. This can be misleading. The mean arises from very few individuals on transects.

### 5.2 Sea Urchin Density

- **Mean density:** 1.83 ind/m2 (range 0-15.6 ind/m2)
- **Dominant species:** Echinometra mathaei, Diadema setosum
- **Status:** NOT YET INCLUDED in formal SEEA account; provisional reference level only (1.5-2 ind/m2, LOW confidence)

### 5.3 Giant Clam (Tridacna maxima)

- **Status:** Data available in macroinvertebrate dataset; not yet quantified as formal indicator
- **Provisional reference:** 122-141 ind/ha (Lakshadweep, Indian Ocean; Apte et al. 2010; LOW-MEDIUM confidence)
- **Context:** WIO populations >90% depleted; low counts expected

---

## 6. Normalisation and Reference Levels

### 6.1 Reference Levels

| Indicator | Reference level | Formula type | Confidence | Source |
|-----------|----------------|-------------|------------|--------|
| Fish biomass | 1,150 kg/ha (WIO conservation target) | Standard | HIGH | McClanahan et al. (2016) PLOS ONE |
| Fish species richness | Max observed (103 species) | Standard (relative) | MEDIUM | Dataset-internal |
| COTS density | 15 ind/ha (outbreak threshold) | Inverted | MEDIUM | Dulvy et al. (2021) Nature Communications |
| Sea urchin density | 1.75 ind/m2 optimum (provisional) | Optimum range | LOW | Kenya/WIO provisional |

### 6.2 Normalisation Formulae

**Standard (higher = better):**
```
CI = min(measured / reference, 1.0)
```

**Inverted (COTS; higher = worse):**
```
CI = max(1 - measured / threshold, 0.0)
```

**Optimum range (sea urchin; provisional):**
```
CI = max(1 - |measured - optimum| / optimum, 0.0)
```

---

## 7. SEEA EA Condition Account

### 7.1 Accounting-Area Summary

| Entry | Units | Coral Reef (M1.3) |
|-------|-------|-------------------|
| Fish biomass -- 2025 | index (0-1) | 1.00 |
| Fish biomass -- 2026 | index (0-1) | 1.00 |
| Fish richness -- 2025 | index (0-1) | 0.54 |
| Fish richness -- 2026 | index (0-1) | 0.54 |
| COTS density -- 2025 | index (0-1) | 0.55 |
| COTS density -- 2026 | index (0-1) | 1.00 |
| Composite -- 2025 | index (0-1) | 0.70 |
| Composite -- 2026 | index (0-1) | 0.85 |

**Interpretation:** Fish biomass exceeds the WIO conservation target at the accounting-area level (CI = 1.0). Species richness is moderate (CI ~0.54). COTS density is well below outbreak threshold in 2026 (CI = 1.0). Composite condition is moderate-to-good (0.70-0.85).

### 7.2 Site-Level Heterogeneity

Biomass ranges from 498 kg/ha (Ambatomilo; CI = 0.43) to 4,707 kg/ha (Ambitiky; CI = 1.0). This 9.4x variation across sites is masked by the accounting-area average. Site-level tables are essential for identifying degraded sites for targeted management.

---

## 8. Trophic Composition

| Functional Group | % Biomass (2025-2026 pooled) |
|------------------|------------------------------|
| Herbivore | 40.6 |
| Carnivore | 30.0 |
| Planktivore | 15.2 |
| Corallivore | 8.7 |
| Omnivore | 5.5 |

**Interpretation:** Herbivore dominance (41%) indicates strong algal grazing capacity -- a positive sign for reef resilience. Balanced trophic structure with carnivores at 30% suggests functional ecosystem complexity.

---

## 9. Extent Account (Pending)

**Method:** Sentinel-2 satellite imagery (10 m resolution) + Spectral Angle Mapper (SAM) classification.

**Provider:** Yves Amoros Mitondrasoa, University of Toliara / IHSM.

**Classes:** Coral (M1.3), sand/rubble, seagrass (if present).

**Status:** Classification in progress; baseline expected March 2026. Estimated ~12,085 ha reef extent (preliminary).

---

## 10. Ecosystem Service Accounts

### 10.1 Fisheries Nursery Service (Regulating)

- **Method:** Log Response Ratio (LRR); 31% enhancement for coral reefs
- **Annual enhanced production:** ~20,362 kg/yr
- **Market price:** ~$3/kg (URGENT: confirm via local market survey)
- **Annual economic value:** ~$61,087/yr (plus/minus 50% uncertainty)

### 10.2 Wild Fish Provisioning Service

- **Estimated annual catch:** ~115,700 kg/yr
- **Average unit price:** $2.50/kg ($1-8/kg by family)
- **Gross revenue:** ~$289,250/yr
- **Resource rent (net profit):** ~$87,563/yr (plus/minus 50% uncertainty)

Both service accounts are PRELIMINARY and require market price surveys, extent mapping, and landing site data to be finalised.

---

## 11. QA/QC Pipeline

```
1. INGEST: readxl::read_excel() + janitor::clean_names()
2. GPS FIXES: Restore missing decimal points (17 lat, 18 lon values)
   Valid range: lat -22 to -24, lon 43 to 44
3. TAXONOMY: str_to_sentence(species), str_to_title(family)
4. FUNCTIONAL GROUPS: 17 raw variants harmonised to 7 standard categories
   (Herbivore, Carnivore, Planktivore, Corallivore, Omnivore, Piscivore, Detritivore)
5. FORMULA EVALUATION: 36 sea urchin abundance strings (e.g., "=(10*48)")
   parsed and converted to numeric
6. NULL FILTERING: Macroinvertebrate 999 -> 434 rows; Urchin 999 -> 264 rows
   (rows with missing core fields removed)
7. SIZE CLASS PARSING: "5_10" -> midpoint 7.5 cm (6 bins)
8. BIOMASS: W = a x L^b per species per size class
9. AGGREGATION: Transect -> Site x Year x Functional Group
10. EXPORT: CSV files with MDG_ prefix to 03_outputs/
```

---

## 12. Outputs and File Structure

All in `Madagascar/03_outputs/` with MDG_ prefix:

| File | Content |
|------|---------|
| MDG_fish_invert_site_condition.csv | Site-level summary (27 sites; biomass, richness, COTS, urchin) |
| MDG_fish_invert_site_fg_condition.csv | Functional group breakdown by site and year |
| MDG_fish_invert_seea_condition.csv | Accounting-area SEEA EA condition table (3 indicators x 2 years) |
| MDG_fish_invert_seea_condition_per_site.csv | Per-site SEEA EA breakdown (81 rows) |
| MDG_fish_invert_condition_account_raw.csv | Raw metric values with opening/closing/change |
| MDG_fish_invert_condition_account_normalized.csv | Normalised CIs with interpretation |

### Analysis Script

`Madagascar/02_analysis/fish_invert_condition.R` (962 lines)

---

## 13. Open Items and Limitations

### 13.1 Critical

| Item | Impact |
|------|--------|
| Transect area | Confirmed: 250 m2 (50 m x 5 m) — resolved |
| CSVs still use 500 kg/ha reference | Re-run script with 1,150 kg/ha and re-export |
| Sentinel-2 extent mapping not complete | Per-ha service calculations blocked |
| Market price survey not done | Service valuations are estimates only |

### 13.2 Medium Priority

| Item | Impact |
|------|--------|
| Sea urchin reference level provisional | Urchin indicator excluded from formal account |
| No field validation of biomass estimates | No stereo-BRUV cross-check |
| PA stratification not yet implemented | Cannot compare protected vs. unprotected condition |
| Only 3 sites had COTS | COTS density driven by very few individuals |

---

## 14. References

Dulvy, N.K., et al. (2021). COTS outbreak threshold: 15 ind/ha. *Nature Communications*.

MacNeil, M.A., et al. (2015). Recovery potential of the world's coral reef fishes. *Nature*, 520, 341-344.

McClanahan, T.R., et al. (2016). Global baselines and benchmarks for fish biomass. *PLOS ONE*. WIO conservation target: 1,150 kg/ha.

Samoilys, M.A., et al. (2019). WIO reef fish richness range: 82-152 species per transect.

UN SEEA EA (2021). System of Environmental-Economic Accounting -- Ecosystem Accounting.

---

*Version: 1.0*
*Created: 2026-03-29*
*Companion documents: MDG_FACILITATOR_GUIDE.md, MDG_TRAINING_GUIDELINES.md*
