# Kenya — SEEA EA Ecosystem Accounting Pilot

**Status:** Early-stage setup
**Ecosystem:** [To be determined — e.g., seagrass beds, mangroves, kelp forests]
**Accounting period:** [To be confirmed]
**Data sources:** [To be populated]

---

## Folder Structure

```
Kenya/
├── 01_inputs/
│   ├── raw_data/          # Raw data files (Excel, CSV, GeoJSON)
│   └── metadata/          # Auto-generated data summaries & field metadata
├── 02_analysis/
│   └── [analysis scripts]  # R, Python analysis workflows
├── 03_outputs/
│   └── [results CSVs]     # Condition/extent/services account outputs
└── docs/
    ├── skills/            # Standardised operating procedures for this pilot
    ├── rag/               # RAG systems (academic, policy evidence linking)
    │   ├── academic/      # Citation & evidence linking
    │   └── policy/        # Policy-commitment semantic linking
    ├── accounts/          # Account methodology & status documentation
    ├── briefs/            # Policy brief drafts
    └── templates/         # Adapted publication templates
```

---

## Getting Started

### Step 1: Define Pilot Scope
- [ ] Confirm primary ecosystem type (mangrove, seagrass, kelp, coral reef, etc.)
- [ ] Identify geographic focus area (coastal region, specific sites, etc.)
- [ ] Define accounting period
- [ ] List key data providers & collaborators

### Step 2: Data Preparation
- [ ] Add raw data files to `01_inputs/raw_data/`
- [ ] Generate metadata summaries in `01_inputs/metadata/` (see Madagascar/Mozambique examples)
- [ ] Document data quality issues & assumptions

### Step 3: Methodology Setup
- [ ] Adapt shared templates to Kenya context
  - Copy `_shared/rag_schemas/template_seea_publication_GENERIC.md` → `docs/template_seea_publication.md`
  - Copy `_shared/rag_schemas/policy_rag_schema_GENERIC.md` → `docs/policy_rag_schema.md`
  - Copy `_shared/templates/POLICY_BRIEF_TEMPLATE.md` → `docs/POLICY_BRIEF_TEMPLATE.md`
- [ ] Document ecosystem-specific accounts in `docs/skills/`
- [ ] Set up analysis scripts in `02_analysis/`

### Step 4: Analysis & Outputs
- [ ] Run analysis pipeline → `03_outputs/`
- [ ] Create status tracker (see Madagascar example: `docs/accounts/cond_reef_fish_invert_plan.md`)
- [ ] Document open questions & next steps

### Step 5: Integration
- [ ] Link to regional precedents (see `_shared/literature/`)
- [ ] Connect to policy commitments (update `docs/policy_rag_schema.md`)
- [ ] Build academic evidence system (see Madagascar: `docs/rag/academic/`)

---

## Key References

| Resource | Purpose |
|----------|---------|
| [CLAUDE.md](../CLAUDE.md) | Project conventions & shared instructions |
| [README.md](../README.md) | Workspace overview |
| [Madagascar/docs/](../Madagascar/docs/) | Full implementation example (condition + extent + services) |
| [Mozambique/docs/](../Mozambique/docs/) | Early-stage extent accounting example |
| [_shared/](../_shared/) | Templates & regional case studies |

---

## Questions?

- See [_shared/README.md](../_shared/README.md) for adaptation guidance
- Review CLAUDE.md for project conventions
- Check Madagascar/Mozambique for worked examples

---

**Last Updated:** 2026-03-16
**Next Milestone:** [To be set]
