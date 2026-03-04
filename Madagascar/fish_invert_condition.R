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

DATA_DIR   <- tryCatch(
  dirname(rstudioapi::getSourceEditorContext()$path),
  error = function(e) getwd()
)
FISH_FILE  <- file.path(DATA_DIR, "Fishdata_OASIS_M.xlsx")
INVERT_FILE <- file.path(DATA_DIR, "Invertebrate_0ASIS_M.xlsx")

# Transect dimensions (standard UVC belt transect)
TRANSECT_LENGTH_M <- 20
TRANSECT_WIDTH_M  <- 5
TRANSECT_AREA_M2  <- TRANSECT_LENGTH_M * TRANSECT_WIDTH_M
TRANSECT_AREA_HA  <- TRANSECT_AREA_M2 / 10000

# Size-class midpoints (cm)
SIZE_MIDPOINTS <- c("5_10" = 7.5, "10_20" = 15, "20_30" = 25,
                    "30_40" = 35, "40_50" = 45, "50_60" = 55)

# Reference levels
REF_FISH_BIOMASS_KG_HA <- 500   # MacNeil et al. (2015) unfished Indo-Pacific
REF_COTS_OUTBREAK_HA   <- 30    # AIMS LTMP outbreak threshold (per ha equivalent)

# Output files
OUT_SITE_FG_CSV <- file.path(DATA_DIR, "fish_invert_site_fg_condition.csv")
OUT_SITE_CSV    <- file.path(DATA_DIR, "fish_invert_site_condition.csv")
OUT_SEEA_CSV    <- file.path(DATA_DIR, "fish_invert_seea_condition.csv")


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
  "Planctonophage"       = "Planktivore",
  "planctonophages"      = "Planktivore",
  "Planktivore"          = "Planktivore",
  "D\u00e9tritivores"    = "Detritivore",
  "piscivores"           = "Piscivore"
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

# --- Site × Year totals (mean & variance across transects) ---
fish_site <- fish_transect_total %>%
  group_by(Year, Sites) %>%
  summarise(
    mean_biomass_kg_ha = mean(biomass_kg_ha, na.rm = TRUE),
    var_biomass_kg_ha  = var(biomass_kg_ha, na.rm = TRUE),
    mean_abundance_ha  = mean(abundance_ha, na.rm = TRUE),
    var_abundance_ha   = var(abundance_ha, na.rm = TRUE),
    species_richness   = n_distinct(
      fish$Species[fish$Sites == first(Sites) & fish$Year == first(Year)]
    ),
    n_transects        = n(),
    .groups = "drop"
  ) %>%
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
  group_by(Year, Sites, Stations, Transects) %>%
  summarise(
    total_abundance  = sum(Abundance, na.rm = TRUE),
    cots_count       = sum(Abundance[Species == "Acanthaster planci"], na.rm = TRUE),
    tridacna_count   = sum(Abundance[Species == "Tridacna maxima"], na.rm = TRUE),
    species_richness = n_distinct(Species[!is.na(Species)]),
    .groups = "drop"
  )

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
    species_richness    = n_distinct(
      invert$Species[invert$Sites == first(Sites) & invert$Year == first(Year) &
                       !is.na(invert$Species)]
    ),
    n_transects         = n(),
    .groups = "drop"
  ) %>%
  mutate(
    across(starts_with("var_"), ~ifelse(is.na(.), 0, .))
  )

# --- 7b. Sea urchin transect-level ---
urchin_transect <- urchin %>%
  group_by(Year, Sites, Station, Transects) %>%
  summarise(
    total_abundance   = sum(Abundance, na.rm = TRUE),
    diadema_count     = sum(Abundance[Species == "Diadema setosum"], na.rm = TRUE),
    echinometra_count = sum(Abundance[Species == "Echinometra mathaei"], na.rm = TRUE),
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

# --- 8d. Sea urchin density per m² (descriptive) ---
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
# 10. SEEA EA CONDITION ACCOUNT TABLE (by Year)
# =============================================================================

seea_list <- lapply(years, function(yr) {
  fs <- fish_site %>% filter(Year == yr)
  is <- invert_site %>% filter(Year == yr)

  ref_rich <- max(fs$ref_richness, na.rm = TRUE)

  tibble(
    calendar_year        = yr,
    ecosystem_type       = "Coral reef (M1.3)",
    condition_indicator  = c("Fish biomass",
                             "Fish species richness",
                             "COTS density"),
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

# --- SEEA EA condition account ---
write.csv(seea_table, OUT_SEEA_CSV, row.names = FALSE)
cat(sprintf("SEEA EA condition table saved to: %s\n", OUT_SEEA_CSV))

cat("\n=== DONE ===\n")
