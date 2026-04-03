# Skill: Ecosystem Condition by Protected Area
## Fish & Invertebrate Condition Stratified by WDPA Designation

**Purpose:** Assess fish and invertebrate community condition separately by protected area, linking site-level condition metrics with WDPA protected area metadata to enable analysis of conservation effectiveness and ecosystem service value within vs. outside protected areas.

**Framework:** SEEA EA Ecosystem Condition Accounts + Protected Area Analysis
**Ecosystem type:** Photic Coral Reefs (M1.3)
**Spatial scope:** Site-level condition stratified by PA designation (27 sites across 3–5 PAs)
**Accounting period:** 2025–2026
**Integration:** Bridges [skill_condition_biotic_fish_invert.md](skill_condition_biotic_fish_invert.md) condition outputs with [skill_extent_protected_areas_m13_reef.md](skill_extent_protected_areas_m13_reef.md) PA framework

---

## 1. Overview

This skill disaggregates ecosystem condition indicators (fish biomass, richness; invertebrate densities) by protected area designation. Unlike extent disaggregation (which measures *how much* reef area exists in each PA), this skill addresses:

- **Which condition states** exist within vs. outside protected areas?
- **How does conservation status affect** fish and invertebrate community composition?
- **What is the ecosystem service** value (nursery, provisioning) within protected areas?

**Key Deliverables:**

| Deliverable | Format | Purpose | Variables |
|---|---|---|---|
| **Fish condition by PA** | CSV | Site-level fish metrics stratified by PA | Biomass (kg/ha), richness (spp), abundance (ind/ha), trophic composition, PA metadata |
| **Invertebrate condition by PA** | CSV | Site-level invertebrate indicators stratified by PA | COTS density, urchin density, clam abundance, PA metadata |
| **Condition summary by PA** | CSV | Aggregated metrics (mean ± SE) per PA + unprotected areas | Mean biomass, richness, richness SE, PA type |
| **Conservation effectiveness table** | CSV | Comparison of PA vs. unprotected condition | % difference in biomass/richness, sample size per PA |
| **PA-site linkage table** | CSV | Complete site-to-PA mapping with full WDPA metadata | Site ID, PA ID, PA name, designation, IUCN category, governance, etc. |

---

## 2. Data Sources & Preparation

### 2.1 Input Datasets

| Dataset | Source | Format | Status | Notes |
|---|---|---|---|---|
| **Fish condition output** | `Madagascar/03_outputs/fish_invert_site_condition.csv` | CSV (27 sites) | ✅ Ready | Biomass, richness, abundance, functional group breakdown per site |
| **Invertebrate condition output** | `Madagascar/03_outputs/fish_invert_site_condition.csv` | CSV (27 sites) | ✅ Ready | COTS density, urchin density, clam abundance per site |
| **Site coordinates** | Raw UVC metadata or condition CSV | CSV (lat/lon) | ✅ Ready | 27 unique site locations |
| **WDPA polygons** | https://www.protectedplanet.net/ | Shapefile | ✅ Download before starting | Protected Planet World Database of Protected Areas; Madagascar SW coast |
| **WDPA attribute reference** | `Madagascar/docs/WDPA_WDOECM_RAG_Schema.md` | Markdown | ✅ Ready | Complete WDPA field reference (NAME, DESIG, IUCN_CAT, GOV_TYPE, etc.) |

### 2.2 Data Preparation Checklist

**Step 1: Extract site coordinates and condition data**
- [ ] Load `fish_invert_site_condition.csv` (27 sites, condition metrics)
- [ ] Extract columns: `site_id`, `latitude`, `longitude`, `fish_biomass_kg_ha`, `fish_richness_spp`, `fish_abundance_ind_ha`, `cots_density_ind_ha`, `urchin_density_ind_ha`, `clam_abundance_ind_ha`
- [ ] Verify: All 27 sites have valid coordinates (lat/lon within SW Madagascar region, 0–25 m depth zone)
- [ ] Remove duplicates: Ensure each site appears once (deduplication already done in raw data QA/QC)
- [ ] Create working file: `Madagascar/02_analysis/site_condition_for_pa_analysis.csv`

**Step 2: Prepare WDPA data**
- [ ] Download WDPA shapefile from Protected Planet (https://www.protectedplanet.net/download)
- [ ] Filter to Madagascar region (attribute query: `ISO3 = 'MDG'` OR `PARENT_ISO3 = 'MDG'`)
- [ ] Spatially filter to SW coastal region (intersect with accounting area boundary, 25 m depth contour)
- [ ] Keep key fields (see §2.3 below): `WDPA_ID`, `NAME`, `DESIG`, `DESIG_TYPE`, `IUCN_CAT`, `STATUS_YR`, `STATUS`, `VERIF`, `MARINE`, `GOV_TYPE`, `OWN_TYPE`, `MANG_AUTH`, `NO_TAKE`, `NO_TK_AREA`
- [ ] Verify projection: All layers in WGS84 (EPSG:4326)
- [ ] Create working shapefile: `Madagascar/02_analysis/wdpa_madagascar_sw.shp`

**Step 3: Define reference: unprotected sites**
- [ ] Identify sites that fall **outside** any WDPA polygon (these are your reference/unprotected sites)
- [ ] Flag in working file: `pa_status = 'Unprotected'` for these sites
- [ ] Note: These sites may still be under customary marine tenure (LMMA) or community management; flag as "no formal WDPA designation"

### 2.3 Key WDPA Fields to Retain

**For conservation effectiveness analysis, retain these WDPA attributes:**

| Field | Type | Description | Example |
|---|---|---|---|
| `WDPA_ID` | Integer | Unique PA identifier (globally assigned) | 123456 |
| `NAME` | String | PA name (local language) | "Andohahela National Park" |
| `DESIG` | String | PA designation | "National Park", "Marine Reserve", "LMMA" |
| `DESIG_TYPE` | String | Designation category | "National", "Regional", "International" |
| `IUCN_CAT` | String | IUCN Management Category (Ia–VI, N/A) | "II" (National Park), "IV" (Management Area) |
| `STATUS_YR` | Integer | Year of designation/establishment | 2005 |
| `STATUS` | String | Current management status | "Established", "Proposed" |
| `VERIF` | String | Verification by national government | "State Verified", "Expert Verified" |
| `MARINE` | String | Marine composition code | "0" (terrestrial), "1" (coastal), "2" (predominantly marine) |
| `GOV_TYPE` | String | Governance type | "Federal/national ministry", "Sub-national ministry", "Collaborative", "Indigenous/Local communities" |
| `OWN_TYPE` | String | Ownership type | "State", "Communal", "Individual", "For-profit", "Non-profit" |
| `MANG_AUTH` | String | Managing authority | "National park service", "Regional env. agency", "Community committee" |
| `NO_TAKE` | String | No-take zone status | "All", "Part", "None", "Not Reported" |
| `NO_TK_AREA` | Double | No-take zone area (km²) | 500 |

---

## 3. Protected Area Site Assignment (ArcGIS Pro Workflow)

**Note:** Steps 3.1–3.2 parallel the workflow in [skill_extent_protected_areas_m13_reef.md](skill_extent_protected_areas_m13_reef.md) §3 but focus on linking **condition metrics** to PA attributes rather than extent.

### 3.1 Create XY Event Layer from Site Coordinates

**Objective:** Convert site lat/lon into spatial points, linked to condition data.

**Steps in ArcGIS Pro:**

1. **Prepare input CSV**
   - CSV columns: `site_id`, `latitude`, `longitude`, `fish_biomass_kg_ha`, `fish_richness_spp`, `fish_abundance_ind_ha`, `cots_density_ind_ha`, `urchin_density_ind_ha`, `clam_abundance_ind_ha`, [other condition columns from fish_invert_site_condition.csv]
   - Save as: `Madagascar/02_analysis/site_condition_for_pa_analysis.csv`

2. **Create XY Event Layer**
   - Open ArcGIS Pro → New map project
   - Add data → Select CSV file (`site_condition_for_pa_analysis.csv`)
   - Data tab → Display XY Data
   - X field: `longitude`, Y field: `latitude`
   - Coordinate system: WGS84 (EPSG:4326)
   - Right-click output layer → Export Feature Class → Save as `fish_invert_sites_xy.shp`

3. **Visual verification**
   - Zoom to SW Madagascar coastline
   - Confirm all 27 site points visible and within expected region
   - Check: Points should cluster in 3–5 spatial groupings (corresponding to 3–5 PAs in region)
   - Flag any outliers (points > 25 m depth or on land)

### 3.2 Spatial Join: Sites to WDPA Polygons with Full Metadata

**Objective:** For each site, retrieve all WDPA attributes (NAME, IUCN_CAT, GOV_TYPE, NO_TAKE, etc.).

**Steps in ArcGIS Pro:**

1. **Spatial join (one-to-one)**
   - Target features: `fish_invert_sites_xy.shp` (site points)
   - Join features: `wdpa_madagascar_sw.shp` (WDPA polygons)
   - Join operation: **ONE_TO_ONE** (each site intersects ≤1 PA polygon, typically)
   - **Alternative (if overlapping PAs):** Use **ONE_TO_MANY** and handle overlapping PA assignments in post-processing
   - Match option: INTERSECTS
   - Output name: `sites_with_pa_metadata.shp`

2. **Verify join attributes**
   - Output table should include:
     - Site attributes: `site_id`, `latitude`, `longitude`, `fish_biomass_kg_ha`, `fish_richness_spp`, `fish_abundance_ind_ha`, `cots_density_ind_ha`, `urchin_density_ind_ha`, `clam_abundance_ind_ha`, [etc.]
     - WDPA attributes: `WDPA_ID`, `NAME`, `DESIG`, `IUCN_CAT`, `GOV_TYPE`, `OWN_TYPE`, `NO_TAKE`, `NO_TK_AREA`, `STATUS_YR`, [etc.]
     - Join metadata: `Join_Count` (= 0 if site outside all PAs; = 1 if inside single PA; = >1 if overlapping PAs)

3. **Handle unprotected sites**
   - Add field: `pa_status` (String)
   - Calculate: `pa_status = 'Unprotected'` where `Join_Count = 0`
   - Calculate: `pa_status = 'Protected'` where `Join_Count > 0`
   - For overlapping PA sites (Join_Count > 1): Note in separate column which PAs overlap (manual or script)

4. **Export to CSV**
   - Right-click output table → Export → CSV format
   - Save as: `Madagascar/02_analysis/sites_with_pa_metadata.csv`
   - Verify: 27 rows (sites) + 1 header row

---

## 4. Condition Metrics by Protected Area

### 4.1 Summarize Condition by PA (Spreadsheet)

**Objective:** Calculate mean condition indices per PA.

**Steps in Excel or R:**

1. **Load `sites_with_pa_metadata.csv`**

2. **Create summary table by PA designation:**
   - Grouping variables: `NAME` (PA name), `IUCN_CAT` (category), `DESIG` (designation)
   - Condition variables to summarize:
     - **Fish:** Mean ± SE `fish_biomass_kg_ha`, `fish_richness_spp`, `fish_abundance_ind_ha`
     - **Invertebrates:** Mean ± SE `cots_density_ind_ha`, `urchin_density_ind_ha`, `clam_abundance_ind_ha`
   - Sample size: Count sites per PA
   - Add columns: `Join_Count`, `GOV_TYPE`, `OWN_TYPE`, `NO_TAKE` (for management context)

3. **Example output structure:**

| PA_Name | IUCN_CAT | DESIG | GOV_TYPE | NO_TAKE | n_sites | Fish_Biomass_mean | Fish_Biomass_se | Fish_Richness_mean | Fish_Richness_se | COTS_density_mean | COTS_density_se | Urchin_density_mean | Urchin_density_se | Clam_abundance_mean | Clam_abundance_se |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Andohahela NP | II | National Park | Federal ministry | Part | 8 | 1,850 | 280 | 54 | 5 | 0.2 | 0.05 | 8.3 | 1.2 | 12 | 2.1 |
| Ifaty Community Reserve | IV | Community LMMA | Local communities | All | 6 | 1,420 | 350 | 48 | 8 | 0.4 | 0.08 | 6.1 | 1.8 | 5 | 1.5 |
| Velondriake LMMA | IV | Community LMMA | Local communities | All | 5 | 1,680 | 220 | 52 | 6 | 0.15 | 0.04 | 7.8 | 1.4 | 8 | 1.2 |
| **Unprotected areas** | — | None | — | No | 8 | 980 | 240 | 41 | 7 | 0.6 | 0.12 | 5.2 | 2.1 | 2 | 0.8 |

4. **Save as:** `Madagascar/03_outputs/condition_summary_by_protected_area.csv`

### 4.2 Disaggregate by Functional Group / Invertebrate Type (Optional Advanced)

**For deeper analysis, stratify condition further:**

1. **Fish by functional group within PA:**
   - Grouping: `NAME` (PA) × `functional_group` (Carnivore, Herbivore, Planktivore, etc.)
   - Metrics: Biomass (kg/ha), abundance (ind/ha), richness (spp within group) per group
   - Purpose: Identify trophic recovery or imbalance in each PA

2. **Invertebrate by species (if counts sufficient):**
   - *Acanthaster planci* (COTS) density by PA
   - *Diadema setosum* (sea urchin) density by PA
   - *Tridacna maxima* (giant clam) density by PA
   - Purpose: Identify species-specific conservation needs

3. **Save as:** `Madagascar/03_outputs/condition_by_functional_group_pa.csv`, `Madagascar/03_outputs/condition_by_invertebrate_species_pa.csv`

---

## 5. Conservation Effectiveness Analysis

### 5.1 Compare Protected vs. Unprotected Condition

**Objective:** Quantify whether fish and invertebrate condition differs significantly between protected and unprotected areas.

**Steps in spreadsheet or R:**

1. **Partition sites by PA status**
   ```
   Protected sites (n ≥ 1 site in WDPA polygon):
     - Aggregate condition metrics for all "Protected" sites

   Unprotected sites (n = remaining sites outside WDPA):
     - Aggregate condition metrics for all "Unprotected" sites
   ```

2. **Calculate effect size (% difference)**
   ```
   % difference = 100 × (Protected_mean − Unprotected_mean) / Unprotected_mean

   Example: If Protected fish biomass = 1,650 kg/ha and Unprotected = 1,000 kg/ha
            % difference = 100 × (1,650 − 1,000) / 1,000 = +65% (better in protected areas)
   ```

3. **Assess statistical significance (if sample size permits)**
   - If n_protected ≥ 10 and n_unprotected ≥ 5: conduct independent t-test
   - Report: t-statistic, degrees of freedom, p-value
   - Interpret: p < 0.05 = significant difference in condition between PA status
   - Note: Limited sample size may reduce statistical power; focus on effect size and confidence intervals

4. **Output table:**

| Comparison | Metric | Unprotected_mean | Protected_mean | % Difference | n_unprotected | n_protected | Notes |
|---|---|---|---|---|---|---|---|
| Fish condition | Biomass (kg/ha) | 980 | 1,650 | +65% | 8 | 19 | Protected sites have higher fish biomass; possible spillover or better habitat |
| Fish condition | Richness (spp) | 41 | 51 | +24% | 8 | 19 | Protected sites have richer fish communities |
| COTS control | COTS density (ind/ha) | 0.6 | 0.25 | −58% | 8 | 19 | Protected areas show lower COTS density; possible active management or lower outbreak risk |
| Urchin grazing | Urchin density (ind/ha) | 5.2 | 7.5 | +44% | 8 | 19 | Higher urchin density in protected areas; may indicate restored herbivory function |

5. **Save as:** `Madagascar/03_outputs/conservation_effectiveness_pa_vs_unprotected.csv`

---

## 6. Full Output Files & Deliverables

### 6.1 Primary Outputs

| File Name | Location | Format | Content | Dependencies |
|---|---|---|---|---|
| `sites_with_pa_metadata.csv` | `02_analysis/` | CSV | Site-level condition + full WDPA attributes (27 rows) | Sites XY + WDPA spatial join (§3.2) |
| `condition_summary_by_protected_area.csv` | `03_outputs/` | CSV | Condition metrics aggregated per PA (mean ± SE); includes PA metadata | Spatial join output (§4.1) |
| `conservation_effectiveness_pa_vs_unprotected.csv` | `03_outputs/` | CSV | Effect size: Protected vs. Unprotected condition comparison | Condition summary (§5.1) |

### 6.2 Optional Advanced Outputs

| File Name | Location | Format | Content | Dependencies |
|---|---|---|---|---|
| `condition_by_functional_group_pa.csv` | `03_outputs/` | CSV | Fish condition stratified by PA × functional group | Condition + functional group classification (§4.2) |
| `condition_by_invertebrate_species_pa.csv` | `03_outputs/` | CSV | Invertebrate condition by species & PA | Condition + species classification (§4.2) |
| `sites_with_pa_metadata.shp` | `02_analysis/` | Shapefile | Site points with PA attributes (for map visualization) | Sites XY + WDPA spatial join (§3.2) |

### 6.3 Data Quality Metadata

Create accompanying file: `Madagascar/03_outputs/condition_by_pa_metadata.txt`
- [ ] Data source: Fish/invertebrate site condition (date), WDPA dataset (download date, version)
- [ ] Sample sizes: n_total = 27 sites; n_protected = [X]; n_unprotected = [Y]
- [ ] PA coverage: # unique PAs represented; # overlapping PA sites (if any)
- [ ] Confidence intervals: 95% CI reported for means (unless n_per_group < 3)
- [ ] Known limitations: GPS precision (±20 m), small sample sizes for some PAs, temporal mismatch (2025 condition data vs. WDPA boundaries from [date])

---

## 7. Quality Assurance Checks

**Before finalizing outputs, verify:**

- [ ] **Site-to-PA linkage:** All 27 sites assigned to PA or unprotected category; visual check on map
- [ ] **Condition data completeness:** No NULL values in key condition columns; missing data flagged in output metadata
- [ ] **WDPA attribute completeness:** NAME, DESIG, IUCN_CAT populated for all protected sites (some fields may be "Not Reported" — flag)
- [ ] **PA metadata consistency:** IUCN_CAT values conform to WDPA manual (Ia, Ib, II, III, IV, V, VI, N/A, Not Assigned)
- [ ] **Conservation effectiveness logic:** Protected condition > Unprotected condition (expected positive effect; if reversed, investigate site-level drivers)
- [ ] **Sample size reporting:** Each summary row includes n_sites; averages based on < 3 sites flagged as "provisional"
- [ ] **Overlap handling:** If any sites fall in multiple overlapping PAs, documented in output and methodology section

---

## 8. Integration with Related Skills

| Related Skill | Purpose | Output Used | Output Produced |
|---|---|---|---|
| [skill_condition_biotic_fish_invert.md](skill_condition_biotic_fish_invert.md) | Fish/invertebrate condition calculation | Fish/invert metrics, site coordinates | Inputs to this skill |
| [skill_condition_measurement_m13_reef.md](skill_condition_measurement_m13_reef.md) | Ecosystem condition normalization (0–1 scale) | Site-level condition index | Optionally integrate CI into PA summary |
| [skill_extent_protected_areas_m13_reef.md](skill_extent_protected_areas_m13_reef.md) | Extent disaggregation by PA | WDPA polygon methodology, site-PA linkage | Parallel PA analysis (extent vs. condition) |
| [skill_services_regulating_nursery_m13.md](skill_services_regulating_nursery_m13.md) | Nursery service valuation | Fish biomass per PA | Upstream input to service value by PA |
| [skill_services_provisioning_wildfish_m13.md](skill_services_provisioning_wildfish_m13.md) | Wild fish provisioning service | Fish catch allocation & landings | Upstream input to catch value by PA |

---

## 9. Workflow & Timeline

| Phase | Activity | Timing | Responsibility | Inputs | Outputs |
|---|---|---|---|---|---|
| **Phase 1: Data prep** | Extract site condition + WDPA, coordinate system verification | 2026-03 | Data/GIS team | `fish_invert_site_condition.csv`, WDPA download | `site_condition_for_pa_analysis.csv`, `wdpa_madagascar_sw.shp` |
| **Phase 2: Site–PA linkage** | Create XY event layer, spatial join with WDPA metadata | 2026-03 | GIS analyst | Site XY layer, WDPA polygons | `sites_with_pa_metadata.csv` |
| **Phase 3: Condition summary** | Aggregate condition metrics per PA (mean ± SE) | 2026-03 | Analyst (R/Excel) | Sites with PA metadata | `condition_summary_by_protected_area.csv` |
| **Phase 4: Effectiveness analysis** | Compare protected vs. unprotected condition; calculate effect size | 2026-03 | Analyst | Condition summary | `conservation_effectiveness_pa_vs_unprotected.csv` |
| **Phase 5: Functional breakdown (optional)** | Stratify by functional group, invertebrate species | 2026-04 | Analyst | Condition + species metadata | Optional advanced outputs |
| **Phase 6: QA & visualization** | Verify outputs, create summary maps, document metadata | 2026-04 | GIS lead + analyst | All outputs | Metadata document, finalized CSVs |

---

## 10. Critical Data Gaps & Future Work

1. **Temporal dynamics:** Current analysis is **snapshot 2025** condition. To assess *effectiveness of protection over time*, repeat surveys in 2026 and compare 2025–2026 trends by PA status.

2. **PA boundary precision:** WDPA polygons are official but may lag implementation (STATUS_YR vs. actual enforcement date). Verify with Madagascar ministry (MINTED) for most recent PA boundaries.

3. **Management intensity:** WDPA records PA *designation* not *management effectiveness*. To assess "true" conservation impact, cross-reference with:
   - Management Effectiveness Tracking Tool (METT) scores
   - Patrol effort / enforcement records
   - Stakeholder interviews on actual management activity

4. **Spillover & connectivity:** Sites outside PAs may benefit from spillover (juvenile/adult larval dispersal) if located adjacent to PAs. Current analysis assumes independent sites; spatial buffering analysis recommended for future work.

5. **Community-managed conservation:** Many SW Madagascar PAs are LMMAs (Locally Managed Marine Areas) managed by communities. Distinguish governance effectiveness by `GOV_TYPE` in follow-up analyses.

---

## 11. Key WDPA Fields Reference

**For detailed field definitions, refer to:**
- `Madagascar/docs/WDPA_WDOECM_RAG_Schema.md` (Section 3: Attribute Data Schema, pp. 73–117)
- WDPA Manual 1.6, Appendix 1 (pp. 44–61): Complete field descriptions

**Minimum fields required for this analysis:**
- `WDPA_ID`, `NAME`, `DESIG`, `IUCN_CAT`, `GOV_TYPE`, `OWN_TYPE`, `STATUS_YR`, `VERIF`, `NO_TAKE`, `NO_TK_AREA`, `MARINE`, `STATUS`

**Optional fields for deeper analysis:**
- `MANG_AUTH`, `CONS_OBJ`, `INT_CRIT`, `SUB_LOC` (sub-national location code)

---

## 12. Example Interpretation & Policy Relevance

### Scenario 1: Protected Areas Show Higher Fish Biomass (+65%)
**Interpretation:** PAs appear effective at supporting fish recovery or spillover.
**Policy implication:** Recommend continued protection and increased extent of existing PAs.
**Data gap:** Does 65% difference persist across functional groups? Are large predators (carnivores) or small juveniles (nursery effect) driving the difference?

### Scenario 2: COTS Density Higher in Protected Areas (× 2)
**Interpretation:** Protection alone may not prevent COTS outbreaks; active management (culling, removal) or environmental factors (nutrient runoff, crown-of-thorns larvae recruitment) may dominate.
**Policy implication:** PA designation insufficient; integrated pest management or water quality improvement needed.
**Data gap:** Is COTS outbreak recent (post-2025) or chronic? Is there evidence of culling effort in these PAs?

### Scenario 3: Unprotected Areas Have Higher Urchin Density
**Interpretation:** Either (a) overfishing of urchin predators in unprotected areas, or (b) higher nutrient input promoting algae → urchin food.
**Policy implication:** If (a), fisheries closure in unprotected areas. If (b), land-based pollution control.
**Data gap:** Urchin size distribution (small juveniles vs. large adults)? Algal cover data?

---

## 13. References

1. UNEP-WCMC & IUCN. (2024). *Protected Planet: The World Database of Protected Areas (WDPA).* https://www.protectedplanet.net/
2. UNEP-WCMC. (2019). *User Manual for the World Database on Protected Areas and other effective area-based conservation measures: 1.6.* https://www.protectedplanet.net/download
3. UN SEEA EA. (2021). *System of Environmental-Economic Accounting — Ecosystem Accounting.* https://seea.un.org/
4. McClanahan, T. R., et al. (2016). "Modeling reef fish biomass, recovery potential, and management priorities in the Western Indian Ocean." *PLOS ONE*, 11(5), e0154585. [Primary reference level for fish biomass: 1,150 kg/ha WIO conservation target; 600 kg/ha sustainability floor]
5. MacNeil, M. A., et al. (2015). "Recovery potential of the world's coral reef fishes." *Nature*, 520(7547), 341–344. [Supplementary: unfished Indo-Pacific B0 ~1,000 kg/ha]
6. Dulvy, N. K., et al. (2021). "Fish predators control outbreaks of Crown-of-Thorns Starfish." *Nature Communications*. [COTS outbreak threshold 15 ind/ha; background <1 ind/ha]

---

## 14. Document Control

| Version | Date | Author | Changes |
|---|---|---|---|
| 1.0 | 2026-03-16 | Claude Code | Initial skill creation; customized for Madagascar M1.3 coral reef; integrated with WDPA/WDOECM schema; linked to condition and extent skills |

**Last updated:** 2026-03-16
**Customised by:** Claude Code for AFRICA–Madagascar project
**Data providers:** Laza & field team (condition data), WDPA (Protected Planet), Yves Amoros Mitondrasoa (spatial coordination)
**Contact:** See [README.md](README.md) for project team

