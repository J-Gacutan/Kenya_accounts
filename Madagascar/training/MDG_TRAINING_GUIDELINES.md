# Madagascar SEEA EA Ecosystem Accounting -- Training Guidelines

**Purpose:** Practical training guide for researchers, statisticians, and practitioners building SEEA EA coral reef condition accounts from fish and invertebrate UVC survey data.

**Audience:** Marine ecologists, fisheries scientists, national statistics office staff, and conservation managers in Madagascar and the Western Indian Ocean region.

**Prerequisite knowledge:** Familiarity with reef fish surveys, basic spreadsheet skills, and introductory R programming for analysis modules.

---

## Training Structure

| Module | Duration | Focus |
|--------|----------|-------|
| 1. SEEA EA Foundations | 0.5 day | Framework, account types, ecosystem typology |
| 2. UVC Survey Data and QA/QC | 0.5 day | Data standards, GPS fixes, taxonomy, formula evaluation |
| 3. Fish Biomass Calculation | 1 day | Allometric relationships, size classes, per-ha scaling |
| 4. Community and Invertebrate Indicators | 0.5 day | Richness, trophic composition, COTS, urchins |
| 5. Normalisation and Reference Levels | 0.5 day | Standard, inverted, optimum range; confidence ratings |
| 6. SEEA EA Account Assembly | 0.5 day | Site-level tables, accounting-area aggregation, change detection |
| 7. Ecosystem Service Linkages | 0.5 day | Nursery (LRR), provisioning (resource rent), extent integration |
| 8. Policy Communication | 0.5 day | Policy briefs, regional framing, key messages |

**Total:** ~4.5 days

---

## Learning Objectives

1. Calculate fish biomass from UVC survey data using W = a x L^b
2. Derive invertebrate indicators (COTS density, urchin density) from field counts
3. Apply standard, inverted, and optimum-range normalisation formulas
4. Assemble multi-indicator SEEA EA condition account tables
5. Interpret site-level heterogeneity and trophic composition
6. Link condition accounts to ecosystem service valuations
7. Communicate results for policy audiences

---

## Practical Exercises

| Exercise | Module | Time | Skills |
|----------|--------|------|--------|
| QA/QC walkthrough: GPS fixes, species names | 2 | 30 min | Data validation |
| Manual biomass calculation for 5 fish | 3 | 30 min | Allometric formula |
| Site-level CI for 3 reef sites | 5 | 35 min | Normalisation |
| Accounting-area aggregation | 6 | 20 min | Averaging, cap effects |
| Trophic composition analysis | 4 | 15 min | Functional group interpretation |
| COTS scaling sensitivity | 5 | 15 min | Understanding transect area effects |
| Policy brief drafting | 8 | 30 min | Communication synthesis |

### Data Files

All in `Madagascar/03_outputs/`:
- MDG_fish_invert_site_condition.csv
- MDG_fish_invert_site_fg_condition.csv
- MDG_fish_invert_seea_condition.csv
- MDG_fish_invert_seea_condition_per_site.csv
- MDG_fish_invert_condition_account_raw.csv
- MDG_fish_invert_condition_account_normalized.csv

---

## Software Requirements

| Software | Purpose | Modules |
|----------|---------|---------|
| R 4.3+ with readxl, dplyr, tidyr, stringr, janitor | Analysis pipeline | 2-6 |
| RStudio 2023+ | IDE | 2-6 |
| Excel / LibreOffice | Data review, exercises | All |

---

## Key Messages for Madagascar

1. **Fish biomass exceeds the WIO conservation target** (1,929 kg/ha vs. 1,150 kg/ha reference) at the accounting-area level -- good news for reef health
2. **Enormous site-level variation** (498-4,707 kg/ha; 9.4x range) means some sites need urgent management attention
3. **COTS density is well below outbreak levels** -- no immediate threat to reef structure
4. **The transect area uncertainty must be resolved** before any values are published
5. **Trophic balance is healthy** -- 41% herbivores indicates strong algal grazing capacity

---

## Resources

| Resource | Location |
|----------|----------|
| Full methodology | Madagascar/docs/training/MDG_SEEA_EA_METHODOLOGY.md |
| Skills library (SOPs) | Madagascar/docs/skills/ |
| Account plan | Madagascar/docs/accounts/cond_reef_fish_invert_plan.md |
| R analysis script | Madagascar/02_analysis/fish_invert_condition.R |
| Academic evidence base | Madagascar/docs/rag/academic/ |
| Kenya pilot (comparison) | Kenya/docs/training/ |
| Mozambique pilot (comparison) | Mozambique/docs/training/ |

---

*Version: 1.0 | Created: 2026-03-29*
