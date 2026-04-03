# Methods

## Survey Design, Data Processing, and SEEA EA Framework

---

## 1. Study Area

The study covers coastal ecosystems along **Kilifi County**, Kenya, from Ngomeni in the north to Kilifi Creek in the south. Three ecosystem types are assessed:

- **Coral reefs (M1.3):** Fringing and patch reefs along the Kilifi coastline, including Watamu Marine Park, Malindi MPA, and open-access sites
- **Mangroves (MFT1.2):** Four survey areas - Kilifi Creek, Marereni, Mida Creek, and Ngomeni
- **Seagrass meadows (M1.1):** Nine survey areas from Ngomeni to Takaungu

---

## 2. Coral Reef Surveys

### Survey Design

| Parameter | Value |
|------|----|
| Survey method | Underwater Visual Census (UVC) belt transect |
| Transect dimensions | 50 m x 5 m (250 m2) |
| Transects per site | 2 |
| Total reef sites | 25 (across 2 periods) |
| Survey periods | November 2024, July 2025 |
| Data sources | CCVA (Nov 2024), COMRED (Jul 2025), PU-GOAP (Nov 2024) |

### Indicators Measured

| Indicator | Method | Reference Level | Confidence |
|------|----|--------|------|
| Live hard coral cover | Point intercept transect | 30% (GCRMN 2021; Obura et al. 2022) | MEDIUM |
| Coral colony health | Colony-level visual assessment | 95% healthy (non-bleaching baseline) | MEDIUM |
| Coral bleaching | Colony-level visual assessment | <5% background (Hoegh-Guldberg 1999) | MEDIUM |
| Coral recruitment | Quadrat counts (1 m2) | 1-3 recruits/m$^2$ (WIO; Hughes et al. 2010) | LOW-MEDIUM |
| Fish biomass | UVC belt transect | 500 kg/ha (sustainability threshold) | MEDIUM |
| Fish species richness | UVC belt transect | Max observed in period | MEDIUM |
| COTS density | Belt transect count | 15 ind/ha outbreak threshold (Dulvy et al. 2021) | MEDIUM |
| Sea urchin density | Belt transect count | 1.5-2 ind/m$^2$ (provisional; WIO) | LOW |

### Fish Biomass Calculation

$$W = a \times L^b$$

where $W$ is weight (g), $L$ is total length (cm), and $a$ and $b$ are species-specific allometric parameters from FishBase.

---

## 3. Mangrove Surveys

### Extent Account

| Component | Source | Method |
|------|----|----|
| Opening (2020) | Global Mangrove Watch v4 | Satellite classification clipped to study area |
| Additions (2025) | Project classification | Erase analysis: 2025 extent minus GMW 2020 |
| Reductions (2020-2025) | Project classification | Erase analysis: GMW 2020 minus 2025 extent |
| Protected area overlay | WDPA | De-duplicated spatial intersection |

### Field-Based Condition Assessment

| Parameter | Value |
|------|----|
| Survey areas | 4 (Kilifi Creek, Marereni, Mida Creek, Ngomeni) |
| Total sites | 32 |
| Total plots | Variable (1-4 per site) |
| Plot method | Standard mangrove structure plots |

### Condition Indicators and Reference Levels

| Indicator | Reference Level | CI Formula |
|------|--------|------|
| Stem density | 5,600 stems/ha (Kenya mangrove average) | $CI = \min(x / 5600, 1.0)$ |
| Mean DBH | 39.7 cm (mature stand benchmark) | $CI = x / 39.7$ |
| Mean height | 17.42 m (Kenya mangrove reference) | $CI = x / 17.42$ |
| Canopy cover | 60% (closed canopy threshold) | $CI = x / 60$ (capped where $x < 60$) |
| Tree quality index | 1.0 (all trees healthy) | $CI = x$ (direct) |

$$CI_{composite} = \frac{1}{5}\sum_{i=1}^{5} CI_i$$

---

## 4. Seagrass Surveys

### Survey Design

| Parameter | Value |
|------|----|
| Survey areas | 9 |
| Method | Quadrat-based assessment |
| Indicators | Total cover (%), species richness, shoot density (shoots/m2), canopy height (cm) |
| Quadrat size | 0.25 m2 |
| Total quadrats | Variable (20-117 per area) |

### Condition Indicators

| Indicator | Reference Level | Confidence |
|------|--------|------|
| Total cover | 100% (theoretical maximum) | MEDIUM |
| Species richness | 8 species (maximum observed at Ngomeni) | MEDIUM |

$$CI_{cover} = \frac{\text{observed cover}}{100}$$

$$CI_{richness} = \frac{\text{observed species}}{8}$$

---

## 5. Fisheries Provisioning Service

### Physical Supply

| Parameter | Value |
|------|----|
| County | Kilifi |
| Period | 2020-2024 |
| Data source | Kenya Fisheries Service (KeFS) landing records |
| Attribution method | Species-level reef association fraction |
| Adjustment factor | 1.3x (unreported catch; FAO/IHH methodology) |
| Status | PROVISIONAL - pending Dr Pascal Thoya validation |

### Monetary Valuation

| Parameter | Value |
|------|----|
| Method | Resource rent (SEEA EA Chapter 10) |
| Price data | Average market price at landing sites (KES/kg) |
| Deflation | GDP deflator series to 2024 real KES |
| Exchange rate | 1 USD = 134.85 KES (2024 average) |
| Rent share (lower) | 30% of gross revenue |
| Rent share (central) | 38% |
| Rent share (upper) | 45% |

---

## 6. Condition Index Normalisation

All condition indices follow the general SEEA EA normalisation formula:

$$CI_i = \min\left(\frac{x_i}{x_{ref,i}}, 1.0\right)$$

where $x_i$ is the measured value and $x_{ref,i}$ is the reference level. For inverted indicators (e.g., bleaching, COTS density):

$$CI_i = \max\left(1 - \frac{x_i}{x_{threshold}}, 0\right)$$

---

## 7. SEEA EA Framework Alignment

This account follows the **UN SEEA EA** (2021) structure:

- **Ecosystem types:** Photic Coral Reefs (IUCN GET M1.3), Mangroves (MFT1.2), Seagrass Meadows (M1.1)
- **Accounting area:** Kilifi County, Kenya
- **Account types:** Extent (mangrove only), Condition (all three types), Ecosystem Services (fisheries provisioning)
- **Accounting periods:** 2020-2025 (extent), Nov 2024 and Jul 2025 (condition), 2020-2024 (services)

---

## 8. Known Limitations

1. **Coral reef extent:** No satellite-derived extent account yet; benthic habitat classification in progress
2. **Seagrass extent:** Not yet mapped; extent account depends on Sentinel-2 classification
3. **Temporal mismatch:** Coral condition compares two different site sets (Nov 2024 vs Jul 2025), not repeated surveys at the same locations
4. **Low transect counts:** Most reef sites surveyed with only 2 transects (minimum viable); limited statistical power
5. **Fisheries attribution:** Reef catch fraction is provisional pending expert validation
6. **Mangrove single-year condition:** No temporal comparison available; condition account is a baseline snapshot
7. **Seagrass condition indices:** Cover and richness indices are preliminary; no established WIO reference levels for shoot density or canopy height

---

## 9. Data Sources

| Dataset | Records | Coverage |
|-----|-----|-----|
| KEN_fish_condition_site.csv | 17 site-periods | 9 sites (Nov 2024) + 8 sites (Jul 2025) |
| KEN_benthic_cover_site.csv | 11 site-periods | 6 sites (Nov 2024) + 5 sites (Jul 2025) |
| KEN_coral_health_site.csv | 15 site-periods | 9 sites (Nov 2024) + 6 sites (Jul 2025) |
| KEN_coral_recruitment_site.csv | 16 site-periods | 10 sites (Nov 2024) + 6 sites (Jul 2025) |
| KEN_mangrove_condition_by_site.csv | 32 sites | 4 areas, 32 field plots |
| KEN_seagrass_cover_site.csv | 9 areas | Cover and species composition |
| KEN_seagrass_health_site.csv | 40 records | Shoot density and canopy height by species |
| KEN_fisheries_supply_physical.csv | 5 years | Reef-associated catch, 2020-2024 |
| KEN_fisheries_supply_monetary.csv | 5 years | Resource rent valuation, 2020-2024 |

**Analysis scripts:** `Kenya/02_analysis/`

---

## References

- Dulvy, N.K. et al. (2021). Updated COTS outbreak thresholds for the Western Indian Ocean.
- Hoegh-Guldberg, O. (1999). Climate change, coral bleaching and the future of the world's coral reefs. *Marine and Freshwater Research*, 50(8), 839-866.
- Hughes, T.P. et al. (2010). Rising to the challenge of sustaining coral reef resilience. *Trends in Ecology & Evolution*, 25(11), 633-642.
- McClanahan, T.R. et al. (2016). Global baselines and benchmarks for fish biomass. *Conservation Biology*, 30(3), 577-587.
- Obura, D. et al. (2022). Status of Coral Reefs of the World. *Global Coral Reef Monitoring Network*.
- United Nations (2021). *System of Environmental-Economic Accounting - Ecosystem Accounting* (SEEA EA). United Nations, New York.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
</style>
