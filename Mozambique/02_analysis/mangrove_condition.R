# =============================================================================
# Project:  AFRICA - accounts | Mozambique Mangrove SEEA EA Condition Account
# Script:   mangrove_condition.R
# Date:     2026-03-28
# Author:   Generated for Mozambique pilot
# Purpose:  Process NASA GEDI LiDAR metrics for mangrove ecosystem condition
#           accounts under the UN SEEA EA framework (MFT1.2).
#           Produces normalised condition indices (0-1) for four biophysical
#           indicators and a composite condition index, plus a carbon account.
#
# Inputs (Mozambique/01_inputs/raw_data/archive/):
#   - morrumbene_by_asset.csv                        3 rows, one per Morrumbene asset (Shape_Area in sq deg)
#   - Morrumbene_mangrove_area_condition_stats.csv   1 row, Morrumbene site aggregate (Area_ha pre-computed)
#   - Save_mangrove_assets_condition_stats.csv       8 rows, one per Save Estuary asset (area_ha pre-computed)
#   - Save_mangrove_area_condition_stats.csv         1 row, Save Estuary site aggregate (area_ha pre-computed)
#
# Outputs (Mozambique/03_outputs/):
#   - mangrove_condition_by_asset.csv       All assets: CI indicators + area
#   - mangrove_condition_by_site.csv        Site-level area-weighted mean CI
#   - mangrove_carbon_account.csv           Per-asset carbon stock (Mg C, CO2 eq)
#   - mangrove_seea_condition_account.csv   SEEA EA standard format table
#
# Framework:  UN SEEA EA Ecosystem Condition Accounts
# Ecosystem:  Mangrove Forests (MFT1.2)
# Sites:      Save Estuary (8 assets), Morrumbene (3 assets)
# Data:       NASA GEDI L2A, L2B, L4A v2
# =============================================================================


# -----------------------------------------------------------------------------
# 1. Libraries
# -----------------------------------------------------------------------------

library(tidyverse)
library(here)


# -----------------------------------------------------------------------------
# 2. Reference levels for normalisation
#    Formula: (value - poor) / (pristine - poor), clamped to [0, 1]
#    Sources and confidence documented per indicator.
# -----------------------------------------------------------------------------

ref_levels <- tibble(
  indicator    = c("mean_rh100",      "mean_L2B_cover", "mean_L4A_agbd",   "mean_L2B_pai"),
  ci_col       = c("ci_canopy_height", "ci_canopy_cover", "ci_agbd",         "ci_pai"),
  poor         = c(3.0,               0.30,              5.0,               0.05),
  pristine     = c(15.0,              0.70,              100.0,             2.0),
  unit         = c("m",               "fraction",        "Mg/ha",           "m2/m2"),
  confidence   = c("HIGH",            "LOW",             "MEDIUM",          "LOW"),
  source       = c(
    "Fatoyinbo et al. 2008; Lagomasino et al. 2015",
    "Expert estimate (provisional)",
    "Godoy & De Lacerda 2015 (provisional)",
    "Expert estimate (provisional)"
  )
)

# Accounting year (SEEA EA requires explicit year attribution)
account_year <- 2025


# -----------------------------------------------------------------------------
# 3. Area source
#    All area values use ArcGIS UTM-projected polygon geometry (authoritative).
#    Save: area_ha pre-computed per asset in condition_stats CSV.
#    Morrumbene: site-level Area_ha from ArcGIS (1,068.76 ha); per-asset
#    areas allocated proportionally by Shape_Area share.
#    Do NOT use lat-corrected sq-degree conversion (11% overestimate vs UTM).
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# 4. Normalisation helper
#    Clamps output to [0, 1] using pmin / pmax to avoid out-of-range indices.
# -----------------------------------------------------------------------------

normalise_ci <- function(x, poor, pristine) {
  raw <- (x - poor) / (pristine - poor)
  pmin(pmax(raw, 0), 1)
}


# -----------------------------------------------------------------------------
# 5. GEDI confidence flag
#    HIGH  : Point_Count >= 20   (adequate GEDI footprint density)
#    MEDIUM: Point_Count 6-19
#    LOW   : Point_Count < 6     (sparse sampling; treat with caution)
# -----------------------------------------------------------------------------

gedi_confidence_flag <- function(point_count) {
  case_when(
    point_count >= 20 ~ "HIGH",
    point_count >= 6  ~ "MEDIUM",
    TRUE              ~ "LOW"
  )
}


# -----------------------------------------------------------------------------
# 6. Data ingestion
#    Read CSVs from archive folder; attach site label.
#    Save uses the new condition_stats CSV (8 assets, area_ha pre-computed).
#    Morrumbene uses the original by_asset CSV (3 assets, Shape_Area in sq deg).
#    Site aggregates use the new condition_stats CSVs for cross-check.
# -----------------------------------------------------------------------------

archive_dir <- here::here("Mozambique", "01_inputs", "raw_data", "archive")

read_csv_safe <- function(path, description) {
  tryCatch(
    read_csv(path, show_col_types = FALSE),
    error = function(e) {
      stop(sprintf("Failed to read %s (%s): %s", description, path, e$message))
    }
  )
}

# Asset-level: Morrumbene (3 assets)
# No per-asset area_ha CSV; allocate ArcGIS site total
# proportionally by Shape_Area share.
morrumbene_assets <- read_csv_safe(
  file.path(archive_dir, "morrumbene_by_asset.csv"),
  "Morrumbene by-asset file"
)

# Asset-level: Save Estuary (8 assets, area_ha pre-computed from ArcGIS)
save_assets <- read_csv_safe(
  file.path(archive_dir, "Save_mangrove_assets_condition_stats.csv"),
  "Save Estuary assets condition stats"
) |>
  mutate(site = "Save")

# Site-aggregate files (cross-check only, not used for CI calculation)
morrumbene_agg <- read_csv_safe(
  file.path(archive_dir, "Morrumbene_mangrove_area_condition_stats.csv"),
  "Morrumbene site-aggregate file"
) |> mutate(site = "Morrumbene")

save_agg <- read_csv_safe(
  file.path(archive_dir, "Save_mangrove_area_condition_stats.csv"),
  "Save Estuary site-aggregate file"
) |> mutate(site = "Save")

# Allocate Morrumbene ArcGIS site total to assets by Shape_Area share
morrumbene_assets <- morrumbene_assets |>
  mutate(
    site    = "Morrumbene",
    area_ha = Shape_Area / sum(Shape_Area) * morrumbene_agg$Area_ha
  )

# Combine all asset rows — standardise column names first
morrumbene_assets <- morrumbene_assets |>
  select(site, Asset_ID, area_ha,
         mean_rh100, mean_L4A_agbd, mean_L4A_agbd_se,
         mean_L2B_cover, mean_L2B_pai, mean_L4A_carbono_mgha,
         Point_Count)

save_assets <- save_assets |>
  select(site, Asset_ID, area_ha,
         mean_rh100, mean_L4A_agbd, mean_L4A_agbd_se,
         mean_L2B_cover, mean_L2B_pai, mean_L4A_carbono_mgha,
         Point_Count)

all_assets <- bind_rows(morrumbene_assets, save_assets)

cat("Assets loaded:", nrow(all_assets), "rows\n")
cat("  Morrumbene:", sum(all_assets$site == "Morrumbene"), "assets\n")
cat("  Save Estuary:", sum(all_assets$site == "Save"), "assets\n\n")

# Cross-check: asset areas vs site aggregates
morr_check <- abs(sum(morrumbene_assets$area_ha) - morrumbene_agg$Area_ha)
save_check <- abs(sum(save_assets$area_ha) - save_agg$area_ha)
cat("Area cross-check (asset sum vs site aggregate):\n")
cat("  Morrumbene diff:", round(morr_check, 2), "ha\n")
cat("  Save diff:      ", round(save_check, 2), "ha\n\n")


# -----------------------------------------------------------------------------
# 7. Area summary
#    area_ha was set during ingestion (converted for Morrumbene, pre-computed
#    for Save). No further conversion needed.
# -----------------------------------------------------------------------------

cat("Total mapped area:", round(sum(all_assets$area_ha), 1), "ha\n")
cat("  Morrumbene:", round(sum(all_assets$area_ha[all_assets$site == "Morrumbene"]), 1), "ha\n")
cat("  Save:      ", round(sum(all_assets$area_ha[all_assets$site == "Save"]), 1), "ha\n\n")


# -----------------------------------------------------------------------------
# 8. Apply normalisation to all four condition indicators
#    Reference levels drawn from the ref_levels tibble defined above.
# -----------------------------------------------------------------------------

# Extract individual reference rows for readability
ref_height <- ref_levels |> filter(indicator == "mean_rh100")
ref_cover  <- ref_levels |> filter(indicator == "mean_L2B_cover")
ref_agbd   <- ref_levels |> filter(indicator == "mean_L4A_agbd")
ref_pai    <- ref_levels |> filter(indicator == "mean_L2B_pai")

all_assets <- all_assets |>
  mutate(
    # Canopy height CI (HIGH confidence; Fatoyinbo et al. 2008)
    ci_canopy_height = normalise_ci(mean_rh100, ref_height$poor, ref_height$pristine),

    # Canopy cover CI (LOW confidence; provisional expert estimate)
    ci_canopy_cover  = normalise_ci(mean_L2B_cover, ref_cover$poor, ref_cover$pristine),

    # Above-ground biomass density CI (MEDIUM confidence; Godoy & De Lacerda 2015)
    ci_agbd          = normalise_ci(mean_L4A_agbd, ref_agbd$poor, ref_agbd$pristine),

    # Plant Area Index CI (LOW confidence; provisional expert estimate)
    ci_pai           = normalise_ci(mean_L2B_pai, ref_pai$poor, ref_pai$pristine)
  )


# -----------------------------------------------------------------------------
# 9. Composite condition index
#    Equal-weight mean of four normalised indicators.
#    All inputs are already clamped to [0, 1]; average will also be in [0, 1].
# -----------------------------------------------------------------------------

all_assets <- all_assets |>
  mutate(
    condition_index_composite = (ci_canopy_height + ci_canopy_cover + ci_agbd + ci_pai) / 4
  )


# -----------------------------------------------------------------------------
# 10. GEDI confidence flag (based on Point_Count per asset)
# -----------------------------------------------------------------------------

all_assets <- all_assets |>
  mutate(gedi_confidence = gedi_confidence_flag(Point_Count))


# -----------------------------------------------------------------------------
# 11. Output 1: Condition by asset
#     Retains all raw GEDI columns plus derived fields.
# -----------------------------------------------------------------------------

condition_by_asset <- all_assets |>
  select(
    site,
    asset_id         = Asset_ID,
    area_ha,
    # Raw GEDI indicators
    mean_rh100,
    mean_L4A_agbd,
    mean_L4A_agbd_se,
    mean_L2B_cover,
    mean_L2B_pai,
    mean_L4A_carbono_mgha,
    point_count      = Point_Count,
    # Normalised condition indicators
    ci_canopy_height,
    ci_canopy_cover,
    ci_agbd,
    ci_pai,
    # Composite and quality
    condition_index_composite,
    gedi_confidence
  )


# -----------------------------------------------------------------------------
# 12. Output 2: Condition by site (area-weighted mean)
#     Each indicator is weighted by the asset's area_ha share within the site.
# -----------------------------------------------------------------------------

condition_by_site <- condition_by_asset |>
  group_by(site) |>
  summarise(
    n_assets                  = n(),
    total_area_ha             = sum(area_ha),
    # Area-weighted means for raw indicators
    mean_rh100_wtd            = weighted.mean(mean_rh100,    area_ha, na.rm = TRUE),
    mean_agbd_wtd             = weighted.mean(mean_L4A_agbd, area_ha, na.rm = TRUE),
    mean_cover_wtd            = weighted.mean(mean_L2B_cover, area_ha, na.rm = TRUE),
    mean_pai_wtd              = weighted.mean(mean_L2B_pai,  area_ha, na.rm = TRUE),
    # Area-weighted means for condition indices
    ci_canopy_height_wtd      = weighted.mean(ci_canopy_height, area_ha, na.rm = TRUE),
    ci_canopy_cover_wtd       = weighted.mean(ci_canopy_cover,  area_ha, na.rm = TRUE),
    ci_agbd_wtd               = weighted.mean(ci_agbd,          area_ha, na.rm = TRUE),
    ci_pai_wtd                = weighted.mean(ci_pai,           area_ha, na.rm = TRUE),
    condition_index_composite_wtd = weighted.mean(condition_index_composite, area_ha, na.rm = TRUE),
    .groups = "drop"
  )


# -----------------------------------------------------------------------------
# 13. Output 3: Carbon account
#     Carbon stock is NOT normalised (not a condition index; belongs in
#     carbon account). Reports total Mg C and CO2 equivalent per asset.
#     CO2 factor: 3.664 (molecular weight ratio CO2/C = 44/12)
# -----------------------------------------------------------------------------

co2_factor <- 3.664   # Mg CO2 per Mg C

carbon_account <- all_assets |>
  mutate(
    # Total carbon stock for the asset polygon
    carbon_stock_mgc_total   = mean_L4A_carbono_mgha * area_ha,
    # CO2 equivalent
    carbon_stock_mgco2_total = carbon_stock_mgc_total * co2_factor
  ) |>
  select(
    site,
    asset_id                 = Asset_ID,
    area_ha,
    carbon_density_mgc_ha    = mean_L4A_carbono_mgha,
    carbon_stock_mgc_total,
    carbon_stock_mgco2_total,
    point_count              = Point_Count,
    gedi_confidence
  )


# -----------------------------------------------------------------------------
# 14. Output 4: SEEA EA condition account (standard format)
#     One row per accounting asset; columns follow SEEA EA table structure.
# -----------------------------------------------------------------------------

seea_condition_account <- condition_by_asset |>
  mutate(
    ecosystem_type = "Mangrove Forests (MFT1.2)",
    year           = account_year
  ) |>
  select(
    ecosystem_type,
    site,
    asset_id,
    area_ha,
    ci_canopy_height,
    ci_canopy_cover,
    ci_agbd,
    ci_pai,
    condition_index_composite,
    gedi_confidence,
    year
  )


# -----------------------------------------------------------------------------
# 15. Write outputs
#     Per-estuary results go into site subfolders (Save/, Morrumbene/).
#     Combined totals stay at the 03_outputs/ top level.
# -----------------------------------------------------------------------------

out_dir  <- here::here("Mozambique", "03_outputs")
save_dir <- file.path(out_dir, "Save")
morr_dir <- file.path(out_dir, "Morrumbene")
dir.create(save_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(morr_dir, showWarnings = FALSE, recursive = TRUE)

# --- Per-estuary: Save ---
write_csv(
  condition_by_asset |> filter(site == "Save"),
  file.path(save_dir, "Save_mangrove_condition_by_asset.csv")
)
write_csv(
  condition_by_site |> filter(site == "Save"),
  file.path(save_dir, "Save_mangrove_condition_by_site.csv")
)
write_csv(
  carbon_account |> filter(site == "Save"),
  file.path(save_dir, "Save_mangrove_carbon_account.csv")
)
write_csv(
  seea_condition_account |> filter(site == "Save"),
  file.path(save_dir, "Save_mangrove_seea_condition_account.csv")
)
cat("Written: Save/ (4 files)\n")

# --- Per-estuary: Morrumbene ---
write_csv(
  condition_by_asset |> filter(site == "Morrumbene"),
  file.path(morr_dir, "Morrumbene_mangrove_condition_by_asset.csv")
)
write_csv(
  condition_by_site |> filter(site == "Morrumbene"),
  file.path(morr_dir, "Morrumbene_mangrove_condition_by_site.csv")
)
write_csv(
  carbon_account |> filter(site == "Morrumbene"),
  file.path(morr_dir, "Morrumbene_mangrove_carbon_account.csv")
)
write_csv(
  seea_condition_account |> filter(site == "Morrumbene"),
  file.path(morr_dir, "Morrumbene_mangrove_seea_condition_account.csv")
)
cat("Written: Morrumbene/ (4 files)\n")

# --- Combined totals (top level) ---
write_csv(
  condition_by_asset,
  file.path(out_dir, "MOZ_mangrove_condition_by_asset.csv")
)
write_csv(
  condition_by_site,
  file.path(out_dir, "MOZ_mangrove_condition_by_site.csv")
)
write_csv(
  carbon_account,
  file.path(out_dir, "MOZ_mangrove_carbon_account.csv")
)
write_csv(
  seea_condition_account,
  file.path(out_dir, "MOZ_mangrove_seea_condition_account.csv")
)
cat("Written: 03_outputs/ (4 combined files)\n\n")


# -----------------------------------------------------------------------------
# 16. Console summary
# -----------------------------------------------------------------------------

cat("=============================================================\n")
cat("MOZAMBIQUE MANGROVE CONDITION ACCOUNT -- SUMMARY\n")
cat("=============================================================\n\n")

cat("Assets processed:", nrow(seea_condition_account), "\n")
cat("Total mapped area:", round(sum(condition_by_asset$area_ha), 1), "ha\n\n")

cat("--- Condition index by site (area-weighted composite) ---\n")
condition_by_site |>
  select(site, total_area_ha, condition_index_composite_wtd) |>
  mutate(
    total_area_ha                 = round(total_area_ha, 1),
    condition_index_composite_wtd = round(condition_index_composite_wtd, 3)
  ) |>
  print()

cat("\n--- Carbon stock ---\n")
carbon_totals <- carbon_account |>
  group_by(site) |>
  summarise(
    total_carbon_mgc   = round(sum(carbon_stock_mgc_total, na.rm = TRUE), 1),
    total_carbon_mgco2 = round(sum(carbon_stock_mgco2_total, na.rm = TRUE), 1)
  )
print(carbon_totals)

cat("\n--- GEDI confidence distribution ---\n")
print(table(condition_by_asset$gedi_confidence))

cat("\n--- Reference levels used (CI normalisation) ---\n")
ref_levels |>
  select(indicator, poor, pristine, unit, confidence) |>
  print()

cat("\n=============================================================\n")
cat("NOTE: Canopy cover and PAI reference levels are provisional\n")
cat("(LOW confidence). See ref_levels tibble in this script for\n")
cat("sources and confidence ratings.\n")
cat("Carbon account columns report raw values; do not normalise.\n")
cat("=============================================================\n")
