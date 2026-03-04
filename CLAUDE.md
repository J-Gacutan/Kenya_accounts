# CLAUDE.md — AFRICA - accounts

## Project Overview

Environmental accounting project for African coastal/marine ecosystems under the **UN SEEA EA** (System of Environmental-Economic Accounting — Ecosystem Accounting) framework. Currently focused on **Madagascar coral reef (M1.3)** condition accounts.

## Repository Structure

```
AFRICA - accounts/
├── CLAUDE.md                  # This file
├── change_log.md              # Session-level change history
├── README.md
└── Madagascar/
    ├── Fishdata_OASIS_M.xlsx              # Raw fish UVC data (5,186 rows, 27 sites)
    ├── Invertebrate_0ASIS_M.xlsx          # Raw invertebrate + sea urchin data
    ├── new_data_submission_form (1).xlsx   # Data submission template
    ├── Fishdata_OASIS_M_metadata.md       # Auto-generated metadata for fish data
    ├── Invertebrate_0ASIS_M_metadata.md   # Auto-generated metadata for invertebrate data
    ├── Provider_metadata.md               # Benthic habitat map metadata (Sentinel-2)
    ├── fish_invert_condition.R            # R analysis script (QA/QC → indicators → SEEA EA)
    ├── fish_invert_site_condition.csv     # Output: site-level condition (27 sites)
    ├── fish_invert_seea_condition.csv     # Output: SEEA EA condition account (3 indicators)
    └── cond_reef_fish_invert_plan.md      # Analysis plan, status tracker, open questions
```

## Key Conventions

- **Framework:** UN SEEA EA Ecosystem Condition Accounts
- **Ecosystem type:** Photic Coral Reefs (M1.3)
- **Accounting period:** 2025–2026
- **Analysis language:** R (readxl, dplyr, tidyr, stringr)
- **Methodology reference:** `skill_condition_biotic_fish_invert.md` in the Accounting bot repo

## Data Providers

- **Fish data observer:** Laza (27 sites, SW Madagascar, Nov 2025 – Feb 2026)
- **Invertebrate data observer:** Maka
- **Benthic habitat:** Yves Amoros Mitondrasoa (University of Toliara / IHSM)

## Analysis Pipeline

1. Data ingestion (Excel → R)
2. QA/QC (GPS fixes, taxonomy standardisation, formula evaluation)
3. Fish biomass calculation (W = a × L^b across 6 size classes)
4. Community metrics (abundance, richness, trophic composition)
5. Invertebrate indicators (COTS density, urchin density, clam abundance)
6. Normalisation to condition indices (0–1)
7. SEEA EA condition table export

## Open Review Items

- **Transect area assumption:** 100 m² (20×5) vs 400 m² (20×20) — confirm with field team
- **Fish biomass reference level:** 500 kg/ha (MacNeil et al. 2015) may underestimate for total reef fish
- **COTS scaling sensitivity:** Very low counts scaled to per-ha may be misleading
- **Sea urchin reference level:** No standard established; currently descriptive only

## Working With This Project

- Metadata files (`*_metadata.md`) are auto-generated summaries of the raw Excel data — use these instead of re-reading the Excel files when possible
- `cond_reef_fish_invert_plan.md` is the canonical status tracker — update it when analysis steps change
- The R script (`fish_invert_condition.R`) uses `rstudioapi` with a `tryCatch` fallback to `getwd()` for portability
- Update `change_log.md` at the end of each session
