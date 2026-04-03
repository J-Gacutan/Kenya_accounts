# =============================================================================
# Project:  AFRICA - accounts | Mozambique
# Script:   check_areas.R
# Date:     2026-03-28
# Purpose:  Cross-check mangrove area totals between site-aggregate CSVs,
#           asset-level CSVs, and shapefile-derived condition stats from the
#           archive folder. Confirms that asset areas sum to reported totals.
#
# Inputs (Mozambique/01_inputs/raw_data/archive/):
#   - Morrumbene_mangrove_area_condition_stats.csv   Site-level (1 row)
#   - Save_mangrove_area_condition_stats.csv         Site-level (1 row)
#   - Save_mangrove_assets_condition_stats.csv       Asset-level (8 rows)
#   - morrumbene_by_asset.csv                        Asset-level (3 rows)
#   - morrumbene_all_mangroves.csv                   Site aggregate (1 row)
#   - save_estuary_by_asset.csv                      Asset-level (7 rows)
#   - save_estuary_all_mangroves.csv                 Site aggregate (1 row)
# =============================================================================

library(tidyverse)
library(here)

archive <- here::here("Mozambique", "01_inputs", "raw_data", "archive")

# -----------------------------------------------------------------------------
# 1. Read shapefile-derived condition stats (from ArcGIS export)
# -----------------------------------------------------------------------------

morr_area_stats <- read_csv(file.path(archive, "Morrumbene_mangrove_area_condition_stats.csv"),
                            show_col_types = FALSE)
save_area_stats <- read_csv(file.path(archive, "Save_mangrove_area_condition_stats.csv"),
                            show_col_types = FALSE)
save_asset_stats <- read_csv(file.path(archive, "Save_mangrove_assets_condition_stats.csv"),
                             show_col_types = FALSE)

# -----------------------------------------------------------------------------
# 2. Read the CSVs used by mangrove_condition.R
# -----------------------------------------------------------------------------

morr_by_asset <- read_csv(file.path(archive, "morrumbene_by_asset.csv"),
                          show_col_types = FALSE)
morr_all      <- read_csv(file.path(archive, "morrumbene_all_mangroves.csv"),
                          show_col_types = FALSE)
save_by_asset <- read_csv(file.path(archive, "save_estuary_by_asset.csv"),
                          show_col_types = FALSE)
save_all      <- read_csv(file.path(archive, "save_estuary_all_mangroves.csv"),
                          show_col_types = FALSE)

# -----------------------------------------------------------------------------
# 3. Area checks
# -----------------------------------------------------------------------------

cat("=============================================================\n")
cat("AREA CROSS-CHECK: Morrumbene & Save Estuary\n")
cat("=============================================================\n\n")

# --- Morrumbene ---
cat("--- MORRUMBENE ---\n")
cat("  Site-level reported area (area_condition_stats):", morr_area_stats$Area_ha, "ha\n")
cat("  Site-level reported area (all_mangroves CSV):   ", morr_all$Shape_Area, "sq deg\n")

# Sum assets from morrumbene_by_asset.csv (Shape_Area in sq degrees)
morr_asset_area_sqdeg <- sum(morr_by_asset$Shape_Area)
cat("  Sum of asset Shape_Area (by_asset CSV):         ", morr_asset_area_sqdeg, "sq deg\n")
cat("  Site aggregate Shape_Area:                      ", morr_all$Shape_Area, "sq deg\n")
cat("  Difference (assets - aggregate):                ",
    round(morr_asset_area_sqdeg - morr_all$Shape_Area, 10), "sq deg\n")

# Convert sq degrees to ha for comparison with Area_ha
# Mozambique ~23.5 deg S for Morrumbene
lat_morr <- -23.5
area_factor_morr <- (111000 * cos(lat_morr * pi / 180) * 111000) / 10000
morr_asset_ha <- morr_asset_area_sqdeg * area_factor_morr
morr_agg_ha   <- morr_all$Shape_Area * area_factor_morr

cat("\n  Converted areas (using lat =", lat_morr, "deg):\n")
cat("    Assets sum:     ", round(morr_asset_ha, 2), "ha\n")
cat("    Site aggregate: ", round(morr_agg_ha, 2), "ha\n")
cat("    Reported Area_ha:", morr_area_stats$Area_ha, "ha\n")
cat("    Match (assets vs reported):",
    ifelse(abs(morr_asset_ha - morr_area_stats$Area_ha) < 1, "YES (< 1 ha)", "NO -- CHECK"), "\n")

# --- Save Estuary ---
cat("\n--- SAVE ESTUARY ---\n")
cat("  Site-level reported area (area_condition_stats):", save_area_stats$area_ha, "ha\n")
cat("  Site-level reported area (all_mangroves CSV):   ", save_all$Shape_Area, "sq deg\n")

# Sum assets from save_estuary_by_asset.csv
save_asset_area_sqdeg <- sum(save_by_asset$Shape_Area)
cat("  Sum of asset Shape_Area (by_asset CSV):         ", save_asset_area_sqdeg, "sq deg\n")
cat("  Site aggregate Shape_Area:                      ", save_all$Shape_Area, "sq deg\n")
cat("  Difference (assets - aggregate):                ",
    round(save_asset_area_sqdeg - save_all$Shape_Area, 10), "sq deg\n")

# Save Estuary ~23.7 deg S
lat_save <- -23.7
area_factor_save <- (111000 * cos(lat_save * pi / 180) * 111000) / 10000
save_asset_ha <- save_asset_area_sqdeg * area_factor_save
save_agg_ha   <- save_all$Shape_Area * area_factor_save

cat("\n  Converted areas (using lat =", lat_save, "deg):\n")
cat("    Assets sum:     ", round(save_asset_ha, 2), "ha\n")
cat("    Site aggregate: ", round(save_agg_ha, 2), "ha\n")
cat("    Reported area_ha:", save_area_stats$area_ha, "ha\n")
cat("    Match (assets vs reported):",
    ifelse(abs(save_asset_ha - save_area_stats$area_ha) < 1, "YES (< 1 ha)", "NO -- CHECK"), "\n")

# --- Save asset-level check (stats file has 8 rows with area_ha) ---
cat("\n--- SAVE ASSET-LEVEL DETAIL (condition_stats) ---\n")
cat("  Assets in stats file:", nrow(save_asset_stats), "\n")
cat("  Sum of area_ha from stats:", round(sum(save_asset_stats$area_ha), 2), "ha\n")
cat("  Reported site total:      ", save_area_stats$area_ha, "ha\n")
cat("  Difference:               ",
    round(sum(save_asset_stats$area_ha) - save_area_stats$area_ha, 2), "ha\n")

# --- Combined ---
cat("\n--- COMBINED ---\n")
cat("  Morrumbene:", morr_area_stats$Area_ha, "ha\n")
cat("  Save:      ", save_area_stats$area_ha, "ha\n")
cat("  Total:     ", round(morr_area_stats$Area_ha + save_area_stats$area_ha, 2), "ha\n")

# --- GEDI Point counts ---
cat("\n--- GEDI POINT COUNTS ---\n")
cat("  Morrumbene (site):         ", morr_area_stats$Point_Count, "points\n")
cat("  Morrumbene (sum of assets):", sum(morr_by_asset$Point_Count), "points\n")
cat("  Save (site):               ", save_area_stats$Point_Count, "points\n")
cat("  Save (sum of assets):      ", sum(save_by_asset$Point_Count), "points\n")
cat("  Save (stats file sum):     ", sum(save_asset_stats$Point_Count), "points\n")

cat("\n=============================================================\n")
cat("DONE\n")
cat("=============================================================\n")
