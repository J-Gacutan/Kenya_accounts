# =============================================================================
# Coral Reef Condition Analysis — Kenya SEEA EA Accounts
# Kilifi County | Photic Coral Reefs (M1.3) | 2024-2025
#
# Input:  8 Excel files — CCVA (Nov 2024), PU-GOAP (Nov 2024), COMRED (Jul 2025)
# Output: Site-level condition accounts, PA-disaggregated SEEA EA condition table
#
# Plan:    Kenya/docs/accounts/cond_reef_coral_fish_invert_plan.md
# Baselines: Kenya/docs/rag/academic/BASELINE_REFERENCE_TABLE.md
# =============================================================================

library(here)
library(readxl)
library(janitor)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)
library(lubridate)

# =============================================================================
# 0. CONFIG
# =============================================================================

RAW_DIR    <- here("Kenya", "01_inputs", "raw_data", "coral_reef")
META_DIR   <- here("Kenya", "01_inputs", "metadata")
OUT_DIR    <- here("Kenya", "03_outputs")

# File paths — RAW_DIR / META_DIR already use here(), so file.path() is fine
F_KLF      <- file.path(RAW_DIR, "KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx")
F_CCVA_INV <- file.path(RAW_DIR, "CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx")
F_COMRED_F <- file.path(RAW_DIR, "COMRED_OCEANS-JULY2025-FISH-DATA.xlsx")
F_COMRED_C <- file.path(RAW_DIR, "COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx")
F_COMRED_B <- file.path(RAW_DIR, "COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx")
F_PUGOAP   <- file.path(RAW_DIR, "PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx")
F_FISHBASE <- file.path(META_DIR, "fishbase_params_kenya.csv")

# ----------------------------------------------------------------------------
# TRANSECT AREA — PENDING CONFIRMATION WITH FIELD TEAM
# Standard WIO UVC belt = 50 m x 5 m = 250 m² (CCVA) and variable for COMRED.
# Update TRANSECT_AREA_M2 once confirmed with Dr. Karisa / Dr. Thoya / KMFRI.
# See plan: Open Question 1.
TRANSECT_AREA_M2   <- 250     # [PENDING] assumed 50 m x 5 m for CCVA fish
TRANSECT_AREA_HA   <- TRANSECT_AREA_M2 / 10000
RECRUIT_QUADRAT_M2 <- 1.0     # 1 x 1 m quadrats (confirmed from metadata)
# ----------------------------------------------------------------------------

# Reference levels (BASELINE_REFERENCE_TABLE.md — Part 2, Themes 7-10)
REF <- list(
  fish_biomass_target = 1150,   # kg/ha; McClanahan et al. 2016 WIO conservation target
  fish_biomass_floor  = 600,    # kg/ha; McClanahan et al. 2016 sustainability floor
  coral_cover_good    = 30,     # % live coral; GCRMN 2021 / Obura et al. 2022
  bleach_background   = 5,      # % colonies; Hoegh-Guldberg 1999 non-bleaching year
  disease_background  = 2,      # % colonies; Bourne et al. 2009
  recruit_density_wio = 1.0,    # recruits/m²; Hughes et al. 2010 WIO healthy (LOW-MED confidence)
  cots_outbreak_ha    = 15,     # ind/ha; Dulvy et al. 2021
  urchin_ref_m2       = 1.75    # ind/m²; provisional midpoint 1.5-2; LOW confidence
)

# Survey periods (used as account periods)
PERIOD_NOV24 <- "Nov_2024"
PERIOD_JUL25 <- "Jul_2025"

# Stringly-typed constants for SEEA output (reused in build_seea_rows)
ECOSYSTEM_TYPE   <- "Coral reef (M1.3)"
GEOGRAPHIC_SCOPE <- "Kilifi County, Kenya"

# Column detection patterns for size-bin pivots (adult structure + recruits)
ADULT_SIZE_PATTERN   <- "^x[0-9]|^[0-9]|gt_|^x_[0-9]"
RECRUIT_SIZE_PATTERN <- "^[0-9]|^r_|^x[0-9]"

# Protected area classification (based on known site names — update if sites added)
PA_CLASSIFICATION <- tribble(
  ~site_std,                    ~pa_name,                     ~pa_type,
  "Watamu Coral Garden",        "Watamu Marine Park",         "No-take MPA",
  "Turtle Reef",                "Watamu Marine Park",         "No-take MPA",
  "Whale island/Uyombo",        "Watamu Marine Park",         "No-take MPA",
  "Richard Bennett",            "Watamu Marine Park",         "No-take MPA",
  "Malindi Coral Garden",       "Malindi MPA",                "Managed MPA",
  "Ngomeni Outer",              "Malindi MPA",                "Managed MPA",
  "Kanamai Community Park",     "Kanamai Community Park",     "Community CPA",
  "Kuruwitu Community Park",    "Kuruwitu Community Park",    "Community CPA",
  "Roka",                       "Unprotected",                "Open access",
  "Roka 1",                     "Unprotected",                "Open access",
  "Roka 2",                     "Unprotected",                "Open access",
  "Wesa",                       "Unprotected",                "Open access",
  "Wesa 1",                     "Unprotected",                "Open access",
  "Wesa 2",                     "Unprotected",                "Open access",
  "Uyombo",                     "Unprotected",                "Open access",
  "Bofa",                       "Unprotected",                "Open access",
  "Jumba Ruins",                "Unprotected",                "Open access",
  "Navy",                       "Unprotected",                "Open access",
  "Takaungu",                   "Unprotected",                "Open access",
  "Marereni",                   "Unprotected",                "Open access",
  "Ngomeni",                    "Unprotected",                "Open access",
  "Sultan Palace",              "Unprotected",                "Open access"
)

# Trophic group lookup by family
TROPHIC_LOOKUP <- tribble(
  ~family,           ~trophic_group,
  "Acanthuridae",    "Herbivore",
  "Scaridae",        "Herbivore",
  "Siganidae",       "Herbivore",
  "Kyphosidae",      "Herbivore",
  "Epinephelidae",   "Piscivore",
  "Serranidae",      "Piscivore",
  "Lutjanidae",      "Carnivore",
  "Lethrinidae",     "Carnivore",
  "Carangidae",      "Piscivore",
  "Haemulidae",      "Carnivore",
  "Mullidae",        "Carnivore",
  "Labridae",        "Carnivore",
  "Balistidae",      "Omnivore",
  "Tetraodontidae",  "Omnivore",
  "Pomacentridae",   "Planktivore",
  "Chaetodontidae",  "Corallivore",
  "Pomacanthidae",   "Omnivore",
  "Holocentridae",   "Carnivore"
)

# Coral health condition categories
HEALTH_COLS <- c("healthy", "pale", "bleached", "diseased", "dead")

# Coral adult size bins (midpoint diameters in cm)
ADULT_SIZE_BINS  <- c("11_20" = 15, "21_40" = 30, "41_80" = 60,
                      "80_160" = 120, "160_320" = 240, "gt_320" = 400)

# Coral recruit size bins (midpoint diameters in cm)
RECRUIT_SIZE_BINS <- c("r_0_2_5" = 1.25, "r_2_6_5" = 3.8, "r_6_10" = 8.0)

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

# Fix GPS coordinates to decimal degrees.
# Handles two common field-data errors:
#   1. Sign errors: positive latitude in S hemisphere (e.g. 3.5 -> -3.5)
#   2. Missing decimal point: integer-encoded coords (e.g. -2303851 -> -23.03851)
# Values that cannot be recovered are returned as NA with a warning.
fix_gps <- function(x, valid_min, valid_max) {
  x <- suppressWarnings(as.numeric(x))
  needs_fix <- !is.na(x) & (x < valid_min | x > valid_max)
  for (i in which(needs_fix)) {
    val <- x[i]
    # 1. Sign flip: covers positive-lat entry for southern-hemisphere sites
    if (!is.na(val) && -val >= valid_min && -val <= valid_max) {
      x[i] <- -val
      next
    }
    # 2. Missing decimal: divide by 10 up to 10 times (handles up to 8-digit integers)
    n_div <- 0L
    while (!is.na(val) && (val < valid_min || val > valid_max) && n_div < 10L) {
      val   <- val / 10
      n_div <- n_div + 1L
    }
    if (!is.na(val) && val >= valid_min && val <= valid_max) {
      x[i] <- val
    } else {
      warning(sprintf("fix_gps: could not recover value %s to [%s, %s] — set to NA",
                      x[i], valid_min, valid_max))
      x[i] <- NA_real_
    }
  }
  x
}

# Parse fish size range string to numeric midpoint ("5--10" -> 7.5)
parse_size_mid <- function(x) {
  x <- str_trim(as.character(x))
  parsed <- str_match(x, "^(\\d+(?:\\.\\d+)?)\\s*-+\\s*(\\d+(?:\\.\\d+)?)$")
  lo <- suppressWarnings(as.numeric(parsed[, 2]))
  hi <- suppressWarnings(as.numeric(parsed[, 3]))
  ifelse(!is.na(lo) & !is.na(hi), (lo + hi) / 2, suppressWarnings(as.numeric(x)))
}

# Standardise location / site names (vectorised lookup)
SITE_NAME_MAP <- c(
  "Sultance palace"        = "Sultan Palace",
  "Sultan palace"          = "Sultan Palace",
  "Kilifi Wesa"            = "Wesa",
  "Richard Bennet"         = "Richard Bennett",
  "Richard Benet"          = "Richard Bennett",
  "Richard Bennette"       = "Richard Bennett",   # COMRED typo (extra 'e')
  "Watamu marine park"     = "Watamu Coral Garden",
  "Watamu Marine Park"     = "Watamu Coral Garden",
  "Coral garden"           = "Watamu Coral Garden",
  "Coral Garden"           = "Watamu Coral Garden",
  "Ngomeni outer"          = "Ngomeni Outer",
  "Ras Ngomeni outer"      = "Ngomeni Outer",
  "Turtle reef"            = "Turtle Reef",        # case mismatch in COMRED
  "Jumba ruins"            = "Jumba Ruins",        # case mismatch in CCVA
  "Malindi Coral garden"   = "Malindi Coral Garden", # case mismatch in CCVA
  "Kanamai community park" = "Kanamai Community Park",
  "Kuruwitu community park"= "Kuruwitu Community Park",
  "Makofi ya chini"        = "Wesa",     # Wesa sub-site; update if sub-site tracking needed
  "Kijambani"              = "Roka",
  "Makofi (Wesa 1)"        = "Wesa 1"
)

standardise_site <- function(x) {
  coalesce(SITE_NAME_MAP[str_trim(x)], str_trim(x))
}

# Condition index for maximise-type indicators (clamp to [0, 1])
ci_max <- function(value, reference) pmin(value / reference, 1.0)

# Condition index for minimise-type indicators (inverted, clamp to [0, 1])
ci_min <- function(value, reference) pmax(1 - value / reference, 0.0)

# Condition index for optimum-range type (1 at optimum, declines away)
ci_opt <- function(value, optimum) pmax(1 - abs(value - optimum) / optimum, 0.0)

# =============================================================================
# 1. DATA INGESTION
# =============================================================================

cat("--- Step 1: Reading data files ---\n")

# --- 1a. Fish: KLF consolidated master (Nov 2024) ---
fish_klf_raw <- read_excel(F_KLF) |> clean_names()
cat(sprintf("  KLF fish: %d rows, %d cols\n", nrow(fish_klf_raw), ncol(fish_klf_raw)))

# --- 1b. Fish: COMRED Jul 2025 ---
fish_comred_raw <- read_excel(F_COMRED_F, sheet = 1) |> clean_names()
cat(sprintf("  COMRED fish: %d rows\n", nrow(fish_comred_raw)))

# --- 1c. Invertebrates: CCVA (only available source; COMRED Jul 2025 sheet is empty) ---
invert_raw <- read_excel(F_CCVA_INV, sheet = "CCVA INVERTERBRATES DATA") |> clean_names()
cat(sprintf("  CCVA inverts: %d rows\n", nrow(invert_raw)))

# --- 1d. PU-GOAP coral data (5 sheets, Nov 2024) ---
pugoap_sheets <- c(extent = "Extent", adult = "Adult size",
                   cond   = "Condition 1", recruits = "Recruits")
pugoap <- map(pugoap_sheets, \(sh) read_excel(F_PUGOAP, sheet = sh) |> clean_names())
walk2(pugoap, names(pugoap_sheets),
      \(df, nm) cat(sprintf("  PU-GOAP %s: %d rows\n", nm, nrow(df))))

# --- 1e. COMRED coral data (3 sheets, Jul 2025) ---
comred_coral_sheets <- c(adult = "Adult size class", recruits = "Recruits",
                         cond  = "Conditions")
comred_coral <- map(comred_coral_sheets,
                    \(sh) read_excel(F_COMRED_C, sheet = sh) |> clean_names())

# --- 1f. Benthic cover: COMRED-CORAL-DATA (authoritative; spans 2024-2025) ---
# File 4 (CORAL COVER) appears to be a subset of File 5 (CORAL-DATA); use File 5 only.
benthic_sheets <- c(major = "Major benthic category", genera = "Coral Genera")
benthic_comred <- map(benthic_sheets,
                      \(sh) read_excel(F_COMRED_B, sheet = sh) |> clean_names())

cat("--- Data ingestion complete ---\n\n")

# =============================================================================
# 2. QA/QC
# =============================================================================

cat("--- Step 2: QA/QC ---\n")

# Shared cleaner for both fish UVC sources (KLF master and COMRED Jul 2025).
# Removes template/empty rows, standardises taxonomy and site names, parses
# size midpoints. KLF includes reference_notes; COMRED does not — any_of()
# handles the difference transparently.
clean_fish_uvc <- function(raw, period) {
  raw |>
    mutate(date = suppressWarnings(
      coalesce(as_date(date), as.Date(as.numeric(date), origin = "1899-12-30"))
    )) |>
    filter(!is.na(date), !is.na(species),
           species != "", species != "0") |>
    mutate(
      site = standardise_site(coalesce(site_name_1, area_location)),
      latitude  = fix_gps(latitude,   valid_min = -5,  valid_max = -1),
      longitude = fix_gps(longtitude, valid_min = 38,  valid_max = 42),
      family           = str_to_title(str_trim(family_name)),
      species          = str_to_sentence(str_trim(species)),
      fish_size_mid_cm = parse_size_mid(fish_size_cm),
      total_number     = suppressWarnings(as.integer(total_number)),
      survey_period    = period
    ) |>
    filter(
      !is.na(fish_size_mid_cm),
      !is.na(total_number),
      total_number > 0
    ) |>
    rename(any_of(c(transect_no = "transcet_no"))) |>
    select(
      survey_period, date, site, latitude, longitude,
      transect_no, transect_length_m,
      family, species, total_number, fish_size_mid_cm,
      any_of("reference_notes")
    )
}

# ---------- 2a + 2b. Fish QA/QC -------------------------------------------

fish_klf    <- clean_fish_uvc(fish_klf_raw,    PERIOD_NOV24)
fish_comred <- clean_fish_uvc(fish_comred_raw, PERIOD_JUL25)

cat(sprintf("  KLF fish after QA/QC: %d -> %d rows\n",
            nrow(fish_klf_raw), nrow(fish_klf)))
cat(sprintf("  COMRED fish after QA/QC: %d -> %d rows\n",
            nrow(fish_comred_raw), nrow(fish_comred)))

# Bind fish surveys; trophic group assigned after FishBase join (Step 4)
fish_all <- bind_rows(fish_klf, fish_comred)

# ---------- 2c. CCVA invertebrates ----------------------------------------

invert <- invert_raw |>
  filter(!is.na(species), species != "", species != "0") |>
  mutate(
    site      = standardise_site(coalesce(site, location)),
    latitude  = fix_gps(latitude, valid_min = -5, valid_max = -1),
    longitude = fix_gps(longtitude, valid_min = 38, valid_max = 42),
    species   = str_to_sentence(str_trim(species)),
    family    = str_to_title(str_trim(family_name)),
    abundance = suppressWarnings(as.numeric(total_number)),
    date      = suppressWarnings(as_date(date)),
    survey_period = PERIOD_NOV24
  ) |>
  filter(!is.na(abundance)) |>
  rename(any_of(c(transect_no = "transcet_no"))) |>
  select(survey_period, date, site, latitude, longitude,
         transect_no, family, species, abundance)

cat(sprintf("  CCVA inverts after QA/QC: %d -> %d rows\n",
            nrow(invert_raw), nrow(invert)))

# ---------- 2d. Coral condition (PU-GOAP + COMRED) ------------------------
# Shared cleaner: fixes the duplicate-key rename bug (both "transect_number"
# and "transect" should map to "transect_no"; a named c() vector only keeps
# the last entry for a duplicate key, so rename_with() is used instead).

clean_coral_cond <- function(df, period) {
  df |>
    rename_with(\(x) "transect_no",
                any_of(c("transect_number", "transect"))) |>
    mutate(
      site          = standardise_site(site),
      genus         = str_to_sentence(str_trim(genus)),
      survey_period = period
    ) |>
    select(survey_period, site, genus,
           any_of(c("transect_no", "size_class")),
           any_of(HEALTH_COLS))
}

coral_cond <- bind_rows(
  clean_coral_cond(pugoap$cond,       PERIOD_NOV24),
  clean_coral_cond(comred_coral$cond, PERIOD_JUL25)
) |>
  mutate(across(all_of(HEALTH_COLS), \(x) suppressWarnings(as.numeric(x))))

# ---------- 2e. Coral adult size structure ---------------------------------

# PU-GOAP: identify size-bin columns by pattern (numeric ranges and ">")
clean_adult_size <- function(df, period) {
  size_cols <- names(df)[str_detect(names(df), "^x?[0-9]|^x?_?[0-9]|gt_|x_[0-9]")]
  df |>
    mutate(site = standardise_site(site),
           genus = str_to_sentence(str_trim(genus)),
           survey_period = period) |>
    select(survey_period, site, genus, any_of(c("transect_no", "transect")),
           any_of(size_cols)) |>
    mutate(across(any_of(size_cols), \(x) suppressWarnings(as.numeric(x))))
}

adult_pugoap  <- clean_adult_size(pugoap$adult,       PERIOD_NOV24)
adult_comred  <- clean_adult_size(comred_coral$adult, PERIOD_JUL25)

# ---------- 2f. Coral recruitment ------------------------------------------

clean_recruits <- function(df, period) {
  recruit_cols <- names(df)[str_detect(names(df), "^r_|^x?0_|^x?2_|^x?6_")]
  if (length(recruit_cols) == 0) {
    # Fallback: assume last numeric-looking columns before notes/collector are recruit counts
    recruit_cols <- names(df)[str_detect(names(df), "^[0-9]")]
  }
  df |>
    mutate(site = standardise_site(site),
           genus = str_to_sentence(str_trim(genus)),
           survey_period = period) |>
    select(survey_period, site, genus,
           any_of(c("transect_no", "transect", "quadrant")),
           any_of(recruit_cols)) |>
    mutate(across(any_of(recruit_cols), \(x) suppressWarnings(as.numeric(x))))
}

recruits_pugoap  <- clean_recruits(pugoap$recruits,       PERIOD_NOV24)
recruits_comred  <- clean_recruits(comred_coral$recruits, PERIOD_JUL25)

# ---------- 2g. Benthic cover (COMRED-CORAL-DATA, both years) ---------------

benthic <- benthic_comred$major |>
  mutate(
    site          = standardise_site(coalesce(site_name_1, area_location)),
    benthic_cat   = {
      raw  <- str_to_upper(str_trim(major_benthic_category))
      code <- str_extract(raw, "(?<=\\()\\w[^)]*(?=\\))")
      coalesce(code, raw)
    },
    pct_cover     = suppressWarnings(as.numeric(percent_cover)),
    survey_period = if_else(suppressWarnings(as.integer(year)) == 2024,
                            PERIOD_NOV24, PERIOD_JUL25)
  ) |>
  filter(!is.na(pct_cover)) |>
  select(survey_period, site, transect_no, benthic_cat, pct_cover)

# PU-GOAP extent sheet: rapid quadrat-based assessment across 7 stretches
benthic_pugoap <- pugoap$extent |>
  mutate(
    site          = standardise_site(location),
    survey_period = PERIOD_NOV24,
    live_coral_pct    = suppressWarnings(as.numeric(live_coral_percent)),
    dead_coral_pct    = suppressWarnings(as.numeric(dead_coral)),
    bleached_pct      = suppressWarnings(as.numeric(bleached_coral)),
    macroalgae_pct    = suppressWarnings(as.numeric(macro_algae_percent)),
    rubble_pct        = suppressWarnings(as.numeric(rubble_percent))
  ) |>
  filter(!is.na(live_coral_pct)) |>
  select(survey_period, site, live_coral_pct, dead_coral_pct,
         bleached_pct, macroalgae_pct, rubble_pct)

cat("--- QA/QC complete ---\n\n")

# =============================================================================
# 3. FISHBASE ALLOMETRIC PARAMETERS
# =============================================================================

cat("--- Step 3: FishBase allometric parameters ---\n")

# Expected CSV format (fishbase_params_kenya.csv):
# species, family, a, b, source
# Parupeneus macronemus, Mullidae, 0.01514, 3.011, FishBase
# Siganus sutor, Siganidae, 0.01622, 3.047, FishBase
# ... (one row per species; use family-level mean for unmatched species)

if (!file.exists(F_FISHBASE)) {
  warning(paste0(
    "\n[STEP 3 PENDING] FishBase parameters file not found:\n  ", F_FISHBASE,
    "\nFish biomass calculation (Steps 4) will be skipped.",
    "\nCreate the CSV with columns: species, family, a, b, source",
    "\nSee plan: Kenya/docs/accounts/cond_reef_coral_fish_invert_plan.md\n"
  ))
  fishbase_params <- NULL
} else {
  fishbase_params <- read.csv(F_FISHBASE) |>
    as_tibble() |>
    mutate(species = str_to_sentence(str_trim(species)),
           family  = str_to_title(str_trim(family)))
  cat(sprintf("  FishBase params loaded: %d species\n", nrow(fishbase_params)))
}

# =============================================================================
# 4. FISH BIOMASS & COMMUNITY METRICS
# =============================================================================

cat("--- Step 4: Fish biomass and community metrics ---\n")

if (is.null(fishbase_params)) {
  message("[Step 4 skipped — FishBase params not available]")
  fish_site <- NULL
} else {
  # --- 4a. Join allometric parameters to fish data ---
  # Species-level match first; fall back to family-level mean
  family_params <- fishbase_params |>
    group_by(family) |>
    summarise(a_family = mean(a, na.rm = TRUE),
              b_family = mean(b, na.rm = TRUE), .groups = "drop")

  fish_params <- fish_all |>
    left_join(fishbase_params |> select(species, a, b), by = "species") |>
    left_join(family_params, by = "family") |>
    mutate(
      a = coalesce(a, a_family),
      b = coalesce(b, b_family),
      param_source = case_when(
        !is.na(a) & !is.na(a_family) ~ "species",
        !is.na(a_family)             ~ "family_mean",
        TRUE                         ~ "missing"
      )
    )

  n_missing <- sum(fish_params$param_source == "missing")
  if (n_missing > 0)
    warning(sprintf("[Step 4] %d fish records missing allometric params — excluded from biomass", n_missing))

  # --- 4b. Assign trophic groups ---
  fish_params <- fish_params |>
    left_join(TROPHIC_LOOKUP, by = "family") |>
    mutate(trophic_group = coalesce(trophic_group, "Unknown"))

  # --- 4c. Biomass per record (W = a * L^b; grams per total count) ---
  # [PENDING] TRANSECT_AREA_M2 assumed 250 m² (50 m x 5 m); confirm with KMFRI
  fish_calcs <- fish_params |>
    filter(param_source != "missing", !is.na(fish_size_mid_cm)) |>
    mutate(
      biomass_g = a * (fish_size_mid_cm ^ b) * total_number,
      # Scale to per-ha using assumed transect area
      biomass_kg_ha = (biomass_g / 1000) / TRANSECT_AREA_HA,
      abundance_ha  = total_number / TRANSECT_AREA_HA
    )

  # --- 4d. Aggregate: transect level (sum within transect) ---
  fish_transect <- fish_calcs |>
    group_by(survey_period, site, transect_no) |>
    summarise(
      biomass_kg_ha    = sum(biomass_kg_ha, na.rm = TRUE),
      abundance_ha     = sum(abundance_ha, na.rm = TRUE),
      species_richness = n_distinct(species),
      n_records        = n(),
      .groups = "drop"
    )

  # --- 4e. Trophic composition: transect level ---
  fish_trophic_transect <- fish_calcs |>
    group_by(survey_period, site, transect_no, trophic_group) |>
    summarise(biomass_kg_ha = sum(biomass_kg_ha, na.rm = TRUE), .groups = "drop")

  # --- 4f. Site-level means (mean ± SE across transects) ---
  fish_site <- fish_transect |>
    group_by(survey_period, site) |>
    summarise(
      mean_biomass_kg_ha = mean(biomass_kg_ha, na.rm = TRUE),
      se_biomass_kg_ha   = sd(biomass_kg_ha, na.rm = TRUE) / sqrt(n()),
      mean_abundance_ha  = mean(abundance_ha, na.rm = TRUE),
      mean_richness      = mean(species_richness, na.rm = TRUE),
      n_transects        = n(),
      .groups = "drop"
    )

  # Trophic composition: site-level % biomass per group
  fish_trophic_site <- fish_trophic_transect |>
    group_by(survey_period, site, trophic_group) |>
    summarise(mean_biomass_kg_ha = mean(biomass_kg_ha, na.rm = TRUE), .groups = "drop") |>
    group_by(survey_period, site) |>
    mutate(pct_biomass = mean_biomass_kg_ha / sum(mean_biomass_kg_ha) * 100) |>
    ungroup()

  cat(sprintf("  Fish biomass calculated: %d site × period combinations\n",
              nrow(fish_site)))
}

# =============================================================================
# 5. INVERTEBRATE METRICS
# =============================================================================

cat("--- Step 5: Invertebrate metrics ---\n")

# Species of interest (adjust exact strings to match clean data)
SPP_URCHIN  <- c("Diadema setosum", "Echinometra mathaei",
                 "Diadema savignyi", "Echinothrix diadema")
SPP_COTS    <- c("Acanthaster planci", "Acanthaster cf solaris",
                 "Crown of thorns", "Crown-of-thorns")
SPP_TRIDACNA <- c("Tridacna squamosa", "Tridacna maxima", "Giant clam")
SPP_CUCUMBER <- c("Holothuria scabra", "Holothuria atra", "Actinopyga miliaris",
                  "Thelenota ananas", "Bohadschia argus")

invert_metrics <- invert |>
  mutate(
    is_urchin   = species %in% SPP_URCHIN | str_detect(species, regex("urchin", ignore_case = TRUE)),
    is_cots     = species %in% SPP_COTS | str_detect(species, regex("acanthaster|crown", ignore_case = TRUE)),
    is_tridacna = species %in% SPP_TRIDACNA | str_detect(species, regex("tridacna|giant clam", ignore_case = TRUE)),
    is_cucumber = species %in% SPP_CUCUMBER | str_detect(family, regex("holothuridae|stichopodidae", ignore_case = TRUE))
  )

# Transect-level counts
invert_transect <- invert_metrics |>
  group_by(survey_period, site, transect_no) |>
  summarise(
    urchin_count   = sum(abundance[is_urchin],   na.rm = TRUE),
    cots_count     = sum(abundance[is_cots],     na.rm = TRUE),
    tridacna_count = sum(abundance[is_tridacna], na.rm = TRUE),
    cucumber_count = sum(abundance[is_cucumber], na.rm = TRUE),
    .groups = "drop"
  ) |>
  mutate(
    # Scale to per-ha using assumed transect area [PENDING confirmation]
    urchin_density_ha  = urchin_count / TRANSECT_AREA_HA,
    cots_density_ha    = cots_count   / TRANSECT_AREA_HA,
    # Scale urchin to ind/m² for reference comparison
    urchin_density_m2  = urchin_count / TRANSECT_AREA_M2
  )

# Site-level means
invert_site <- invert_transect |>
  group_by(survey_period, site) |>
  summarise(
    mean_urchin_m2      = mean(urchin_density_m2, na.rm = TRUE),
    se_urchin_m2        = sd(urchin_density_m2, na.rm = TRUE)  / sqrt(n()),
    mean_cots_ha        = mean(cots_density_ha, na.rm = TRUE),
    se_cots_ha          = sd(cots_density_ha, na.rm = TRUE)    / sqrt(n()),
    mean_tridacna_ha    = mean(tridacna_count / TRANSECT_AREA_HA, na.rm = TRUE),
    mean_cucumber_ha    = mean(cucumber_count / TRANSECT_AREA_HA, na.rm = TRUE),
    tridacna_present    = any(tridacna_count > 0, na.rm = TRUE),
    n_transects         = n(),
    .groups = "drop"
  )

cat(sprintf("  Invertebrate site summaries: %d sites\n", nrow(invert_site)))

# =============================================================================
# 6. CORAL STRUCTURAL CONDITION
# =============================================================================

cat("--- Step 6: Coral structural condition ---\n")

# ---- 6a. Benthic cover (live coral, dead, macroalgae) ---------------------

# From COMRED CORAL-DATA (major benthic categories; both years)
cover_comred_site <- benthic |>
  group_by(survey_period, site, transect_no) |>
  summarise(
    live_coral_pct   = sum(pct_cover[benthic_cat == "C"],    na.rm = TRUE),
    dead_coral_pct   = sum(pct_cover[benthic_cat == "DCA"],  na.rm = TRUE),
    macroalgae_pct   = sum(pct_cover[benthic_cat == "MA"],   na.rm = TRUE),
    rubble_pct       = sum(pct_cover[benthic_cat %in% c("SPR", "BS")], na.rm = TRUE),
    bleached_pct     = sum(pct_cover[benthic_cat == "DC"],   na.rm = TRUE),
    .groups = "drop"
  ) |>
  group_by(survey_period, site) |>
  summarise(across(ends_with("_pct"), \(x) mean(x, na.rm = TRUE)),
            n_transects = n(), .groups = "drop") |>
  mutate(source = "COMRED")

# From PU-GOAP extent sheet (Nov 2024; quadrat-based; 7 stretches)
cover_pugoap_site <- benthic_pugoap |>
  group_by(survey_period, site) |>
  summarise(across(ends_with("_pct"), \(x) mean(x, na.rm = TRUE)),
            n_transects = n(), .groups = "drop") |>
  mutate(source = "PU-GOAP")

# Combine: prefer COMRED where overlap exists (COMRED uses LIT/PIT method)
cover_site <- bind_rows(cover_comred_site, cover_pugoap_site) |>
  group_by(survey_period, site) |>
  slice(1) |>   # keep COMRED if present (bind_rows puts it first)
  ungroup()

cat(sprintf("  Benthic cover: %d site × period combinations\n", nrow(cover_site)))

# ---- 6b. Coral health status (% healthy, bleached, diseased, dead) --------

# Calculate total colonies and proportion in each health state per site
coral_health_site <- coral_cond |>
  filter(!is.na(site)) |>
  group_by(survey_period, site) |>
  summarise(
    n_healthy  = sum(healthy,  na.rm = TRUE),
    n_pale     = sum(pale,     na.rm = TRUE),
    n_bleached = sum(bleached, na.rm = TRUE),
    n_diseased = sum(diseased, na.rm = TRUE),
    n_dead     = sum(dead,     na.rm = TRUE),
    .groups = "drop"
  ) |>
  mutate(
    n_total        = n_healthy + n_pale + n_bleached + n_diseased + n_dead,
    pct_healthy    = if_else(n_total > 0, 100 * n_healthy  / n_total, NA_real_),
    pct_pale       = if_else(n_total > 0, 100 * n_pale     / n_total, NA_real_),
    pct_bleached   = if_else(n_total > 0, 100 * n_bleached / n_total, NA_real_),
    pct_diseased   = if_else(n_total > 0, 100 * n_diseased / n_total, NA_real_),
    pct_dead       = if_else(n_total > 0, 100 * n_dead     / n_total, NA_real_)
  ) |>
  filter(n_total > 0)

cat(sprintf("  Coral health: %d site × period combinations\n",
            nrow(coral_health_site)))

# ---- 6c. Colony size structure --------------------------------------------

# Identify size-bin columns by name pattern (handles both PU-GOAP and COMRED naming)
adult_size_cols_pugoap <- names(adult_pugoap)[
  str_detect(names(adult_pugoap), ADULT_SIZE_PATTERN)
]
adult_size_cols_comred <- names(adult_comred)[
  str_detect(names(adult_comred), ADULT_SIZE_PATTERN)
]

pivot_adult <- function(df, size_cols, period) {
  df |>
    pivot_longer(cols = all_of(size_cols),
                 names_to = "size_bin", values_to = "count") |>
    mutate(count = replace_na(count, 0),
           survey_period = period) |>
    group_by(survey_period, site, genus, size_bin) |>
    summarise(total_colonies = sum(count, na.rm = TRUE), .groups = "drop")
}

adult_long <- bind_rows(
  pivot_adult(adult_pugoap,  adult_size_cols_pugoap,  PERIOD_NOV24),
  pivot_adult(adult_comred,  adult_size_cols_comred,  PERIOD_JUL25)
)

# Site-level size structure: proportion of colonies in large classes (>80 cm)
# (proportion of large adults = maturity / population persistence indicator)
adult_size_site <- adult_long |>
  group_by(survey_period, site) |>
  summarise(
    n_colonies_total = sum(total_colonies),
    n_colonies_large = sum(total_colonies[str_detect(size_bin, "80|160|320|gt")]),
    pct_large_colonies = 100 * n_colonies_large / n_colonies_total,
    # Size-frequency: dominant size class (mode)
    dominant_size_class = size_bin[which.max(total_colonies)],
    .groups = "drop"
  )

cat(sprintf("  Colony size structure: %d site × period combinations\n",
            nrow(adult_size_site)))

# ---- 6d. Coral recruitment density ----------------------------------------

recruit_cols_pugoap <- names(recruits_pugoap)[
  str_detect(names(recruits_pugoap), RECRUIT_SIZE_PATTERN)
]
recruit_cols_comred <- names(recruits_comred)[
  str_detect(names(recruits_comred), RECRUIT_SIZE_PATTERN)
]

pivot_recruits <- function(df, recruit_cols, period) {
  df |>
    pivot_longer(cols = all_of(recruit_cols),
                 names_to = "size_bin", values_to = "count") |>
    mutate(count = replace_na(count, 0),
           survey_period = period)
}

recruits_long <- bind_rows(
  pivot_recruits(recruits_pugoap, recruit_cols_pugoap, PERIOD_NOV24),
  pivot_recruits(recruits_comred, recruit_cols_comred, PERIOD_JUL25)
)

# Aggregate to quadrat then site level
# Each observation row = one quadrat (1 m²); sum counts across size bins per quadrat
recruits_quadrat <- recruits_long |>
  group_by(survey_period, site, genus,
           quadrant = coalesce(as.character(quadrant), "1")) |>
  summarise(
    n_recruits         = sum(count, na.rm = TRUE),
    n_small_recruits   = sum(count[str_detect(size_bin, "0_2|0.2|^[0-9].*2")],
                             na.rm = TRUE),
    .groups = "drop"
  ) |>
  # Scale to recruits/m² (quadrat = 1 m²)
  mutate(recruits_m2       = n_recruits       / RECRUIT_QUADRAT_M2,
         small_recruits_m2 = n_small_recruits / RECRUIT_QUADRAT_M2)

recruits_site <- recruits_quadrat |>
  group_by(survey_period, site) |>
  summarise(
    mean_recruits_m2       = mean(recruits_m2, na.rm = TRUE),
    se_recruits_m2         = sd(recruits_m2, na.rm = TRUE) / sqrt(n()),
    mean_small_recruits_m2 = mean(small_recruits_m2, na.rm = TRUE),
    n_quadrats             = n(),
    .groups = "drop"
  )

cat(sprintf("  Coral recruitment: %d site × period combinations\n",
            nrow(recruits_site)))

# =============================================================================
# 7. NORMALISATION TO CONDITION INDICES (0-1)
# =============================================================================

cat("--- Step 7: Normalisation to condition indices ---\n")

# --- 7a. Fish condition indices (conditional on Step 4 having run) ----------
fish_ci <- if (!is.null(fish_site)) {
  fish_site |>
    group_by(survey_period) |>
    mutate(ref_richness = max(mean_richness, na.rm = TRUE)) |>
    ungroup() |>
    mutate(
      ci_fish_biomass  = ci_max(mean_biomass_kg_ha, REF$fish_biomass_target),
      ci_fish_richness = ci_max(mean_richness, ref_richness)
    )
} else NULL

# --- 7b. Invertebrate condition indices ------------------------------------
invert_ci <- invert_site |>
  mutate(
    ci_cots   = ci_min(mean_cots_ha, REF$cots_outbreak_ha),
    ci_urchin = ci_opt(mean_urchin_m2, REF$urchin_ref_m2),  # provisional; LOW confidence
    ci_tridacna = as.numeric(tridacna_present)               # binary proxy
  )

# --- 7c. Coral cover condition index ---------------------------------------
cover_ci <- cover_site |>
  mutate(ci_coral_cover = ci_max(live_coral_pct, REF$coral_cover_good))

# --- 7d. Coral health condition indices ------------------------------------
health_ci <- coral_health_site |>
  mutate(
    ci_bleaching = ci_min(pct_bleached, REF$bleach_background),
    ci_disease   = ci_min(pct_diseased, REF$disease_background),
    # % healthy colonies: reference = 95% (non-bleaching year baseline)
    ci_healthy   = ci_max(pct_healthy, 95)
  )

# --- 7e. Recruitment condition index ---------------------------------------
recruit_ci <- recruits_site |>
  mutate(ci_recruitment = ci_max(mean_recruits_m2, REF$recruit_density_wio))

cat("--- Normalisation complete ---\n\n")

# =============================================================================
# 8. PA-DISAGGREGATED CONDITION ACCOUNT
# =============================================================================

cat("--- Step 8: PA-disaggregated condition account ---\n")

# Join PA classification to all site-level outputs
add_pa <- function(df) left_join(df, PA_CLASSIFICATION, by = c("site" = "site_std"))

# Build complete site × period condition table
all_conditions <- cover_ci |>
  select(survey_period, site, live_coral_pct, ci_coral_cover) |>
  full_join(health_ci |> select(survey_period, site, pct_healthy, pct_bleached,
                                pct_diseased, pct_dead, ci_healthy, ci_bleaching,
                                ci_disease),
            by = c("survey_period", "site")) |>
  full_join(adult_size_site |> select(survey_period, site, pct_large_colonies),
            by = c("survey_period", "site")) |>
  full_join(recruit_ci |> select(survey_period, site, mean_recruits_m2, ci_recruitment),
            by = c("survey_period", "site")) |>
  full_join(invert_ci |> select(survey_period, site,
                                mean_urchin_m2, mean_cots_ha, tridacna_present,
                                ci_cots, ci_urchin, ci_tridacna),
            by = c("survey_period", "site"))

if (!is.null(fish_ci)) {
  all_conditions <- all_conditions |>
    full_join(
      fish_ci |> select(survey_period, site, mean_biomass_kg_ha,
                        mean_richness, ci_fish_biomass, ci_fish_richness),
      by = c("survey_period", "site")
    )
}

all_conditions <- all_conditions |> add_pa()

# PA-level summary: mean condition index per PA category × period
pa_summary <- all_conditions |>
  filter(!is.na(pa_type)) |>
  group_by(survey_period, pa_name, pa_type) |>
  summarise(
    n_sites               = n(),
    mean_live_coral_pct   = mean(live_coral_pct,    na.rm = TRUE),
    mean_pct_healthy      = mean(pct_healthy,       na.rm = TRUE),
    mean_pct_bleached     = mean(pct_bleached,      na.rm = TRUE),
    mean_recruits_m2      = mean(mean_recruits_m2,  na.rm = TRUE),
    mean_ci_coral_cover   = mean(ci_coral_cover,    na.rm = TRUE),
    mean_ci_bleaching     = mean(ci_bleaching,      na.rm = TRUE),
    mean_ci_disease       = mean(ci_disease,        na.rm = TRUE),
    mean_ci_recruitment   = mean(ci_recruitment,    na.rm = TRUE),
    mean_ci_cots          = mean(ci_cots,           na.rm = TRUE),
    .groups = "drop"
  ) |>
  arrange(survey_period, pa_type, pa_name)

cat(sprintf("  PA summary: %d PA × period rows\n", nrow(pa_summary)))
print(pa_summary)

# =============================================================================
# 9. MULTI-YEAR COMPARISON (Nov 2024 vs Jul 2025)
# =============================================================================

cat("--- Step 9: Multi-period comparison ---\n")

# Sites with data in both periods
sites_both <- all_conditions |>
  group_by(site) |>
  filter(n_distinct(survey_period) == 2) |>
  pull(site) |>
  unique()

cat(sprintf("  Sites with both Nov 2024 and Jul 2025 data: %d\n",
            length(sites_both)))
cat(sprintf("  Sites: %s\n", paste(sites_both, collapse = ", ")))

# Context note: Jul 2025 is ~15 months post-peak of 2023-2024 global bleaching event.
# Dead coral in Jul 2025 likely represents 2024 bleaching mortality.
# Do NOT interpret Jul 2025 as a standard 12-month accounting period change.

multiperiod <- all_conditions |>
  filter(site %in% sites_both) |>
  pivot_wider(
    id_cols  = c(site, pa_name, pa_type),
    names_from  = survey_period,
    values_from = c(live_coral_pct, pct_healthy, pct_bleached, pct_dead,
                    mean_recruits_m2, ci_coral_cover, ci_bleaching,
                    ci_disease, ci_recruitment, ci_cots),
    names_sep = "_"
  ) |>
  mutate(
    # Bleaching change (Nov 2024 baseline vs Jul 2025 post-bleaching)
    bleach_change_ppt  = .data[[paste0("pct_bleached_", PERIOD_JUL25)]] -
                         .data[[paste0("pct_bleached_", PERIOD_NOV24)]],
    dead_change_ppt    = .data[[paste0("pct_dead_", PERIOD_JUL25)]] -
                         .data[[paste0("pct_dead_", PERIOD_NOV24)]],
    cover_change_ppt   = .data[[paste0("live_coral_pct_", PERIOD_JUL25)]] -
                         .data[[paste0("live_coral_pct_", PERIOD_NOV24)]],
    bleaching_note = "Jul 2025 surveys = ~15 months post-2024 bleaching event peak"
  )

cat("\n  Multi-period coral change (Nov 2024 vs Jul 2025):\n")
multiperiod |>
  select(site, pa_type, cover_change_ppt, bleach_change_ppt, dead_change_ppt) |>
  print()

# =============================================================================
# 10. SEEA EA CONDITION TABLE & EXPORT
# =============================================================================

cat("--- Step 10: SEEA EA condition table and export ---\n")

# Build long-format SEEA EA condition account table
# One row per: ecosystem × survey_period × site × indicator
build_seea_rows <- function(df, indicator, unit, measured_col, ci_col,
                            reference_label, confidence, note = NA_character_) {
  df |>
    transmute(
      ecosystem_type    = ECOSYSTEM_TYPE,
      geographic_scope  = GEOGRAPHIC_SCOPE,
      survey_period,
      site,
      pa_name           = coalesce(pa_name, "Unknown"),
      pa_type           = coalesce(pa_type, "Unknown"),
      condition_indicator = indicator,
      unit,
      measured_value    = round(.data[[measured_col]], 3),
      condition_index   = round(.data[[ci_col]], 3),
      reference_level   = reference_label,
      confidence,
      note              = note
    )
}

seea_rows <- list(
  # Coral cover
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_coral_cover)),
    "Live hard coral cover", "%", "live_coral_pct", "ci_coral_cover",
    ">30% (GCRMN 2021; Obura et al. 2022)", "MEDIUM"
  ),
  # Coral health: bleaching
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_bleaching)),
    "Bleached coral colonies", "% colonies", "pct_bleached", "ci_bleaching",
    "<5% background (Hoegh-Guldberg 1999)", "MEDIUM",
    "Jul 2025 data = post-2024 bleaching event; interpret with caution"
  ),
  # Coral health: disease
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_disease)),
    "Diseased coral colonies", "% colonies", "pct_diseased", "ci_disease",
    "<2% background (Bourne et al. 2009)", "MEDIUM"
  ),
  # Coral health: % healthy
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_healthy)),
    "Healthy coral colonies", "% colonies", "pct_healthy", "ci_healthy",
    "95% healthy (non-bleaching year baseline)", "MEDIUM"
  ),
  # Coral recruitment
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_recruitment)),
    "Coral recruit density", "recruits/m2", "mean_recruits_m2", "ci_recruitment",
    "1-3 recruits/m2 (WIO healthy; Hughes et al. 2010)", "LOW-MEDIUM"
  ),
  # COTS density
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_cots)),
    "Crown-of-thorns density", "ind/ha", "mean_cots_ha", "ci_cots",
    "Outbreak threshold: 15 ind/ha (Dulvy et al. 2021)", "MEDIUM"
  ),
  # Sea urchin density
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_urchin)),
    "Sea urchin density", "ind/m2", "mean_urchin_m2", "ci_urchin",
    "1.5-2 ind/m2 optimum (provisional; WIO; LOW confidence)", "LOW"
  )
)

# Append fish indicators if available
if (!is.null(fish_ci)) {
  fish_ci_joined <- fish_ci |> add_pa()

  seea_rows <- c(seea_rows, list(
    build_seea_rows(
      fish_ci_joined,
      "Fish biomass", "kg/ha",
      "mean_biomass_kg_ha", "ci_fish_biomass",
      "1,150 kg/ha WIO conservation target (McClanahan et al. 2016)",
      "HIGH",
      paste0("[PENDING] transect area assumed ", TRANSECT_AREA_M2, " m2")
    ),
    build_seea_rows(
      fish_ci_joined,
      "Fish species richness", "species count",
      "mean_richness", "ci_fish_richness",
      "Max observed in dataset", "MEDIUM"
    )
  ))
}

seea_table <- bind_rows(seea_rows) |>
  arrange(survey_period, site, condition_indicator)

cat(sprintf("  SEEA EA rows: %d\n", nrow(seea_table)))

# --- Accounting-area summary (mean across sites, per period × indicator) ---
seea_summary <- seea_table |>
  group_by(survey_period, condition_indicator, unit, reference_level, confidence) |>
  summarise(
    mean_value = round(mean(measured_value, na.rm = TRUE), 3),
    se_value   = round(sd(measured_value, na.rm = TRUE) / sqrt(n()), 3),
    mean_ci    = round(mean(condition_index, na.rm = TRUE), 3),
    n_sites    = n(),
    .groups = "drop"
  ) |>
  arrange(survey_period, condition_indicator)

cat("\n=== SEEA EA CONDITION ACCOUNT — ACCOUNTING-AREA SUMMARY ===\n")
print(seea_summary, n = 50)

# --- Export ---
dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

output_files <- list(
  "seea_condition_account_kenya.csv"  = seea_table,
  "seea_condition_summary_kenya.csv"  = seea_summary,
  "site_condition_all_indicators.csv" = all_conditions,
  "condition_by_pa.csv"               = pa_summary,
  "multiperiod_comparison.csv"        = multiperiod,
  "coral_health_site.csv"             = coral_health_site,
  "coral_recruitment_site.csv"        = recruits_site,
  "benthic_cover_site.csv"            = cover_site,
  "invertebrate_condition_site.csv"   = invert_site
)

if (!is.null(fish_site))
  output_files[["fish_condition_site.csv"]] <- fish_site

iwalk(output_files, \(df, nm) {
  write.csv(df, file.path(OUT_DIR, nm), row.names = FALSE)
  cat(sprintf("  Wrote %s\n", nm))
})

cat("\n=== DONE — outputs written to Kenya/03_outputs/ ===\n")
