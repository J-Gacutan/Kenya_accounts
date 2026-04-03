# Kenya — Ecosystem Services Documentation

This folder contains execution prompts, search plans, and supporting methodology documents for Kenya's SEEA EA ecosystem service accounts.

---

## Contents

| File | Purpose | Status |
|------|---------|--------|
| `PROMPT_provisioning_wildfish_resource_rent.md` | Step-by-step execution prompt for the wild fish resource rent calculation | Ready — calls `skill_services_provisioning_wildfish_kenya.md` |
| `SEARCH_PLAN_attribution_percentages.md` | Systematic search strategy to find empirical evidence for reef catch attribution percentages | Searches 1-7 executed 2026-03-16; 3 attributions revised in R script; Search 8 (Dr. Thoya data request) pending |
| `SEARCH6_SEEA_attribution_precedents.md` | Search 6 results: SEEA EA and ocean accounting precedents for reef catch attribution | Complete (2026-03-16) — no published standard fractions found; expert elicitation endorsed as WIO standard |

---

## Services in Development

| Service | Ecosystem | Tier | Status |
|---------|-----------|------|--------|
| Wild fish provisioning | Coral Reef M1.3 | Tier 1 complete | `02_analysis/fisheries_provisioning.R` written and run; outputs in `03_outputs/` |
| Fisheries nursery | Coral Reef M1.3 | Not started | Dependent on UVC biomass from condition account |
| Coastal protection | All coastal | Not started | Requires reef/mangrove/seagrass extent account |

---

## Related Documents

- Skill: `docs/skills/skill_services_provisioning_wildfish_kenya.md`
- Data request: `docs/data_request_provisioning_service.md`
- Open-access data retrieval: `docs/search_plan_open_access_provisioning.md`
- Outputs: `03_outputs/fisheries_supply_physical.csv` | `fisheries_supply_monetary.csv` | `fisheries_attribution_table.csv` | `fisheries_sensitivity_resource_rent_2024.csv`

---

*Last updated: 2026-03-16 (searches 1-7 complete; attribution table revised)*
