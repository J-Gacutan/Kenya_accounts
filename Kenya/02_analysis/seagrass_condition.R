# =============================================================================
# Seagrass Biotic Condition Analysis
# SEEA EA Condition Account — Seagrass Meadows (M1.1)
# Kenya Pilot
#
# Input:  Kenya/01_inputs/raw_data/seagrass/All_seagrass_field_data.xlsx
#         Sheet 1: "SEAGRASS COVER"  (1,604 rows)
#         Sheet 2: "SEAGRASS HEALTH" (1,436 rows)
#
# Output: Kenya/03_outputs/
#   seagrass_cover_site.csv              — site-level cover by species (wide)
#   seagrass_health_site.csv             — site-level shoot density + canopy height
#   seagrass_health_zone.csv             — zone-level shoot density + canopy height
#   seea_condition_account_seagrass_kenya.csv — SEEA EA condition table (long)
#
# Reference values are PROVISIONAL — confirm against WIO literature before
# finalising the condition account.
# =============================================================================

# ============================================================
# 0. Setup
# ============================================================

library(here)
library(tidyverse)
library(readxl)
library(lubridate)

# Resolve project root: here() anchors to the directory containing .here or
# the top-level git root.  All paths below use here() from the project root
# (AFRICA - accounts/).
DATA_FILE <- here("Kenya", "01_inputs", "raw_data", "seagrass",
                  "All_seagrass_field_data.xlsx")

OUTPUT_DIR <- here("Kenya", "03_outputs")

# Provisional reference values used for condition index normalisation.
# All values should be confirmed against peer-reviewed WIO literature.
# PROVISIONAL — confirm against WIO literature
REF_COVER_PCT        <- 60    # % total seagrass cover reference level
REF_DENSITY_Th       <- 800   # shoots/m² — Thalassia hemprichii
REF_DENSITY_Cs       <- 500   # shoots/m² — Cymodocea serrulata
REF_DENSITY_Cr       <- 500   # shoots/m² — Cymodocea rotundata
REF_DENSITY_Hu       <- 1000  # shoots/m² — Halodule uninervis
REF_DENSITY_Ea       <- 100   # shoots/m² — Enhalus acoroides

# Quadrat area for shoot density calculations (15 cm × 15 cm in metres²)
HEALTH_QUADRAT_AREA_M2 <- 0.15 * 0.15  # = 0.0225 m²

# ============================================================
# 1. Load data
# ============================================================

message("Loading seagrass cover data (Sheet 1: SEAGRASS COVER)...")
cover_raw <- read_excel(DATA_FILE, sheet = "SEAGRASS COVER")

message("Loading seagrass health data (Sheet 2: SEAGRASS HEALTH)...")
health_raw <- read_excel(DATA_FILE, sheet = "SEAGRASS HEALTH")

message(sprintf("  Cover sheet:  %d rows, %d columns", nrow(cover_raw), ncol(cover_raw)))
message(sprintf("  Health sheet: %d rows, %d columns", nrow(health_raw), ncol(health_raw)))

# ============================================================
# 2. QA/QC
# ============================================================

message("Running QA/QC...")

# ------------------------------------------------------------
# 2a. Standardise column names
# ------------------------------------------------------------

# Cover sheet — rename to clean snake_case equivalents
cover <- cover_raw |>
  rename(
    date          = Date,
    county        = County,
    area          = Area,
    latitude      = Latitude,
    longitude     = Longitude,
    quadrat_5m    = `Quadrant 5m*5m`,
    quadrat_50cm  = `Quadrant 50 cm*50cm`,
    cover_pct     = `Percentage Cover`,
    substrate     = `Substrate type`
  )

# Health sheet — rename to clean snake_case equivalents
health <- health_raw |>
  rename(
    date           = Date,
    county         = County,
    area           = Area,
    zone           = Zone,
    latitude       = `Latitude (S)`,
    longitude      = `Longitude (E)`,
    quadrat_15cm   = `Quadrant 15 cm*15cm`,
    species        = `Seagrass species`,
    shoot_density  = `Shoot density`,
    canopy_height  = `Canopy height`
  )

# ------------------------------------------------------------
# 2b. Taxonomy standardisation
# ------------------------------------------------------------
# Correct known misspellings to accepted species names.
# Source: WoRMS / accepted seagrass nomenclature.

taxonomy_fix <- c(
  "Halophilia ovalis"     = "Halophila ovalis",
  "Halophilia stipulacea" = "Halophila stipulacea",
  "Thelassia hemprichii"  = "Thalassia hemprichii",
  "Halodulle wrightii"    = "Halodule wrightii",
  "Halodule wrightii"     = "Halodule wrightii"   # correct form passthrough
)

cover <- cover |>
  mutate(substrate = str_replace_all(substrate, taxonomy_fix))

health <- health |>
  mutate(species = str_replace_all(species, taxonomy_fix))

message(sprintf("  Taxonomy corrections applied to cover and health sheets."))

# ------------------------------------------------------------
# 2c. Date parsing
# ------------------------------------------------------------
# Handle mixed date formats (ymd, dmy) and Excel date serial integers.

parse_dates <- function(x) {
  if (is.numeric(x)) {
    # Excel stores dates as integer days since 1899-12-30
    as.Date(as.numeric(x), origin = "1899-12-30")
  } else {
    parse_date_time(x, orders = c("ymd", "dmy"), quiet = TRUE) |>
      as.Date()
  }
}

cover <- cover |>
  mutate(date = parse_dates(date))

health <- health |>
  mutate(date = parse_dates(date))

# ------------------------------------------------------------
# 2d. Coordinate validation
# ------------------------------------------------------------
# Coordinates are stored as character strings with a degree symbol (°) suffix,
# e.g. "03.93582°" or "-3.934860°".  The column headers "Latitude (S)" and
# "Latitude" imply southern hemisphere, but the negative sign is absent in
# most rows.  Steps:
#   1. Strip the degree symbol.
#   2. Convert to numeric.
#   3. Force all latitudes to negative (Kenya coast: approx. -1 to -4°S).
#      Any row already stored as negative is left unchanged via -abs().

parse_coords <- function(x) {
  x |>
    str_remove_all("°") |>       # strip degree symbol
    str_trim() |>
    as.numeric()
}

cover <- cover |>
  mutate(
    latitude  = -abs(parse_coords(latitude)),   # enforce southern hemisphere
    longitude =  parse_coords(longitude)
  )

health <- health |>
  mutate(
    latitude  = -abs(parse_coords(latitude)),   # enforce southern hemisphere
    longitude =  parse_coords(longitude)
  )

# Report any remaining NAs (genuine missing coords, not format issues)
n_na_lat_cover  <- sum(is.na(cover$latitude))
n_na_lat_health <- sum(is.na(health$latitude))
message(sprintf(
  "  Coord parsing — cover NAs: %d lat, health NAs: %d lat",
  n_na_lat_cover, n_na_lat_health
))

# Sanity check: all latitudes should be in the -1 to -4.5 range for Kilifi
out_of_range <- cover |>
  filter(!is.na(latitude) & (latitude < -5 | latitude > 0))
if (nrow(out_of_range) > 0) {
  warning(sprintf(
    "%d cover rows have latitude outside expected range (-1 to -4.5). Check data.",
    nrow(out_of_range)
  ))
}

# Add a coordinate validity flag column (TRUE = parsed and in range)
cover <- cover |>
  mutate(coord_ok = !is.na(latitude) & latitude < 0 & latitude > -5 &
           !is.na(longitude) & longitude > 39 & longitude < 41)

health <- health |>
  mutate(coord_ok = !is.na(latitude) & latitude < 0 & latitude > -5 &
           !is.na(longitude) & longitude > 39 & longitude < 41)

# ------------------------------------------------------------
# 2e. Numeric type coercion
# ------------------------------------------------------------
# Ensure cover_pct, shoot_density, and canopy_height are numeric.

cover <- cover |>
  mutate(cover_pct = suppressWarnings(as.numeric(cover_pct)))

health <- health |>
  mutate(
    shoot_density = suppressWarnings(as.numeric(shoot_density)),
    canopy_height = suppressWarnings(as.numeric(canopy_height))
  )

# Report coercion-induced NAs
n_na_cover   <- sum(is.na(cover$cover_pct))
n_na_density <- sum(is.na(health$shoot_density))
n_na_canopy  <- sum(is.na(health$canopy_height))
message(sprintf("  NA values after coercion — cover_pct: %d  shoot_density: %d  canopy_height: %d",
                n_na_cover, n_na_density, n_na_canopy))

# NOTE: 1,151 NA shoot_density rows are canopy-height-only observations (not errors).
# The field team recorded canopy height for all quadrats but shoot counts for only ~285.
# Shoot density metrics are therefore based on a subset of the data — see n_quadrats in outputs.

# ------------------------------------------------------------
# 2f-extra. Flag extreme canopy height outliers
# ------------------------------------------------------------
# Cymodocea serrulata max realistic height ~10 cm; any value > 100 cm is suspect.
canopy_outliers <- health |>
  filter(!is.na(canopy_height) & canopy_height > 100)
if (nrow(canopy_outliers) > 0) {
  warning(sprintf(
    "%d canopy height value(s) exceed 100 cm and are likely data entry errors. Flagging and excluding from aggregation.",
    nrow(canopy_outliers)
  ))
  message(sprintf("  Canopy outliers (>100 cm): %d row(s) — see below:", nrow(canopy_outliers)))
  canopy_outliers |>
    select(area, zone, species, shoot_density, canopy_height) |>
    as.data.frame() |>
    print()
  health <- health |>
    mutate(canopy_height = if_else(canopy_height > 100, NA_real_, canopy_height))
}

# ------------------------------------------------------------
# 2f. Exclude Sand substrate from cover sheet
# ------------------------------------------------------------
# "Sand" is not a seagrass species; exclude from all species-level aggregation.

cover_seagrass <- cover |>
  filter(!str_detect(substrate, regex("^sand$", ignore_case = TRUE)))

n_sand <- nrow(cover) - nrow(cover_seagrass)
message(sprintf("  Excluded %d Sand rows from cover sheet (%d seagrass rows retained).",
                n_sand, nrow(cover_seagrass)))

message("QA/QC complete.")

# ============================================================
# 3. Cover aggregation
# ============================================================

message("Aggregating seagrass cover by site and species...")

# ------------------------------------------------------------
# 3a. Species-level mean cover per site
# ------------------------------------------------------------
# Mean Percentage Cover per area per species, averaged across all
# sub-quadrats and 5m x 5m plots within each site.

cover_by_species <- cover_seagrass |>
  filter(!is.na(cover_pct)) |>
  group_by(area, species = substrate) |>
  summarise(mean_cover_pct = mean(cover_pct, na.rm = TRUE), .groups = "drop")

# ------------------------------------------------------------
# 3b. Total seagrass cover per site (correct aggregation)
# ------------------------------------------------------------
# CORRECT METHOD: sum species covers within each sub-quadrat first (multiple species
# can co-occur in the same quadrat), cap per-quadrat total at 100% (physical ceiling),
# then take the mean across all sub-quadrats within the site.
# NOTE: Summing species means directly (naive method) overcounts because it mixes
# sub-quadrats with different species compositions and inflates totals to >>100%.

cover_by_quadrat <- cover_seagrass |>
  filter(!is.na(cover_pct)) |>
  group_by(area, quadrat_5m, quadrat_50cm) |>
  summarise(
    quadrat_total_cover = pmin(sum(cover_pct, na.rm = TRUE), 100),  # cap at 100%
    .groups = "drop"
  )

cover_site_totals <- cover_by_quadrat |>
  group_by(area) |>
  summarise(
    Total_Cover_pct  = mean(quadrat_total_cover, na.rm = TRUE),
    n_quadrats_cover = n(),
    .groups = "drop"
  ) |>
  # Join species richness from species-level aggregation
  left_join(
    cover_seagrass |>
      filter(!is.na(cover_pct)) |>
      group_by(area) |>
      summarise(Species_Richness = n_distinct(substrate), .groups = "drop"),
    by = "area"
  )

# ------------------------------------------------------------
# 3c. Species composition (% of total seagrass cover)
# ------------------------------------------------------------
# Each species as a proportion of the site total cover.

cover_composition <- cover_by_species |>
  left_join(cover_site_totals |> select(area, Total_Cover_pct), by = "area") |>
  mutate(species_pct_of_total = (mean_cover_pct / Total_Cover_pct) * 100)

# ------------------------------------------------------------
# 3d. Pivot to wide format
# ------------------------------------------------------------
# One column per species showing mean cover %, plus total cover and richness.
# Column names: e.g. Cymodocea_rotundata_pct

cover_wide <- cover_composition |>
  select(area, species, mean_cover_pct) |>
  mutate(
    # Clean species name for use as column header
    col_name = paste0(str_replace_all(species, " ", "_"), "_pct")
  ) |>
  select(area, col_name, mean_cover_pct) |>
  pivot_wider(names_from = col_name, values_from = mean_cover_pct, values_fill = 0) |>
  left_join(cover_site_totals, by = "area") |>
  # Move summary columns to the front
  select(Area = area, Total_Cover_pct, Species_Richness, everything())

message(sprintf("  Cover aggregation complete: %d sites, %d species observed.",
                nrow(cover_wide),
                nrow(cover_site_totals |> left_join(
                  cover_by_species |> distinct(area, species),
                  by = "area"
                ) |> distinct(species))))

# ============================================================
# 4. Health metrics
# ============================================================

message("Computing seagrass health metrics (shoot density and canopy height)...")

# ------------------------------------------------------------
# 4a. Convert raw shoot count to shoots per m²
# ------------------------------------------------------------
# Quadrat size: 15 cm × 15 cm = 0.0225 m²
# shoots/m² = raw count ÷ 0.0225

health <- health |>
  mutate(
    # PROVISIONAL — confirm quadrat area with field team
    shoots_per_m2 = shoot_density / HEALTH_QUADRAT_AREA_M2
  )

# ------------------------------------------------------------
# 4b. Site-level mean shoot density and canopy height per species
# ------------------------------------------------------------

health_site <- health |>
  filter(!is.na(shoots_per_m2), !is.na(canopy_height)) |>
  group_by(area, species) |>
  summarise(
    Mean_Shoots_m2        = mean(shoots_per_m2, na.rm = TRUE),
    Mean_Canopy_height_cm = mean(canopy_height,  na.rm = TRUE),
    n_quadrats            = n(),
    .groups = "drop"
  ) |>
  rename(Area = area, Species = species)

# ------------------------------------------------------------
# 4c. Zone-level breakdown: shoot density and canopy height
# ------------------------------------------------------------

health_zone <- health |>
  filter(!is.na(shoots_per_m2), !is.na(canopy_height), !is.na(zone)) |>
  group_by(area, zone, species) |>
  summarise(
    Mean_Shoots_m2        = mean(shoots_per_m2, na.rm = TRUE),
    Mean_Canopy_height_cm = mean(canopy_height,  na.rm = TRUE),
    n_quadrats            = n(),
    .groups = "drop"
  ) |>
  rename(Area = area, Zone = zone, Species = species)

# ------------------------------------------------------------
# 4d. Site-level overall means (across all species)
# ------------------------------------------------------------

health_site_overall <- health |>
  filter(!is.na(shoots_per_m2), !is.na(canopy_height)) |>
  group_by(area) |>
  summarise(
    Overall_Mean_Shoots_m2        = mean(shoots_per_m2, na.rm = TRUE),
    Overall_Mean_Canopy_height_cm = mean(canopy_height,  na.rm = TRUE),
    .groups = "drop"
  ) |>
  rename(Area = area)

message(sprintf("  Health metrics complete: %d site-species combinations, %d zone-species combinations.",
                nrow(health_site), nrow(health_zone)))

# ============================================================
# 5. Condition index normalisation
# ============================================================

message("Computing condition indices (0-1 normalisation)...")

# ------------------------------------------------------------
# 5a. Cover condition index
# ------------------------------------------------------------
# CI_cover = pmin(total_cover / 60, 1.0)
# Reference: 60% total seagrass cover
# PROVISIONAL — confirm against WIO literature

ci_cover <- cover_site_totals |>
  mutate(
    CI_cover = pmin(Total_Cover_pct / REF_COVER_PCT, 1.0)  # PROVISIONAL — confirm against WIO literature
  ) |>
  rename(Area = area)

# ------------------------------------------------------------
# 5b. Species richness condition index
# ------------------------------------------------------------
# CI_richness = richness / max(richness) across all sites
# Reference: maximum observed species richness
# PROVISIONAL — confirm against WIO literature

max_richness <- max(cover_site_totals$Species_Richness, na.rm = TRUE)

ci_richness <- cover_site_totals |>
  mutate(
    CI_richness = Species_Richness / max_richness  # PROVISIONAL — confirm against WIO literature
  ) |>
  rename(Area = area)

# ------------------------------------------------------------
# 5c. Shoot density condition index (species-specific references)
# ------------------------------------------------------------
# Species-specific reference levels applied where available;
# all others normalised to the maximum observed density across sites.
# PROVISIONAL — confirm against WIO literature

# First get max observed density per species (for "other" species normalisation)
max_density_by_species <- health_site |>
  group_by(Species) |>
  summarise(max_density = max(Mean_Shoots_m2, na.rm = TRUE), .groups = "drop")

ci_density <- health_site |>
  left_join(max_density_by_species, by = "Species") |>
  mutate(
    # Assign species-specific reference values where known
    # PROVISIONAL — confirm against WIO literature
    ref_density = case_when(
      Species == "Thalassia hemprichii"  ~ REF_DENSITY_Th,
      Species == "Cymodocea serrulata"   ~ REF_DENSITY_Cs,
      Species == "Cymodocea rotundata"   ~ REF_DENSITY_Cr,
      Species == "Halodule uninervis"    ~ REF_DENSITY_Hu,
      Species == "Enhalus acoroides"     ~ REF_DENSITY_Ea,
      TRUE                               ~ max_density  # other species: max observed
    ),
    CI_density = pmin(Mean_Shoots_m2 / ref_density, 1.0)  # PROVISIONAL — confirm against WIO literature
  )

# ------------------------------------------------------------
# 5d. Composite condition index per site
# ------------------------------------------------------------
# Mean of all available CIs: cover, richness, and species-level density CIs.

# Site-level mean density CI (averaged across species per site)
ci_density_site <- ci_density |>
  group_by(Area) |>
  summarise(CI_density_mean = mean(CI_density, na.rm = TRUE), .groups = "drop")

# Join all CIs and compute composite
ci_composite <- ci_cover |>
  select(Area, CI_cover) |>
  left_join(ci_richness |> select(Area, CI_richness), by = "Area") |>
  left_join(ci_density_site, by = "Area") |>
  rowwise() |>
  mutate(
    # Composite = mean of available (non-NA) CIs
    CI_composite = mean(c(CI_cover, CI_richness, CI_density_mean), na.rm = TRUE)
  ) |>
  ungroup()

message("Condition index normalisation complete.")

# ============================================================
# 6. SEEA EA condition table
# ============================================================

message("Building SEEA EA condition table...")

# Helper: create a standard SEEA EA row
seea_row <- function(area, indicator_group, indicator, variable, unit,
                     value_2024, ci_2024, reference_value,
                     reference_confidence, notes) {
  tibble(
    Ecosystem_type        = "Seagrass meadows (M1.1)",
    Area                  = area,
    Indicator_group       = indicator_group,
    Indicator             = indicator,
    Variable              = variable,
    Unit                  = unit,
    Value_2024            = value_2024,
    CI_2024               = ci_2024,
    Reference_value       = reference_value,
    Reference_confidence  = reference_confidence,
    Notes                 = notes
  )
}

# ------------------------------------------------------------
# 6a. Cover indicators
# ------------------------------------------------------------

seea_cover <- cover_site_totals |>
  rename(Area = area) |>
  left_join(ci_cover |> select(Area, CI_cover), by = "Area") |>
  left_join(ci_richness |> select(Area, CI_richness), by = "Area") |>
  select(Area, Total_Cover_pct, Species_Richness, CI_cover, CI_richness) |>
  pmap_dfr(function(Area, Total_Cover_pct, Species_Richness,
                    CI_cover, CI_richness) {
    bind_rows(
      seea_row(
        area                 = Area,
        indicator_group      = "Biotic condition — Seagrass cover",
        indicator            = "Total seagrass cover",
        variable             = "Mean percentage cover across all species",
        unit                 = "%",
        value_2024           = round(Total_Cover_pct, 2),
        ci_2024              = round(CI_cover, 3),
        reference_value      = REF_COVER_PCT,
        reference_confidence = "LOW",     # PROVISIONAL — confirm against WIO literature
        notes                = "PROVISIONAL reference: 60% cover. Confirm against WIO seagrass literature."
      ),
      seea_row(
        area                 = Area,
        indicator_group      = "Biotic condition — Seagrass cover",
        indicator            = "Species richness",
        variable             = "Number of seagrass species observed",
        unit                 = "count",
        value_2024           = Species_Richness,
        ci_2024              = round(CI_richness, 3),
        reference_value      = max_richness,
        reference_confidence = "LOW",     # PROVISIONAL — confirm against WIO literature
        notes                = "Reference = maximum observed richness across all Kenya pilot sites."
      )
    )
  })

# ------------------------------------------------------------
# 6b. Health indicators (shoot density and canopy height)
# ------------------------------------------------------------

seea_health <- ci_density |>
  pmap_dfr(function(Area, Species, Mean_Shoots_m2, Mean_Canopy_height_cm,
                    n_quadrats, max_density, ref_density, CI_density) {

    ref_conf <- case_when(
      Species %in% c("Thalassia hemprichii",
                     "Cymodocea serrulata",
                     "Cymodocea rotundata",
                     "Halodule uninervis",
                     "Enhalus acoroides") ~ "LOW",   # PROVISIONAL — confirm against WIO literature
      TRUE                                ~ "LOW"    # max observed — no external reference
    )

    density_note <- case_when(
      Species == "Thalassia hemprichii"  ~
        paste0("PROVISIONAL ref 800 shoots/m² (Th. hemprichii WIO). Confirm against WIO literature."),
      Species == "Cymodocea serrulata"   ~
        paste0("PROVISIONAL ref 500 shoots/m² (C. serrulata WIO). Confirm against WIO literature."),
      Species == "Cymodocea rotundata"   ~
        paste0("PROVISIONAL ref 500 shoots/m² (C. rotundata WIO). Confirm against WIO literature."),
      Species == "Halodule uninervis"    ~
        paste0("PROVISIONAL ref 1000 shoots/m² (H. uninervis WIO). Confirm against WIO literature."),
      Species == "Enhalus acoroides"     ~
        paste0("PROVISIONAL ref 100 shoots/m² (E. acoroides WIO). Confirm against WIO literature."),
      TRUE                               ~
        paste0("Reference = max observed across sites (", round(max_density, 1),
               " shoots/m²). No published WIO baseline available.")
    )

    bind_rows(
      seea_row(
        area                 = Area,
        indicator_group      = "Biotic condition — Seagrass health",
        indicator            = paste0("Shoot density — ", Species),
        variable             = "Mean shoot density",
        unit                 = "shoots/m2",
        value_2024           = round(Mean_Shoots_m2, 1),
        ci_2024              = round(CI_density, 3),
        reference_value      = ref_density,
        reference_confidence = ref_conf,
        notes                = density_note
      ),
      seea_row(
        area                 = Area,
        indicator_group      = "Biotic condition — Seagrass health",
        indicator            = paste0("Canopy height — ", Species),
        variable             = "Mean canopy height",
        unit                 = "cm",
        value_2024           = round(Mean_Canopy_height_cm, 2),
        ci_2024              = NA_real_,   # no condition index for canopy height (no reference)
        reference_value      = NA_real_,
        reference_confidence = "LOW",
        notes                = "No published WIO canopy height reference level. Reported for information only."
      )
    )
  })

# ------------------------------------------------------------
# 6c. Composite condition index rows
# ------------------------------------------------------------

seea_composite <- ci_composite |>
  pmap_dfr(function(Area, CI_cover, CI_richness, CI_density_mean, CI_composite) {
    seea_row(
      area                 = Area,
      indicator_group      = "Biotic condition — Composite",
      indicator            = "Composite condition index",
      variable             = "Mean of cover CI, richness CI, and mean shoot density CI",
      unit                 = "index (0-1)",
      value_2024           = round(CI_composite, 3),
      ci_2024              = round(CI_composite, 3),
      reference_value      = 1.0,
      reference_confidence = "LOW",
      notes                = paste0(
        "PROVISIONAL composite. Components: CI_cover=", round(CI_cover, 3),
        ", CI_richness=", round(CI_richness, 3),
        ", CI_density_mean=", round(CI_density_mean, 3), "."
      )
    )
  })

# Combine all SEEA EA rows
seea_table <- bind_rows(seea_cover, seea_health, seea_composite) |>
  arrange(Area, Indicator_group, Indicator)

message(sprintf("  SEEA EA condition table: %d rows.", nrow(seea_table)))

# ============================================================
# 7. Export outputs
# ============================================================

message("Writing outputs...")

# Ensure output directory exists
if (!dir.exists(OUTPUT_DIR)) {
  dir.create(OUTPUT_DIR, recursive = TRUE)
  message(sprintf("  Created output directory: %s", OUTPUT_DIR))
}

# 7a. Site-level cover (wide format)
write_csv(
  cover_wide,
  here("Kenya", "03_outputs", "KEN_seagrass_cover_site.csv")
)
message("  Written: KEN_seagrass_cover_site.csv")

# 7b. Site-level health (shoot density + canopy height by species)
write_csv(
  health_site,
  here("Kenya", "03_outputs", "KEN_seagrass_health_site.csv")
)
message("  Written: KEN_seagrass_health_site.csv")

# 7c. Zone-level health
write_csv(
  health_zone,
  here("Kenya", "03_outputs", "KEN_seagrass_health_zone.csv")
)
message("  Written: KEN_seagrass_health_zone.csv")

# 7d. SEEA EA condition account table
write_csv(
  seea_table,
  here("Kenya", "03_outputs", "KEN_seea_condition_account_seagrass.csv")
)
message("  Written: KEN_seea_condition_account_seagrass.csv")

message("Done. All outputs written to Kenya/03_outputs/")
message("")
message("IMPORTANT: All reference values are PROVISIONAL.")
message("  Confirm the following against peer-reviewed WIO seagrass literature before finalising:")
message(sprintf("  - Total cover reference: %d%%", REF_COVER_PCT))
message(sprintf("  - Shoot density refs: Th=%d, Cs=%d, Cr=%d, Hu=%d, Ea=%d shoots/m2",
                REF_DENSITY_Th, REF_DENSITY_Cs, REF_DENSITY_Cr,
                REF_DENSITY_Hu, REF_DENSITY_Ea))
message("  - Health quadrat area: 0.0225 m2 (15cm x 15cm) — confirm with field team")
