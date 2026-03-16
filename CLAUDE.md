# CLAUDE.md — AFRICA - accounts

## Project Overview

Environmental accounting project for African coastal/marine ecosystems under the **UN SEEA EA** (System of Environmental-Economic Accounting — Ecosystem Accounting) framework. Currently includes two country pilots: **Madagascar coral reef (M1.3)** condition accounts (advanced) and **Mozambique mangrove (M2.1)** extent accounts (early-stage).

## Repository Structure

```
AFRICA - accounts/
├── CLAUDE.md                          # This file
├── README.md                          # Project overview & how to get started
├── change_log.md                      # Session-level change history
│
├── _shared/                           # Shared resources across all pilots
│   ├── README.md                      # Guide to shared resources
│   ├── templates/
│   │   ├── POLICY_BRIEF_TEMPLATE.md   # Generic policy brief template
│   │   └── WDPA_WDOECM_Manual_1_6.pdf # Protected area reference manual
│   ├── literature/
│   │   ├── README.md                  # Regional case studies summary
│   │   └── *.pdf, *.txt               # Uganda, Rwanda, South Africa SEEA EA case studies
│   └── rag_schemas/
│       ├── template_seea_publication_GENERIC.md  # Generic publication skeleton
│       └── policy_rag_schema_GENERIC.md          # Generic policy-commitment linking schema
│
├── Madagascar/                        # Coral reef condition accounts (M1.3)
│   ├── 01_inputs/
│   │   ├── raw_data/
│   │   │   ├── Fishdata_OASIS_M.xlsx              # Fish UVC data (5,186 rows, 27 sites)
│   │   │   ├── Invertebrate_0ASIS_M.xlsx          # Invertebrate + sea urchin data
│   │   │   └── new_data_submission_form (1).xlsx  # Data submission template
│   │   └── metadata/
│   │       ├── *_metadata.md                      # Auto-generated data summaries
│   │       └── meta_site_*.csv                    # Site-level metadata tables
│   ├── 02_analysis/
│   │   └── fish_invert_condition.R                # QA/QC → biomass → condition indices → SEEA EA
│   ├── 03_outputs/
│   │   └── *.csv                                  # Condition accounts & site-level results
│   └── docs/
│       ├── skills/                                # 8 standardised operating procedures
│       ├── cond_reef_fish_invert_plan.md          # Canonical status tracker
│       ├── template_seea_publication.md           # Madagascar-adapted publication template
│       ├── policy_rag_schema.md                   # Madagascar-specific policy linking
│       ├── ACADEMIC_RAG_*.md                      # Academic evidence-linking system
│       └── [other methodology & policy docs]
│
└── Mozambique/                        # Mangrove extent accounts (M2.1)
    ├── 01_inputs/
    │   ├── raw_data/
    │   │   └── *.csv                              # Mangrove extent data (GMW 2020 + field surveys)
    │   └── metadata/
    │       └── *_metadata.md                      # Data summaries
    ├── 03_outputs/
    │   └── FINDINGS_OVERVIEW.md                   # Preliminary findings
    └── docs/
        ├── skills/
        │   └── skill_extent_mangrove_m13_mozambique.md  # Extent SOP
        ├── template_seea_publication.md           # Mozambique-adapted publication template
        ├── policy_rag_schema.md                   # Mozambique-specific policy linking
        └── POLICY_BRIEF_*.md                      # Policy brief outlines
```

## Key Conventions

- **Framework:** UN SEEA EA Ecosystem Condition Accounts
- **Ecosystem type:** Photic Coral Reefs (M1.3)
- **Accounting period:** 2025–2026
- **Analysis language:** R (readxl, dplyr, tidyr, stringr)
- **Methodology reference:** `skill_condition_biotic_fish_invert.md` in the Accounting bot repo
- **Never use icons** — all outputs should use plain text formatting only
- **Policy brief framing (Multi-country work):** When developing policy briefs for ecosystems with data from individual countries (e.g., Mozambique mangroves), consider framing at the **Western Indian Ocean regional level** in headline and opening sections, rather than identifying a specific country. This enables the brief to be shared across WIO states, positions local data within broader regional context, and reduces country-specific sensitivities. Country-specific details can appear in data sections; regional framing in situational context.

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

### Cross-Pilot
- All shared templates, methodologies, and reference materials live in `_shared/`. See `_shared/README.md` for guidance on adapting templates for new pilots.
- Each country pilot has its own `docs/` folder with country-adapted versions of templates (e.g., `Madagascar/docs/template_seea_publication.md` vs. `Mozambique/docs/template_seea_publication.md`)

### Madagascar-Specific
- Metadata files (`01_inputs/metadata/*.md`) are auto-generated summaries of raw Excel data — use these instead of re-reading Excel
- `docs/cond_reef_fish_invert_plan.md` is the canonical status tracker — update when analysis steps change
- `docs/skills/` contains 8 detailed SOPs covering condition, extent, and services accounts
- The R script (`02_analysis/fish_invert_condition.R`) uses `rstudioapi` with `tryCatch` fallback to `getwd()` for portability
- Update `change_log.md` at the end of each session

### Mozambique-Specific
- Extent accounting focus; condition & services frameworks are ready but analysis not yet started
- Structure mirrors Madagascar for consistency (`01_inputs/`, `02_analysis/`, `03_outputs/`, `docs/`)
- Skills documentation in `docs/skills/`
