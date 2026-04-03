# Kenya — Ecosystem Accounting for Coastal & Marine Ecosystems

Environmental accounting project for Kenya's coastal and marine ecosystems under the **UN SEEA EA** (System of Environmental-Economic Accounting -- Ecosystem Accounting) framework.

---

## Project Overview

| Item | Detail |
|------|--------|
| **Framework** | UN SEEA EA Ecosystem Accounting (UN 2021, UNEP 2023) |
| **Ecosystems** | Coastal and marine (coral reefs, mangroves, seagrass beds) |
| **Accounts** | Ecosystem condition, extent, and ecosystem services |
| **Policy integration** | Links accounts to national marine spatial planning, fisheries policy, climate commitments, and SDG targets |

---

## Repository Structure

```
Kenya_accounts/
├── README.md                          # This file
├── CLAUDE.md                          # Project conventions & working instructions
├── change_log.md                      # Session-level change history
│
├── _shared/                           # Shared resources (templates, literature, RAG schemas)
│
└── Kenya/
    ├── 01_inputs/
    │   ├── raw_data/                 # Raw data files
    │   └── metadata/                 # Data summaries
    ├── 02_analysis/
    │   └── [analysis scripts]
    ├── 03_outputs/
    │   └── [results]
    ├── research-report/              # Observable Framework data visualisation
    └── docs/
        ├── skills/                   # SOPs for Kenya accounts
        ├── ecosystem_services/       # Ecosystem services documentation
        ├── rag/                      # RAG systems (academic, policy)
        ├── accounts/                 # Account methodology docs
        ├── briefs/                   # Policy briefs
        └── templates/                # Publication templates
```

---

## Getting Started

1. Read [CLAUDE.md](CLAUDE.md) for project conventions, key files, and open review items
2. Review [change_log.md](change_log.md) for recent session history
3. Check `Kenya/docs/skills/` for methodology SOPs

---

## Data Policy

- **Raw input data** (`01_inputs/raw_data/`) -- sensitive field coordinates and observer identifiers may be restricted
- **Metadata** (`01_inputs/metadata/`) -- auto-generated summaries; safe to share
- **Analysis scripts** (`02_analysis/`) -- open and reusable
- **Outputs & accounts** (`03_outputs/`) -- open and publishable

---

## See Also

- [UN SEEA EA Handbook](https://seea.un.org/) -- Official framework documentation

---

**Last Updated:** 2026-04-03
