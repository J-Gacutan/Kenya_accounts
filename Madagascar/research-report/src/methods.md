# Methods

## Survey Design, Data Processing, and SEEA EA Framework

---

## 1. Study Area and Survey Design

The study covers **27 coastal survey sites** along the barrier and fringing reefs of the **Atsimo-Andrefana region**, southwest Madagascar, from Morombe in the north to Ambohibola in the south.

### Survey Parameters

| Parameter | Value |
|-----------|-------|
| Survey method | Underwater Visual Census (UVC) belt transect |
| Transect dimensions | 50 m x 5 m (250 m2) |
| Transects per station | 2 |
| Total stations | 85 |
| Total sites | 27 |
| Depth range | 3.6--16.5 m |
| Survey period | November 2025 -- February 2026 |

### Temporal Structure

The survey programme spans two accounting periods:

- **Opening period (Year 1):** 15 sites surveyed November--December 2025
- **Closing period (Year 2):** 13 sites surveyed January--February 2026 (one site overlaps)

Sites are not repeated across periods; the design captures spatial variation across the accounting area rather than temporal change at individual sites.

---

## 2. Data Collection

### Fish UVC

Fish surveys recorded species identity, size class, and abundance along belt transects. Size classes follow a 6-bin protocol:

| Bin | Range |
|-----|-------|
| 1 | 5--10 cm |
| 2 | 10--20 cm |
| 3 | 20--30 cm |
| 4 | 30--40 cm |
| 5 | 40--50 cm |
| 6 | 50--60 cm |

- **5,186** individual fish records
- **227** species across **39** families and **100** genera
- Primary observer: Laza

### Macroinvertebrate UVC

Invertebrate surveys recorded species, abundance, and presence/absence of key indicator taxa along the same transects.

- **434** records post-QA/QC (from 999 raw)
- **59** species
- Key taxa: Crown-of-thorns starfish (*Acanthaster planci*), giant clams (*Tridacna* spp.)
- Primary observer: Maka

### Sea Urchin UVC

- **264** records post-QA/QC (from 999 raw)
- **8** species
- Key taxa: *Echinometra mathaei*, *Diadema* spp.

---

## 3. Data Quality Assurance

### QA/QC Corrections Applied

| Issue | Records Affected | Correction |
|-------|-----------------|------------|
| GPS decimal-point restoration | 35 (17 lat, 18 lon) | Regex pattern matching to restore decimal points |
| Functional group standardisation | All fish records | 17 raw categories mapped to 7 standard groups |
| Transect column typos | 1 ("onus rattus") | Set to NA |
| Sea urchin formula strings | 36 | Evaluated (e.g., `=(10*48)` to 480) |
| Invertebrate row filtering | 565 rows removed | Non-target records, duplicates |
| Sea urchin row filtering | 735 rows removed | Non-target records, duplicates |

### Data Quality Flags

- **Transect area:** 250 m2 (50 m x 5 m) — confirmed with field team.
- **Size class 6 (50--60 cm):** Only 1 unique value across entire dataset -- large fish under-represented.
- **13 of 27 sites** surveyed with only 2 transects (minimum viable; low statistical power for site-level inference).

---

## 4. Biomass Calculation

Fish biomass is calculated using the allometric length-weight relationship:

$$W = a \times L^b$$

where $W$ is weight (g), $L$ is total length (cm), and $a$ and $b$ are species-specific parameters from FishBase.

- Size class midpoints used as length estimates (e.g., 5--10 cm bin = 7.5 cm)
- Biomass aggregated per transect, then averaged per site
- Units: kg/ha (converted from g/250 m2)

---

## 5. Condition Index Normalisation

Raw biophysical measurements are normalised to condition indices (CI) on a 0--1 scale using the following formulae:

### Fish Biomass CI

$$CI_{biomass} = \min\left(\frac{\text{measured biomass}}{500 \text{ kg/ha}}, 1.0\right)$$

Reference level: 500 kg/ha (minimum sustainability threshold).

### Fish Species Richness CI

$$CI_{richness} = \frac{\text{observed species}}{\text{max observed species in year}}$$

Reference level: maximum observed richness within each survey year (94 species in 2025, 103 in 2026).

### COTS Density CI (Inverted)

$$CI_{COTS} = \max\left(1 - \frac{\text{density}}{15 \text{ ind/ha}}, 0\right)$$

Reference level: 0 ind/ha (ideal, no COTS present). Outbreak threshold: 15 ind/ha (Dulvy et al. 2021).

---

## 6. Reference Levels

| Indicator | Reference Level | Source | Confidence |
|-----------|----------------|--------|------------|
| Fish biomass | 500 kg/ha | Minimum sustainability threshold | MEDIUM |
| Fish biomass (conservation target) | 1,150 kg/ha | McClanahan et al. 2016 (WIO) | MEDIUM |
| Fish species richness | Max observed in year | Internal benchmark | MEDIUM |
| COTS density | 0 ind/ha (ideal) | Dulvy et al. 2021 (WIO) | MEDIUM |
| COTS outbreak threshold | 15 ind/ha | Dulvy et al. 2021 (WIO, updated) | MEDIUM |
| Sea urchin density | 1.5--2.0 ind/m2 | Provisional (*E. mathaei* outer reef) | LOW |

---

## 7. SEEA EA Framework Alignment

This account follows the **UN SEEA EA** (2021) Ecosystem Condition Account structure:

- **Ecosystem type:** Photic Coral Reefs (IUCN Global Ecosystem Typology M1.3)
- **Accounting area:** Atsimo-Andrefana barrier and fringing reefs, SW Madagascar
- **Condition indicators:** Biotic (fish biomass, species richness, COTS density)
- **Condition reference levels:** Sustainability thresholds and maximum observed values
- **Accounting period:** 2025--2026

The condition account reports:

1. **Indicator values** (measured biophysical metrics)
2. **Reference levels** (benchmarks for comparison)
3. **Condition indices** (normalised 0--1 departure from reference)

---

## 8. Trophic Classification

Fish species are classified into **7 standard functional groups** based on diet:

| Functional Group | Description |
|-----------------|-------------|
| Herbivore | Macroalgal grazers and browsers |
| Carnivore | Predators of fish and mobile invertebrates |
| Planktivore | Zooplankton feeders |
| Corallivore | Coral tissue feeders |
| Omnivore | Mixed diet (algae + invertebrates) |
| Piscivore | Obligate fish predators |
| Detritivore | Detritus and sediment feeders |

Original field classifications (17 categories including French-language variants) were standardised to these 7 groups during QA/QC.

---

## 9. Known Limitations

1. **No temporal replication at site level.** Each site was surveyed in one period only; the opening/closing structure captures spatial variation, not temporal change at individual locations.
2. **Transect area.** Confirmed as 250 m2 (50 m x 5 m) with field team.
3. **Sea urchin reference level provisional.** No formal WIO reference published; awaiting GCRMN East Africa consultation.
4. **Large fish under-represented.** Size class 6 (50--60 cm) contains minimal observations, likely reflecting both rarity and observer bias.
5. **COTS scaling sensitivity.** With 250 m2 transects, a single COTS individual translates to 40 ind/ha -- above outbreak threshold. Presence/absence may be more reliable than density estimates at this transect scale.

---

## 10. Data Sources

| Dataset | Records | Coverage |
|---------|---------|----------|
| Fishdata_OASIS_M.xlsx | 5,186 | 27 sites, 85 stations, 227 species |
| Invertebrate_0ASIS_M.xlsx (Macroinvertebrates) | 434 (post-QA/QC) | 27 sites, 81 stations, 59 species |
| Invertebrate_0ASIS_M.xlsx (Sea urchins) | 264 (post-QA/QC) | 27 sites, 79 stations, 8 species |

**Analysis script:** `Madagascar/02_analysis/fish_invert_condition.R`

---

## References

- McClanahan, T.R. et al. (2016). Global baselines and benchmarks for fish biomass. *Conservation Biology*, 30(3), 577--587.
- Dulvy, N.K. et al. (2021). Updated COTS outbreak thresholds for the Western Indian Ocean.
- United Nations (2021). *System of Environmental-Economic Accounting -- Ecosystem Accounting* (SEEA EA). United Nations, New York.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
</style>
