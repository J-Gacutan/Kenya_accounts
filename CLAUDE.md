# CLAUDE.md — AFRICA - accounts

## Project Overview

Environmental accounting project for African coastal/marine ecosystems under the **UN SEEA EA** (System of Environmental-Economic Accounting — Ecosystem Accounting) framework. Currently includes two country pilots: **Madagascar coral reef (M1.3)** condition accounts (advanced) and **Kenya** (setup phase, ecosystem type TBD). Mozambique mangrove (M2.1) extent accounts have been migrated to a standalone repository at `../Mozambique_accounts/`.

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
│       ├── skills/                                # 8 standardised operating procedures (SOPs)
│       ├── rag/                                   # Retrieval-Augmented Generation systems
│       │   ├── academic/                          # Evidence-linking (18+ literature sources)
│       │   ├── policy/                            # Policy-commitment semantic linking
│       │   └── wdpa/                              # Protected area WDPA RAG pipeline
│       ├── accounts/                              # Account methodology & status
│       │   ├── cond_reef_fish_invert_plan.md      # Canonical status tracker
│       │   ├── data_flow_condition_to_services.md # Service valuation linkages
│       │   └── SEEA_EA_policy_integration_summary.md
│       ├── briefs/                                # Policy briefs
│       │   └── POLICY_BRIEF_Madagascar_CoralReef.md
│       └── templates/
│           └── template_seea_publication.md       # Madagascar-adapted publication template
│
└── Kenya/                             # [Ecosystem TBD] — Setup phase
    ├── 01_inputs/
    │   ├── raw_data/                              # Raw data files (TBD)
    │   └── metadata/                              # Data summaries (TBD)
    ├── 02_analysis/
    │   └── [analysis scripts TBD]
    ├── 03_outputs/
    │   └── [results TBD]
    └── docs/
        ├── skills/                                # SOPs (to be created)
        ├── rag/
        │   ├── academic/                          # Academic evidence linking (TBD)
        │   └── policy/                            # Policy-commitment linking (TBD)
        ├── accounts/                              # Account methodology (TBD)
        ├── briefs/                                # Policy briefs (TBD)
        └── templates/
            ├── template_seea_publication.md       # Shared template (adapted)
            ├── policy_rag_schema.md               # Shared template (adapted)
            └── POLICY_BRIEF_TEMPLATE.md           # Shared template (adapted)
```

## Key Conventions

- **Framework:** UN SEEA EA Ecosystem Condition Accounts
- **Ecosystem type:** Photic Coral Reefs (M1.3)
- **Accounting period:** 2025–2026
- **Analysis language:** R (readxl, dplyr, tidyr, stringr)
- **Methodology reference:** `skill_condition_biotic_fish_invert.md` in the Accounting bot repo
- **Never use icons** — all outputs should use plain text formatting only
- **Country codes in output files:** All output files (CSVs, tables, exports) must include the ISO 3166-1 alpha-3 country code in the filename: **KEN** (Kenya), **MDG** (Madagascar)
- **Publications vs. Policy Briefs:** Academic publications (SEEA EA standard format) include full academic citations to evidence sources; policy briefs do NOT include academic citations. Policy briefs are for decision-makers and should use plain language, data, and policy anchors without scholarly apparatus.
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

- **Transect area:** 250 m² (50 m x 5 m) — confirmed with field team
- **Fish biomass reference level:** RESOLVED — updated to 1,150 kg/ha (McClanahan et al. 2016 WIO conservation target); sustainability floor 600 kg/ha
- **COTS scaling sensitivity:** Very low counts scaled to per-ha may be misleading; updated outbreak threshold to 15 ind/ha (Dulvy et al. 2021)
- **Sea urchin reference level:** PROVISIONAL — 1.5–2 ind/m² (*Echinometra mathaei* outer reef, Kenya/WIO; LOW confidence); no formal WIO baseline published

## Working With This Project

### Cross-Pilot
- All shared templates, methodologies, and reference materials live in `_shared/`. See `_shared/README.md` for guidance on adapting templates for new pilots.
- Each country pilot has its own `docs/` folder with country-adapted versions of templates (e.g., `Madagascar/docs/template_seea_publication.md`)

### Madagascar-Specific
- Metadata files (`01_inputs/metadata/*.md`) are auto-generated summaries of raw Excel data — use these instead of re-reading Excel
- `docs/accounts/cond_reef_fish_invert_plan.md` is the canonical status tracker — update when analysis steps change
- `docs/skills/` contains 8 detailed SOPs covering condition, extent, and services accounts
- `docs/rag/` contains 3 RAG systems (academic, policy, WDPA) for evidence & policy linking
- The R script (`02_analysis/fish_invert_condition.R`) uses `rstudioapi` with `tryCatch` fallback to `getwd()` for portability
- Update `change_log.md` at the end of each session

### Mozambique (Migrated)

- Mozambique mangrove accounts have been migrated to standalone repo: `../Mozambique_accounts/`
