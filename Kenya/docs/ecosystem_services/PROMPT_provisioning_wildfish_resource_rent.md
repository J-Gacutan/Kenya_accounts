# Execution Prompt: Wild Fish Provisioning Service — Resource Rent Calculation
## Kenya Coral Reef (M1.3), Kilifi County | 2025-2026 Accounts

**Type:** Analysis execution prompt
**Skill called:** `Kenya/docs/skills/skill_services_provisioning_wildfish_kenya.md`
**Accounting period:** 2025-2026
**Status:** Ready to execute Tier 1. Tier 2 blocked pending fisher cost survey.

---

## Objective

Calculate the wild fish provisioning service account for Kilifi County coral reefs using official Kenya Fisheries Service (KeFS) landings data (2020-2024). Produce:

1. A 5-year physical supply table (reef-attributed catch in MT/yr, adjusted for unreported landings)
2. A 5-year monetary supply table (gross revenue and resource rent in constant 2024 USD)
3. A sensitivity analysis on the reef attribution fraction and cost-to-revenue ratio
4. Two output CSVs ready for inclusion in the SEEA EA condition and services account

---

## Pre-Execution Checklist

Before running, confirm the following:

- [ ] `01_inputs/raw_data/fisheries/Fisheries Data.xlsx` is readable (6 sheets: summary + 2020-2024)
- [ ] `01_inputs/metadata/fisheries_metadata.md` has been read and the species name inconsistencies are noted
- [ ] Dr. Pascal Thoya has been contacted to validate the habitat attribution table (Section 3.2 of the skill); if validation is not yet received, proceed with the provisional attribution fractions and flag as PENDING VALIDATION in all outputs
- [ ] Confirm with Dr. Thoya whether the 2023 catch/value estimates in the KeFS data have since been revised to final values

---

## Step-by-Step Execution

### Step 1 — Read and inspect the KeFS data

Open `01_inputs/raw_data/fisheries/Fisheries Data.xlsx`. Read the five annual sheets (2020, 2021, 2022, 2023, 2024) and the summary sheet. For each annual sheet, confirm:

- Number of species group rows (expect 36-40 per year)
- Column names: Fish group | Catch (MT) | Value (KES '000)
- That 2023 rows are flagged or marked as estimates in the source

Stack all five annual sheets into a single long-format data frame with columns:

```
year | species_group | catch_mt | value_kes_000
```

### Step 2 — Standardise species group names

Apply the following name corrections before any calculations:

| Raw form | Standardised form |
|---|---|
| Scarvenger | Scavenger |
| Littla mackerels | Little mackerels |
| Steaker | Streaker |
| Dolphin Fish | Dolphins |

Convert all species group names to Title Case. Check for any additional year-to-year inconsistencies by comparing unique group names across the five annual sheets and resolving any further mismatches.

### Step 3 — Join the habitat attribution table

Use the habitat attribution table from Section 3.2 of `docs/skills/skill_services_provisioning_wildfish_kenya.md`. Create a lookup data frame with columns:

```
species_group | reef_attribution_pct | confidence
```

Left-join this to the stacked KeFS data on `species_group`. Any KeFS group without a match should be assigned `reef_attribution_pct = 0` and flagged as UNMATCHED for manual review.

### Step 4 — Calculate reef-attributed physical supply

For each row:

```r
reef_catch_mt <- catch_mt * reef_attribution_pct / 100
```

Sum to annual totals:

```r
reef_catch_annual <- data %>%
  group_by(year) %>%
  summarise(
    total_county_catch_mt   = sum(catch_mt, na.rm = TRUE),
    reef_catch_mt           = sum(reef_catch_mt, na.rm = TRUE),
    reef_fraction_pct       = reef_catch_mt / total_county_catch_mt * 100
  )
```

Apply unreported catch adjustment (Tier 1 central estimate: 25%):

```r
reef_catch_annual <- reef_catch_annual %>%
  mutate(
    reef_catch_adjusted_mt      = reef_catch_mt * 1.25,
    reef_catch_lower_mt         = reef_catch_mt * 1.20,   # lower bound
    reef_catch_upper_mt         = reef_catch_mt * 1.40    # upper bound
  )
```

### Step 5 — Derive implied average ex-vessel price per species group

For each year and species group where catch_mt > 0:

```r
price_kes_per_kg <- (value_kes_000 * 1000) / (catch_mt * 1000)
              # = value_kes_000 / catch_mt
```

Check for implausible values: price < 10 KES/kg or > 5,000 KES/kg should be investigated and flagged.

### Step 6 — Calculate reef-attributed gross revenue

```r
reef_revenue_kes_000 <- value_kes_000 * (reef_attribution_pct / 100)
```

Sum to annual totals:

```r
reef_revenue_annual <- data %>%
  group_by(year) %>%
  summarise(reef_revenue_nominal_kes_000 = sum(reef_revenue_kes_000, na.rm = TRUE))
```

### Step 7 — Deflate to constant 2024 KES

Join the GDP deflator conversion factors from the skill (Section 2.3):

| year | deflator_to_2024 |
|------|-----------------|
| 2020 | 1.285 |
| 2021 | 1.211 |
| 2022 | 1.124 |
| 2023 | 1.045 |
| 2024 | 1.000 |

```r
reef_revenue_annual <- reef_revenue_annual %>%
  left_join(deflators, by = "year") %>%
  mutate(reef_revenue_real_2024_kes_000 = reef_revenue_nominal_kes_000 * deflator_to_2024)
```

### Step 8 — Convert to USD

Join the annual KES/USD exchange rates from the skill (Section 2.3):

| year | kes_per_usd |
|------|------------|
| 2020 | 106.45 |
| 2021 | 109.64 |
| 2022 | 117.87 |
| 2023 | 139.85 |
| 2024 | 134.82 |

Convert constant 2024 KES to USD at the 2024 rate (134.82) for all years, to produce a consistent USD series in constant 2024 prices:

```r
reef_revenue_annual <- reef_revenue_annual %>%
  mutate(reef_revenue_real_2024_usd = reef_revenue_real_2024_kes_000 * 1000 / 134.82)
```

Note: the 2024 exchange rate is used for all years when converting from constant 2024 KES to USD, because the real KES series has already removed inflation. This is the correct approach for SEEA EA constant-price accounts.

### Step 9 — Calculate resource rent (Tier 1)

Apply three cost-to-revenue scenarios based on WIO artisanal fisheries literature (Munga et al. 2014; Mills et al. 2011; Cinner et al. 2009). See skill Section 5.3 for sources.

```r
reef_revenue_annual <- reef_revenue_annual %>%
  mutate(
    resource_rent_central_usd = reef_revenue_real_2024_usd * (1 - 0.62),
    resource_rent_lower_usd   = reef_revenue_real_2024_usd * (1 - 0.70),
    resource_rent_upper_usd   = reef_revenue_real_2024_usd * (1 - 0.55)
  )
```

Label these: central = 38% margin; lower = 30% margin; upper = 45% margin.

### Step 10 — Export outputs

Write two CSVs to `03_outputs/`:

**File 1: `fisheries_supply_physical.csv`**

Columns: `year | total_county_catch_mt | reef_catch_mt | reef_fraction_pct | reef_catch_adjusted_mt | reef_catch_lower_mt | reef_catch_upper_mt | attribution_status`

**File 2: `fisheries_supply_monetary.csv`**

Columns: `year | reef_revenue_nominal_kes_000 | reef_revenue_real_2024_kes_000 | reef_revenue_real_2024_usd | resource_rent_central_usd | resource_rent_lower_usd | resource_rent_upper_usd | notes`

Also write the attribution lookup used:

**File 3: `fisheries_attribution_table.csv`**

Columns: `species_group | reef_attribution_pct | confidence | habitat_class | notes`

---

## R Script Location

Write the analysis to `02_analysis/fisheries_provisioning.R`. Use the same header convention as `02_analysis/coral_reef_condition.R`:

```r
# =============================================================================
# Wild Fish Provisioning Service — Resource Rent Calculation
# Kenya SEEA EA Accounts | Kilifi County | Photic Coral Reefs (M1.3)
#
# Input:   01_inputs/raw_data/fisheries/Fisheries Data.xlsx
# Output:  03_outputs/fisheries_supply_physical.csv
#          03_outputs/fisheries_supply_monetary.csv
#          03_outputs/fisheries_attribution_table.csv
#
# Skill:   docs/skills/skill_services_provisioning_wildfish_kenya.md
# Tier:    1 (literature cost ratios); Tier 2 pending fisher cost survey
# =============================================================================
```

Use `here()` for all file paths. Use `readxl::read_excel()` with explicit `sheet =` argument for each annual KeFS sheet. Include `library(writexl)` or `readr::write_csv()` for outputs.

---

## Sensitivity Analysis

After generating the central estimate, produce a sensitivity table varying two key assumptions independently:

| Parameter | Low | Central | High |
|---|---|---|---|
| Reef attribution fraction | 30% of county catch | 40% | 55% |
| Cost-to-revenue ratio | 55% | 62% | 70% |

This yields a 3×3 grid of resource rent estimates. Report as a range rather than a single point value in all account outputs and in the policy brief.

---

## Outputs to Review

After running the script, check:

1. Does the reef-attributed fraction (%) vary across years? It should be approximately stable unless the species mix changed substantially — large year-on-year swings may indicate data quality issues in the KeFS sheets
2. Does real (constant-price) revenue growth differ from nominal growth? The 172% nominal growth in catch value (2020-2024) likely reflects both increased catch and inflation; real growth should be lower
3. Are any species groups unmatched in the attribution join? If so, they are assigned 0% and need manual review
4. Is the implied ex-vessel price for high-value groups (Snapper, Grouper) plausible? Snapper: expect 400-1,000 KES/kg; Surgeon fish: expect 100-300 KES/kg — outliers indicate data entry errors in KeFS

---

## Blocking Issues

The following must be resolved before outputs are considered final:

1. **Attribution table validation** — Send the habitat attribution table (skill Section 3.2) to Dr. Pascal Thoya for expert review. Until validated, label all outputs PROVISIONAL.
2. **2023 data status** — Confirm whether the asterisked 2023 estimates have been updated to final values in any more recent KeFS publication. If still estimates, include a note in the CSV `notes` column and exclude 2023 from the trend calculation.
3. **Extent account** — The per-ha supply metric (kg/ha/yr) cannot be calculated until the reef extent account is complete. Leave this column blank in the output CSV with a note: "PENDING reef extent (ha) from extent account."

---

## Tier 2 Upgrade Path

This prompt produces a Tier 1 estimate only. To upgrade to Tier 2:

1. Administer the fisher cost survey (30-50 interviews at Kilifi landing sites) — see `docs/data_request_provisioning_service.md` items 3-9
2. Replace the literature cost ratio (62% central) with domestically collected cost breakdown (labour, fuel, capital, maintenance, ice)
3. Rerun Steps 9-10 substituting empirical cost structure for literature ratios
4. Reduce sensitivity range proportionally; document Tier 2 in the account metadata

The Tier 2 R script can be written as a modular extension to `fisheries_provisioning.R` — add a conditional block that loads a `fisher_costs.csv` input file when available and substitutes it for the literature cost parameters.

---

*Created: 2026-03-16*
*Skill reference: `docs/skills/skill_services_provisioning_wildfish_kenya.md`*
*Related data docs: `docs/data_request_provisioning_service.md` | `docs/search_plan_open_access_provisioning.md`*
