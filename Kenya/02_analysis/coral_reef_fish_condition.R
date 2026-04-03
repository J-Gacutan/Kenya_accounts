# =============================================================================
# Coral Reef Fish Condition Analysis — Kenya SEEA EA Accounts
# Kilifi County | Photic Coral Reefs (M1.3) | 2024-2025
#
# Scope:   Fish biomass and community condition indicators only
# Input:   KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx (Nov 2024)
#          COMRED_OCEANS-JULY2025-FISH-DATA.xlsx (Jul 2025)
#          fishbase_params_kenya.csv
# Output:  fish_condition_site.csv   — site-level biomass / richness / trophics
#          fish_seea_rows.csv        — SEEA EA long-format condition rows
#
# Paired script: coral_reef_coral_invert_condition.R
# Plan:    Kenya/docs/accounts/cond_reef_coral_fish_invert_plan.md
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

RAW_DIR  <- here("Kenya", "01_inputs", "raw_data", "coral_reef")
META_DIR <- here("Kenya", "01_inputs", "metadata")
OUT_DIR  <- here("Kenya", "03_outputs", "coral_reef")

F_KLF      <- file.path(RAW_DIR, "KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx")
F_COMRED_F <- file.path(RAW_DIR, "COMRED_OCEANS-JULY2025-FISH-DATA.xlsx")
F_FISHBASE <- file.path(META_DIR, "fishbase_params_kenya.csv")

# ----------------------------------------------------------------------------
# TRANSECT AREA — PENDING CONFIRMATION WITH FIELD TEAM
# Standard WIO UVC belt = 50 m x 5 m = 250 m² assumed for CCVA.
# Update once confirmed with Dr. Karisa / Dr. Thoya / KMFRI (Open Question 1).
TRANSECT_AREA_M2 <- 250        # [PENDING] assumed 50 m x 5 m
TRANSECT_AREA_HA <- TRANSECT_AREA_M2 / 10000
# ----------------------------------------------------------------------------

REF <- list(
  fish_biomass_target = 1150,  # kg/ha; McClanahan et al. 2016 WIO conservation target
  fish_biomass_floor  = 600    # kg/ha; McClanahan et al. 2016 sustainability floor
)

PERIOD_NOV24     <- "Nov_2024"
PERIOD_JUL25     <- "Jul_2025"
ECOSYSTEM_TYPE   <- "Coral reef (M1.3)"
GEOGRAPHIC_SCOPE <- "Kilifi County, Kenya"

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

parse_size_mid <- function(x) {
  x <- str_trim(as.character(x))
  parsed <- str_match(x, "^(\\d+(?:\\.\\d+)?)\\s*-+\\s*(\\d+(?:\\.\\d+)?)$")
  lo <- suppressWarnings(as.numeric(parsed[, 2]))
  hi <- suppressWarnings(as.numeric(parsed[, 3]))
  ifelse(!is.na(lo) & !is.na(hi), (lo + hi) / 2, suppressWarnings(as.numeric(x)))
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

# =============================================================================
# 1. DATA INGESTION
# =============================================================================

cat("--- Step 1: Reading fish data ---\n")

fish_klf_raw    <- read_excel(F_KLF) |> clean_names()
fish_comred_raw <- read_excel(F_COMRED_F, sheet = 1) |> clean_names()

cat(sprintf("  KLF fish:    %d rows, %d cols\n", nrow(fish_klf_raw), ncol(fish_klf_raw)))
cat(sprintf("  COMRED fish: %d rows\n", nrow(fish_comred_raw)))

# =============================================================================
# 2. QA/QC
# =============================================================================

cat("--- Step 2: Fish QA/QC ---\n")

# Shared cleaner for both fish UVC sources.
# KLF includes reference_notes; COMRED does not — any_of() handles the difference.
clean_fish_uvc <- function(raw, period) {
  raw |>
    mutate(date = suppressWarnings(
      coalesce(as_date(date),
               as.Date(as.numeric(date), origin = "1899-12-30"),
               dmy(date))
    )) |>
    filter(!is.na(date), !is.na(species),
           species != "", species != "0") |>
    mutate(
      site             = standardise_site(coalesce(site_name_1, area_location)),
      latitude         = fix_gps(latitude,   valid_min = -5,  valid_max = -1),
      longitude        = fix_gps(longtitude, valid_min = 38,  valid_max = 42),
      family           = str_to_title(str_trim(family_name)),
      # Correct family name typos in raw data that would break family-level fallback
      family           = case_when(
        family == "Mulidae"     ~ "Mullidae",
        family == "Lutjnanidae" ~ "Lutjanidae",
        .default = family
      ),
      species          = str_to_sentence(str_trim(species)),
      fish_size_mid_cm = parse_size_mid(fish_size_cm),
      total_number     = suppressWarnings(as.integer(total_number)),
      survey_period    = period
    ) |>
    filter(!is.na(fish_size_mid_cm), !is.na(total_number), total_number > 0) |>
    rename(any_of(c(transect_no = "transcet_no"))) |>
    select(
      survey_period, date, site, latitude, longitude,
      transect_no, transect_length_m,
      family, species, total_number, fish_size_mid_cm,
      any_of("reference_notes")
    )
}

fish_klf    <- clean_fish_uvc(fish_klf_raw,    PERIOD_NOV24)
fish_comred <- clean_fish_uvc(fish_comred_raw, PERIOD_JUL25)

cat(sprintf("  KLF:    %d -> %d rows\n", nrow(fish_klf_raw), nrow(fish_klf)))
cat(sprintf("  COMRED: %d -> %d rows\n", nrow(fish_comred_raw), nrow(fish_comred)))

# De-duplicate: KLF master file includes COMRED sites (Jul 2025) pre-loaded
# as Nov 2024. Remove KLF rows for sites that appear in the standalone COMRED
# file, since COMRED has the correct survey period assignment.
comred_sites <- unique(fish_comred$site)
fish_klf_dedup <- fish_klf |> filter(!(site %in% comred_sites))
cat(sprintf("  KLF de-duplicated: %d -> %d rows (removed %d COMRED-overlap rows)\n",
            nrow(fish_klf), nrow(fish_klf_dedup),
            nrow(fish_klf) - nrow(fish_klf_dedup)))

fish_all <- bind_rows(fish_klf_dedup, fish_comred)

# =============================================================================
# 3. FISHBASE ALLOMETRIC PARAMETERS
# =============================================================================

cat("--- Step 3: FishBase allometric parameters ---\n")

if (!file.exists(F_FISHBASE)) {
  warning(paste0(
    "\n[STEP 3 PENDING] FishBase parameters file not found:\n  ", F_FISHBASE,
    "\nFish biomass calculation will be skipped.",
    "\nCreate the CSV with columns: species, family, a, b, source\n"
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
  fish_site          <- NULL
  fish_trophic_site  <- NULL
} else {

  # Species-level parameter match, fall back to family-level mean
  family_params <- fishbase_params |>
    group_by(family) |>
    summarise(a_family = mean(a, na.rm = TRUE),
              b_family = mean(b, na.rm = TRUE), .groups = "drop")

  fish_params <- fish_all |>
    left_join(fishbase_params |> select(species, a, b), by = "species") |>
    left_join(family_params, by = "family") |>
    mutate(
      # param_source must be computed BEFORE coalesce overwrites a/b,
      # otherwise species matches with no family fallback (family typo) are
      # misclassified as "missing" because a_family is NA post-join.
      param_source = case_when(
        !is.na(a)        ~ "species",
        !is.na(a_family) ~ "family_mean",
        TRUE             ~ "missing"
      ),
      a = coalesce(a, a_family),
      b = coalesce(b, b_family)
    )

  n_missing <- sum(fish_params$param_source == "missing")
  if (n_missing > 0)
    warning(sprintf("[Step 4] %d fish records missing allometric params — excluded from biomass", n_missing))

  fish_params <- fish_params |>
    left_join(TROPHIC_LOOKUP, by = "family") |>
    mutate(trophic_group = coalesce(trophic_group, "Unknown"))

  # Biomass per record: W = a * L^b; scale to per-ha
  # [PENDING] transect area assumed 250 m2; confirm with KMFRI
  fish_calcs <- fish_params |>
    filter(param_source != "missing", !is.na(fish_size_mid_cm)) |>
    mutate(
      biomass_g     = a * (fish_size_mid_cm ^ b) * total_number,
      biomass_kg_ha = (biomass_g / 1000) / TRANSECT_AREA_HA,
      abundance_ha  = total_number / TRANSECT_AREA_HA
    )

  # Transect-level aggregation
  fish_transect <- fish_calcs |>
    group_by(survey_period, site, transect_no) |>
    summarise(
      biomass_kg_ha    = sum(biomass_kg_ha, na.rm = TRUE),
      abundance_ha     = sum(abundance_ha, na.rm = TRUE),
      species_richness = n_distinct(species),
      n_records        = n(),
      .groups = "drop"
    )

  fish_trophic_transect <- fish_calcs |>
    group_by(survey_period, site, transect_no, trophic_group) |>
    summarise(biomass_kg_ha = sum(biomass_kg_ha, na.rm = TRUE), .groups = "drop")

  # Site-level means (mean +/- SE across transects)
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

  cat(sprintf("  Fish site summaries: %d site x period combinations\n", nrow(fish_site)))
}

# =============================================================================
# 5. NORMALISATION TO CONDITION INDICES (0-1)
# =============================================================================

cat("--- Step 5: Normalise fish condition indices ---\n")

if (!is.null(fish_site)) {
  fish_ci <- fish_site |>
    group_by(survey_period) |>
    mutate(ref_richness = max(mean_richness, na.rm = TRUE)) |>
    ungroup() |>
    mutate(
      ci_fish_biomass  = ci_max(mean_biomass_kg_ha, REF$fish_biomass_target),
      ci_fish_richness = ci_max(mean_richness, ref_richness)
    )
  cat(sprintf("  Fish CI rows: %d\n", nrow(fish_ci)))
} else {
  fish_ci <- NULL
  message("[Step 5 skipped — no fish biomass data]")
}

# =============================================================================
# 6. PA JOIN & SEEA EA ROWS
# =============================================================================

cat("--- Step 6: PA join and SEEA EA rows ---\n")

if (!is.null(fish_ci)) {

  fish_ci_pa <- fish_ci |>
    left_join(PA_CLASSIFICATION, by = c("site" = "site_std"))

  # Diagnostic: sites that didn't join to any PA — add to PA_CLASSIFICATION or SITE_NAME_MAP
  unmapped <- fish_ci_pa |> filter(is.na(pa_type)) |> distinct(site)
  if (nrow(unmapped) > 0) {
    cat("  WARNING: sites not in PA_CLASSIFICATION (update lookup table):\n")
    print(unmapped)
  }

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

  fish_seea_rows <- bind_rows(
    build_seea_rows(
      fish_ci_pa,
      "Fish biomass", "kg/ha",
      "mean_biomass_kg_ha", "ci_fish_biomass",
      "1,150 kg/ha WIO conservation target (McClanahan et al. 2016)",
      "HIGH",
      paste0("[PENDING] transect area assumed ", TRANSECT_AREA_M2, " m2")
    ),
    build_seea_rows(
      fish_ci_pa,
      "Fish species richness", "species count",
      "mean_richness", "ci_fish_richness",
      "Max observed in dataset", "MEDIUM"
    )
  ) |>
    arrange(survey_period, site, condition_indicator)

  cat(sprintf("  Fish SEEA rows: %d\n", nrow(fish_seea_rows)))
  fish_seea_rows |>
    group_by(survey_period, condition_indicator) |>
    summarise(n_sites = n(),
              mean_ci = round(mean(condition_index, na.rm = TRUE), 3),
              .groups = "drop") |>
    print()

} else {
  fish_seea_rows <- NULL
}

# =============================================================================
# 7. EXPORT
# =============================================================================

cat("--- Step 7: Export (per survey period) ---\n")

dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

periods <- unique(fish_all$survey_period)

for (p in periods) {
  tag <- tolower(p)  # e.g. "nov_2024"

  if (!is.null(fish_site)) {
    df <- fish_site |> filter(survey_period == p)
    if (nrow(df) > 0) {
      nm <- sprintf("KEN_fish_condition_site_%s.csv", tag)
      write.csv(df, file.path(OUT_DIR, nm), row.names = FALSE)
      cat(sprintf("  Wrote %s (%d rows)\n", nm, nrow(df)))
    }
  }

  if (!is.null(fish_seea_rows)) {
    df <- fish_seea_rows |> filter(survey_period == p)
    if (nrow(df) > 0) {
      nm <- sprintf("KEN_fish_seea_rows_%s.csv", tag)
      write.csv(df, file.path(OUT_DIR, nm), row.names = FALSE)
      cat(sprintf("  Wrote %s (%d rows)\n", nm, nrow(df)))
    }
  }
}

# =============================================================================
# 8. BAR GRAPH — FISH BIOMASS BY SITE AND SURVEY PERIOD
# =============================================================================

cat("--- Step 8: Bar graph ---\n")

if (!is.null(fish_site)) {
  library(ggplot2)
  library(scales)

  # Reorder sites by biomass (highest first) and label survey periods
  plot_df <- fish_site |>
    mutate(
      period_label = case_when(
        survey_period == "Nov_2024" ~ "Nov 2024",
        survey_period == "Jul_2025" ~ "Jul 2025",
        .default = survey_period
      ),
      site = reorder(site, mean_biomass_kg_ha, FUN = max)
    )

  p <- ggplot(plot_df, aes(x = site, y = mean_biomass_kg_ha, fill = period_label)) +
    geom_col(position = position_dodge(width = 0.8), width = 0.7) +
    geom_errorbar(
      aes(ymin = pmax(mean_biomass_kg_ha - se_biomass_kg_ha, 0),
          ymax = mean_biomass_kg_ha + se_biomass_kg_ha),
      position = position_dodge(width = 0.8), width = 0.25, linewidth = 0.4
    ) +
    geom_hline(
      yintercept = REF$fish_biomass_target, linetype = "dashed",
      colour = "grey40", linewidth = 0.5
    ) +
    annotate("text", x = 0.5, y = REF$fish_biomass_target,
             label = "WIO conservation target (1,150 kg/ha)",
             hjust = 0, vjust = -0.5, size = 3, colour = "grey40") +
    scale_fill_manual(
      values = c("Nov 2024" = "#4E79A7", "Jul 2025" = "#F28E2B"),
      name = "Survey period"
    ) +
    scale_y_continuous(labels = comma) +
    coord_flip() +
    labs(
      title = "Fish biomass by site",
      subtitle = "Kilifi County coral reefs — mean biomass per transect (+/- SE)",
      x = NULL,
      y = "Mean biomass (kg/ha)",
      caption = paste0("Transect area assumed ", TRANSECT_AREA_M2, " m2 (pending confirmation)")
    ) +
    theme_minimal(base_size = 11) +
    theme(
      legend.position = "top",
      panel.grid.major.y = element_blank(),
      plot.title = element_text(face = "bold")
    )

  ggsave(file.path(OUT_DIR, "KEN_fish_biomass_by_site.png"),
         p, width = 10, height = 7, dpi = 300)
  cat("  Wrote KEN_fish_biomass_by_site.png\n")
}

cat("--- Fish condition analysis complete ---\n")
