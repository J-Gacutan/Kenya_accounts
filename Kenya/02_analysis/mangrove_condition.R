# =============================================================================
# Project:  AFRICA - accounts | Kenya Mangrove SEEA EA Condition Account
# Script:   mangrove_condition.R
# Date:     2026-03-16
# Author:   Generated for Kenya pilot
# Purpose:  Process plot-based mangrove structural survey data (Kilifi County,
#           Dec 2025) to produce SEEA EA ecosystem condition accounts under the
#           UN SEEA EA framework (MFT1.2).
#           Derives 5 biotic condition indicators from individual tree records,
#           normalises to condition indices (0-1), and exports a SEEA EA
#           condition account table.
#
# Inputs (Kenya/01_inputs/raw_data/mangrove/):
#   - All_mangrove_field_data.xlsx    2,095 rows; 38 plots; 22 sites; 4 areas
#
# Outputs (Kenya/03_outputs/):
#   - mangrove_condition_by_plot.csv          Plot-level metrics + CIs
#   - mangrove_condition_by_site.csv          Site-level mean CIs
#   - mangrove_species_composition.csv        Species counts per site
#   - mangrove_coords.csv                     Decimal-degree plot coordinates
#   - seea_condition_account_mangrove_kenya.csv  SEEA EA standard format
#
# Plan:     Kenya/docs/accounts/cond_mangrove_plan.md
# Framework: UN SEEA EA Ecosystem Condition Accounts
# Ecosystem: Intertidal Forests and Shrublands (IUCN GET MFT1.2)
# Sites:     Ngomeni, Marereni, Mida Creek, Kilifi Creek — Kilifi County
#
# Reference levels are PROVISIONAL. Confirm against peer-reviewed WIO
# literature before finalising the condition account.
# =============================================================================


# -----------------------------------------------------------------------------
# 0. Setup
# -----------------------------------------------------------------------------

library(here)
library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)

DATA_FILE  <- here("Kenya", "01_inputs", "raw_data", "mangrove",
                   "All_mangrove_field_data.xlsx")
OUTPUT_DIR <- here("Kenya", "03_outputs")

ACCOUNT_YEAR <- 2025
PLOT_AREA_M2 <- 100    # 10 x 10 m plots (verify from Plot size (m2) column)


# -----------------------------------------------------------------------------
# 1. Reference levels for condition index normalisation
#    Formula: CI = (value - poor) / (pristine - poor), clamped [0, 1]
#    All levels are PROVISIONAL — confirm against WIO literature.
# -----------------------------------------------------------------------------

ref_levels <- tibble(
  indicator   = c("stem_density_ha", "mean_dbh_cm", "mean_height_m", "canopy_cover_pct"),
  ci_col      = c("ci_stem_density",  "ci_mean_dbh",  "ci_mean_height",  "ci_canopy_cover"),
  poor        = c(200,               3,              2,                 30),
  pristine    = c(3000,              20,             12,                90),
  unit        = c("trees/ha",        "cm",           "m",               "%"),
  confidence  = c("MEDIUM",          "MEDIUM",       "MEDIUM",          "LOW"),
  source      = c(
    "Kirui et al. 2006 (Kenya); Bosire et al. 2014 (WIO)",
    "Bosire et al. 2014; Kairo et al. 2009 (Kenya)",
    "Fatoyinbo et al. 2008; Lagomasino et al. 2015 (WIO)",
    "Provisional expert estimate"
  )
)

# Tree quality index (quality-1 proportion) is already 0-1; no normalisation
# needed. Confidence: LOW — no published WIO standard for this metric.


# -----------------------------------------------------------------------------
# 2. Species name lookup
#    Maps abbreviations (RM, Rm, rm, AM, etc.) to full scientific names.
#    Additional variants should be added if encountered in the data.
# -----------------------------------------------------------------------------

species_lookup <- c(
  "rm"  = "Rhizophora mucronata",
  "am"  = "Avicennia marina",
  "bg"  = "Bruguiera gymnorrhiza",
  "ct"  = "Ceriops tagal",
  "rhizophora mucronata"   = "Rhizophora mucronata",
  "avicennia marina"       = "Avicennia marina",
  "bruguiera gymnorrhiza"  = "Bruguiera gymnorrhiza",
  "bruguiera gymnorhiza"   = "Bruguiera gymnorrhiza",  # single-r variant in data
  "bruggeria gymnorhiza"   = "Bruguiera gymnorrhiza",  # typo in data
  "bruggeria gymnorrhiza"  = "Bruguiera gymnorrhiza",  # typo in data
  "ceriops tagal"          = "Ceriops tagal"
)

standardise_species <- function(x) {
  key <- str_trim(str_to_lower(x))
  result <- species_lookup[key]
  # Return NA (not the NA name) for unrecognised entries
  ifelse(is.na(result), NA_character_, result)
}


# -----------------------------------------------------------------------------
# 3. Area name lookup
#    Harmonises inconsistent area labels to canonical names.
# -----------------------------------------------------------------------------

area_lookup <- c(
  "dabaso"           = "Mida Creek",
  "debaso"           = "Mida Creek",
  "kidundu"          = "Mida Creek",
  "mida"             = "Mida Creek",
  "mida creek"       = "Mida Creek",
  "mtongani"         = "Mida Creek",
  "mtongani/kidundu" = "Mida Creek",
  "ngomeni"          = "Ngomeni",
  "ngomeni rasi"     = "Ngomeni",
  "rasi"             = "Ngomeni",
  "marereni"              = "Marereni",
  "marereni-kwa kanyama"  = "Marereni",
  "marereni- kwa kanyama" = "Marereni",   # space after dash in data
  "kilifi creek"     = "Kilifi Creek"
)

standardise_area <- function(x) {
  key <- str_trim(str_to_lower(x))
  result <- area_lookup[key]
  ifelse(is.na(result), x, result)   # fall back to original if not in lookup
}


# -----------------------------------------------------------------------------
# 4. Coordinate parser
#    Handles two formats found in the data:
#      (a) DMS strings  e.g. "40°11'1.01\"" or "39° 59\u2032 21.70\u2033"
#      (b) Decimal-degree strings e.g. "40.21686"
#    Returns decimal degrees. Apply negative sign for S latitudes externally.
#
#    DQ flags raised by parse_coord_dd (called in section 8c):
#      - DOUBLE_DOT : malformed seconds field (two decimal points) -> NA
#      - GARBLED    : parsed seconds >= 60 -> NA
#      - UNMATCHED  : not decimal-degree and DMS regex failed       -> NA
# -----------------------------------------------------------------------------

dms_to_dd <- function(x) {
  # Normalise Unicode prime characters to ASCII equivalents before matching:
  #   U+2032 PRIME (minutes) -> '
  #   U+2033 DOUBLE PRIME (seconds) -> "
  x2 <- x |>
    str_replace_all("\u2032", "'") |>
    str_replace_all("\u2033", "\"")
  m <- str_match(
    str_trim(x2),
    "([0-9]+)\\s*[\u00b0]\\s*([0-9]+)[^0-9.]*([0-9]*\\.?[0-9]*)"
  )
  deg <- as.numeric(m[, 2])
  min <- as.numeric(m[, 3])
  sec <- as.numeric(ifelse(m[, 4] == "" | is.na(m[, 4]), "0", m[, 4]))
  dd  <- deg + min / 60 + sec / 3600
  ifelse(is.na(deg), NA_real_, dd)
}

parse_coord_dd <- function(x, col_label = "coord") {
  x2 <- str_trim(x)

  # Repair double-decimal seconds: e.g. "38.42.90" → "38.4290"
  # Matches digit(s).digit(s).digit(s) and removes the second dot.
  x2 <- str_replace(x2, "([0-9]+\\.[0-9]+)\\.([0-9]+)", "\\1\\2")

  # Repair missing decimal in seconds: e.g. "3°21′4121′′" → "3°21′41.21′′"
  # 4-digit integer seconds (no decimal) → insert decimal after 2 digits.
  # Seconds marker may be U+2033 (″) or two U+2032 (′′).
  x2 <- str_replace(x2,
    "(\u00b0[^.]*\u2032[^0-9.]*)([0-9]{2})([0-9]{2})(\u2033|\u2032\u2032)",
    "\\1\\2.\\3\\4")

  # Detect format for each element
  is_decimal  <- grepl("^-?[0-9]+\\.[0-9]+$", x2)
  is_dbl_dot  <- !is_decimal & (str_count(x2, "\\.") > 1)

  result <- dplyr::case_when(
    is_decimal ~ suppressWarnings(as.numeric(x2)),
    is_dbl_dot ~ NA_real_,
    TRUE       ~ dms_to_dd(x2)
  )

  # Flag garbled DMS where raw seconds >= 60 (e.g. "3deg21'4121''" parsed as
  # sec=4121). Extract seconds directly from the regex rather than back-
  # calculating from the decimal result, which hides the overflow.
  x_norm <- x2 |>
    str_replace_all("\u2032", "'") |>
    str_replace_all("\u2033", "\"")
  m_sec <- str_match(
    x_norm,
    "[0-9]+\\s*[\u00b0]\\s*[0-9]+[^0-9.]*([0-9]*\\.?[0-9]*)"
  )
  raw_sec <- suppressWarnings(as.numeric(
    ifelse(m_sec[, 2] == "" | is.na(m_sec[, 2]), "0", m_sec[, 2])
  ))
  is_garbled <- !is_decimal & !is_dbl_dot & !is.na(raw_sec) & raw_sec >= 60

  result <- ifelse(is_garbled, NA_real_, result)

  # Report DQ issues
  n_dbl  <- sum(is_dbl_dot, na.rm = TRUE)
  n_gar  <- sum(is_garbled, na.rm = TRUE)
  n_none <- sum(!is_decimal & !is_dbl_dot & is.na(dms_to_dd(x2)), na.rm = TRUE)
  if (n_dbl > 0)
    message(sprintf("  DQ-COORD WARNING [%s]: %d value(s) with malformed seconds (double decimal point) -> NA:",
                    col_label, n_dbl),
            "\n    ", paste(x[is_dbl_dot], collapse = "\n    "))
  if (n_gar > 0)
    message(sprintf("  DQ-COORD WARNING [%s]: %d value(s) with garbled DMS (sec >= 60) -> NA:",
                    col_label, n_gar),
            "\n    ", paste(x[is_garbled], collapse = "\n    "))
  if (n_none > 0)
    message(sprintf("  DQ-COORD WARNING [%s]: %d value(s) unmatched by DMS regex -> NA",
                    col_label, n_none))

  result
}


# -----------------------------------------------------------------------------
# 5. Cover class to numeric midpoint
#    Adjust this lookup to match the exact strings used in the data.
#    Run unique(raw$Cover) after loading to verify categories.
# -----------------------------------------------------------------------------

cover_to_pct <- function(x) {
  # Classes found in data: "0-20", "20-40", "21-40", "40-60", "41-60",
  # "60-80", "61-80". Use range midpoints.
  key <- str_trim(str_to_lower(as.character(x)))
  dplyr::case_when(
    key %in% c("0-20", "0-20%")                               ~ 10,
    key %in% c("20-40", "21-40", "20-40%", "21-40%")          ~ 30,
    key %in% c("40-60", "41-60", "40-60%", "41-60%")          ~ 50,
    key %in% c("60-80", "61-80", "60-80%", "61-80%")          ~ 70,
    key %in% c("80-100", ">80", "80-100%", ">80%")            ~ 90,
    # Legacy classes retained for safety
    key %in% c("<10", "<10%", "0-10", "sparse")                ~  5,
    key %in% c(">90", ">90%", "90-100", "dense")               ~ 95,
    !is.na(suppressWarnings(as.numeric(key)))                   ~ suppressWarnings(as.numeric(key)),
    TRUE                                                         ~ NA_real_
  )
}


# -----------------------------------------------------------------------------
# 6. Condition index normalisation helper
#    Clamps output to [0, 1].
# -----------------------------------------------------------------------------

normalise_ci <- function(x, poor, pristine) {
  raw <- (x - poor) / (pristine - poor)
  pmin(pmax(raw, 0), 1)
}


# -----------------------------------------------------------------------------
# 7. Data ingestion
# -----------------------------------------------------------------------------

message("Loading mangrove field data...")

tryCatch({
  raw <- read_excel(DATA_FILE, sheet = 1)
}, error = function(e) {
  stop(sprintf("Cannot read %s: %s", DATA_FILE, e$message))
})

message(sprintf("  Loaded: %d rows, %d columns", nrow(raw), ncol(raw)))

# The Quality column contains mixed numeric (Part 1) and text (Part 2) values.
# readxl infers it as numeric and silently coerces text cells to NA.
# Re-read Quality as text and replace the inferred numeric column.
quality_col_idx <- which(toupper(names(raw)) == "QUALITY")
if (length(quality_col_idx) == 1) {
  col_types_vec      <- rep("skip", ncol(raw))
  col_types_vec[quality_col_idx] <- "text"
  quality_text       <- read_excel(DATA_FILE, sheet = 1, col_types = col_types_vec)
  raw[[quality_col_idx]] <- quality_text[[1]]
  message("  Quality column re-read as text.")
}

# Standardise column names to snake_case
names(raw) <- names(raw) |>
  str_to_lower() |>
  str_replace_all("[^a-z0-9]+", "_") |>
  str_replace("_$", "")

message(sprintf("  Columns: %s", paste(names(raw), collapse = ", ")))


# -----------------------------------------------------------------------------
# 7b. Batch split and harmonise
#     The two survey batches use different field coding conventions:
#
#     Part 1 (rows 1-1105) — Patricia & Kisilu:
#       species  : full scientific names (minor spelling variants)
#       quality  : numeric 1/2/3  (1 = good, 3 = severe damage/dead)
#       comments : "live tree [+ damage notes]"
#
#     Part 2 (rows 1106-2095) — Marvin & Gilbert:
#       species  : abbreviations (RM/Rm, CT/Ct, AM/Am, BG/Bg)
#       quality  : free-text — mix of tree damage notes and plot ecology
#                  observations; some numeric 1/2/3 retained
#       comments : specific damage counts; mostly NA
#       dbh_cm   : 476 NAs — always recomputed from circumference in §8e
#
#     Both parts are harmonised to quality_num (integer 1/2/3) before
#     rejoining.  Rule: if no damage signal anywhere → assume live tree (1).
# -----------------------------------------------------------------------------

PART1_ROWS <- 1105   # last row of Part 1 (data rows, after header)

part1 <- raw[1:PART1_ROWS, ]
part2 <- raw[(PART1_ROWS + 1):nrow(raw), ]

message(sprintf("  Part 1 (rows 1-%d): %d rows", PART1_ROWS, nrow(part1)))
message(sprintf("  Part 2 (rows %d-%d): %d rows",
                PART1_ROWS + 1, nrow(raw), nrow(part2)))

# ---- Part 1: quality → quality_num ----
# Quality is numeric 1/2/3 as a character string; 2 NAs.
# NAs: check comments for dead signal; default to 1 (live).
part1 <- part1 |>
  mutate(
    quality_num = {
      q  <- suppressWarnings(as.integer(quality))
      cc <- str_to_lower(coalesce(comments, ""))
      case_when(
        !is.na(q)                           ~ q,
        grepl("standing dead|^dead", cc)    ~ 3L,
        TRUE                                ~ 1L
      )
    },
    quality_source = "part1_numeric"
  )

# ---- Part 2: quality + comments → quality_num ----
#
# Quality text → numeric mapping:
#   Standing dead (either field)                       → 3
#   Major cuts: main stem cut / topcut                 → 3
#   Minor damage: side cuts, branch cuts, epiphytes,
#                 dieback                               → 2
#   Numeric "1"/"2"/"3" retained as-is
#   Plot ecology notes (regeneration, biodiversity,
#     human impact, burrows) → not tree damage → 1
#   NA in both fields                                  → 1 (assume live)
#
part2 <- part2 |>
  mutate(
    quality_num = {
      q <- str_to_lower(str_trim(coalesce(as.character(quality), "")))
      c <- str_to_lower(str_trim(coalesce(as.character(comments), "")))
      case_when(
        # Dead — either field
        grepl("standing dead", c) | grepl("standing dead", q) ~ 3L,
        # Major structural damage
        grepl("main stem cut|mainbranchcut|topcut|top cut", q) |
          grepl("main stem cut|top cut", c)                    ~ 3L,
        # Numeric codes retained
        q == "1"                                               ~ 1L,
        q == "2"                                               ~ 2L,
        q == "3"                                               ~ 3L,
        # Minor damage
        grepl("dieback|die back|epiphyte", q) |
          grepl("epiphyte", c)                                 ~ 2L,
        grepl("side cut|branch cut|branchcut|side branch", q) |
          grepl("side cut|branch cut|side branch", c)          ~ 2L,
        # Plot-level ecology observations — not individual tree damage
        grepl(paste0("regeneration|biodiversity|human impact|burrow",
                     "|low human|minimal human|moderate human",
                     "|below ground|good below|large burrow",
                     "|sufficient|high regeneration"), q)      ~ 1L,
        # Default: no damage signal → live tree
        TRUE                                                   ~ 1L
      )
    },
    quality_source = "part2_harmonised"
  )

# ---- Rejoin ----
raw <- bind_rows(part1, part2)

message("  Quality distribution after harmonisation:")
print(table(raw$quality_num, raw$quality_source, useNA = "ifany"))

message("Batch harmonisation complete.\n")


# -----------------------------------------------------------------------------
# 8. QA/QC
# -----------------------------------------------------------------------------

message("Running QA/QC...")

# Identify the canonical column names after clean_names; print to verify
# Expected after standardisation:
#   observers, date, area, site, plot_no, eastings, southings, plot_size_m2,
#   forest_type, inundation_class, cover, tree_no, sub_branch, species,
#   p_o_m, circumference_cm, dbh_cm, height_m, quality, comments

# ---- 8a. Species standardisation ----
raw <- raw |>
  mutate(
    species_raw  = species,
    species      = map_chr(species, standardise_species),
    species_flag = is.na(species) & !is.na(species_raw)
  )

n_unrecognised_spp <- sum(raw$species_flag, na.rm = TRUE)
if (n_unrecognised_spp > 0) {
  message(sprintf(
    "  DQ-1 WARNING: %d rows with unrecognised species values:",
    n_unrecognised_spp
  ))
  raw |>
    filter(species_flag) |>
    count(species_raw) |>
    print()
}

# ---- 8b. Area name standardisation ----
raw <- raw |>
  mutate(
    area_raw = area,
    area     = map_chr(area, standardise_area)
  )

message("  Areas after standardisation:")
print(sort(unique(raw$area)))

# ---- 8c. Coordinate conversion ----
# Data contains mixed formats: DMS strings ("40°11'1.01\"") and decimal
# degrees ("40.21686"). parse_coord_dd() handles both and flags malformed
# entries (double-decimal seconds, garbled DMS) as NA.
raw <- raw |>
  mutate(
    lon_dd = parse_coord_dd(eastings,  "eastings"),
    lat_dd = -abs(parse_coord_dd(southings, "southings"))
  )

n_coord_fail <- sum(is.na(raw$lon_dd) | is.na(raw$lat_dd))
if (n_coord_fail > 0) {
  message(sprintf(
    "  DQ-3 WARNING: %d rows with unparseable or flagged coordinates (see DQ-COORD above)",
    n_coord_fail
  ))
}

# Sanity check: all parsed coordinates should be within Kilifi County bounds
# lon 39.5-40.5, lat -4.5 to -2.5
n_oob <- sum(
  !is.na(raw$lon_dd) & (raw$lon_dd < 39.5 | raw$lon_dd > 40.5) |
  !is.na(raw$lat_dd) & (raw$lat_dd < -4.5 | raw$lat_dd > -2.5),
  na.rm = TRUE
)
if (n_oob > 0) {
  message(sprintf(
    "  DQ-4 WARNING: %d rows with coordinates outside expected Kilifi County bounds",
    n_oob
  ))
}

# ---- 8d. Plot area verification ----
# The column may be named plot_size_m2 after standardisation
if ("plot_size_m2" %in% names(raw)) {
  plot_sizes <- unique(raw$plot_size_m2[!is.na(raw$plot_size_m2)])
  if (!all(plot_sizes == PLOT_AREA_M2)) {
    message(sprintf(
      "  WARNING: Plot sizes found: %s (expected %d m2). Review before analysis.",
      paste(plot_sizes, collapse = ", "), PLOT_AREA_M2
    ))
  }
}

# ---- 8e. DBH from circumference ----
# The DBH column in the raw data is shifted by one row relative to
# circumference (a known data entry error). Always recalculate from
# circumference to ensure consistency.
raw <- raw |>
  mutate(dbh_cm = circumference_cm / pi)

# ---- 8f. Survey phase flag ----
raw <- raw |>
  mutate(
    survey_phase = if_else(
      !is.na(date) & as.Date(date) < as.Date("2025-12-01"),
      "reconnaissance",
      "main"
    )
  )

message("  Survey phase distribution:")
print(table(raw$survey_phase))

# ---- 8g. Sub-branch identification ----
# Sub-branches are labelled with letters (a/A, b/B, c/C...) in the
# Sub (Branch) column; main stems have NA. Any non-NA value = sub-branch.
raw <- raw |>
  mutate(is_sub_branch = !is.na(sub_branch))

message(sprintf(
  "  Sub-branches identified: %d of %d records",
  sum(raw$is_sub_branch), nrow(raw)
))

# ---- 8h. Height outlier flags ----
raw <- raw |>
  mutate(height_flag = !is.na(height_m) & (height_m < 0.3 | height_m > 20))

n_height_flag <- sum(raw$height_flag, na.rm = TRUE)
if (n_height_flag > 0) {
  message(sprintf("  WARNING: %d height outliers (< 0.3 m or > 20 m)", n_height_flag))
}

message("QA/QC complete.\n")


# -----------------------------------------------------------------------------
# 9. Plot-level metrics
# -----------------------------------------------------------------------------

message("Computing plot-level metrics...")

# ---- 9a. Stem density ----
# Count only main stems (not sub-branches) per plot
main_stems <- raw |> filter(!is_sub_branch)

stem_counts <- main_stems |>
  group_by(area, site, plot_no) |>
  summarise(
    n_stems          = n(),
    n_species        = n_distinct(species, na.rm = TRUE),
    .groups          = "drop"
  ) |>
  mutate(
    stem_density_ha = n_stems / (PLOT_AREA_M2 / 10000)   # trees/ha
  )

# ---- 9b. Structural metrics (all stems including sub-branches) ----
struct_metrics <- raw |>
  filter(!height_flag) |>                                 # exclude outliers
  group_by(area, site, plot_no) |>
  summarise(
    mean_dbh_cm    = mean(dbh_cm,   na.rm = TRUE),
    mean_height_m  = mean(height_m, na.rm = TRUE),
    .groups        = "drop"
  )

# ---- 9c. Canopy cover ----
cover_metrics <- raw |>
  distinct(area, site, plot_no, cover) |>
  mutate(canopy_cover_pct = cover_to_pct(cover)) |>
  group_by(area, site, plot_no) |>
  summarise(
    canopy_cover_pct = mean(canopy_cover_pct, na.rm = TRUE),
    .groups          = "drop"
  )

n_cover_na <- sum(is.na(
  semi_join(cover_metrics, stem_counts, by = c("area", "site", "plot_no"))$canopy_cover_pct
))
if (n_cover_na > 0) {
  message(sprintf(
    "  WARNING: %d plots with unresolved cover class values. Run unique(raw$cover) to inspect.",
    n_cover_na
  ))
}

# ---- 9d. Tree quality index ----
# Proportion of main stems with quality_num == 1 (healthy/undamaged).
# quality_num was harmonised in §7b from both batches' coding conventions.
quality_index <- raw |>
  filter(!is_sub_branch) |>
  group_by(area, site, plot_no) |>
  summarise(
    quality_index = sum(quality_num == 1L, na.rm = TRUE) / n(),
    .groups       = "drop"
  )

# ---- 9e. Plot coordinates (centroid of trees in each plot) ----
plot_coords <- raw |>
  group_by(area, site, plot_no) |>
  summarise(
    lon_dd = mean(lon_dd, na.rm = TRUE),
    lat_dd = mean(lat_dd, na.rm = TRUE),
    forest_type      = first(forest_type),
    inundation_class = first(inundation_class),
    survey_phase     = first(survey_phase),
    .groups = "drop"
  )

# ---- 9f. Join all plot metrics ----
plots <- stem_counts |>
  left_join(struct_metrics,  by = c("area", "site", "plot_no")) |>
  left_join(cover_metrics,   by = c("area", "site", "plot_no")) |>
  left_join(quality_index,   by = c("area", "site", "plot_no")) |>
  left_join(plot_coords,     by = c("area", "site", "plot_no"))

message(sprintf("  Plots processed: %d\n", nrow(plots)))


# -----------------------------------------------------------------------------
# 10. Condition index normalisation
# -----------------------------------------------------------------------------

message("Normalising condition indices...")

ref_dens   <- ref_levels |> filter(indicator == "stem_density_ha")
ref_dbh    <- ref_levels |> filter(indicator == "mean_dbh_cm")
ref_height <- ref_levels |> filter(indicator == "mean_height_m")
ref_cover  <- ref_levels |> filter(indicator == "canopy_cover_pct")

plots <- plots |>
  mutate(
    # Stem density CI (MEDIUM confidence)
    ci_stem_density  = normalise_ci(stem_density_ha,    ref_dens$poor,   ref_dens$pristine),

    # Mean DBH CI (MEDIUM confidence)
    ci_mean_dbh      = normalise_ci(mean_dbh_cm,        ref_dbh$poor,    ref_dbh$pristine),

    # Canopy height CI (MEDIUM confidence)
    ci_mean_height   = normalise_ci(mean_height_m,      ref_height$poor, ref_height$pristine),

    # Canopy cover CI (LOW confidence; provisional)
    ci_canopy_cover  = normalise_ci(canopy_cover_pct,   ref_cover$poor,  ref_cover$pristine),

    # Tree quality index is already 0-1; included directly (LOW confidence)
    ci_quality_index = pmin(pmax(quality_index, 0), 1)
  )


# -----------------------------------------------------------------------------
# 11. Composite condition index
#     Equal-weight mean of 5 condition indices.
#     NA values excluded from mean (plots with partial indicator coverage
#     will still produce a composite from available indicators).
# -----------------------------------------------------------------------------

plots <- plots |>
  mutate(
    ci_composite = rowMeans(
      cbind(ci_stem_density, ci_mean_dbh, ci_mean_height,
            ci_canopy_cover, ci_quality_index),
      na.rm = TRUE
    ),
    n_indicators = rowSums(!is.na(
      cbind(ci_stem_density, ci_mean_dbh, ci_mean_height,
            ci_canopy_cover, ci_quality_index)
    ))
  )


# -----------------------------------------------------------------------------
# 12. Site-level aggregation
#     Unweighted mean of plots within each site.
#     Reports n_plots and flags low-sample-size sites (< 2 plots).
# -----------------------------------------------------------------------------

message("Aggregating to site level...")

sites <- plots |>
  group_by(area, site) |>
  summarise(
    n_plots                = n(),
    # Raw metric means
    mean_stem_density_ha   = mean(stem_density_ha,   na.rm = TRUE),
    mean_dbh_cm            = mean(mean_dbh_cm,        na.rm = TRUE),
    mean_height_m          = mean(mean_height_m,      na.rm = TRUE),
    mean_canopy_cover_pct  = mean(canopy_cover_pct,   na.rm = TRUE),
    mean_quality_index     = mean(quality_index,      na.rm = TRUE),
    # Condition index means
    ci_stem_density        = mean(ci_stem_density,    na.rm = TRUE),
    ci_mean_dbh            = mean(ci_mean_dbh,         na.rm = TRUE),
    ci_mean_height         = mean(ci_mean_height,      na.rm = TRUE),
    ci_canopy_cover        = mean(ci_canopy_cover,     na.rm = TRUE),
    ci_quality_index       = mean(ci_quality_index,    na.rm = TRUE),
    ci_composite           = mean(ci_composite,        na.rm = TRUE),
    # Centroid coordinates
    lon_dd                 = mean(lon_dd, na.rm = TRUE),
    lat_dd                 = mean(lat_dd, na.rm = TRUE),
    .groups = "drop"
  ) |>
  mutate(
    low_sample = n_plots < 2
  )

n_low <- sum(sites$low_sample)
if (n_low > 0) {
  message(sprintf(
    "  NOTE: %d site(s) with < 2 plots — condition indices have low reliability:",
    n_low
  ))
  sites |> filter(low_sample) |> select(area, site, n_plots) |> print()
}


# -----------------------------------------------------------------------------
# 13. Species composition per site
# -----------------------------------------------------------------------------

species_comp <- main_stems |>
  filter(!is.na(species)) |>
  group_by(area, site, species) |>
  summarise(n_stems = n(), .groups = "drop") |>
  group_by(area, site) |>
  mutate(
    total_stems   = sum(n_stems),
    pct_abundance = round(100 * n_stems / total_stems, 1)
  ) |>
  ungroup()


# -----------------------------------------------------------------------------
# 14. Plot coordinates table
# -----------------------------------------------------------------------------

coords_out <- plots |>
  select(area, site, plot_no, lon_dd, lat_dd, forest_type,
         inundation_class, survey_phase)


# -----------------------------------------------------------------------------
# 15. Protected area assignment (Step 10 of cond_mangrove_plan.md)
#     Sites within or adjacent to Mida Creek MNR are classed as "protected".
#     All other areas (Ngomeni, Marereni, Kilifi Creek) are "unprotected".
#     Assignment based on plan section "Protected Area Integration":
#       - Mida Creek MNR (IUCN Cat II): Dabaso, Kidundu, Mtongani + adjacent
#       - Kilifi Creek: Unprotected
#       - Ngomeni / Marereni: Unprotected
# -----------------------------------------------------------------------------

message("Assigning protected area status...")

# Mida Creek area sites are within or adjacent to Mida Creek MNR.
# Kilifi Creek sites Mtongani and Kidundu are geographically near Mida
# but are part of the Kilifi Creek area — tagged unprotected per plan.
# Mwinyihaji and Mzodzongoloni are under Mida Creek area but lie outside
# the MNR boundary (Kilifi Creek tributary) — tagged unprotected.
pa_lookup <- c(
  "Boardwalk"        = "Mida Creek MNR",
  "Dabaso"           = "Mida Creek MNR",
  "Debaso Rock"      = "Mida Creek MNR",
  "Fisheries"        = "Unprotected",
  "Kachaa"           = "Mida Creek MNR",
  "Kadzuyuni"        = "Unprotected",
  "Kaogoni"          = "Unprotected",
  "Kidundu"          = "Mida Creek MNR",
  "Kilifi creek"     = "Unprotected",
  "Kurawa-kanagoni"  = "Unprotected",
  "Kwa Doughlas"     = "Unprotected",
  "Kwa Douglas"      = "Unprotected",
  "Kwa Nzai"         = "Unprotected",
  "Kwazimba Island"  = "Mida Creek MNR",
  "Luwahi"           = "Mida Creek MNR",
  "Mandarini"        = "Unprotected",
  "Marereni-Kwa Kanyama" = "Unprotected",
  "Mida"             = "Mida Creek MNR",
  "Mto wa Mawe"      = "Unprotected",
  "Mtongani"         = "Unprotected",
  "Mwinyihaji"       = "Unprotected",
  "Mzodzongoloni"    = "Unprotected",
  "Ngomeni Rasi"     = "Unprotected",
  "Pwani toto"       = "Unprotected",
  "Rasi"             = "Unprotected",
  "Rasi Msikiti"     = "Unprotected",
  "Darajani"         = "Unprotected"
)

sites <- sites |>
  mutate(
    pa_status = ifelse(
      site %in% names(pa_lookup),
      pa_lookup[site],
      # Fallback: Mida Creek area sites → protected, else unprotected
      ifelse(area == "Mida Creek", "Mida Creek MNR", "Unprotected")
    )
  )

# PA-disaggregated summary
pa_summary <- sites |>
  group_by(pa_status) |>
  summarise(
    n_sites                = n(),
    n_plots                = sum(n_plots),
    mean_ci_stem_density   = mean(ci_stem_density,   na.rm = TRUE),
    mean_ci_dbh            = mean(ci_mean_dbh,        na.rm = TRUE),
    mean_ci_height         = mean(ci_mean_height,     na.rm = TRUE),
    mean_ci_cover          = mean(ci_canopy_cover,    na.rm = TRUE),
    mean_ci_quality        = mean(ci_quality_index,   na.rm = TRUE),
    mean_ci_composite      = mean(ci_composite,       na.rm = TRUE),
    .groups = "drop"
  )

message("  PA-disaggregated condition summary:")
pa_summary |>
  mutate(across(starts_with("mean_"), ~ round(.x, 3))) |>
  print()


# -----------------------------------------------------------------------------
# 16. SEEA EA condition account (standard format)
# -----------------------------------------------------------------------------

seea_account <- sites |>
  mutate(
    ecosystem_type   = "Intertidal Forests and Shrublands (MFT1.2)",
    country          = "Kenya",
    accounting_unit  = site,
    year             = ACCOUNT_YEAR
  ) |>
  select(
    ecosystem_type,
    country,
    area,
    accounting_unit,
    pa_status,
    n_plots,
    ci_stem_density,
    ci_mean_dbh,
    ci_mean_height,
    ci_canopy_cover,
    ci_quality_index,
    ci_composite,
    low_sample,
    year
  )


# -----------------------------------------------------------------------------
# 17. Write outputs
# -----------------------------------------------------------------------------

message("Writing outputs...")

write.csv(
  plots,
  file.path(OUTPUT_DIR, "KEN_mangrove_condition_by_plot.csv"),
  row.names = FALSE
)
message("  Written: KEN_mangrove_condition_by_plot.csv")

write.csv(
  sites,
  file.path(OUTPUT_DIR, "KEN_mangrove_condition_by_site.csv"),
  row.names = FALSE
)
message("  Written: KEN_mangrove_condition_by_site.csv")

write.csv(
  species_comp,
  file.path(OUTPUT_DIR, "KEN_mangrove_species_composition.csv"),
  row.names = FALSE
)
message("  Written: KEN_mangrove_species_composition.csv")

write.csv(
  coords_out,
  file.path(OUTPUT_DIR, "KEN_mangrove_coords.csv"),
  row.names = FALSE
)
message("  Written: KEN_mangrove_coords.csv")

write.csv(
  seea_account,
  file.path(OUTPUT_DIR, "KEN_seea_condition_account_mangrove.csv"),
  row.names = FALSE
)
message("  Written: KEN_seea_condition_account_mangrove.csv")

write.csv(
  pa_summary,
  file.path(OUTPUT_DIR, "KEN_mangrove_condition_by_pa.csv"),
  row.names = FALSE
)
message("  Written: KEN_mangrove_condition_by_pa.csv\n")


# -----------------------------------------------------------------------------
# 18. Console summary
# -----------------------------------------------------------------------------

cat("=============================================================\n")
cat("KENYA MANGROVE CONDITION ACCOUNT — SUMMARY\n")
cat("=============================================================\n\n")

cat(sprintf("Records loaded:    %d\n",   nrow(raw)))
cat(sprintf("Main stems:        %d\n",   nrow(main_stems)))
cat(sprintf("Sub-branches:      %d\n",   sum(raw$is_sub_branch)))
cat(sprintf("Plots processed:   %d\n",   nrow(plots)))
cat(sprintf("Sites summarised:  %d\n\n", nrow(sites)))

cat("--- Composite condition index by site ---\n")
sites |>
  select(area, site, n_plots, ci_composite) |>
  arrange(area, desc(ci_composite)) |>
  mutate(ci_composite = round(ci_composite, 3)) |>
  print(n = Inf)

cat("\n--- Species composition (main stems) ---\n")
species_comp |>
  group_by(species) |>
  summarise(total_stems = sum(n_stems)) |>
  arrange(desc(total_stems)) |>
  print()

cat("\n--- Indicator means by area ---\n")
sites |>
  group_by(area) |>
  summarise(
    n_sites     = n(),
    ci_density  = round(mean(ci_stem_density,  na.rm = TRUE), 3),
    ci_dbh      = round(mean(ci_mean_dbh,       na.rm = TRUE), 3),
    ci_height   = round(mean(ci_mean_height,    na.rm = TRUE), 3),
    ci_cover    = round(mean(ci_canopy_cover,   na.rm = TRUE), 3),
    ci_quality  = round(mean(ci_quality_index,  na.rm = TRUE), 3),
    ci_composite = round(mean(ci_composite,     na.rm = TRUE), 3),
    .groups = "drop"
  ) |>
  print()

cat("\n--- Condition by protected area status ---\n")
pa_summary |>
  mutate(across(starts_with("mean_"), ~ round(.x, 3))) |>
  print()

cat("\n--- Reference levels used ---\n")
ref_levels |>
  select(indicator, poor, pristine, unit, confidence) |>
  print()

cat("\n=============================================================\n")
cat("NOTE: All reference levels are PROVISIONAL (see cond_mangrove_plan.md).\n")
cat("Canopy cover and tree quality CI have LOW confidence.\n")
cat("Verify cover class strings with unique(raw$cover) before analysis.\n")
cat("=============================================================\n")
