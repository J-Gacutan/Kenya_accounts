# Kenya — Skills Library (SOPs)

This folder contains standardised operating procedures (SOPs) for Kenya's SEEA EA accounts.

**Status:** In progress — 3 skills documented

---

## Skills

| Skill | Ecosystem Type | Purpose | Status |
| ----- | -------------- | ------- | ------ |
| `skill_condition_seagrass_kenya.md` | Seagrass meadows (M1.1) | Biotic condition from plot-based seagrass cover + health surveys | Complete |
| `skill_condition_mangrove_kenya.md` | Intertidal Forests (MFT1.2) | Biotic condition from plot-based mangrove structural survey; 5 indicators (stem density, DBH, height, cover, quality); PA-disaggregated (Mida Creek MNR vs unprotected); 22 sites, 36 plots | Complete |
| `skill_extent_mangrove_kenya.md` | MFT1.2 | Mangrove extent by PA status + multi-period change detection (GMW 2020 to 2025); 7-step ArcGIS workflow producing total, per-WDPA, protected/unprotected extent, additions, reductions, and SEEA EA extent account | Complete |
| `skill_services_provisioning_wildfish_kenya.md` | Coral Reef (M1.3) | Wild fish provisioning service — resource rent using KeFS landing data (2020-2024); Tier 1 ready | Complete — Tier 1 ready; Tier 2 pending fisher survey |

## Planned Skills

| Skill | Ecosystem Type | Purpose | Status |
| ----- | -------------- | ------- | ------ |
| `skill_extent_seagrass_kenya.md` | M1.1 | Satellite extent mapping | Not started |
| `skill_condition_coral_reef_kenya.md` | Coral reefs (M1.3) | Fish + coral structural condition from UVC surveys | Not started |
| `skill_condition_by_protected_area_kenya.md` | All | Condition disaggregated by Mida Creek MNR, Watamu MPA, Malindi MPA | Mangrove PA done (in skill_condition_mangrove_kenya.md); coral reef PA pending |

---

## How to Write a Skill

See [Madagascar/docs/skills/README.md](../../Madagascar/docs/skills/README.md) for the SOP template and worked examples.

Each skill should include:

- **Overview:** What does this SOP measure?
- **Data sources:** Where does the data come from?
- **Methodology:** Step-by-step calculation logic
- **QA/QC:** Data validation & assumption checks
- **Results:** Expected outputs (CSV structure, ranges)
- **Open questions:** Issues to resolve with the field team

---

## Reference Skills (Other Pilots)

### Madagascar (Coral Reef — Advanced)

- `skill_condition_biotic_fish_invert.md`
- `skill_condition_measurement_m13_reef.md`
- `skill_extent_measurement_m13_reef.md`
- `skill_extent_protected_areas_m13_reef.md`
- `skill_condition_by_protected_area_m13_reef.md`
- `skill_services_regulating_nursery_m13.md`
- `skill_services_provisioning_wildfish_m13.md`

### Mozambique (Mangrove — Early-Stage)

- `skill_extent_mangrove_m13_mozambique.md`

---

**Last Updated:** 2026-03-27
