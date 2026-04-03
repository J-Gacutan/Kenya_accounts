# =============================================================================
# Fish & Invertebrate Biotic Condition Analysis
# SEEA EA Condition Account — Coral Reef (M1.3)
#
# Input:  Fishdata_OASIS_M.xlsx, Invertebrate_0ASIS_M.xlsx
# Output: Site-level condition summary (CSV), SEEA EA condition rows (CSV)
#
# Methodology: skill_condition_biotic_fish_invert.md
# =============================================================================

library(readxl)
library(dplyr)
library(tidyr)
library(stringr)

# -----------------------------------------------------------------------------
# 0. CONFIG
# -----------------------------------------------------------------------------

SCRIPT_DIR <- tryCatch(
  dirname(rstudioapi::getSourceEditorContext()$path),
  error = function(e) getwd()
)
INPUT_DIR  <- file.path(dirname(SCRIPT_DIR), "01_inputs", "raw_data")
OUTPUT_DIR <- file.path(dirname(SCRIPT_DIR), "03_outputs")

FISH_FILE  <- file.path(INPUT_DIR, "Fishdata_OASIS_M.xlsx")
INVERT_FILE <- file.path(INPUT_DIR, "Invertebrate_0ASIS_M.xlsx")

# Transect dimensions (standard UVC belt transect)
TRANSECT_LENGTH_M <- 50
TRANSECT_WIDTH_M  <- 5
TRANSECT_AREA_M2  <- TRANSECT_LENGTH_M * TRANSECT_WIDTH_M
TRANSECT_AREA_HA  <- TRANSECT_AREA_M2 / 10000

# Size-class midpoints (cm)
SIZE_MIDPOINTS <- c("5_10" = 7.5, "10_20" = 15, "20_30" = 25,
                    "30_40" = 35, "40_50" = 45, "50_60" = 55)

# Reference levels
REF_FISH_BIOMASS_KG_HA <- 1150  # McClanahan et al. (2016) PLOS ONE — WIO conservation target (15 countries); sustainability floor: 600 kg/ha
REF_FISH_BIOMASS_FLOOR <- 600   # McClanahan et al. (2016) — WIO sustainability floor
REF_COTS_OUTBREAK_HA   <- 15    # Dulvy et al. (2021) Nat.Commun. / Indo-Pacific consensus; background <1 ind/ha; intervention threshold 10–15 ind/ha

# Species and functional group constants (avoid stringly-typed code)
SPECIES_COTS <- "Acanthaster planci"
SPECIES_TRIDACNA <- "Tridacna maxima"
SPECIES_DIADEMA <- "Diadema setosum"
SPECIES_ECHINOMETRA <- "Echinometra mathaei"

FG_CARNIVORE <- "Carnivore"
FG_HERBIVORE <- "Herbivore"
FG_CORALLIVORE <- "Corallivore"
FG_OMNIVORE <- "Omnivore"
FG_PLANKTIVORE <- "Planktivore"
FG_DETRITIVORE <- "Detritivore"
FG_PISCIVORE <- "Piscivore"

SEEA_IND_FISH_BIOMASS <- "Fish biomass"
SEEA_IND_FISH_RICHNESS <- "Fish species richness"
SEEA_IND_COTS_DENSITY <- "COTS density"

# Output files
OUT_SITE_FG_CSV <- file.path(OUTPUT_DIR, "MDG_fish_invert_site_fg_condition.csv")
OUT_SITE_CSV    <- file.path(OUTPUT_DIR, "MDG_fish_invert_site_condition.csv")
OUT_SEEA_CSV    <- file.path(OUTPUT_DIR, "MDG_fish_invert_seea_condition.csv")
OUT_CONDITION_RAW_CSV <- file.path(OUTPUT_DIR, "MDG_fish_invert_condition_account_raw.csv")
OUT_CONDITION_NORM_CSV <- file.path(OUTPUT_DIR, "MDG_fish_invert_condition_account_normalized.csv")
OUT_SEEA_SITE_CSV <- file.path(OUTPUT_DIR, "MDG_fish_invert_seea_condition_per_site.csv")


# =============================================================================
# 1. DATA INGESTION
# =============================================================================

cat("--- Reading fish data ---\n")
fish_raw <- read_excel(FISH_FILE, sheet = "Fish_All data")

cat("--- Reading invertebrate data ---\n")
invert_raw  <- read_excel(INVERT_FILE, sheet = "Macroinvertebrates")
urchin_raw  <- read_excel(INVERT_FILE, sheet = "Sea urchin")

cat(sprintf("Fish: %d rows, %d cols\n", nrow(fish_raw), ncol(fish_raw)))
cat(sprintf("Macroinvertebrates: %d rows, %d cols\n", nrow(invert_raw), ncol(invert_raw)))
cat(sprintf("Sea urchins: %d rows, %d cols\n", nrow(urchin_raw), ncol(urchin_raw)))


# =============================================================================
# 2. QA/QC
# =============================================================================

# --- Helper: fix GPS coordinates with missing decimal points ---
fix_gps <- function(x, valid_min, valid_max) {
  x <- suppressWarnings(as.numeric(x))
  bad <- !is.na(x) & (x < valid_min | x > valid_max)
  if (any(bad, na.rm = TRUE)) {
    # Iteratively divide by 10 until in range
    for (i in which(bad)) {
      val <- x[i]
      while (!is.na(val) && (val < valid_min | val > valid_max)) {
        val <- val / 10
      }
      x[i] <- val
    }
  }
  x
}

# --- 2a. Fish QA/QC ---

fish <- fish_raw

# Fix GPS
fish$Latitude  <- fix_gps(fish$Latitude,  valid_min = -30, valid_max = -15)
fish$Longitude <- fix_gps(fish$Longitude, valid_min = 40,  valid_max = 55)

# Trim whitespace in taxonomy
fish$Genus   <- str_trim(fish$Genus)
fish$Species <- str_trim(fish$Species)
fish$Family  <- str_trim(fish$Family)

# Fix family typos
fish$Family <- str_remove(fish$Family, "\\+.*$")

# Standardise functional groups
fg_lookup <- c(
  "Carnivore"            = "Carnivore",
  "Carnivores"           = "Carnivore",
  "carnivore"            = "Carnivore",
  "carnivores"           = "Carnivore",
  "Carnivore 1er ordre"  = "Carnivore",
  "Carnivore 2nd ordre"  = "Carnivore",
  "Herbivore"            = "Herbivore",
  "herbivores"           = "Herbivore",
  "Corallivore"          = "Corallivore",
  "corallivores"         = "Corallivore",
  "Omnivore"             = "Omnivore",
  "omnivores"            = "Omnivore",
  "Planctonophage"       = FG_PLANKTIVORE,
  "planctonophages"      = FG_PLANKTIVORE,
  "Planktivore"          = FG_PLANKTIVORE,
  "D\u00e9tritivores"    = FG_DETRITIVORE,
  "piscivores"           = FG_PISCIVORE
)
fish$Functional_Group_Std <- fg_lookup[fish$`Functional Group`]
# Keep original if no match
fish$Functional_Group_Std[is.na(fish$Functional_Group_Std)] <-
  str_to_title(fish$`Functional Group`[is.na(fish$Functional_Group_Std)])

# Standardise secondary groups
fish$Secondary_Group_Std <- str_to_title(str_trim(fish$`Secondary Group`))
fish$Secondary_Group_Std <- str_replace(fish$Secondary_Group_Std, "Invertvore", "Invertivore")

# Remove rows with no valid species
fish <- fish %>% filter(!is.na(Species), Species != "0", Species != "")

cat(sprintf("Fish after QA/QC: %d rows\n", nrow(fish)))


# --- 2b. Invertebrate QA/QC ---

invert <- invert_raw

# Fix GPS
invert$Latitude  <- fix_gps(invert$Latitude,  valid_min = -30, valid_max = -15)
invert$Longitude <- fix_gps(invert$Longitude, valid_min = 40,  valid_max = 55)

# Fix misplaced transect value
invert$Transects[invert$Transects == "onus rattus"] <- NA

# Remove rows with no species or species = 0
invert$Species <- as.character(invert$Species)
invert <- invert %>%
  filter(!is.na(Species), Species != "0", Species != "")

# Ensure abundance is numeric
invert$Abundance <- suppressWarnings(as.numeric(invert$Abundance))

# Remove rows with all NAs (padding rows)
invert <- invert %>% filter(!is.na(Sites) | !is.na(Species))

# Standardize column names (note: source data has Stations/Transects plural)
invert <- invert %>% rename(Station = Stations, Transect = Transects)

cat(sprintf("Macroinvertebrates after QA/QC: %d rows\n", nrow(invert)))


# --- 2c. Sea urchin QA/QC ---

urchin <- urchin_raw

# Fix GPS
urchin$Latitude  <- fix_gps(urchin$Latitude,  valid_min = -30, valid_max = -15)
urchin$Longitude <- fix_gps(urchin$Longitude, valid_min = 40,  valid_max = 55)

# Remove rows with no species or species = 0
urchin$Species <- as.character(urchin$Species)
urchin <- urchin %>%
  filter(!is.na(Species), Species != "0", Species != "")

# Evaluate formula strings in Abundance
urchin$Abundance <- sapply(urchin$Abundance, function(x) {
  x_char <- as.character(x)
  if (grepl("^=", x_char)) {
    # Remove leading "=" and evaluate
    tryCatch(eval(parse(text = sub("^=", "", x_char))),
             error = function(e) NA_real_)
  } else {
    suppressWarnings(as.numeric(x_char))
  }
})

# Remove padding rows
urchin <- urchin %>% filter(!is.na(Sites) | !is.na(Species))

cat(sprintf("Sea urchins after QA/QC: %d rows\n", nrow(urchin)))


# =============================================================================
# 3. EXTRACT CALENDAR YEAR
# =============================================================================

fish$Date   <- as.Date(fish$Date)
fish$Year   <- as.integer(format(fish$Date, "%Y"))

invert$Date  <- as.Date(invert$Date)
invert$Year  <- as.integer(format(invert$Date, "%Y"))

urchin$Date  <- as.Date(urchin$Date)
urchin$Year  <- as.integer(format(urchin$Date, "%Y"))

cat(sprintf("Fish calendar years: %s\n",
            paste(sort(unique(fish$Year)), collapse = ", ")))
cat(sprintf("Invertebrate calendar years: %s\n",
            paste(sort(unique(invert$Year)), collapse = ", ")))
cat(sprintf("Urchin calendar years: %s\n",
            paste(sort(unique(urchin$Year)), collapse = ", ")))


# =============================================================================
# 4. FISH BIOMASS CALCULATION
# =============================================================================

# Ensure size-class columns are numeric
size_cols <- names(SIZE_MIDPOINTS)
for (col in size_cols) {
  fish[[col]] <- suppressWarnings(as.numeric(fish[[col]]))
}
fish$a <- suppressWarnings(as.numeric(fish$a))
fish$b <- suppressWarnings(as.numeric(fish$b))

# Calculate biomass per row (grams)
fish$biomass_g <- 0

for (col in size_cols) {
  midpoint <- SIZE_MIDPOINTS[col]
  count    <- fish[[col]]
  count[is.na(count)] <- 0

  # W = a * L^b (grams per individual)
  w_individual <- fish$a * (midpoint ^ fish$b)

  fish$biomass_g <- fish$biomass_g + (count * w_individual)
}

# Total abundance per row (sum of all size-class counts)
fish$total_count <- rowSums(fish[, size_cols], na.rm = TRUE)


# =============================================================================
# 5. FISH AGGREGATION: Transect → Site × Functional Group × Year
# =============================================================================

# --- Transect-level by functional group ---
fish_transect_fg <- fish %>%
  group_by(Year, Sites, Station, Transect, Functional_Group_Std) %>%
  summarise(
    biomass_g  = sum(biomass_g, na.rm = TRUE),
    abundance  = sum(total_count, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    biomass_kg_ha = (biomass_g / 1000) / TRANSECT_AREA_HA,
    abundance_ha  = abundance / TRANSECT_AREA_HA
  )

# --- Transect-level totals (all functional groups combined) ---
fish_transect_total <- fish %>%
  group_by(Year, Sites, Station, Transect) %>%
  summarise(
    biomass_g        = sum(biomass_g, na.rm = TRUE),
    abundance        = sum(total_count, na.rm = TRUE),
    species_richness = n_distinct(Species),
    .groups = "drop"
  ) %>%
  mutate(
    biomass_kg_ha = (biomass_g / 1000) / TRANSECT_AREA_HA,
    abundance_ha  = abundance / TRANSECT_AREA_HA
  )

# --- Site × Functional Group × Year (mean & variance across transects) ---
fish_site_fg <- fish_transect_fg %>%
  group_by(Year, Sites, Functional_Group_Std) %>%
  summarise(
    mean_biomass_kg_ha = mean(biomass_kg_ha, na.rm = TRUE),
    var_biomass_kg_ha  = var(biomass_kg_ha, na.rm = TRUE),
    mean_abundance_ha  = mean(abundance_ha, na.rm = TRUE),
    var_abundance_ha   = var(abundance_ha, na.rm = TRUE),
    n_transects        = n(),
    .groups = "drop"
  ) %>%
  # Replace NA variance (single transect) with 0
  mutate(
    var_biomass_kg_ha = ifelse(is.na(var_biomass_kg_ha), 0, var_biomass_kg_ha),
    var_abundance_ha  = ifelse(is.na(var_abundance_ha), 0, var_abundance_ha)
  )

cat("\n--- Fish site × functional group × year (first 30 rows) ---\n")
print(fish_site_fg, n = 30)

# Pre-compute species richness (avoid N+1 pattern: only filter once)
fish_richness <- fish %>%
  group_by(Sites, Year) %>%
  summarise(species_richness = n_distinct(Species), .groups = "drop")

# --- Site × Year totals (mean & variance across transects) ---
fish_site <- fish_transect_total %>%
  group_by(Year, Sites) %>%
  summarise(
    mean_biomass_kg_ha = mean(biomass_kg_ha, na.rm = TRUE),
    var_biomass_kg_ha  = var(biomass_kg_ha, na.rm = TRUE),
    mean_abundance_ha  = mean(abundance_ha, na.rm = TRUE),
    var_abundance_ha   = var(abundance_ha, na.rm = TRUE),
    n_transects        = n(),
    .groups = "drop"
  ) %>%
  left_join(fish_richness, by = c("Year", "Sites")) %>%
  mutate(
    var_biomass_kg_ha = ifelse(is.na(var_biomass_kg_ha), 0, var_biomass_kg_ha),
    var_abundance_ha  = ifelse(is.na(var_abundance_ha), 0, var_abundance_ha)
  )

cat("\n--- Fish site × year totals ---\n")
print(fish_site, n = 60)


# =============================================================================
# 6. TROPHIC COMPOSITION (by Site × Year)
# =============================================================================

trophic <- fish_site_fg %>%
  group_by(Year, Sites) %>%
  mutate(
    total_biomass = sum(mean_biomass_kg_ha, na.rm = TRUE),
    pct_biomass   = ifelse(total_biomass > 0,
                           mean_biomass_kg_ha / total_biomass * 100, 0)
  ) %>%
  ungroup() %>%
  select(Year, Sites, Functional_Group_Std, mean_biomass_kg_ha, pct_biomass)

# Accounting-area-wide trophic summary (by year)
trophic_overall <- trophic %>%
  group_by(Year, Functional_Group_Std) %>%
  summarise(
    mean_biomass_kg_ha = mean(mean_biomass_kg_ha, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  group_by(Year) %>%
  mutate(pct_biomass = mean_biomass_kg_ha / sum(mean_biomass_kg_ha) * 100) %>%
  ungroup() %>%
  arrange(Year, desc(pct_biomass))

cat("\n--- Overall trophic composition (% biomass, by year) ---\n")
print(trophic_overall)


# =============================================================================
# 7. INVERTEBRATE METRICS (by Site × Year)
# =============================================================================

# --- 7a. Macroinvertebrate transect-level ---
invert_transect <- invert %>%
  group_by(Year, Sites, Station, Transect) %>%
  summarise(
    total_abundance  = sum(Abundance, na.rm = TRUE),
    cots_count       = sum(Abundance[Species == SPECIES_COTS], na.rm = TRUE),
    tridacna_count   = sum(Abundance[Species == SPECIES_TRIDACNA], na.rm = TRUE),
    species_richness = n_distinct(Species[!is.na(Species)]),
    .groups = "drop"
  )

# Pre-compute macroinvertebrate species richness (avoid N+1 pattern)
invert_richness <- invert %>%
  group_by(Sites, Year) %>%
  summarise(species_richness = n_distinct(Species[!is.na(Species)]), .groups = "drop")

# --- 7a. Macroinvertebrate site × year (mean & variance across transects) ---
invert_site <- invert_transect %>%
  group_by(Year, Sites) %>%
  summarise(
    mean_abundance      = mean(total_abundance, na.rm = TRUE),
    var_abundance       = var(total_abundance, na.rm = TRUE),
    mean_cots_count     = mean(cots_count, na.rm = TRUE),
    var_cots_count      = var(cots_count, na.rm = TRUE),
    mean_tridacna_count = mean(tridacna_count, na.rm = TRUE),
    var_tridacna_count  = var(tridacna_count, na.rm = TRUE),
    n_transects         = n(),
    .groups = "drop"
  ) %>%
  left_join(invert_richness, by = c("Year", "Sites")) %>%
  mutate(
    across(starts_with("var_"), ~ifelse(is.na(.), 0, .))
  )

# --- 7b. Sea urchin transect-level ---
urchin_transect <- urchin %>%
  group_by(Year, Sites, Station, Transects) %>%
  summarise(
    total_abundance   = sum(Abundance, na.rm = TRUE),
    diadema_count     = sum(Abundance[Species == SPECIES_DIADEMA], na.rm = TRUE),
    echinometra_count = sum(Abundance[Species == SPECIES_ECHINOMETRA], na.rm = TRUE),
    urchin_richness   = n_distinct(Species[!is.na(Species)]),
    .groups = "drop"
  )

# --- 7b. Sea urchin site × year (mean & variance across transects) ---
urchin_site <- urchin_transect %>%
  group_by(Year, Sites) %>%
  summarise(
    mean_urchin_abundance = mean(total_abundance, na.rm = TRUE),
    var_urchin_abundance  = var(total_abundance, na.rm = TRUE),
    mean_diadema          = mean(diadema_count, na.rm = TRUE),
    mean_echinometra      = mean(echinometra_count, na.rm = TRUE),
    urchin_richness       = max(urchin_richness, na.rm = TRUE),
    n_transects           = n(),
    .groups = "drop"
  ) %>%
  mutate(
    var_urchin_abundance = ifelse(is.na(var_urchin_abundance), 0, var_urchin_abundance)
  )

cat("\n--- Macroinvertebrate site × year summary ---\n")
print(invert_site, n = 60)

cat("\n--- Sea urchin site × year summary ---\n")
print(urchin_site, n = 60)


# =============================================================================
# 8. NORMALISATION TO CONDITION INDICES (by Year)
# =============================================================================

# --- 8a. Fish biomass CI ---
fish_site <- fish_site %>%
  mutate(
    ci_fish_biomass = pmin(mean_biomass_kg_ha / REF_FISH_BIOMASS_KG_HA, 1.0)
  )

# --- 8b. Fish species richness CI (relative to max observed, per year) ---
fish_site <- fish_site %>%
  group_by(Year) %>%
  mutate(
    ref_richness     = max(species_richness, na.rm = TRUE),
    ci_fish_richness = species_richness / ref_richness
  ) %>%
  ungroup()

# --- 8c. COTS CI (inverted — lower density = higher condition) ---
# Scale COTS mean count to per-ha density
invert_site <- invert_site %>%
  mutate(
    cots_density_ha = mean_cots_count / TRANSECT_AREA_HA,
    ci_cots         = pmax(1 - (cots_density_ha / REF_COTS_OUTBREAK_HA), 0)
  )

# --- 8d. Sea urchin density per m² (descriptive only, no CI) ---
# Reference level not yet established; descriptive metric only (see CLAUDE.md open items)
urchin_site <- urchin_site %>%
  mutate(
    urchin_density_m2 = mean_urchin_abundance / TRANSECT_AREA_M2
  )

cat("\n--- Fish condition indices (by year) ---\n")
print(fish_site %>%
        select(Year, Sites, mean_biomass_kg_ha, ci_fish_biomass,
               species_richness, ci_fish_richness),
      n = 60)

cat("\n--- COTS condition index (by year) ---\n")
print(invert_site %>%
        select(Year, Sites, mean_cots_count, cots_density_ha, ci_cots),
      n = 60)


# =============================================================================
# 9. ACCOUNTING-AREA SUMMARY (by Year)
# =============================================================================

years <- sort(unique(fish_site$Year))

summary_list <- lapply(years, function(yr) {
  fs <- fish_site %>% filter(Year == yr)
  is <- invert_site %>% filter(Year == yr)
  us <- urchin_site %>% filter(Year == yr)

  tibble(
    year      = yr,
    indicator = c("Fish biomass (kg/ha)",
                  "Fish species richness",
                  "COTS density (ind/ha)",
                  "Sea urchin density (ind/m²)",
                  "Macroinvertebrate richness"),
    mean_value = c(
      mean(fs$mean_biomass_kg_ha, na.rm = TRUE),
      mean(fs$species_richness, na.rm = TRUE),
      mean(is$cots_density_ha, na.rm = TRUE),
      mean(us$urchin_density_m2, na.rm = TRUE),
      mean(is$species_richness, na.rm = TRUE)
    ),
    se = c(
      sd(fs$mean_biomass_kg_ha, na.rm = TRUE) / sqrt(nrow(fs)),
      sd(fs$species_richness, na.rm = TRUE) / sqrt(nrow(fs)),
      sd(is$cots_density_ha, na.rm = TRUE) / sqrt(nrow(is)),
      sd(us$urchin_density_m2, na.rm = TRUE) / sqrt(nrow(us)),
      sd(is$species_richness, na.rm = TRUE) / sqrt(nrow(is))
    )
  )
})

summary_stats <- bind_rows(summary_list)

cat("\n=== ACCOUNTING-AREA SUMMARY (by year) ===\n")
print(summary_stats, n = 50)


# =============================================================================
# 9.5. OPENING & CLOSING CONDITION ACCOUNTS (per Site, across Years)
# =============================================================================

# Combine all site-level indicators
# First prepare each dataset with distinct names
fish_for_oc <- fish_site %>%
  select(Year, Sites,
         mean_biomass_kg_ha, mean_abundance_ha, species_richness,
         ci_fish_biomass, ci_fish_richness) %>%
  rename(fish_richness = species_richness)

invert_for_oc <- invert_site %>%
  select(Year, Sites,
         mean_cots_count, cots_density_ha, ci_cots,
         mean_tridacna_count, mean_abundance,
         species_richness) %>%
  rename(macroinvert_richness = species_richness)

urchin_for_oc <- urchin_site %>%
  select(Year, Sites, mean_urchin_abundance, urchin_density_m2)

# Merge all three
site_combined <- fish_for_oc %>%
  left_join(invert_for_oc, by = c("Year", "Sites")) %>%
  left_join(urchin_for_oc, by = c("Year", "Sites"))

# Determine opening (min year) and closing (max year) per site
min_year <- min(site_combined$Year, na.rm = TRUE)
max_year <- max(site_combined$Year, na.rm = TRUE)

# Separate opening and closing data
site_opening <- site_combined %>%
  filter(Year == min_year) %>%
  select(-Year) %>%
  rename_with(~paste0(., "_opening"), -Sites)

site_closing <- site_combined %>%
  filter(Year == max_year) %>%
  select(-Year) %>%
  rename_with(~paste0(., "_closing"), -Sites)

# Merge opening and closing
site_oc <- full_join(site_opening, site_closing, by = "Sites") %>%
  arrange(Sites)

# --- Create RAW VALUES TABLE ---
raw_values_list <- list()

# Fish biomass
raw_values_list[[1]] <- site_oc %>%
  select(Sites,
         mean_biomass_kg_ha_opening, mean_biomass_kg_ha_closing) %>%
  mutate(
    Variable = "Fish biomass (total)",
    Opening_Year = min_year,
    Closing_Year = max_year,
    Opening_Value = mean_biomass_kg_ha_opening,
    Closing_Value = mean_biomass_kg_ha_closing,
    Absolute_Change = Closing_Value - Opening_Value,
    Percent_Change = ifelse(Opening_Value > 0,
                            (Closing_Value - Opening_Value) / Opening_Value * 100,
                            NA_real_),
    Unit = "kg/ha"
  ) %>%
  select(Sites, Variable, Opening_Year, Opening_Value, Closing_Year,
         Closing_Value, Absolute_Change, Percent_Change, Unit)

# Fish abundance
raw_values_list[[2]] <- site_oc %>%
  select(Sites,
         mean_abundance_ha_opening, mean_abundance_ha_closing) %>%
  mutate(
    Variable = "Fish abundance (total)",
    Opening_Year = min_year,
    Closing_Year = max_year,
    Opening_Value = mean_abundance_ha_opening,
    Closing_Value = mean_abundance_ha_closing,
    Absolute_Change = Closing_Value - Opening_Value,
    Percent_Change = ifelse(Opening_Value > 0,
                            (Closing_Value - Opening_Value) / Opening_Value * 100,
                            NA_real_),
    Unit = "ind/ha"
  ) %>%
  select(Sites, Variable, Opening_Year, Opening_Value, Closing_Year,
         Closing_Value, Absolute_Change, Percent_Change, Unit)

# Fish species richness
raw_values_list[[3]] <- site_oc %>%
  select(Sites,
         fish_richness_opening, fish_richness_closing) %>%
  mutate(
    Variable = "Fish species richness",
    Opening_Year = min_year,
    Closing_Year = max_year,
    Opening_Value = fish_richness_opening,
    Closing_Value = fish_richness_closing,
    Absolute_Change = Closing_Value - Opening_Value,
    Percent_Change = ifelse(Opening_Value > 0,
                            (Closing_Value - Opening_Value) / Opening_Value * 100,
                            NA_real_),
    Unit = "count"
  ) %>%
  select(Sites, Variable, Opening_Year, Opening_Value, Closing_Year,
         Closing_Value, Absolute_Change, Percent_Change, Unit)

# COTS density
raw_values_list[[4]] <- site_oc %>%
  select(Sites,
         cots_density_ha_opening, cots_density_ha_closing) %>%
  mutate(
    Variable = "COTS density",
    Opening_Year = min_year,
    Closing_Year = max_year,
    Opening_Value = cots_density_ha_opening,
    Closing_Value = cots_density_ha_closing,
    Absolute_Change = Closing_Value - Opening_Value,
    Percent_Change = ifelse(Opening_Value > 0,
                            (Closing_Value - Opening_Value) / Opening_Value * 100,
                            NA_real_),
    Unit = "ind/ha"
  ) %>%
  select(Sites, Variable, Opening_Year, Opening_Value, Closing_Year,
         Closing_Value, Absolute_Change, Percent_Change, Unit)

# Sea urchin density
raw_values_list[[5]] <- site_oc %>%
  select(Sites,
         urchin_density_m2_opening, urchin_density_m2_closing) %>%
  mutate(
    Variable = "Sea urchin density",
    Opening_Year = min_year,
    Closing_Year = max_year,
    Opening_Value = urchin_density_m2_opening,
    Closing_Value = urchin_density_m2_closing,
    Absolute_Change = Closing_Value - Opening_Value,
    Percent_Change = ifelse(Opening_Value > 0,
                            (Closing_Value - Opening_Value) / Opening_Value * 100,
                            NA_real_),
    Unit = "ind/m²"
  ) %>%
  select(Sites, Variable, Opening_Year, Opening_Value, Closing_Year,
         Closing_Value, Absolute_Change, Percent_Change, Unit)

# Macroinvertebrate richness
if ("macroinvert_richness_opening" %in% colnames(site_oc)) {
  raw_values_list[[6]] <- site_oc %>%
    select(Sites,
           macroinvert_richness_opening, macroinvert_richness_closing) %>%
    mutate(
      Variable = "Macroinvertebrate richness",
      Opening_Year = min_year,
      Closing_Year = max_year,
      Opening_Value = macroinvert_richness_opening,
      Closing_Value = macroinvert_richness_closing,
      Absolute_Change = Closing_Value - Opening_Value,
      Percent_Change = ifelse(Opening_Value > 0,
                              (Closing_Value - Opening_Value) / Opening_Value * 100,
                              NA_real_),
      Unit = "count"
    ) %>%
    select(Sites, Variable, Opening_Year, Opening_Value, Closing_Year,
           Closing_Value, Absolute_Change, Percent_Change, Unit)
}

# Giant clam abundance (if available)
if ("mean_tridacna_count_opening" %in% colnames(site_oc)) {
  raw_values_list[[7]] <- site_oc %>%
    select(Sites,
           mean_tridacna_count_opening, mean_tridacna_count_closing) %>%
    mutate(
      Variable = "Giant clam abundance",
      Opening_Year = min_year,
      Closing_Year = max_year,
      Opening_Value = mean_tridacna_count_opening,
      Closing_Value = mean_tridacna_count_closing,
      Absolute_Change = Closing_Value - Opening_Value,
      Percent_Change = ifelse(Opening_Value > 0,
                              (Closing_Value - Opening_Value) / Opening_Value * 100,
                              NA_real_),
      Unit = "count/transect"
    ) %>%
    select(Sites, Variable, Opening_Year, Opening_Value, Closing_Year,
           Closing_Value, Absolute_Change, Percent_Change, Unit)
}

condition_account_raw <- bind_rows(raw_values_list) %>%
  arrange(Variable, Sites)

cat("\n=== CONDITION ACCOUNT — RAW VALUES (Opening × Closing) ===\n")
print(condition_account_raw, n = 200)

# --- Create NORMALIZED VALUES TABLE ---
normalized_values_list <- list()

# Fish biomass CI
normalized_values_list[[1]] <- site_oc %>%
  select(Sites,
         ci_fish_biomass_opening, ci_fish_biomass_closing) %>%
  mutate(
    Indicator = "Fish biomass",
    Opening_Year = min_year,
    Closing_Year = max_year,
    CI_Opening = ci_fish_biomass_opening,
    CI_Closing = ci_fish_biomass_closing,
    CI_Change = CI_Closing - CI_Opening,
    Interpretation = case_when(
      CI_Change > 0.05 ~ "Improving",
      CI_Change < -0.05 ~ "Declining",
      TRUE ~ "Stable"
    ),
    Reference_Level = "1,150 kg/ha (WIO conservation target; McClanahan et al. 2016)"
  ) %>%
  select(Sites, Indicator, Opening_Year, CI_Opening, Closing_Year,
         CI_Closing, CI_Change, Interpretation, Reference_Level)

# Fish species richness CI (renamed from ci_fish_richness to ci_richness to avoid confusion)
# Note: need to handle the different ci_fish_richness columns from fish_site
normalized_values_list[[2]] <- tibble(
  Sites = character(),
  Indicator = character(),
  Opening_Year = integer(),
  CI_Opening = numeric(),
  Closing_Year = integer(),
  CI_Closing = numeric(),
  CI_Change = numeric(),
  Interpretation = character(),
  Reference_Level = character()
)

# We need to manually join fish_site data since ci_fish_richness isn't in site_oc
# Prepare fish_site data for richness
fish_richness_opening <- fish_site %>%
  filter(Year == min_year) %>%
  select(Sites, ci_fish_richness) %>%
  rename(ci_fish_richness_opening = ci_fish_richness)

fish_richness_closing <- fish_site %>%
  filter(Year == max_year) %>%
  select(Sites, ci_fish_richness) %>%
  rename(ci_fish_richness_closing = ci_fish_richness)

fish_richness_oc <- full_join(fish_richness_opening, fish_richness_closing, by = "Sites")

normalized_values_list[[2]] <- fish_richness_oc %>%
  mutate(
    Indicator = "Fish species richness",
    Opening_Year = min_year,
    Closing_Year = max_year,
    CI_Opening = ci_fish_richness_opening,
    CI_Closing = ci_fish_richness_closing,
    CI_Change = CI_Closing - CI_Opening,
    Interpretation = case_when(
      CI_Change > 0.05 ~ "Improving",
      CI_Change < -0.05 ~ "Declining",
      TRUE ~ "Stable"
    ),
    Reference_Level = "Max observed richness"
  ) %>%
  select(Sites, Indicator, Opening_Year, CI_Opening, Closing_Year,
         CI_Closing, CI_Change, Interpretation, Reference_Level)

# COTS density CI (inverted)
normalized_values_list[[3]] <- site_oc %>%
  select(Sites,
         ci_cots_opening, ci_cots_closing) %>%
  mutate(
    Indicator = "COTS density (inverted)",
    Opening_Year = min_year,
    Closing_Year = max_year,
    CI_Opening = ci_cots_opening,
    CI_Closing = ci_cots_closing,
    CI_Change = CI_Closing - CI_Opening,
    Interpretation = case_when(
      CI_Change > 0.05 ~ "Improving",
      CI_Change < -0.05 ~ "Declining",
      TRUE ~ "Stable"
    ),
    Reference_Level = "0 ind/ha (ideal)"
  ) %>%
  select(Sites, Indicator, Opening_Year, CI_Opening, Closing_Year,
         CI_Closing, CI_Change, Interpretation, Reference_Level)

condition_account_normalized <- bind_rows(normalized_values_list) %>%
  arrange(Indicator, Sites)

cat("\n=== CONDITION ACCOUNT — NORMALIZED VALUES (Opening × Closing) ===\n")
print(condition_account_normalized, n = 200)

# =============================================================================
# 10. SEEA EA CONDITION ACCOUNT TABLE (by Year)
# =============================================================================

seea_list <- lapply(years, function(yr) {
  fs <- fish_site %>% filter(Year == yr)
  is <- invert_site %>% filter(Year == yr)

  ref_rich <- max(fs$ref_richness, na.rm = TRUE)

  tibble(
    calendar_year        = yr,
    ecosystem_type       = "Coral reef (M1.3)",
    condition_indicator  = c(SEEA_IND_FISH_BIOMASS,
                             SEEA_IND_FISH_RICHNESS,
                             SEEA_IND_COTS_DENSITY),
    reference_level      = c(paste0(REF_FISH_BIOMASS_KG_HA, " kg/ha"),
                             paste0(ref_rich, " species (max observed)"),
                             "0 ind/ha (ideal)"),
    measured_value       = c(
      sprintf("%.1f kg/ha", mean(fs$mean_biomass_kg_ha, na.rm = TRUE)),
      sprintf("%.0f species", mean(fs$species_richness, na.rm = TRUE)),
      sprintf("%.1f ind/ha", mean(is$cots_density_ha, na.rm = TRUE))
    ),
    condition_index      = c(
      sprintf("%.2f", mean(fs$ci_fish_biomass, na.rm = TRUE)),
      sprintf("%.2f", mean(fs$ci_fish_richness, na.rm = TRUE)),
      sprintf("%.2f (inverted)", mean(is$ci_cots, na.rm = TRUE))
    )
  )
})

seea_table <- bind_rows(seea_list)

cat("\n=== SEEA EA CONDITION ACCOUNT TABLE (by year) ===\n")
print(seea_table)


# =============================================================================
# 10.5 SEEA EA CONDITION ACCOUNT TABLE (Per Site × Year)
# =============================================================================

# Build per-site condition account following skill_condition_biotic_fish_invert.md § 7b format
seea_per_site_list <- lapply(years, function(yr) {
  fs <- fish_site %>% filter(Year == yr)
  is <- invert_site %>% filter(Year == yr)

  # Merge fish and invert data per site
  per_site_data <- fs %>%
    left_join(is %>% select(Year, Sites, cots_density_ha, ci_cots),
              by = c("Year", "Sites"))

  # Reference level for richness (max observed in that year)
  ref_rich <- max(fs$ref_richness, na.rm = TRUE)

  # For each site × year combination, create one row per indicator
  per_site_rows <- lapply(seq_len(nrow(per_site_data)), function(i) {
    row <- per_site_data[i, ]

    tibble(
      calendar_year        = row$Year,
      site                 = row$Sites,
      ecosystem_type       = "Coral reef (M1.3)",
      condition_indicator  = c(SEEA_IND_FISH_BIOMASS,
                               SEEA_IND_FISH_RICHNESS,
                               SEEA_IND_COTS_DENSITY),
      reference_level      = c(paste0(REF_FISH_BIOMASS_KG_HA, " kg/ha"),
                               paste0(ref_rich, " species (max observed)"),
                               "0 ind/ha (ideal)"),
      measured_value       = c(
        sprintf("%.1f kg/ha", row$mean_biomass_kg_ha),
        sprintf("%.0f species", row$species_richness),
        sprintf("%.1f ind/ha", row$cots_density_ha)
      ),
      condition_index      = c(
        sprintf("%.2f", row$ci_fish_biomass),
        sprintf("%.2f", row$ci_fish_richness),
        sprintf("%.2f (inverted)", row$ci_cots)
      )
    )
  })

  bind_rows(per_site_rows)
})

seea_per_site <- bind_rows(seea_per_site_list)

cat("\n=== SEEA EA CONDITION ACCOUNT TABLE (Per Site × Year) ===\n")
print(seea_per_site, n = 100)


# =============================================================================
# 11. EXPORT
# =============================================================================

# --- Site × Functional Group × Year summary ---
write.csv(fish_site_fg, OUT_SITE_FG_CSV, row.names = FALSE)
cat(sprintf("\nSite × FG × Year summary saved to: %s\n", OUT_SITE_FG_CSV))

# --- Site-level condition summary (by year) ---
site_export <- fish_site %>%
  select(Year, Sites, mean_biomass_kg_ha, var_biomass_kg_ha,
         mean_abundance_ha, var_abundance_ha,
         species_richness, ci_fish_biomass, ci_fish_richness, n_transects) %>%
  left_join(
    invert_site %>% select(Year, Sites, mean_cots_count, var_cots_count,
                           cots_density_ha, ci_cots,
                           mean_tridacna_count, mean_abundance,
                           species_richness_invert = species_richness),
    by = c("Year", "Sites")
  ) %>%
  left_join(
    urchin_site %>% select(Year, Sites, mean_urchin_abundance,
                           var_urchin_abundance, urchin_density_m2,
                           mean_diadema),
    by = c("Year", "Sites")
  )

write.csv(site_export, OUT_SITE_CSV, row.names = FALSE)
cat(sprintf("Site-level summary saved to: %s\n", OUT_SITE_CSV))

# --- SEEA EA condition account (accounting-area level) ---
write.csv(seea_table, OUT_SEEA_CSV, row.names = FALSE)
cat(sprintf("SEEA EA condition table saved to: %s\n", OUT_SEEA_CSV))

# --- SEEA EA condition account (per site level) ---
write.csv(seea_per_site, OUT_SEEA_SITE_CSV, row.names = FALSE)
cat(sprintf("SEEA EA condition table (per site) saved to: %s\n", OUT_SEEA_SITE_CSV))

# --- Condition account with raw values (opening × closing) ---
write.csv(condition_account_raw, OUT_CONDITION_RAW_CSV, row.names = FALSE)
cat(sprintf("Condition account (raw values) saved to: %s\n", OUT_CONDITION_RAW_CSV))

# --- Condition account with normalized values (opening × closing) ---
write.csv(condition_account_normalized, OUT_CONDITION_NORM_CSV, row.names = FALSE)
cat(sprintf("Condition account (normalized values) saved to: %s\n", OUT_CONDITION_NORM_CSV))

cat("\n=== DONE ===\n")
