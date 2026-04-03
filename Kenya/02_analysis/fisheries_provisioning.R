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
# Prompt:  docs/ecosystem_services/PROMPT_provisioning_wildfish_resource_rent.md
# Tier:    1 (literature cost ratios); Tier 2 pending fisher cost survey
# =============================================================================

library(here)
library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(readr)

# =============================================================================
# 0. CONFIG
# =============================================================================

RAW_DIR <- here("Kenya", "01_inputs", "raw_data", "fisheries")
OUT_DIR <- here("Kenya", "03_outputs")

F_KEFS  <- file.path(RAW_DIR, "Fisheries Data.xlsx")

# Economic parameters — confirmed from World Bank WDI API (2026-03-16)
# See docs/search_plan_open_access_provisioning.md Searches 1-2

EXCHANGE_RATES <- tibble(
  year        = c(2020, 2021, 2022, 2023, 2024),
  kes_per_usd = c(106.45, 109.64, 117.87, 139.85, 134.82)
)

GDP_DEFLATORS <- tibble(
  year              = c(2020, 2021, 2022, 2023, 2024),
  deflator_to_2024  = c(1.285, 1.211, 1.124, 1.045, 1.000)
  # Multiply nominal KES by deflator_to_2024 to express in constant 2024 KES
  # Source: World Bank WDI FP.CPI.TOTL (base 2010=100), API retrieval 2026-03-16
  # 200.24 / 257.35 = 0.778 => invert => 1.285; etc.
)

# Resource rent: Tier 1 cost-to-revenue ratios from WIO artisanal fisheries literature
# Central: Munga et al. 2014 (Malindi-Kilifi, WIOJMS 13(1):57-70) — 60-70%
# Range:   Cinner et al. 2009 + Mills et al. 2011 — 50-70%
# VALIDATED 2026-03-28 (Phase 2 search plan):
#   UNEP-NC 2023 revenue-sharing model (1/3-1/3-1/3) => ~67% cost ratio
#   Degen et al. 2010: tajiri takes 20-50% of catch + maintenance costs
#   McClanahan & Kosgei 2025: gross USD 7.0/day vs net KES 400/day => ~56% implied
#   80% non-motorised fleet (sails 43%, paddles 40%) reduces fuel share to ~5%
#   Vessel ownership split: 48% self-owned, 30% rented (Nyawade 2021 Kwale)
#   See SEARCH_PLAN_Resource_Rent_Factors.md Phase 2 results for full evidence
COST_RATIO_CENTRAL <- 0.62
COST_RATIO_LOWER   <- 0.55   # lower cost => higher rent (optimistic)
COST_RATIO_UPPER   <- 0.70   # higher cost => lower rent (conservative)

# Unreported / subsistence catch adjustment (Tier 1)
# Published estimates for Kenya coastal: 20-40% above formal landings
# McClanahan & Mangi 2004; Samoilys et al. 2017
UNREPORTED_CENTRAL <- 0.30
UNREPORTED_LOWER   <- 0.20
UNREPORTED_UPPER   <- 0.40
# Revised 2026-03-28: central 25% -> 30%. Sea Around Us reconstruction
# (Le Manach et al. 2015; McAlpine & Zeller 2020): even in 2000s, ~50% of
# total Kenya catch unreported. 25% low for artisanal sector; 30% better
# calibrated for KeFS CAS-monitored landings. Range 20-40% unchanged.

# Reef attribution fractions — FishBase-verified for all 37 KeFS groups
# Full table in docs/skills/skill_services_provisioning_wildfish_kenya.md Section 3.2
# STATUS: PROVISIONAL — pending validation by Dr. Pascal Thoya
ATTRIBUTION_TABLE <- tribble(
  ~species_group,         ~reef_pct, ~confidence,    ~habitat_class,
  # All keys in Title Case to match str_to_title() output on KeFS data
  "Snapper",                  90,    "HIGH",          "Reef-associated",
  "Scavenger",                85,    "HIGH",          "Reef-associated",
  "Parrot Fish",              90,    "HIGH",          "Reef-associated",
  "Surgeon Fish",             85,    "HIGH",          "Reef-associated",
  "Unicorn Fish",             85,    "HIGH",          "Reef-associated",
  "Rabbit Fish",              80,    "HIGH",          "Reef-associated",
  "Rock Cod",                 90,    "HIGH",          "Reef-associated",
  "Goat Fish",                80,    "HIGH",          "Reef-associated",
  "Grunter",                  80,    "HIGH",          "Reef-associated",
  "Barracudas",               70,    "MEDIUM",        "Reef-associated",
  "Milk Fish",                20,    "MEDIUM",        "Coastal-pelagic/lagoon",
  # Revised 2026-03-28: Chanos chanos is coastal-pelagic/lagoon, not reef-associated.
  # FishBase + FAO species profile: adults inhabit lagoons, estuaries, mangrove areas.
  # Spawning occurs near reefs but feeding/residence is soft-bottom habitat.
  # Previous 60% significantly overstated reef dependency. Range 10-30%.
  "Cavalla Jacks",            45,    "MEDIUM",        "Mixed reef/pelagic",
  # Revised 2026-03-16: C. melampygus reef-obligate (70-80%); C. sexfasciatus benthopelagic (40-50%)
  # Onyango et al. 2020 (OCM 184:105032): Kilifi category ~60% Scomberoides/pelagic + 40% Caranx
  # => blended ~45%. Source: Searches 3-4; FishBase (Froese & Pauly 2024)
  "Lobsters",                 90,    "HIGH",          "Reef-associated",
  "Beche-De-Mer",             70,    "MEDIUM",        "Reef-associated/sandy",
  "Octopus",                  80,    "HIGH",          "Reef-associated",
  "Squids",                   50,    "MEDIUM",        "Reef-associated (spawn)",
  "Cowries/Shells",           70,    "MEDIUM",        "Reef-associated",
  "Pouter",                   70,    "MEDIUM",        "Reef-associated",
  # Confidence raised 2026-03-16: Plectorhinchus spp. (typical Pouter at East Africa reef sites)
  # are reef-associated per FishBase; Pomadasys spp. (non-reef) minor component at reef-adjacent sites.
  # If Kilifi Pouter is Pomadasys-dominated (estuarine sites), re-evaluate.
  "Black Skin",               90,    "HIGH",          "Reef-associated (Acanthuridae)",
  # Revised 2026-03-16: A. leucosternon, A. nigricans, Ctenochaetus striatus, Naso brevirostris
  # are all obligate coral reef herbivores per FishBase. Search 7 (2026-03-16).
  "Mixed Demersal",           50,    "MEDIUM",        "Mixed reef/seagrass",
  # Revised 2026-03-16: McClanahan & Mangi 2004 (trap-caught demersal 55-65% reef);
  # Hicks & McClanahan 2012 (PLOS ONE 7(5):e36022): reef-assoc ~50-55% of mixed demersal catch
  # Samoilys et al. 2007 (BC 137:201): seagrass fraction (Siganidae+Sillaginidae) ~25-35%
  # Central estimate 50%; uncertainty range 40-60%. Confidence raised LOW -> MEDIUM.
  "King Fish",                10,    "MEDIUM",        "Pelagic-neritic",
  "Queen Fish",                5,    "MEDIUM",        "Pelagic-neritic",
  "Streaker",                  5,    "MEDIUM",        "Pelagic-neritic",
  "Cat Fish",                  0,    "HIGH",          "Demersal/estuarine",
  "Prawns",                    0,    "HIGH",          "Demersal/estuarine",
  "Crabs",                     0,    "HIGH",          "Estuarine/seagrass",
  "Oysters",                   0,    "HIGH",          "Intertidal/mangrove",
  "Mullets",                   0,    "HIGH",          "Benthopelagic/estuarine",
  "Little Mackerels",          0,    "HIGH",          "Pelagic-neritic",
  "Bonitos/Tunas",             0,    "HIGH",          "Pelagic-oceanic",
  "Sail Fish",                 0,    "HIGH",          "Pelagic-oceanic",
  "Dolphins",                  0,    "HIGH",          "Pelagic-oceanic",
  "Sardines",                  0,    "HIGH",          "Pelagic-neritic",
  "Sharks And Rays",          20,    "LOW",           "Mixed (coastal-inshore dominated)",
  # Revised 2026-03-16: C. limbatus dominates landings (coastal-inshore, NOT reef)
  # Himantura spp. rays = sandy/seagrass substrate; reef sharks (C. melanopterus) rare/depleted
  # Dulvy et al. 2021 (Science 373:1148); TRAFFIC Kenya shark trade reports 2012-2019
  # Gillnet gear set on inter-reef sandy substrate, not reef matrix. Range 10-30%.
  "Mixed Pelagic",             0,    "MEDIUM",        "Pelagic (mixed)",
  "Mixed Fish/Others",        40,    "LOW",           "Mixed (pro-rata allocation)"
  # Revised 2026-03-16: Siganidae (rabbitfish) and Balistidae (triggerfish) confirmed in
  # Kilifi UVC surveys — both reef-associated per FishBase. Raises floor estimate. Search 7.
)

# =============================================================================
# 1. READ KEFS DATA
# =============================================================================

# Helper: read a single annual sheet and tag with year
read_kefs_year <- function(path, yr) {
  df <- read_excel(path, sheet = as.character(yr), col_names = TRUE) %>%
    clean_kefs_names() %>%
    mutate(year = yr) %>%
    filter(!is.na(species_group), !is.na(catch_mt)) %>%
    filter(str_detect(species_group, regex("total", ignore_case = TRUE)) == FALSE)
  df
}

clean_kefs_names <- function(df) {
  # Rename to standard 3-column structure regardless of exact header text
  names(df) <- c("species_group", "catch_mt", "value_kes_000")[seq_len(min(3, ncol(df)))]
  df %>%
    mutate(
      catch_mt     = suppressWarnings(as.numeric(catch_mt)),
      value_kes_000 = suppressWarnings(as.numeric(value_kes_000))
    )
}

years <- 2020:2024
kefs_raw <- purrr::map_dfr(years, ~ read_kefs_year(F_KEFS, .x))

cat("KeFS raw rows read:", nrow(kefs_raw), "\n")
cat("Years present:", paste(sort(unique(kefs_raw$year)), collapse = ", "), "\n")

# =============================================================================
# 2. STANDARDISE SPECIES GROUP NAMES
# =============================================================================

NAME_FIXES <- c(
  # Spelling variants (after str_to_title() is already applied)
  "Scarvenger"              = "Scavenger",
  "Scavanger"               = "Scavenger",
  "Littla Mackerels"        = "Little Mackerels",
  "Littla Macker"           = "Little Mackerels",    # truncated in Excel
  "Steaker"                 = "Streaker",
  "Streaker/Steaker"        = "Streaker",
  "Dolphin Fish"            = "Dolphins",
  # Beche-de-mer variants
  "Beche-De-Mer"            = "Beche-De-Mer",         # keep canonical Title Case
  "Beche-De-Mers"           = "Beche-De-Mer",
  "Beche-De-Me"             = "Beche-De-Mer",          # truncated in Excel
  # Mixed categories
  "Mixed Demersal"          = "Mixed Demersal",        # already correct after title case
  "Mixed Dermasal"          = "Mixed Demersal",
  "Mixed Derma"             = "Mixed Demersal",
  "Mixed Pelagics"          = "Mixed Pelagic",
  "Mixed Fish/Others"       = "Mixed Fish/Others",
  # Sharks variants
  "Sharks &Rays"            = "Sharks And Rays",
  "Sharks &Ray"             = "Sharks And Rays",
  "Sharks & Rays"           = "Sharks And Rays",
  "Sharks And Ray"          = "Sharks And Rays",
  # Goat fish (Excel truncation check)
  "Goat Fishr"              = "Goat Fish",
  # Squid variants
  "Squids & Cuttlefish"     = "Squids",
  # Bonito variants
  "Bonitos/Tuna"            = "Bonitos/Tunas"
)

kefs <- kefs_raw %>%
  mutate(
    species_group = str_to_title(str_trim(species_group)),
    species_group = recode(species_group, !!!NAME_FIXES)
  )

# Report any groups that appear in fewer than 5 years (may indicate naming drift)
group_year_count <- kefs %>%
  distinct(species_group, year) %>%
  count(species_group, name = "n_years")

inconsistent_groups <- group_year_count %>% filter(n_years < 5)
if (nrow(inconsistent_groups) > 0) {
  cat("\nGroups appearing in fewer than all 5 years — check for naming inconsistencies:\n")
  print(inconsistent_groups)
}

# =============================================================================
# 3. JOIN HABITAT ATTRIBUTION
# =============================================================================

kefs_attr <- kefs %>%
  left_join(ATTRIBUTION_TABLE, by = "species_group") %>%
  mutate(
    reef_pct      = replace_na(reef_pct, 0),
    confidence    = replace_na(confidence, "UNMATCHED"),
    habitat_class = replace_na(habitat_class, "UNMATCHED — review required")
  )

# Flag unmatched groups
unmatched <- kefs_attr %>%
  filter(confidence == "UNMATCHED") %>%
  distinct(species_group)
if (nrow(unmatched) > 0) {
  cat("\nUnmatched species groups (assigned 0% reef attribution):\n")
  print(unmatched)
}

# =============================================================================
# 4. PHYSICAL SUPPLY — REEF-ATTRIBUTED CATCH
# =============================================================================

kefs_attr <- kefs_attr %>%
  mutate(
    reef_catch_mt   = catch_mt * reef_pct / 100,
    reef_value_k    = value_kes_000 * reef_pct / 100
  )

supply_physical <- kefs_attr %>%
  group_by(year) %>%
  summarise(
    total_county_catch_mt    = sum(catch_mt,   na.rm = TRUE),
    total_county_value_k     = sum(value_kes_000, na.rm = TRUE),
    reef_catch_mt            = sum(reef_catch_mt, na.rm = TRUE),
    reef_value_kes_000       = sum(reef_value_k,  na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    reef_fraction_pct          = reef_catch_mt / total_county_catch_mt * 100,
    # Unreported catch adjustment
    reef_catch_adjusted_mt     = reef_catch_mt * (1 + UNREPORTED_CENTRAL),
    reef_catch_lower_mt        = reef_catch_mt * (1 + UNREPORTED_LOWER),
    reef_catch_upper_mt        = reef_catch_mt * (1 + UNREPORTED_UPPER),
    attribution_status         = "PROVISIONAL — pending Dr. Pascal Thoya validation",
    yr2023_note                = if_else(year == 2023, "2023 values are estimates in KeFS source", NA_character_)
  )

cat("\n--- Physical Supply Summary ---\n")
supply_physical %>%
  select(year, total_county_catch_mt, reef_catch_mt, reef_fraction_pct, reef_catch_adjusted_mt) %>%
  print()

# =============================================================================
# 5. IMPLIED EX-VESSEL PRICE (CHECK)
# =============================================================================

# Plausibility check: implied price per species group (KES/kg)
implied_prices <- kefs_attr %>%
  filter(catch_mt > 0, value_kes_000 > 0) %>%
  mutate(
    price_kes_per_kg = (value_kes_000 * 1000) / (catch_mt * 1000),
    price_flag       = case_when(
      price_kes_per_kg < 10   ~ "FLAG: implausibly low",
      price_kes_per_kg > 5000 ~ "FLAG: implausibly high",
      TRUE                    ~ "OK"
    )
  )

flagged_prices <- implied_prices %>% filter(price_flag != "OK")
if (nrow(flagged_prices) > 0) {
  cat("\nImplausible implied prices — investigate before use:\n")
  print(flagged_prices %>% select(year, species_group, catch_mt, value_kes_000, price_kes_per_kg, price_flag))
}

# =============================================================================
# 6-8. MONETARY SUPPLY — DEFLATE AND CONVERT TO USD
# =============================================================================

supply_monetary <- supply_physical %>%
  left_join(GDP_DEFLATORS, by = "year") %>%
  left_join(EXCHANGE_RATES, by = "year") %>%
  mutate(
    # Step 6: nominal KES reef revenue
    reef_revenue_nominal_kes_000 = reef_value_kes_000,

    # Step 7: constant 2024 KES
    reef_revenue_real_2024_kes_000 = reef_revenue_nominal_kes_000 * deflator_to_2024,

    # Step 8: constant 2024 USD (use 2024 exchange rate for all years —
    # constant-price KES series is already inflation-adjusted)
    reef_revenue_real_2024_usd = reef_revenue_real_2024_kes_000 * 1000 / 134.82,

    # Step 9: resource rent (Tier 1)
    resource_rent_central_usd = reef_revenue_real_2024_usd * (1 - COST_RATIO_CENTRAL),
    resource_rent_lower_usd   = reef_revenue_real_2024_usd * (1 - COST_RATIO_UPPER),   # highest cost => lowest rent
    resource_rent_upper_usd   = reef_revenue_real_2024_usd * (1 - COST_RATIO_LOWER),   # lowest cost => highest rent

    notes = case_when(
      year == 2023 ~ "2023 KeFS values are estimates; treat with caution",
      TRUE         ~ "Provisional: attribution fraction pending Dr. Thoya validation"
    )
  )

cat("\n--- Monetary Supply Summary (constant 2024 USD) ---\n")
supply_monetary %>%
  select(year, reef_revenue_nominal_kes_000, reef_revenue_real_2024_usd,
         resource_rent_lower_usd, resource_rent_central_usd, resource_rent_upper_usd) %>%
  mutate(across(where(is.numeric), ~ round(.x, 0))) %>%
  print()

# =============================================================================
# 9. SENSITIVITY ANALYSIS — 3x3 GRID
# =============================================================================

# VALIDATED 2026-03-28: KeFS 2016 Table 8 Kilifi bottom-up reef attribution = 39.1%
# confirms central = 0.40. Bounds narrowed from 0.30-0.55 to 0.35-0.50 based on:
#   Lower: 39.1% minus seagrass-associated demersal overlap (conservative)
#   Upper: UNEP-NC 2023 national "demersal reef fish ~50% of coastal production"
#   KMFRI 2002 "90% from coral reefs" rejected as overestimate (includes reef-adjacent)
reef_fractions <- c(low = 0.35, central = 0.40, high = 0.50)
cost_ratios    <- c(low = 0.55, central = 0.62, high = 0.70)  # low cost => high rent

# Use 2024 as the reference year for the sensitivity grid
ref_2024_revenue_kes <- supply_monetary %>%
  filter(year == 2024) %>%
  pull(reef_revenue_nominal_kes_000)

total_2024_revenue_kes <- supply_monetary %>%
  filter(year == 2024) %>%
  pull(total_county_value_k)

# Revenue scales linearly with reef fraction assumption
sensitivity <- expand.grid(
  reef_fraction   = reef_fractions,
  cost_ratio      = cost_ratios
) %>%
  as_tibble() %>%
  mutate(
    reef_fraction_label  = names(reef_fractions)[match(reef_fraction, reef_fractions)],
    cost_ratio_label     = names(cost_ratios)[match(cost_ratio, cost_ratios)],
    gross_revenue_usd    = (total_2024_revenue_kes * reef_fraction * 1000 / 134.82),
    resource_rent_usd    = gross_revenue_usd * (1 - cost_ratio)
  ) %>%
  mutate(across(c(gross_revenue_usd, resource_rent_usd), ~ round(.x, 0)))

cat("\n--- Sensitivity Grid: Resource Rent (USD, 2024 reference year) ---\n")
sensitivity %>%
  select(reef_fraction_label, cost_ratio_label, gross_revenue_usd, resource_rent_usd) %>%
  tidyr::pivot_wider(names_from = cost_ratio_label, values_from = resource_rent_usd,
                     id_cols = reef_fraction_label) %>%
  print()

# =============================================================================
# 10. EXPORT OUTPUTS
# =============================================================================

# Physical supply table
write_csv(
  supply_physical %>%
    select(year, total_county_catch_mt, reef_catch_mt, reef_fraction_pct,
           reef_catch_adjusted_mt, reef_catch_lower_mt, reef_catch_upper_mt,
           attribution_status, yr2023_note),
  file.path(OUT_DIR, "KEN_fisheries_supply_physical.csv")
)

# Monetary supply table
write_csv(
  supply_monetary %>%
    select(year, reef_revenue_nominal_kes_000, deflator_to_2024,
           reef_revenue_real_2024_kes_000, reef_revenue_real_2024_usd,
           resource_rent_lower_usd, resource_rent_central_usd, resource_rent_upper_usd,
           notes),
  file.path(OUT_DIR, "KEN_fisheries_supply_monetary.csv")
)

# Attribution table (audit trail)
write_csv(
  ATTRIBUTION_TABLE %>%
    mutate(status = "PROVISIONAL — pending Dr. Pascal Thoya validation (2026-03-16)"),
  file.path(OUT_DIR, "KEN_fisheries_attribution_table.csv")
)

# Sensitivity grid
write_csv(
  sensitivity,
  file.path(OUT_DIR, "KEN_fisheries_sensitivity_resource_rent_2024.csv")
)

cat("\nOutputs written to Kenya/03_outputs/:\n")
cat("  KEN_fisheries_supply_physical.csv\n")
cat("  KEN_fisheries_supply_monetary.csv\n")
cat("  KEN_fisheries_attribution_table.csv\n")
cat("  fisheries_sensitivity_resource_rent_2024.csv\n")

cat("\n=============================================================================\n")
cat("TIER 1 COMPLETE.\n")
cat("ATTRIBUTION STATUS: PROVISIONAL — send fisheries_attribution_table.csv\n")
cat("  to Dr. Pascal Thoya (pascalthoya@gmail.com) for expert validation.\n")
cat("TIER 2 UPGRADE: run fisher cost survey (30-50 interviews at Kilifi landing\n")
cat("  sites); see docs/data_request_provisioning_service.md items 3-9.\n")
cat("=============================================================================\n")
