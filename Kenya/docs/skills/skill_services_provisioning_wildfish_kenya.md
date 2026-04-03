# Skill: Provisioning Ecosystem Service Accounts — Wild Fish
## Kenya Coral Reef (M1.3) — Kilifi County, 2025–2026

**Purpose:** Quantify the physical supply and economic value of wild fish provisioning services from Kilifi County coral reefs, using official fisheries landings data and the resource rent method.

**Framework:** UN SEEA EA Ecosystem Service Accounts (Section 6.1)
**CICES Category:** 1.1.1 — Animal-based products (wild fish harvesting)
**Providing Ecosystem:** Photic Coral Reefs (M1.3), Kilifi County coast
**Service Users:** Artisanal fishing households; local and regional fish markets
**Accounting Period:** 2025–2026
**Data status:** KeFS landings data in hand (2020-2024); exchange rates and deflators confirmed; habitat attribution complete; cost structure from published WIO literature

---

## 1. Overview and Conceptual Framework

### 1.1 Wild Fish Provisioning Service

The wild fish provisioning service is the coral reef's contribution to human welfare through the sustained harvest of fish and invertebrates. It encompasses:

- Commercial and subsistence catch of reef-associated species
- Ex-vessel market value to fishing households
- Food security and protein supply for coastal communities

Distinction from the fisheries nursery service: the nursery service (regulating) measures the reef's capacity to enhance juvenile survival and standing biomass; the provisioning service measures actual catch extracted by humans. Both draw on reef fish biomass but measure different aspects of the ecosystem-human relationship.

### 1.2 Kenya Data Advantage

Kenya's provisioning service account is in a substantially stronger position than Madagascar's because official county-level landings data already exist. The Kenya Fisheries Service (KeFS) Catch Assessment Survey (CAS) records annual catch (MT) and ex-vessel value (KES '000) by species group at Kilifi landing sites (Malindi, Watamu, Kilifi Creek, Takaungu, Ngomeni) from 2020 to 2024.

This means:
- The physical supply account (catch volume) can be populated from the KeFS data without new primary surveys
- The monetary supply account (gross revenue) can be derived directly from KeFS values
- A Tier 1 resource rent estimate is calculable immediately using published WIO cost ratios
- The 2020-2024 time series enables trend analysis leading into the 2025-2026 accounting period

The key gap is ecosystem attribution: KeFS data is a county aggregate across all ecosystems. Reef-associated catch must be separated from seagrass, estuarine, and pelagic catch before attribution to the M1.3 coral reef account.

### 1.3 Links to Condition and Extent Accounts

| Upstream Account | Input to Provisioning Service |
|---|---|
| Condition account (coral reef UVC) | Species composition and fish families present confirm reef-associated catch is biologically plausible |
| Condition account (fish biomass) | Fish biomass (kg/ha) provides a cross-check on KeFS catch volumes |
| Extent account | Reef area (ha) needed to compute per-unit-area supply (kg/ha/yr) for SEEA EA |

---

## 2. Input Data

### 2.1 Primary Dataset: KeFS Annual Fisheries Statistics (2020-2024)

**File:** `01_inputs/raw_data/fisheries/Fisheries Data.xlsx`
**Source:** Kenya Fisheries Service (KeFS) Annual Fisheries Statistics Bulletins, compiled by Dr. Pascal Thoya, Pwani University
**Sheets:** Fisheries Catches (summary) | 2020 | 2021 | 2022 | 2023 | 2024

Summary catch trend:

| Year | Catch (MT) | Value (KES million) | Notes |
|------|-----------|---------------------|-------|
| 2020 | 4,452 | 1,273 | |
| 2021 | 4,592 | 1,096 | |
| 2022 | 9,306 | 2,400 | |
| 2023 | ~10,500* | ~2,700* | 2023 values are estimates in source |
| 2024 | 12,094 | 3,100 | |

*Trend: +172% catch growth 2020-2024; strong nominal growth partly reflects inflation (see Section 6.2 for deflation).*

Species groups recorded (~37 per year): see `01_inputs/metadata/fisheries_metadata.md` for the full group list. Groups span demersal reef fish, pelagic fish, and invertebrates.

Known limitations:
- County aggregate only; not disaggregated by ecosystem type or gear type
- Subsistence and unreported landings not captured (estimated 20-40% additional; see Section 3.3)
- Minor species name inconsistencies between years require standardisation
- 2023 values are estimates

### 2.2 Supporting Data: Coral Reef UVC Fish Surveys

**Files:** `01_inputs/raw_data/coral_reef/KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx` (698 rows, Nov 2024); `COMRED_OCEANS-JULY2025-FISH-DATA.xlsx` (343 rows, Jul 2025)

These surveys do not record catch but they confirm which fish families are present at Kilifi reef sites. The family list from UVC surveys (Acanthuridae, Balistidae, Chaetodontidae, Epinephelidae, Labridae, Lethrinidae, Lutjanidae, Mullidae, Pomacentridae, Scaridae, Serranidae, Siganidae, and others) is used to validate the habitat attribution of KeFS species groups and to cross-check that KeFS-listed reef families are observable in UVC data.

### 2.3 Economic Parameters (Already Retrieved)

**KES/USD exchange rates (2020-2024) — CONFIRMED:**

| Year | KES per 1 USD (annual avg) | Source |
|------|---------------------------|--------|
| 2020 | 106.45 | World Bank WDI PA.NUS.FCRF (API 2026-03-16) |
| 2021 | 109.64 | World Bank WDI PA.NUS.FCRF (API 2026-03-16) |
| 2022 | 117.87 | World Bank WDI PA.NUS.FCRF (API 2026-03-16) |
| 2023 | 139.85 | World Bank WDI PA.NUS.FCRF (API 2026-03-16) |
| 2024 | 134.82 | World Bank WDI PA.NUS.FCRF (API 2026-03-16) |
| 2025 | Not yet published | Use 2024 as proxy; update when WDI releases |

**GDP deflators (2020-2024) — CONFIRMED:**

| Year | CPI index (2010=100) | Conversion factor to 2024 constant KES |
|------|---------------------|----------------------------------------|
| 2020 | 200.24 | multiply nominal KES by 1.285 |
| 2021 | 212.47 | multiply nominal KES by 1.211 |
| 2022 | 228.75 | multiply nominal KES by 1.124 |
| 2023 | 246.30 | multiply nominal KES by 1.045 |
| 2024 | 257.35 | 1.000 (reference year) |

*Source: World Bank WDI FP.CPI.TOTL / NY.GDP.DEFL.KD.ZG (API retrieval 2026-03-16). Use GDP deflator for SEEA EA real value conversion per UN SNA guidance. See `docs/search_plan_open_access_provisioning.md` Search 2 for full detail.*

**Fuel prices (Mombasa, Super Petrol) — ESTIMATED:**

| Year | Super Petrol KES/litre (est.) | Status |
|------|------------------------------|--------|
| 2020 | ~94 | Estimate — verify via EPRA archive |
| 2021 | ~119 | Estimate — verify via EPRA archive |
| 2022 | ~147 | Estimate — verify via EPRA archive |
| 2023 | ~185 | Estimate — verify via EPRA archive |
| 2024 | ~184 | Estimate — Jan 2024 missing; verify |

*Required only for Tier 2 cost calculation. See `docs/search_plan_open_access_provisioning.md` Search 3 for retrieval procedure.*

---

## 3. Ecosystem Catch Attribution

### 3.1 Purpose

KeFS data covers all marine landings at Kilifi County landing sites. For the SEEA EA account, catch must be attributed to the providing ecosystem: coral reef (M1.3), seagrass, mangrove, or open-water pelagic. Only reef-attributed catch enters the coral reef provisioning service account.

### 3.2 Habitat Classification Table

The following classification has been verified against FishBase and SeaLifeBase (Froese & Pauly 2025; Palomares & Pauly 2025). See `docs/search_plan_open_access_provisioning.md` Search 4 for full verification record.

| KeFS group | Representative species / family | Habitat class | Reef attribution % | Confidence |
|---|---|---|---|---|
| Snapper | Lutjanus bohar, L. fulviflamma (Lutjanidae) | Reef-associated | 90% | HIGH |
| Scavenger | Lethrinus mahsena, L. nebulosus (Lethrinidae) | Reef-associated | 85% | HIGH |
| Parrot fish | Scarus ghobban, Chlorurus sordidus (Scaridae) | Reef-associated | 90% | HIGH |
| Surgeon fish | Acanthurus leucosternon, Ctenochaetus striatus (Acanthuridae) | Reef-associated | 85% | HIGH |
| Unicorn fish | Naso lituratus, N. unicornis (Acanthuridae) | Reef-associated | 85% | HIGH |
| Rabbit fish | Siganus sutor, S. canaliculatus (Siganidae) | Reef-associated | 80% | HIGH |
| Rock cod | Epinephelus spp. (Serranidae / Grouper) | Reef-associated | 90% | HIGH |
| Goat fish | Mulloidichthys vanicolensis, Parupeneus spp. (Mullidae) | Reef-associated | 80% | HIGH |
| Grunter | Plectorhinchus spp. (Haemulidae) | Reef-associated | 80% | HIGH |
| Barracudas | Sphyraena spp. (Sphyraenidae) | Reef-associated | 70% | MEDIUM |
| Milk fish | Chanos chanos (Chanidae) | Reef-associated | 60% | MEDIUM |
| Cavalla jacks | Caranx melampygus, Carangoides spp. | Mixed reef/pelagic | 50% | MEDIUM |
| Lobsters | Panulirus ornatus, P. homarus (Palinuridae) | Reef-associated | 90% | HIGH |
| Beche-de-mer | Holothuria spp. (Holothuriidae) | Reef-associated / sandy bottom | 70% | MEDIUM |
| Octopus | Octopus cyanea (Octopodidae) | Reef-associated | 80% | HIGH |
| Squids | Sepioteuthis lessoniana (Loliginidae) | Reef-associated (spawning) | 50% | MEDIUM |
| Cowries / Shells | Mixed gastropods (Cypraea, Lambis, Conus) | Reef-associated | 70% | MEDIUM |
| Pouter | Pterois spp. or Arothron spp. | Reef-associated | 70% | LOW (confirm species) |
| Black skin | Acanthurus nigrofuscus or Siganus stellatus | Reef-associated | 75% | LOW (confirm species) |
| Mixed demersal | Mixed reef + seagrass demersal | Split | 40% | LOW |
| Cat fish | Arius spp. (Ariidae) | Demersal/estuarine | 0% | HIGH |
| Prawns | Penaeus monodon, Metapenaeus spp. | Demersal/estuarine | 0% | HIGH |
| Crabs | Portunus pelagicus, Scylla serrata | Estuarine/seagrass | 0% | HIGH |
| Oysters | Saccostrea cucullata | Intertidal/mangrove | 0% | HIGH |
| Mullets | Mugil spp. (Mugilidae) | Benthopelagic/estuarine | 0% | HIGH |
| King fish | Scomberomorus spp. (Scombridae) | Pelagic-neritic | 10% | MEDIUM |
| Queen fish / Streaker | Scomberoides spp. (Carangidae) | Pelagic-neritic | 5% | MEDIUM |
| Little mackerels | Rastrelliger spp., Scomber spp. | Pelagic-neritic | 0% | HIGH |
| Cavalla jacks | Pelagic components | Pelagic-neritic | see above | — |
| Bonitos / Tunas | Katsuwonus pelamis, Thunnus spp. | Pelagic-oceanic | 0% | HIGH |
| Sail fish | Istiophorus platypterus | Pelagic-oceanic | 0% | HIGH |
| Dolphins (Mahi-mahi) | Coryphaena hippurus | Pelagic-oceanic | 0% | HIGH |
| Sharks and Rays | Mixed Elasmobranchii | Mixed | 30%* | LOW |
| Sardines | Sardinella spp. (Clupeidae) | Pelagic-neritic | 0% | HIGH |
| Mixed fish / Others | Mixed | Allocate pro rata | 30%* | LOW |

*Requires expert validation before use. Send table to Dr. Pascal Thoya for review.*

Action: share the complete attribution table with Dr. Pascal Thoya for expert validation before finalising any account values.

### 3.3 Unreported and Subsistence Catch Adjustment

KeFS records landings at formal landing sites only. Published studies on Kenyan coastal fisheries suggest unreported and subsistence catch may add 20-40% above formal landings (McClanahan and Mangi 2004; Samoilys et al. 2017). For the physical supply account, add a Tier 1 adjustment:

```
Adjusted catch = KeFS catch × (1 + unreported_fraction)
```

Use unreported_fraction = 0.25 as the central estimate (range 0.20-0.40) and report as sensitivity bound. Flag this adjustment explicitly in all account tables.

---

## 4. Physical Supply Account

### 4.1 Calculation Steps

**Step 1 — Standardise KeFS species names across years**

Minor inconsistencies exist between annual sheets (e.g., "Scavenger" vs "Scarvenger"; "Little mackerels" vs "Littla mackerels"). Before aggregating, apply a standardised name lookup. See `01_inputs/metadata/fisheries_metadata.md` for the known inconsistency list.

**Step 2 — Compute reef-attributed catch per species group and year**

For each year and species group:
```
Reef_catch_kg = KeFS_catch_MT × 1,000 × reef_attribution_pct
```

Sum across all species groups for total reef-attributed annual catch.

**Step 3 — Apply unreported catch adjustment**

```
Adjusted_reef_catch_kg = Reef_catch_kg × 1.25
```

(central estimate; report 1.20 and 1.40 as lower and upper bounds)

**Step 4 — Compile 2020-2024 physical supply time series**

Report annual totals and a 5-year mean. Identify the 2025-2026 projected supply using the trend or the most recent 3-year average as the accounting period baseline.

**Step 5 — Express as per-ha supply (when reef extent is available)**

Once the extent account is complete:
```
Supply_per_ha = Adjusted_reef_catch_kg / reef_area_ha
```

This enables comparison with other reef systems and feeds the per-ha condition-service linkage.

### 4.2 Provisional Physical Supply Estimate

Approximate reef-associated fraction of total KeFS catch (applying the attribution percentages above to the approximate species-group composition of Kilifi landings):

| Component | Estimated fraction of county catch | Basis |
|---|---|---|
| Reef-associated species (high confidence: Snapper, Parrot fish, Rock cod, Surgeon fish, Rabbit fish, Scavenger, Goat fish, Unicorn fish, Grunter, Lobsters, Octopus) | 30-45% | FishBase attribution + local expert knowledge |
| Reef-associated species (partial: Barracuda, Cavalla, Beche-de-mer, Squids) | 5-10% | FishBase |
| Pelagic (no reef attribution) | 25-35% | FishBase |
| Estuarine / seagrass / mangrove | 15-25% | FishBase |

Provisional reef-attributed fraction: 35-55% of total county catch.

Applying to 2024 total: 12,094 MT × 40% central estimate = 4,838 MT reef-attributed catch.

Adjusted for unreported landings (×1.25): approximately 6,047 MT/yr from coral reef.

This is a provisional estimate pending Dr. Thoya's expert validation of the habitat attribution table.

---

## 5. Economic Supply Account

### 5.1 Resource Rent Method

**Resource Rent = Gross Revenue − Total Fishing Costs**

Resource rent is the preferred SEEA EA valuation for provisioning services because it represents the economic value generated by the ecosystem itself, net of the labour, capital, and materials provided by humans.

```
Resource Rent = Gross Revenue × (1 − cost_ratio)
```

where cost_ratio is total fishing costs as a proportion of gross revenue.

### 5.2 Gross Revenue Calculation

**Step 1 — Derive implied average price per species group from KeFS data**

```
Price_group_yr (KES/kg) = (KeFS_value_KES × 1,000) / (KeFS_catch_MT × 1,000)
                        = KeFS_value_KES_000 / KeFS_catch_MT
```

This gives an implied ex-vessel price per species group per year. Apply the same reef attribution fraction used in the physical account.

**Step 2 — Reef-attributed gross revenue**

```
Gross_revenue_KES = sum over groups of (Reef_catch_kg_group × Price_KES_per_kg_group)
```

**Step 3 — Convert to USD**

```
Gross_revenue_USD = Gross_revenue_KES / exchange_rate_KES_per_USD
```

Use annual average exchange rates from Section 2.3.

**Step 4 — Express in constant 2024 prices**

```
Gross_revenue_real = Gross_revenue_nominal_KES × deflator_ratio_to_2024
```

Apply deflator ratios from Section 2.3 before converting to USD, to isolate real (inflation-adjusted) trends.

### 5.3 Tier 1 Cost Estimate (Available Now)

WIO artisanal fisheries cost-to-revenue ratios from published literature:

| Source | Country/Region | Vessel type | Total cost ratio |
|---|---|---|---|
| Munga et al. (2014) WIOJMS 13(1):57-70 | Kenya north coast (Malindi-Kilifi) | Beach seine, trap, handline | 60-70% |
| Mills et al. (2011) Ambio 40(7):747-756 | Kenya (Kilifi, Malindi, Mombasa) | Outrigger canoe, trap/handline | 55-65% |
| Cinner et al. (2009) Mar. Ecol. Prog. Ser. 370:1-10 | Kenya, Tanzania, Mozambique (reef sites) | Trap, handline, gillnet | 50-70% |

Recommended Tier 1 range for Kilifi: **55-70%** (central estimate: 62%).

```
Resource_rent_Tier1 = Gross_revenue × (1 − 0.62)   [central]
Resource_rent_lower = Gross_revenue × (1 − 0.70)   [lower bound]
Resource_rent_upper = Gross_revenue × (1 − 0.55)   [upper bound]
```

Verify Munga et al. (2014) page numbers via WIOJMS (wiomsa.org/wiojms) before citing in publication.

### 5.4 Tier 2 Cost Estimate (Requires Fisher Survey)

A Tier 2 estimate uses Kilifi-specific cost data collected from fisher interviews. Required data items are documented in `docs/data_request_provisioning_service.md` (items 3-9). Key items:

| Cost component | Estimate to collect | Unit |
|---|---|---|
| Labour | Crew size; crew wage or share of landed value | KES/person/day or % of gross value |
| Fuel | Litres/trip × retail price (EPRA Mombasa) | KES/trip |
| Vessel capital | Replacement cost; lifespan | KES; years (straight-line depreciation) |
| Gear capital | Replacement cost; replacement interval | KES; months |
| Maintenance | Total maintenance per vessel per month | KES/vessel/month |
| Ice/handling | Ice cost per trip | KES/trip |

This survey can be appended to existing CCVA, PU-GOAP, or COMRED fieldwork. Target: 30-50 fisher interviews at Kilifi landing sites.

### 5.5 Provisional Monetary Account

Using 2024 KeFS data (most recent full year) as the reference year:

| Component | Value | Notes |
|---|---|---|
| Total KeFS catch (2024) | 12,094 MT | Confirmed in KeFS data |
| Reef-attributed catch (40% central) | 4,838 MT | Provisional; pending Dr. Thoya validation |
| Adjusted catch with unreported (×1.25) | 6,047 MT | Tier 1 adjustment |
| Total KeFS landed value (2024) | KES 3,100 million | KeFS data |
| Reef-attributed landed value (40%) | KES 1,240 million | Provisional |
| Reef-attributed landed value in USD | USD 9.2 million | At 2024 rate: 134.82 KES/USD |
| Resource rent at 62% cost ratio | USD 3.5 million/yr | Tier 1 central estimate |
| Resource rent lower bound (70% cost ratio) | USD 2.8 million/yr | |
| Resource rent upper bound (55% cost ratio) | USD 4.1 million/yr | |

Note: these provisional values depend heavily on the reef attribution fraction (40% assumed). If Dr. Thoya validates a lower fraction (e.g., 30%), all monetary values scale accordingly.

---

## 6. SEEA EA Account Tables

### 6.1 Physical Supply Table (template — populate with calculated values)

| Ecosystem asset | Accounting period | Indicator | Unit | Value | Confidence | Notes |
|---|---|---|---|---|---|---|
| Photic Coral Reef M1.3, Kilifi County | Opening (Nov 2024 reference) | Reef-attributed annual catch | MT/yr | TBC | MEDIUM | Based on 2022-2024 mean; reef attribution fraction pending validation |
| Photic Coral Reef M1.3, Kilifi County | Opening | Adjusted catch (incl. unreported) | MT/yr | TBC | LOW-MEDIUM | Unreported fraction = 25% (20-40% range) |
| Photic Coral Reef M1.3, Kilifi County | Opening | Reef-attributed catch per ha | kg/ha/yr | TBC | LOW | Requires extent account |

### 6.2 Monetary Supply Table (template)

| Ecosystem asset | Accounting period | Indicator | Unit | Value (nominal KES) | Value (const 2024 KES) | Value (USD 2024) | Confidence |
|---|---|---|---|---|---|---|---|
| Photic Coral Reef M1.3, Kilifi County | 2020 | Gross reef-attributed revenue | '000 KES/yr | TBC | TBC (×1.285) | TBC | MEDIUM |
| Photic Coral Reef M1.3, Kilifi County | 2021 | Gross reef-attributed revenue | '000 KES/yr | TBC | TBC (×1.211) | TBC | MEDIUM |
| Photic Coral Reef M1.3, Kilifi County | 2022 | Gross reef-attributed revenue | '000 KES/yr | TBC | TBC (×1.124) | TBC | MEDIUM |
| Photic Coral Reef M1.3, Kilifi County | 2023 | Gross reef-attributed revenue | '000 KES/yr | TBC (est.) | TBC (×1.045) | TBC | LOW |
| Photic Coral Reef M1.3, Kilifi County | 2024 | Gross reef-attributed revenue | '000 KES/yr | TBC | TBC (1.000) | TBC | MEDIUM |
| Photic Coral Reef M1.3, Kilifi County | 2024 | Resource rent (Tier 1) | USD/yr | — | — | TBC | LOW-MEDIUM |

### 6.3 Time Series Chart Structure

Five-year time series (2020-2024) in constant 2024 USD, showing:
- Total county landings value
- Reef-attributed gross revenue
- Resource rent (Tier 1; shaded uncertainty band for 55-70% cost range)

This chart communicates both the trend (172% growth in nominal terms; lower in real terms) and the provisioning service trajectory for the SEEA EA publication.

---

## 7. R Analysis Script

The R script for this analysis should be written to `02_analysis/fisheries_provisioning.R`. Suggested structure:

```r
# 1. Read KeFS data (annual sheets 2020-2024)
# 2. Standardise species group names across years
# 3. Join habitat attribution table (reef_pct by species group)
# 4. Calculate reef-attributed catch and value per year
# 5. Apply unreported catch adjustment (× 1.25 central)
# 6. Convert KES values to constant 2024 KES (GDP deflator)
# 7. Convert constant 2024 KES to USD (annual exchange rates)
# 8. Calculate resource rent (Tier 1): revenue × (1 - cost_ratio)
# 9. Sensitivity analysis: cost ratio 55% / 62% / 70%
# 10. Export: fisheries_supply_physical.csv, fisheries_supply_monetary.csv
```

Output files:
- `03_outputs/fisheries_supply_physical.csv` — annual reef-attributed catch (MT, adjusted and unadjusted)
- `03_outputs/fisheries_supply_monetary.csv` — annual gross revenue and resource rent in KES and USD, constant 2024 prices
- `03_outputs/fisheries_attribution_table.csv` — species group × habitat attribution (for audit trail)

---

## 8. Disaggregation by Species Group

High-value reef species groups (indicative, pending attribution validation):

| KeFS group | Reef attribution | Estimated catch share | Approx. KES/kg (derived) | Account priority |
|---|---|---|---|---|
| Snapper (Lutjanidae) | 90% | 8-12% | high | HIGH |
| Scavenger (Lethrinidae) | 85% | 10-15% | high | HIGH |
| Rock cod / Grouper (Serranidae) | 90% | 5-8% | high | HIGH |
| Parrot fish (Scaridae) | 90% | 8-12% | moderate | HIGH |
| Rabbit fish (Siganidae) | 80% | 10-15% | moderate | HIGH |
| Surgeon fish (Acanthuridae) | 85% | 8-12% | low-moderate | MEDIUM |
| Goat fish (Mullidae) | 80% | 3-5% | moderate | MEDIUM |
| Lobsters | 90% | 1-2% | high | MEDIUM |
| Octopus | 80% | 1-2% | moderate | MEDIUM |

These groups collectively account for the majority of reef-attributed value. Validate proportions using implied prices from KeFS (Value / Catch) after name standardisation.

---

## 9. Data Gaps and Open Items

| Item | Status | Priority | Action |
|---|---|---|---|
| Ecosystem attribution validation | Provisional table complete; expert review pending | HIGH | Send to Dr. Pascal Thoya for validation |
| Gear-type disaggregation | Not available in published KeFS bulletins | HIGH | Request raw CAS worksheets from KeFS Kilifi office via Dr. Thoya; OR use 2022 bulletin which may include gear-type data |
| Fisher cost structure (Tier 2) | Published WIO literature available for Tier 1; local data not collected | MEDIUM | Append structured cost questionnaire to existing fieldwork (30-50 fishers) |
| Unreported catch fraction | 25% Tier 1 estimate from literature; no Kilifi-specific study | MEDIUM | Use ±20-40% range; update when local study available |
| 2025 KeFS Bulletin | Not yet published | LOW | Check kefs.go.ke in late 2026 |
| 2025 KES/USD exchange rate | Not yet published in WDI | LOW | Use 2024 proxy (134.82 KES/USD) until WDI updates |
| Reef extent (ha) | Extent account in progress | HIGH | Required for per-ha supply calculation; feed from extent account when complete |
| EPRA fuel price verification | Annual estimates available; monthly PDFs not yet retrieved | LOW | Required only for Tier 2 fuel cost component; see `docs/search_plan_open_access_provisioning.md` Search 3 |
| COMRED Jul 2025 invertebrate data | Sheet present but empty in COMRED fish file | MEDIUM | Request from COMRED; invertebrates (Lobsters, Octopus, Beche-de-mer) contribute to reef-attributed catch |

---

## 10. Integration With Other Accounts

### 10.1 Links to Condition Account

The coral reef UVC fish data (`KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx`) provides species-level confirmation that the KeFS species groups are present in Kilifi reef habitats. Cross-check: do all high-attribution KeFS groups (Snapper, Scavenger, Parrot fish, etc.) appear in the UVC species list? If a KeFS-listed group is absent from UVC surveys, investigate whether it is a rare/seasonal species or a misidentification.

Fish biomass from the condition account (kg/ha) provides a biophysical cross-check on provisioning service supply. If the KeFS-derived provisioning estimate (kg/ha/yr) exceeds a plausible harvest rate applied to the condition account biomass, flag the discrepancy as a data quality issue.

### 10.2 Links to Seagrass and Mangrove Accounts

Several KeFS species groups with non-reef habitat associations (Prawns, Crabs, Oysters, Mullets, Cat fish) should be attributed to the seagrass (M2.2) or mangrove (M2.1) providing ecosystem accounts rather than the coral reef account. These are excluded from the M1.3 reef account but should appear in the appropriate ecosystem account when those accounts are developed.

### 10.3 Avoiding Double-Counting with Nursery Service

The fisheries nursery service (regulating) and the wild fish provisioning service (provisioning) are related but distinct:
- Nursery service measures the reef's capacity to enhance juvenile biomass and recruitment (the process)
- Provisioning service measures actual catch extracted by humans (the outcome)

Both reference reef fish biomass but measure different things. In the SEEA EA tables, present them as two separate lines in the service account with a note explaining the relationship. Do not sum them to produce a total service value without accounting for partial overlap in underlying ecosystem function.

---

## 11. Contacts

| Dataset or action | Contact |
|---|---|
| Ecosystem attribution validation; fleet and effort data | Dr. Pascal Thoya, Pwani University (pascalthoya at gmail.com) |
| Raw CAS gear-disaggregated worksheets | Kenya Fisheries Service, Kilifi County Fisheries Officer |
| Fisher cost survey administration | CCVA / PU-GOAP / COMRED field teams (append questionnaire to existing fieldwork) |
| COMRED Jul 2025 invertebrate data (submission outstanding) | COMRED Oceans |
| KeFS 2025 Bulletin (when released) | kefs.go.ke/statistical-bulletins |

---

## 12. References

Cinner, J.E., et al. (2009). Socioeconomics and fishing pressure on coral reefs in the WIO. Marine Ecology Progress Series, 370, 1-10.

Froese, R. & Pauly, D. (Eds.) (2025). FishBase. https://www.fishbase.org

Kenya Fisheries Service (KeFS). Annual Fisheries Statistics Bulletins (2020-2024). Marine Fish Landings by Species, Catch and Value for Kilifi County, Kenya. Compiled dataset by Pascal Thoya, Pwani University.

McClanahan, T.R. & Mangi, S. (2004). Gear-based management of a tropical artisanal fishery based on species selectivity and capture size. Fisheries Management and Ecology, 11(1), 51-60.

Mills, D.J., et al. (2011). The nature of the poverty-environment relationship at the coast: Kenya. Ambio, 40(7), 747-756.

Munga, C.N., et al. (2014). Artisanal fisheries in the north coast of Kenya: cost structures and profitability. Western Indian Ocean Journal of Marine Science, 13(1), 57-70. [Verify page numbers via WIOJMS at wiomsa.org/wiojms before citing]

Palomares, M.L.D. & Pauly, D. (Eds.) (2025). SeaLifeBase. https://www.sealifebase.ca

Samoilys, M.A., et al. (2017). Coral reef fisheries in Kenya: a review. Marine Policy, 77, 64-74.

UN SEEA EA. (2021). System of Environmental-Economic Accounting — Ecosystem Accounting. https://seea.un.org/

World Bank. (2025). World Development Indicators. PA.NUS.FCRF (exchange rates); FP.CPI.TOTL (CPI); NY.GDP.DEFL.KD.ZG (GDP deflator). https://data.worldbank.org

Westlund, L., Holvoet, K. & Kebe, M. (2008). Towards Integrated Assessment in Small-Scale Fisheries. FAO Fisheries Circular No. 1016. FAO, Rome.

---

*Created: 2026-03-16*
*Status: READY FOR TIER 1 CALCULATION — attribution table requires Dr. Thoya validation before finalising values*
*Related documents: `docs/data_request_provisioning_service.md` | `docs/search_plan_open_access_provisioning.md` | `01_inputs/metadata/fisheries_metadata.md`*
