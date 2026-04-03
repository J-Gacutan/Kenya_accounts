# =============================================================================
# Coral Reef Coral + Invertebrate Condition Analysis — Kenya SEEA EA Accounts
# Kilifi County | Photic Coral Reefs (M1.3) | 2024-2025
#
# Scope:   Coral structural condition (cover, health, size structure, recruitment)
#          + Invertebrate condition (sea urchin, COTS, Tridacna, sea cucumber)
# Input:   CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx
#          PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx
#          COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx
#          COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx
#          fish_condition_site.csv (optional — joined for site_condition_all_indicators)
# Output:  coral_invert_condition_site.csv
#          seea_condition_account_kenya.csv
#          seea_condition_summary_kenya.csv
#          condition_by_pa.csv
#          multiperiod_comparison.csv
#          site_condition_all_indicators.csv (fish columns joined if CSV exists)
#          coral_health_site.csv
#          coral_recruitment_site.csv
#          benthic_cover_site.csv
#          invertebrate_condition_site.csv
#
# Paired script: coral_reef_fish_condition.R (fish biomass and community)
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

RAW_DIR <- here("Kenya", "01_inputs", "raw_data", "coral_reef")
OUT_DIR <- here("Kenya", "03_outputs")

F_CCVA_INV <- file.path(RAW_DIR, "CCVA-SEPT2024-KILIFI-INVERTS-DATA.xlsx")
F_COMRED_C <- file.path(RAW_DIR, "COMRED_OCEANS-JULY2025-CORAL ABUNDANCE AND CONDITION-DATA.xlsx")
F_COMRED_B <- file.path(RAW_DIR, "COMRED_OCEANS-JULY2025-CORAL-DATA.xlsx")
F_PUGOAP   <- file.path(RAW_DIR, "PU-GOAP-KILIFI-NOV2024-CORALDATA.xlsx")

# Optional fish output for joining into site_condition_all_indicators
F_FISH_SITE <- file.path(OUT_DIR, "fish_condition_site.csv")

# ----------------------------------------------------------------------------
# TRANSECT / QUADRAT AREAS
TRANSECT_AREA_M2   <- 250    # [PENDING] assumed 50 m x 5 m; confirm with KMFRI
TRANSECT_AREA_HA   <- TRANSECT_AREA_M2 / 10000
RECRUIT_QUADRAT_M2 <- 1.0   # 1 x 1 m quadrats (confirmed from metadata)
# ----------------------------------------------------------------------------

REF <- list(
  coral_cover_good    = 30,   # % live coral; GCRMN 2021 / Obura et al. 2022
  bleach_background   = 5,    # % colonies; Hoegh-Guldberg 1999 non-bleaching year
  disease_background  = 2,    # % colonies; Bourne et al. 2009
  recruit_density_wio = 1.0,  # recruits/m2; Hughes et al. 2010 WIO healthy (LOW-MED confidence)
  cots_outbreak_ha    = 15,   # ind/ha; Dulvy et al. 2021
  urchin_ref_m2       = 1.75  # ind/m2; provisional midpoint 1.5-2; LOW confidence
)

PERIOD_NOV24     <- "Nov_2024"
PERIOD_JUL25     <- "Jul_2025"
ECOSYSTEM_TYPE   <- "Coral reef (M1.3)"
GEOGRAPHIC_SCOPE <- "Kilifi County, Kenya"

# Column detection patterns for adult size and recruit pivots
ADULT_SIZE_PATTERN   <- "^x[0-9]|^[0-9]|gt_|^x_[0-9]"
RECRUIT_SIZE_PATTERN <- "^[0-9]|^r_|^x[0-9]"

# Coral health column names (as they appear after clean_names)
HEALTH_COLS <- c("healthy", "pale", "bleached", "diseased", "dead")

# Protected area classification (must match site names after standardisation)
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

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

fix_gps <- function(x, valid_min, valid_max) {
  x <- suppressWarnings(as.numeric(x))
  needs_fix <- !is.na(x) & (x < valid_min | x > valid_max)
  for (i in which(needs_fix)) {
    val <- x[i]
    if (!is.na(val) && -val >= valid_min && -val <= valid_max) {
      x[i] <- -val; next
    }
    n_div <- 0L
    while (!is.na(val) && (val < valid_min || val > valid_max) && n_div < 10L) {
      val <- val / 10; n_div <- n_div + 1L
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

SITE_NAME_MAP <- c(
  "Sultance palace"         = "Sultan Palace",
  "Sultan palace"           = "Sultan Palace",
  "Kilifi Wesa"             = "Wesa",
  "Richard Bennet"          = "Richard Bennett",
  "Richard Benet"           = "Richard Bennett",
  "Richard Bennette"        = "Richard Bennett",
  "Watamu marine park"      = "Watamu Coral Garden",
  "Watamu Marine Park"      = "Watamu Coral Garden",
  "Coral garden"            = "Watamu Coral Garden",
  "Coral Garden"            = "Watamu Coral Garden",
  "Ngomeni outer"           = "Ngomeni Outer",
  "Ras Ngomeni outer"       = "Ngomeni Outer",
  "Turtle reef"             = "Turtle Reef",
  "Jumba ruins"             = "Jumba Ruins",
  "Malindi Coral garden"    = "Malindi Coral Garden",
  "Kanamai community park"  = "Kanamai Community Park",
  "Kuruwitu community park" = "Kuruwitu Community Park",
  "Makofi ya chini"         = "Wesa",
  "Kijambani"               = "Roka",
  "Makofi (Wesa 1)"         = "Wesa 1"
)

standardise_site <- function(x) {
  coalesce(SITE_NAME_MAP[str_trim(x)], str_trim(x))
}

ci_max <- function(value, reference) pmin(value / reference, 1.0)
ci_min <- function(value, reference) pmax(1 - value / reference, 0.0)
ci_opt <- function(value, optimum)   pmax(1 - abs(value - optimum) / optimum, 0.0)

# =============================================================================
# 1. DATA INGESTION
# =============================================================================

cat("--- Step 1: Reading data files ---\n")

# --- 1a. CCVA invertebrates (Nov 2024) ---
invert_raw <- read_excel(F_CCVA_INV, sheet = "CCVA INVERTERBRATES DATA") |> clean_names()
cat(sprintf("  CCVA inverts: %d rows\n", nrow(invert_raw)))

# --- 1b. PU-GOAP coral data (5 sheets, Nov 2024) ---
pugoap_sheets <- c(extent = "Extent", adult = "Adult size",
                   cond   = "Condition 1", recruits = "Recruits")
pugoap <- map(pugoap_sheets, \(sh) read_excel(F_PUGOAP, sheet = sh) |> clean_names())
walk2(pugoap, names(pugoap_sheets),
      \(df, nm) cat(sprintf("  PU-GOAP %s: %d rows\n", nm, nrow(df))))

# --- 1c. COMRED coral data (3 sheets, Jul 2025) ---
comred_coral_sheets <- c(adult = "Adult size class", recruits = "Recruits",
                         cond  = "Conditions")
comred_coral <- map(comred_coral_sheets,
                    \(sh) read_excel(F_COMRED_C, sheet = sh) |> clean_names())

# --- 1d. Benthic cover: COMRED-CORAL-DATA (authoritative; spans 2024-2025) ---
# NOTE: COMRED CORAL ABUNDANCE file is a subset; use CORAL-DATA (F_COMRED_B) only.
benthic_sheets <- c(major = "Major benthic category", genera = "Coral Genera")
benthic_comred <- map(benthic_sheets,
                      \(sh) read_excel(F_COMRED_B, sheet = sh) |> clean_names())

cat("--- Data ingestion complete ---\n\n")

# =============================================================================
# 2. QA/QC
# =============================================================================

cat("--- Step 2: QA/QC ---\n")

# --- 2a. CCVA invertebrates ---
invert <- invert_raw |>
  filter(!is.na(species), species != "", species != "0") |>
  mutate(
    site      = standardise_site(coalesce(site, location)),
    latitude  = fix_gps(latitude,   valid_min = -5, valid_max = -1),
    longitude = fix_gps(longtitude, valid_min = 38, valid_max = 42),
    species   = str_to_sentence(str_trim(species)),
    family    = str_to_title(str_trim(family_name)),
    abundance = suppressWarnings(as.numeric(total_number)),
    date      = suppressWarnings(coalesce(
      as_date(date),
      as.Date(as.numeric(date), origin = "1899-12-30"),
      dmy(date)
    )),
    survey_period = PERIOD_NOV24
  ) |>
  filter(!is.na(abundance)) |>
  rename(any_of(c(transect_no = "transcet_no"))) |>
  select(survey_period, date, site, latitude, longitude,
         transect_no, family, species, abundance)

cat(sprintf("  CCVA inverts: %d -> %d rows\n", nrow(invert_raw), nrow(invert)))

# --- 2b. Coral condition (PU-GOAP + COMRED) ---
# Handles duplicate-key rename bug: both "transect_number" and "transect" must
# map to "transect_no"; rename_with() is used instead of rename(any_of(...))
# to avoid the named-vector duplicate-key issue.
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

cat(sprintf("  Coral condition: %d rows\n", nrow(coral_cond)))

# --- 2c. Coral adult size structure ---
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

adult_pugoap <- clean_adult_size(pugoap$adult,       PERIOD_NOV24)
adult_comred <- clean_adult_size(comred_coral$adult, PERIOD_JUL25)

# --- 2d. Coral recruitment ---
clean_recruits <- function(df, period) {
  recruit_cols <- names(df)[str_detect(names(df), "^r_|^x?0_|^x?2_|^x?6_")]
  if (length(recruit_cols) == 0) {
    # Fallback: any column that looks like a size class
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

recruits_pugoap <- clean_recruits(pugoap$recruits,       PERIOD_NOV24)
recruits_comred <- clean_recruits(comred_coral$recruits, PERIOD_JUL25)

# --- 2e. Benthic cover ---
# DIAGNOSTIC: inspect benthic category codes to verify the "C" filter
# Run this once to confirm correct category codes in the actual data:
#   benthic_comred$major |> mutate(...) |> count(benthic_cat) |> print(n = 50)

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

# NOTE: If live_coral_pct is 0 at coral sites, the category code "C" may be wrong.
# Check benthic_cat values with: count(benthic, benthic_cat) and update the
# live_coral_pct filter in Step 3a accordingly (e.g. "HC", "CORAL", etc.).
cat(sprintf("  Benthic: %d rows, %d distinct categories\n",
            nrow(benthic), n_distinct(benthic$benthic_cat)))
cat("  Benthic categories found:\n")
benthic |> count(benthic_cat, sort = TRUE) |> print(n = 20)

# PU-GOAP extent sheet: rapid quadrat-based assessment (Nov 2024; 7 stretches)
benthic_pugoap <- pugoap$extent |>
  mutate(
    site              = standardise_site(location),
    survey_period     = PERIOD_NOV24,
    live_coral_pct    = suppressWarnings(as.numeric(live_coral_percent)),
    dead_coral_pct    = suppressWarnings(as.numeric(dead_coral)),
    bleached_pct      = suppressWarnings(as.numeric(bleached_coral)),
    macroalgae_pct    = suppressWarnings(as.numeric(macro_algae_percent)),
    rubble_pct        = suppressWarnings(as.numeric(rubble_percent))
  ) |>
  filter(!is.na(live_coral_pct)) |>
  select(survey_period, site, live_coral_pct, dead_coral_pct,
         bleached_pct, macroalgae_pct, rubble_pct)

cat(sprintf("  PU-GOAP benthic: %d rows\n", nrow(benthic_pugoap)))

cat("--- QA/QC complete ---\n\n")

# =============================================================================
# 3. CORAL STRUCTURAL CONDITION
# =============================================================================

cat("--- Step 3: Coral structural condition ---\n")

# --- 3a. Benthic cover (live coral, dead, macroalgae) ---
# NOTE: Update "C" to the actual category code from the diagnostic above if needed
cover_comred_site <- benthic |>
  group_by(survey_period, site, transect_no) |>
  summarise(
    live_coral_pct = sum(pct_cover[benthic_cat == "C"],   na.rm = TRUE),
    dead_coral_pct = sum(pct_cover[benthic_cat == "DCA"], na.rm = TRUE),
    macroalgae_pct = sum(pct_cover[benthic_cat == "MA"],  na.rm = TRUE),
    rubble_pct     = sum(pct_cover[benthic_cat %in% c("SPR", "BS")], na.rm = TRUE),
    bleached_pct   = sum(pct_cover[benthic_cat == "DC"],  na.rm = TRUE),
    .groups = "drop"
  ) |>
  group_by(survey_period, site) |>
  summarise(across(ends_with("_pct"), \(x) mean(x, na.rm = TRUE)),
            n_transects = n(), .groups = "drop") |>
  mutate(source = "COMRED")

cover_pugoap_site <- benthic_pugoap |>
  group_by(survey_period, site) |>
  summarise(across(ends_with("_pct"), \(x) mean(x, na.rm = TRUE)),
            n_transects = n(), .groups = "drop") |>
  mutate(source = "PU-GOAP")

# Prefer COMRED where overlap exists (LIT/PIT method; more rigorous than PU-GOAP quadrats)
cover_site <- bind_rows(cover_comred_site, cover_pugoap_site) |>
  group_by(survey_period, site) |>
  slice(1) |>
  ungroup()

cat(sprintf("  Benthic cover: %d site x period combinations\n", nrow(cover_site)))

# --- 3b. Coral health (% healthy, bleached, diseased, dead) ---
coral_health_site <- coral_cond |>
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
    n_total      = n_healthy + n_pale + n_bleached + n_diseased + n_dead,
    pct_healthy  = 100 * n_healthy  / n_total,
    pct_pale     = 100 * n_pale     / n_total,
    pct_bleached = 100 * n_bleached / n_total,
    pct_diseased = 100 * n_diseased / n_total,
    pct_dead     = 100 * n_dead     / n_total
  )

cat(sprintf("  Coral health: %d site x period combinations\n", nrow(coral_health_site)))

# --- 3c. Colony size structure ---
adult_size_cols_pugoap <- names(adult_pugoap)[str_detect(names(adult_pugoap), ADULT_SIZE_PATTERN)]
adult_size_cols_comred <- names(adult_comred)[str_detect(names(adult_comred), ADULT_SIZE_PATTERN)]

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
  pivot_adult(adult_pugoap, adult_size_cols_pugoap, PERIOD_NOV24),
  pivot_adult(adult_comred, adult_size_cols_comred, PERIOD_JUL25)
)

# Proportion of large adults (>80 cm): maturity / population persistence indicator
adult_size_site <- adult_long |>
  group_by(survey_period, site) |>
  summarise(
    n_colonies_total   = sum(total_colonies),
    n_colonies_large   = sum(total_colonies[str_detect(size_bin, "80|160|320|gt")]),
    pct_large_colonies = 100 * n_colonies_large / n_colonies_total,
    dominant_size_class = size_bin[which.max(total_colonies)],
    .groups = "drop"
  )

cat(sprintf("  Colony size structure: %d site x period combinations\n", nrow(adult_size_site)))

# --- 3d. Coral recruitment density ---
recruit_cols_pugoap <- names(recruits_pugoap)[str_detect(names(recruits_pugoap), RECRUIT_SIZE_PATTERN)]
recruit_cols_comred <- names(recruits_comred)[str_detect(names(recruits_comred), RECRUIT_SIZE_PATTERN)]

pivot_recruits <- function(df, recruit_cols, period) {
  df |>
    pivot_longer(cols = all_of(recruit_cols),
                 names_to = "size_bin", values_to = "count") |>
    mutate(count = replace_na(count, 0), survey_period = period)
}

recruits_long <- bind_rows(
  pivot_recruits(recruits_pugoap, recruit_cols_pugoap, PERIOD_NOV24),
  pivot_recruits(recruits_comred, recruit_cols_comred, PERIOD_JUL25)
)

# Each row = one quadrat (1 m2); sum counts across size bins per quadrat
recruits_quadrat <- recruits_long |>
  group_by(survey_period, site, genus,
           quadrant = coalesce(as.character(quadrant), "1")) |>
  summarise(
    n_recruits       = sum(count, na.rm = TRUE),
    n_small_recruits = sum(count[str_detect(size_bin, "0_2|0.2|^[0-9].*2")],
                           na.rm = TRUE),
    .groups = "drop"
  ) |>
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

cat(sprintf("  Coral recruitment: %d site x period combinations\n", nrow(recruits_site)))

# =============================================================================
# 4. INVERTEBRATE METRICS
# =============================================================================

cat("--- Step 4: Invertebrate metrics ---\n")

SPP_URCHIN   <- c("Diadema setosum", "Echinometra mathaei",
                  "Diadema savignyi", "Echinothrix diadema")
SPP_COTS     <- c("Acanthaster planci", "Acanthaster cf solaris",
                  "Crown of thorns", "Crown-of-thorns")
SPP_TRIDACNA <- c("Tridacna squamosa", "Tridacna maxima", "Giant clam")
SPP_CUCUMBER <- c("Holothuria scabra", "Holothuria atra", "Actinopyga miliaris",
                  "Thelenota ananas", "Bohadschia argus")

invert_metrics <- invert |>
  mutate(
    is_urchin   = species %in% SPP_URCHIN |
                  str_detect(species, regex("urchin", ignore_case = TRUE)),
    is_cots     = species %in% SPP_COTS |
                  str_detect(species, regex("acanthaster|crown", ignore_case = TRUE)),
    is_tridacna = species %in% SPP_TRIDACNA |
                  str_detect(species, regex("tridacna|giant clam", ignore_case = TRUE)),
    is_cucumber = species %in% SPP_CUCUMBER |
                  str_detect(family, regex("holothuridae|stichopodidae", ignore_case = TRUE))
  )

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
    urchin_density_ha = urchin_count / TRANSECT_AREA_HA,
    cots_density_ha   = cots_count   / TRANSECT_AREA_HA,
    urchin_density_m2 = urchin_count / TRANSECT_AREA_M2
  )

invert_site <- invert_transect |>
  group_by(survey_period, site) |>
  summarise(
    mean_urchin_m2   = mean(urchin_density_m2, na.rm = TRUE),
    se_urchin_m2     = sd(urchin_density_m2, na.rm = TRUE)  / sqrt(n()),
    mean_cots_ha     = mean(cots_density_ha,  na.rm = TRUE),
    se_cots_ha       = sd(cots_density_ha,    na.rm = TRUE) / sqrt(n()),
    mean_tridacna_ha = mean(tridacna_count / TRANSECT_AREA_HA, na.rm = TRUE),
    mean_cucumber_ha = mean(cucumber_count / TRANSECT_AREA_HA, na.rm = TRUE),
    tridacna_present = any(tridacna_count > 0, na.rm = TRUE),
    n_transects      = n(),
    .groups = "drop"
  )

cat(sprintf("  Invertebrate site summaries: %d sites\n", nrow(invert_site)))

# =============================================================================
# 5. NORMALISATION TO CONDITION INDICES (0-1)
# =============================================================================

cat("--- Step 5: Normalisation to condition indices ---\n")

cover_ci <- cover_site |>
  mutate(ci_coral_cover = ci_max(live_coral_pct, REF$coral_cover_good))

health_ci <- coral_health_site |>
  mutate(
    ci_bleaching = ci_min(pct_bleached, REF$bleach_background),
    ci_disease   = ci_min(pct_diseased, REF$disease_background),
    ci_healthy   = ci_max(pct_healthy, 95)   # 95% = non-bleaching year baseline
  )

recruit_ci <- recruits_site |>
  mutate(ci_recruitment = ci_max(mean_recruits_m2, REF$recruit_density_wio))

invert_ci <- invert_site |>
  mutate(
    ci_cots     = ci_min(mean_cots_ha, REF$cots_outbreak_ha),
    ci_urchin   = ci_opt(mean_urchin_m2, REF$urchin_ref_m2),  # provisional; LOW confidence
    ci_tridacna = as.numeric(tridacna_present)                  # binary proxy
  )

cat("--- Normalisation complete ---\n\n")

# =============================================================================
# 6. PA-DISAGGREGATED CONDITION ACCOUNT
# =============================================================================

cat("--- Step 6: PA-disaggregated condition account ---\n")

add_pa <- function(df) left_join(df, PA_CLASSIFICATION, by = c("site" = "site_std"))

# Build coral + invertebrate site-level table
all_conditions <- cover_ci |>
  select(survey_period, site, live_coral_pct, ci_coral_cover) |>
  full_join(health_ci |> select(survey_period, site, pct_healthy, pct_bleached,
                                pct_diseased, pct_dead, ci_healthy,
                                ci_bleaching, ci_disease),
            by = c("survey_period", "site")) |>
  full_join(adult_size_site |> select(survey_period, site, pct_large_colonies),
            by = c("survey_period", "site")) |>
  full_join(recruit_ci |> select(survey_period, site, mean_recruits_m2, ci_recruitment),
            by = c("survey_period", "site")) |>
  full_join(invert_ci |> select(survey_period, site,
                                mean_urchin_m2, mean_cots_ha, tridacna_present,
                                ci_cots, ci_urchin, ci_tridacna),
            by = c("survey_period", "site")) |>
  filter(!is.na(site)) |>   # drop rows with missing site name (data entry gaps)
  add_pa()

# Diagnostic: flag any sites that didn't join to PA_CLASSIFICATION
unmapped <- all_conditions |> filter(is.na(pa_type)) |> distinct(site)
if (nrow(unmapped) > 0) {
  cat("  WARNING: sites not in PA_CLASSIFICATION (add to lookup table or SITE_NAME_MAP):\n")
  print(unmapped)
}

# Optionally join fish condition if the fish script has already been run
if (file.exists(F_FISH_SITE)) {
  fish_site_csv <- read.csv(F_FISH_SITE) |>
    as_tibble() |>
    select(survey_period, site, mean_biomass_kg_ha, mean_richness)
  all_conditions <- all_conditions |>
    left_join(fish_site_csv, by = c("survey_period", "site"))
  cat("  Fish condition joined from fish_condition_site.csv\n")
} else {
  cat("  fish_condition_site.csv not found — run coral_reef_fish_condition.R first to include fish columns\n")
}

# PA-level summary: mean condition per PA category x period
pa_summary <- all_conditions |>
  filter(!is.na(pa_type)) |>
  group_by(survey_period, pa_name, pa_type) |>
  summarise(
    n_sites             = n(),
    mean_live_coral_pct = mean(live_coral_pct,   na.rm = TRUE),
    mean_pct_healthy    = mean(pct_healthy,       na.rm = TRUE),
    mean_pct_bleached   = mean(pct_bleached,      na.rm = TRUE),
    mean_recruits_m2    = mean(mean_recruits_m2,  na.rm = TRUE),
    mean_ci_coral_cover = mean(ci_coral_cover,    na.rm = TRUE),
    mean_ci_bleaching   = mean(ci_bleaching,      na.rm = TRUE),
    mean_ci_disease     = mean(ci_disease,        na.rm = TRUE),
    mean_ci_recruitment = mean(ci_recruitment,    na.rm = TRUE),
    mean_ci_cots        = mean(ci_cots,           na.rm = TRUE),
    .groups = "drop"
  ) |>
  arrange(survey_period, pa_type, pa_name)

cat(sprintf("  PA summary: %d PA x period rows\n", nrow(pa_summary)))
print(pa_summary)

# =============================================================================
# 7. MULTI-PERIOD COMPARISON (Nov 2024 vs Jul 2025)
# =============================================================================

cat("--- Step 7: Multi-period comparison ---\n")

# Context: Jul 2025 is ~15 months post-peak of 2023-2024 global bleaching event.
# Dead coral in Jul 2025 likely represents 2024 bleaching mortality.
# Do NOT interpret as a standard 12-month accounting period change.

sites_both <- all_conditions |>
  group_by(site) |>
  filter(n_distinct(survey_period) == 2) |>
  pull(site) |>
  unique()

cat(sprintf("  Sites with both Nov 2024 and Jul 2025 data: %d\n", length(sites_both)))
cat(sprintf("  Sites: %s\n", paste(sites_both, collapse = ", ")))

multiperiod <- all_conditions |>
  filter(site %in% sites_both) |>
  pivot_wider(
    id_cols     = c(site, pa_name, pa_type),
    names_from  = survey_period,
    values_from = c(live_coral_pct, pct_healthy, pct_bleached, pct_dead,
                    mean_recruits_m2, ci_coral_cover, ci_bleaching,
                    ci_disease, ci_recruitment, ci_cots),
    names_sep   = "_"
  ) |>
  mutate(
    bleach_change_ppt = .data[[paste0("pct_bleached_", PERIOD_JUL25)]] -
                        .data[[paste0("pct_bleached_", PERIOD_NOV24)]],
    dead_change_ppt   = .data[[paste0("pct_dead_", PERIOD_JUL25)]] -
                        .data[[paste0("pct_dead_", PERIOD_NOV24)]],
    cover_change_ppt  = .data[[paste0("live_coral_pct_", PERIOD_JUL25)]] -
                        .data[[paste0("live_coral_pct_", PERIOD_NOV24)]],
    bleaching_note    = "Jul 2025 surveys = ~15 months post-2024 bleaching event peak"
  )

cat("\n  Multi-period coral change (Nov 2024 vs Jul 2025):\n")
multiperiod |>
  select(site, pa_type, cover_change_ppt, bleach_change_ppt, dead_change_ppt) |>
  print()

# =============================================================================
# 8. SEEA EA CONDITION TABLE
# =============================================================================

cat("--- Step 8: SEEA EA condition table ---\n")

build_seea_rows <- function(df, indicator, unit, measured_col, ci_col,
                            reference_label, confidence, note = NA_character_) {
  df |>
    transmute(
      ecosystem_type      = ECOSYSTEM_TYPE,
      geographic_scope    = GEOGRAPHIC_SCOPE,
      survey_period,
      site,
      pa_name             = coalesce(pa_name, "Unknown"),
      pa_type             = coalesce(pa_type, "Unknown"),
      condition_indicator = indicator,
      unit,
      measured_value      = round(.data[[measured_col]], 3),
      condition_index     = round(.data[[ci_col]], 3),
      reference_level     = reference_label,
      confidence,
      note                = note
    )
}

seea_rows <- list(
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_coral_cover)),
    "Live hard coral cover", "%", "live_coral_pct", "ci_coral_cover",
    ">30% (GCRMN 2021; Obura et al. 2022)", "MEDIUM"
  ),
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_bleaching)),
    "Bleached coral colonies", "% colonies", "pct_bleached", "ci_bleaching",
    "<5% background (Hoegh-Guldberg 1999)", "MEDIUM",
    "Jul 2025 data = post-2024 bleaching event; interpret with caution"
  ),
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_disease)),
    "Diseased coral colonies", "% colonies", "pct_diseased", "ci_disease",
    "<2% background (Bourne et al. 2009)", "MEDIUM"
  ),
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_healthy)),
    "Healthy coral colonies", "% colonies", "pct_healthy", "ci_healthy",
    "95% healthy (non-bleaching year baseline)", "MEDIUM"
  ),
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_recruitment)),
    "Coral recruit density", "recruits/m2", "mean_recruits_m2", "ci_recruitment",
    "1-3 recruits/m2 (WIO healthy; Hughes et al. 2010)", "LOW-MEDIUM"
  ),
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_cots)),
    "Crown-of-thorns density", "ind/ha", "mean_cots_ha", "ci_cots",
    "Outbreak threshold: 15 ind/ha (Dulvy et al. 2021)", "MEDIUM"
  ),
  build_seea_rows(
    all_conditions |> filter(!is.na(ci_urchin)),
    "Sea urchin density", "ind/m2", "mean_urchin_m2", "ci_urchin",
    "1.5-2 ind/m2 optimum (provisional; WIO; LOW confidence)", "LOW"
  )
)

# Append fish SEEA rows from fish script output if available
f_fish_seea <- file.path(OUT_DIR, "fish_seea_rows.csv")
if (file.exists(f_fish_seea)) {
  fish_seea_csv <- read.csv(f_fish_seea) |> as_tibble()
  seea_rows <- c(seea_rows, list(fish_seea_csv))
  cat(sprintf("  Fish SEEA rows joined from fish_seea_rows.csv (%d rows)\n",
              nrow(fish_seea_csv)))
} else {
  cat("  fish_seea_rows.csv not found — run coral_reef_fish_condition.R to include fish SEEA rows\n")
}

seea_table <- bind_rows(seea_rows) |>
  arrange(survey_period, site, condition_indicator)

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

cat(sprintf("  SEEA EA rows: %d\n", nrow(seea_table)))
cat("\n=== SEEA EA CONDITION ACCOUNT — ACCOUNTING-AREA SUMMARY ===\n")
print(seea_summary, n = 50)

# =============================================================================
# 9. EXPORT
# =============================================================================

cat("--- Step 9: Export ---\n")

dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

output_files <- list(
  "KEN_seea_condition_account.csv"          = seea_table,
  "KEN_seea_condition_summary.csv"          = seea_summary,
  "KEN_site_condition_all_indicators.csv"   = all_conditions,
  "KEN_condition_by_pa.csv"                 = pa_summary,
  "KEN_multiperiod_comparison.csv"          = multiperiod,
  "KEN_coral_health_site.csv"               = coral_health_site,
  "KEN_coral_recruitment_site.csv"          = recruits_site,
  "KEN_benthic_cover_site.csv"              = cover_site,
  "KEN_invertebrate_condition_site.csv"     = invert_site
)

iwalk(output_files, \(df, nm) {
  write.csv(df, file.path(OUT_DIR, nm), row.names = FALSE)
  cat(sprintf("  Wrote %s\n", nm))
})

cat("--- Coral + invertebrate condition analysis complete ---\n")
