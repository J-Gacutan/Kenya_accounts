## Assemble final SEEA EA extent + condition account tables for Kenya
## Reads all individual outputs and produces standardized account CSVs

library(dplyr, warn.conflicts = FALSE)
library(tidyr, warn.conflicts = FALSE)

# Resolve working directory
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
} else {
  if (grepl("02_analysis$", getwd())) {
    # already correct
  } else {
    setwd(file.path(getwd(), "Kenya", "02_analysis"))
  }
}

out_dir <- "../03_outputs"

# =====================================================================
# PART A: FINAL EXTENT ACCOUNT (mangrove only; seagrass/reef TBD)
# =====================================================================

extent <- data.frame(
  Entry = c("Opening (2020)", "Additions", "Reductions", "Closing (2025)",
            "Net change", "Net change (%)"),
  Units = c("ha", "ha", "ha", "ha", "ha", "%"),
  Mangrove = c(6083.04, 589.10, -927.84, 5741.64, -341.40, -5.6),
  Seagrass = rep(NA_real_, 6),
  Coral_Reef = rep(NA_real_, 6),
  Totals = c(6083.04, 589.10, -927.84, 5741.64, -341.40, -5.6)
)

write.csv(extent, file.path(out_dir, "KEN_SEEA_EA_extent_account_final.csv"),
          row.names = FALSE, na = "--")
cat("Wrote KEN_SEEA_EA_extent_account_final.csv\n")

# =====================================================================
# PART B: FINAL CONDITION ACCOUNT
# =====================================================================

# --- Mangrove (single period 2025) ---
mng_pa <- read.csv(file.path(out_dir, "mangrove", "KEN_mangrove_condition_by_pa.csv"))
mng_composite <- weighted.mean(mng_pa$mean_ci_composite, mng_pa$n_sites)
mng_density   <- weighted.mean(mng_pa$mean_ci_stem_density, mng_pa$n_sites)
mng_dbh       <- weighted.mean(mng_pa$mean_ci_dbh, mng_pa$n_sites)
mng_height    <- weighted.mean(mng_pa$mean_ci_height, mng_pa$n_sites)
mng_cover     <- weighted.mean(mng_pa$mean_ci_cover, mng_pa$n_sites)
mng_quality   <- weighted.mean(mng_pa$mean_ci_quality, mng_pa$n_sites)

cat("\n=== MANGROVE CONDITION (2025) ===\n")
cat(sprintf("  Composite: %.3f\n", mng_composite))
cat(sprintf("  Stem density CI: %.3f\n", mng_density))
cat(sprintf("  Mean DBH CI: %.3f\n", mng_dbh))
cat(sprintf("  Mean height CI: %.3f\n", mng_height))
cat(sprintf("  Canopy cover CI: %.3f\n", mng_cover))
cat(sprintf("  Tree quality CI: %.3f\n", mng_quality))

# --- Seagrass (single period 2024) ---
sg <- read.csv(file.path(out_dir, "seagrass", "KEN_seea_condition_account_seagrass.csv"))
sg_comp  <- sg %>% filter(Indicator == "Composite condition index")
sg_cover <- sg %>% filter(Indicator == "Total seagrass cover")
sg_rich  <- sg %>% filter(Indicator == "Species richness")

sg_all_composite <- mean(sg_comp$CI_2024, na.rm = TRUE)
sg_all_cover     <- mean(sg_cover$CI_2024, na.rm = TRUE)
sg_all_rich      <- mean(sg_rich$CI_2024, na.rm = TRUE)

cat("\n=== SEAGRASS CONDITION (2024) ===\n")
cat(sprintf("  Composite: %.3f\n", sg_all_composite))
cat(sprintf("  Total cover CI: %.3f\n", sg_all_cover))
cat(sprintf("  Species richness CI: %.3f\n", sg_all_rich))

# --- Coral reef (two periods: Nov 2024 opening, Jul 2025 closing) ---
cr <- read.csv(file.path(out_dir, "accounts", "KEN_seea_condition_summary.csv"))
fish <- read.csv(file.path(out_dir, "KEN_fish_seea_rows.csv"))  # written to root by fish script

fish_agg <- fish %>%
  group_by(survey_period, condition_indicator) %>%
  summarise(mean_ci = mean(condition_index, na.rm = TRUE),
            n_sites = n(), .groups = "drop")

cat("\n=== CORAL REEF FISH CONDITION ===\n")
print(as.data.frame(fish_agg))
cat("\n=== CORAL REEF CORAL+INVERT CONDITION ===\n")
print(as.data.frame(cr))

# Helper to safely extract a single CI value
get_ci <- function(df, period, indicator) {
  val <- df$mean_ci[df$survey_period == period &
                      df$condition_indicator == indicator]
  if (length(val) == 0) return(NA_real_)
  val[1]
}
get_fish_ci <- function(df, period, indicator) {
  val <- df$mean_ci[df$survey_period == period &
                      df$condition_indicator == indicator]
  if (length(val) == 0) return(NA_real_)
  val[1]
}

# Extract individual CIs
nov_cover   <- get_ci(cr, "Nov_2024", "Live hard coral cover")
jul_cover   <- get_ci(cr, "Jul_2025", "Live hard coral cover")
nov_bleach  <- get_ci(cr, "Nov_2024", "Bleached coral colonies")
jul_bleach  <- get_ci(cr, "Jul_2025", "Bleached coral colonies")
nov_health  <- get_ci(cr, "Nov_2024", "Healthy coral colonies")
jul_health  <- get_ci(cr, "Jul_2025", "Healthy coral colonies")
nov_recruit <- get_ci(cr, "Nov_2024", "Coral recruit density")
jul_recruit <- get_ci(cr, "Jul_2025", "Coral recruit density")
nov_fish_b  <- get_fish_ci(fish_agg, "Nov_2024", "Fish biomass")
jul_fish_b  <- get_fish_ci(fish_agg, "Jul_2025", "Fish biomass")
nov_fish_r  <- get_fish_ci(fish_agg, "Nov_2024", "Fish species richness")
jul_fish_r  <- get_fish_ci(fish_agg, "Jul_2025", "Fish species richness")

# Composites per period
nov_all <- c(nov_cover, nov_bleach, nov_health, nov_recruit, nov_fish_b, nov_fish_r)
jul_all <- c(jul_cover, jul_bleach, jul_health, jul_recruit, jul_fish_b, jul_fish_r)
nov_composite <- mean(nov_all, na.rm = TRUE)
jul_composite <- mean(jul_all, na.rm = TRUE)

cat(sprintf("\n  Nov 2024 composite: %.3f (%d indicators)\n",
            nov_composite, sum(!is.na(nov_all))))
cat(sprintf("  Jul 2025 composite: %.3f (%d indicators)\n",
            jul_composite, sum(!is.na(jul_all))))

# =====================================================================
# Build condition account table
# =====================================================================

safe_diff <- function(a, b) {
  if (is.na(a) || is.na(b)) return(NA_real_)
  round(b - a, 3)
}

cond <- data.frame(
  Entry = c(
    # Coral reef multi-period
    "Live coral cover -- Opening (Nov 2024)",
    "Live coral cover -- Closing (Jul 2025)",
    "Live coral cover -- Change",
    "Coral bleaching -- Opening (Nov 2024)",
    "Coral bleaching -- Closing (Jul 2025)",
    "Coral bleaching -- Change",
    "Coral health -- Opening (Nov 2024)",
    "Coral health -- Closing (Jul 2025)",
    "Coral health -- Change",
    "Coral recruitment -- Opening (Nov 2024)",
    "Coral recruitment -- Closing (Jul 2025)",
    "Coral recruitment -- Change",
    "Fish biomass -- Opening (Nov 2024)",
    "Fish biomass -- Closing (Jul 2025)",
    "Fish biomass -- Change",
    "Fish richness -- Opening (Nov 2024)",
    "Fish richness -- Closing (Jul 2025)",
    "Fish richness -- Change",
    "Composite -- Opening (Nov 2024)",
    "Composite -- Closing (Jul 2025)",
    "Composite -- Change",
    # Mangrove single period
    "Stem density (2025)",
    "Mean DBH (2025)",
    "Mean height (2025)",
    "Canopy cover (2025)",
    "Tree quality (2025)",
    "Composite (2025)",
    # Seagrass single period
    "Total cover (2024)",
    "Species richness (2024)",
    "Composite (2024)"
  ),
  Units = rep("index (0-1)", 30),
  Coral_Reef = c(
    round(nov_cover, 3), round(jul_cover, 3), safe_diff(nov_cover, jul_cover),
    round(nov_bleach, 3), round(jul_bleach, 3), safe_diff(nov_bleach, jul_bleach),
    round(nov_health, 3), round(jul_health, 3), safe_diff(nov_health, jul_health),
    round(nov_recruit, 3), round(jul_recruit, 3), safe_diff(nov_recruit, jul_recruit),
    round(nov_fish_b, 3), round(jul_fish_b, 3), safe_diff(nov_fish_b, jul_fish_b),
    round(nov_fish_r, 3), round(jul_fish_r, 3), safe_diff(nov_fish_r, jul_fish_r),
    round(nov_composite, 3), round(jul_composite, 3),
    safe_diff(nov_composite, jul_composite),
    rep(NA_real_, 6),
    rep(NA_real_, 3)
  ),
  Mangrove = c(
    rep(NA_real_, 21),
    round(mng_density, 3), round(mng_dbh, 3), round(mng_height, 3),
    round(mng_cover, 3), round(mng_quality, 3), round(mng_composite, 3),
    rep(NA_real_, 3)
  ),
  Seagrass = c(
    rep(NA_real_, 21),
    rep(NA_real_, 6),
    round(sg_all_cover, 3), round(sg_all_rich, 3), round(sg_all_composite, 3)
  )
)

write.csv(cond, file.path(out_dir, "accounts", "KEN_SEEA_EA_condition_account_final.csv"),
          row.names = FALSE, na = "--")
cat("\nWrote KEN_SEEA_EA_condition_account_final.csv\n")

# Print final tables
cat("\n===================================================\n")
cat("FINAL EXTENT ACCOUNT\n")
cat("===================================================\n")
print(extent)

cat("\n===================================================\n")
cat("FINAL CONDITION ACCOUNT\n")
cat("===================================================\n")
print(cond)

cat("\nDone.\n")
