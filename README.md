# AFRICA — Ecosystem Accounting for African Coastal & Marine Ecosystems

Environmental accounting project for African coastal and marine ecosystems under the **UN SEEA EA** (System of Environmental-Economic Accounting — Ecosystem Accounting) framework.

This repository documents ecosystem condition, extent, and service valuations for multiple African pilots, with a focus on building nationally-owned environmental-economic accounts that feed policy decisions.

---

## Project Overview

### Scope
- **Framework:** UN SEEA EA Ecosystem Accounting (UN 2021, UNEP 2023)
- **Ecosystems:** Coastal and marine (coral reefs, mangroves, seagrass beds, kelp forests)
- **Accounts:** Ecosystem condition (biotic structure, water quality), extent (spatial footprint), and ecosystem services (provisioning, regulating, cultural)
- **Policy integration:** Links accounts to national marine spatial planning, fisheries policy, climate commitments, and SDG targets

### Current Pilots

#### 🇲🇬 **Madagascar** — Coral Reef Condition & Services (Advanced)
- **Ecosystem:** Photic coral reefs (M1.3), Southwest Madagascar coast
- **Status:** Full SEEA EA pipeline (condition ✅ + extent ⚠️ in progress + services 🔄 valuation framework ready)
- **Data:** 27 UVC sites, 5,186 fish/invertebrate records (Nov 2025–Feb 2026)
- **Outputs:** Condition indices, site-level condition accounts, preliminary service valuations (~$60–90K/yr)
- **Location:** [`Madagascar/`](Madagascar/)

#### 🇲🇿 **Mozambique** — Mangrove Extent & Condition (Early-Stage)
- **Ecosystem:** Mangrove forests (M2.1), Morrumbene & Save Estuary
- **Status:** Extent accounting ✅ | Condition framework ready 🔄 | Services pending
- **Data:** GMW 2020 satellite classification + field validation data
- **Outputs:** Mangrove extent maps, habitat change analysis
- **Location:** [`Mozambique/`](Mozambique/)

#### 🇰🇪 **Kenya** — [Ecosystem Type TBD] (Setup)
- **Ecosystem:** [To be determined — e.g., seagrass, mangroves, kelp forests]
- **Status:** Pilot setup ⚙️ | Scope definition in progress
- **Data:** [To be sourced]
- **Outputs:** [To be determined]
- **Location:** [`Kenya/`](Kenya/)

---

## Repository Structure

```
AFRICA - accounts/
├── README.md                          # This file
├── CLAUDE.md                          # Project conventions & working instructions
├── change_log.md                      # Session-level change history
│
├── _shared/                           # Resources shared across all pilots
│   ├── README.md                      # Guide to shared resources
│   ├── templates/                     # Policy brief & publication templates
│   ├── literature/                    # Regional SEEA EA case studies (Uganda, Rwanda, SA)
│   └── rag_schemas/                   # Generic RAG schema templates (adaptable for any country)
│
├── Madagascar/                        # Primary pilot: coral reef accounts
│   ├── 01_inputs/
│   │   ├── raw_data/                 # Excel UVC surveys (fish, invertebrates)
│   │   └── metadata/                 # Auto-generated data summaries + site metadata
│   ├── 02_analysis/
│   │   └── fish_invert_condition.R   # QA/QC → biomass → condition indices → SEEA EA export
│   ├── 03_outputs/
│   │   └── *.csv                     # Condition accounts, site-level results
│   └── docs/
│       ├── skills/                   # 8 standardised operating procedures (SOPs)
│       ├── template_seea_publication.md  # Madagascar-adapted publication template
│       ├── policy_rag_schema.md      # Madagascar policy-commitment linking schema
│       ├── ACADEMIC_RAG_*.md         # Academic evidence-linking system
│       └── [other methodology docs]
│
├── Mozambique/                        # Secondary pilot: mangrove extent
│   ├── 01_inputs/
│   │   ├── raw_data/                 # Mangrove extent CSVs (GMW 2020 + field surveys)
│   │   └── metadata/                 # Data summaries
│   ├── 03_outputs/
│   │   └── FINDINGS_OVERVIEW.md      # Preliminary extent findings
│   └── docs/
│       ├── skills/                   # Extent SOP for mangroves
│       ├── template_seea_publication.md  # Mozambique-adapted publication template
│       ├── policy_rag_schema.md      # Mozambique policy-commitment linking schema
│       └── [other methodology docs]
│
└── Kenya/                             # Tertiary pilot: [ecosystem TBD] (setup)
    ├── 01_inputs/
    │   ├── raw_data/                 # Raw data files (to be populated)
    │   └── metadata/                 # Data summaries
    ├── 02_analysis/
    │   └── [analysis scripts TBD]
    ├── 03_outputs/
    │   └── [results TBD]
    └── docs/
        ├── skills/                   # SOPs for Kenya accounts (to be created)
        ├── rag/                       # RAG systems (academic, policy)
        ├── accounts/                  # Account methodology docs
        ├── briefs/                    # Policy briefs
        └── templates/                 # Adapted publication templates (shared copies)
```

---

## Getting Started

### For Reviewers & Collaborators
1. **Start here:** [CLAUDE.md](CLAUDE.md) — Project conventions, key files, open review items
2. **Understand methodology:** [Madagascar/docs/skills/](Madagascar/docs/skills/) for detailed SOPs; [_shared/literature/](/_shared/literature/) for regional precedents
3. **Review status:** [Madagascar/docs/cond_reef_fish_invert_plan.md](Madagascar/docs/cond_reef_fish_invert_plan.md) — canonical status tracker with open questions and next steps

### For Adding a New Pilot Country
1. Follow the adaptation checklist in [_shared/README.md](_shared/README.md) → "How to Adapt for a New Pilot Country"
2. Copy shared templates: `POLICY_BRIEF_TEMPLATE.md`, generic RAG schemas
3. Create country-specific analysis script & skills documentation
4. Update [change_log.md](change_log.md) and this README when the pilot reaches "first outputs" milestone

### For Modifying Analysis
1. All analysis scripts live in `CountryName/02_analysis/`
2. All methodology documented in `CountryName/docs/skills/skill_*.md`
3. Run tests and review outputs in `CountryName/03_outputs/`
4. Update [change_log.md](change_log.md) at the end of each session

---

## Key Resources

### Methodology
| Resource | Purpose |
|----------|---------|
| [Madagascar/docs/skills/](Madagascar/docs/skills/) | 8 detailed SOPs (condition, extent, services) — all Madagascar coral reef, fully worked |
| [_shared/rag_schemas/](/_shared/rag_schemas/) | Generic JSON schemas for policy RAG and publication templates (adaptable) |
| [_shared/literature/](/_shared/literature/) | 3 regional case studies (Uganda, Rwanda, South Africa) for methodological reference |

### Analysis Scripts
| Script | Purpose | Status |
|--------|---------|--------|
| [Madagascar/02_analysis/fish_invert_condition.R](Madagascar/02_analysis/fish_invert_condition.R) | UVC → QA/QC → biomass → condition indices → SEEA EA export | ✅ Production-ready |
| Mozambique/02_analysis/*.R | Mangrove extent → habitat classification → change analysis | 🔄 In development |

### Status Trackers
| File | Scope | Update Frequency |
|------|-------|------------------|
| [CLAUDE.md](CLAUDE.md) → "Open Review Items" | Project-level open questions | Per-session |
| [Madagascar/docs/cond_reef_fish_invert_plan.md](Madagascar/docs/cond_reef_fish_invert_plan.md) | Madagascar condition accounts milestone tracker | Per-session |
| [change_log.md](change_log.md) | Session-level changes (what was worked on, by whom, when) | At end of each session |

---

## Contributing

### Before You Start
- Read [CLAUDE.md](CLAUDE.md) — project conventions, data assumptions, open questions
- Review [change_log.md](change_log.md) — understand recent session history
- Check the relevant country's status tracker (e.g., [Madagascar/docs/cond_reef_fish_invert_plan.md](Madagascar/docs/cond_reef_fish_invert_plan.md))

### Making Changes
1. **Code:** Modify analysis scripts in `CountryName/02_analysis/`. Test locally, then commit with clear message.
2. **Methodology:** Update SOPs in `CountryName/docs/skills/`. Link to policy & academic evidence using RAG schemas.
3. **Data:** All raw data in `CountryName/01_inputs/raw_data/`. Auto-generate metadata summaries in `01_inputs/metadata/`.
4. **Outputs:** Commit CSV results to `03_outputs/` for reproducibility.

### Committing
- Write descriptive commit messages (e.g., "Add sea urchin density indicator to fish_invert_condition.R" vs. "fix")
- Update [change_log.md](change_log.md) at end of each session
- Reference open issues / questions from CLAUDE.md if your commit addresses them

---

## Data Policy

- **Raw input data** (`01_inputs/raw_data/`) — sensitive field coordinates, observer identifiers may be restricted. Contact data providers for access.
- **Metadata** (`01_inputs/metadata/*.md`) — auto-generated summaries of field data; safe to share
- **Analysis scripts** (`02_analysis/`) — open; reusable for any ecosystem/country
- **Outputs & accounts** (`03_outputs/`) — open; publishable

**For field data access:** Contact project leads (see CLAUDE.md)

---

## Frequently Asked Questions

**Q: How do I run the analysis for Madagascar?**
A: Open `Madagascar/02_analysis/fish_invert_condition.R` in RStudio. Script uses `rstudioapi` to detect working directory; if not in RStudio, edit the `setwd()` line. Requires tidyr, dplyr, readxl, ggplot2. Outputs go to `03_outputs/`.

**Q: Which templates should I use for a new account/brief?**
A: See `_shared/templates/` (generic) and adapt for your country. Check `Madagascar/docs/` and `Mozambique/docs/` for worked examples.

**Q: How do I integrate a new data source?**
A: Add raw file to `CountryName/01_inputs/raw_data/`. Document in `01_inputs/metadata/[filename]_metadata.md`. Update analysis script to ingest + validate. Test outputs. Update change_log.

**Q: What's the difference between condition, extent, and services accounts?**
A:
- **Condition:** Is the ecosystem healthy? (biotic structure, water quality, habitat intactness; 0–1 index)
- **Extent:** How much ecosystem is there? (spatial footprint, habitat change, area in hectares)
- **Services:** What's it worth to people? (provisioning, regulating, cultural; economic value in USD)

All three feed into national environmental-economic accounts.

---

## See Also
- [UN SEEA EA Handbook](https://seea.un.org/) — Official framework documentation
- [WRI Ecosystem Accounting](https://www.wri.org/research/environmental-accounting) — Practice guidance
- [WAVES Initiative](https://www.worldbank.org/en/topic/environment/brief/waves) — World Bank ecosystem accounting partnerships
- Madagascar field data & stakeholder contacts: See [CLAUDE.md](CLAUDE.md)

---

## License & Citation

All analysis scripts, methodology documents, and outputs are available for use under [specify license]. When citing, use:

> AFRICA Ecosystem Accounting Project. (2026). Environmental-Economic Accounts for African Coastal & Marine Ecosystems. [GitHub/Repository URL].

---

**Project Lead:** [Name, Institution]
**Last Updated:** 2026-03-16
**Next Review:** 2026-04-30
