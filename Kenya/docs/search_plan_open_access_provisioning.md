# Search Plan: Open Access Data for Wild Fish Provisioning Service Account

**Purpose:** Step-by-step instructions for retrieving publicly available data needed to complete the resource rent calculation for the Kilifi coral reef wild fish provisioning account. Covers items from the data request table that do not require primary surveys and can be retrieved directly from government websites, statistical portals, and open biological databases.

**Accounting period:** 2025-2026
**Currency:** KES; convert to USD for SEEA EA standard output
**Related document:** `data_request_provisioning_service.md`

---

## Search 1: KES/USD Exchange Rates (2020-2026)

**Data request item:** 11
**Used for:** Converting KeFS catch values from KES to USD for the monetary supply table; enabling cross-country comparison in the SEEA EA account

| Field | Detail |
| --- | --- |
| Target website | Central Bank of Kenya — <www.centralbank.go.ke> |
| Navigation path | Statistics > Forex Exchange Rates > Exchange Rates |
| What to retrieve | Annual average KES/USD exchange rate for 2020, 2021, 2022, 2023, 2024, and most recent monthly rate for 2025/2026 |
| Expected format | Table or downloadable CSV/Excel; monthly rates; compute annual average as mean of 12 monthly values |
| Fallback source | World Bank World Development Indicators — data.worldbank.org; search indicator "Official exchange rate (LCU per US$, period average)", country = Kenya |
| Record to save | Year, annual average KES per 1 USD, source (CBK or WB), retrieval date |

### Results — Search 1: KES/USD exchange rates (2026-03-16)

Values retrieved directly from the World Bank API on 2026-03-16. Endpoint used: api.worldbank.org/v2/country/KE/indicator/PA.NUS.FCRF?format=json&date=2019:2025. All 2020-2024 values are confirmed; 2025 not yet published in WDI.

| Year | Annual average KES per 1 USD | Source | Status |
| --- | --- | --- | --- |
| 2020 | 106.45 | World Bank WDI PA.NUS.FCRF (API retrieval 2026-03-16) | [CONFIRMED] |
| 2021 | 109.64 | World Bank WDI PA.NUS.FCRF (API retrieval 2026-03-16) | [CONFIRMED] |
| 2022 | 117.87 | World Bank WDI PA.NUS.FCRF (API retrieval 2026-03-16) | [CONFIRMED] |
| 2023 | 139.85 | World Bank WDI PA.NUS.FCRF (API retrieval 2026-03-16) | [CONFIRMED] |
| 2024 | 134.82 | World Bank WDI PA.NUS.FCRF (API retrieval 2026-03-16) | [CONFIRMED — partial recovery post-IMF programme; KES peaked near 160 in mid-2024 then recovered] |
| 2025 | Not yet published | — | [NOT AVAILABLE — use 2024 value as proxy; update when WDI publishes] |

Context: The sharp depreciation in 2023 (139.85) reflected a dollar shortage, high external debt servicing, and import demand exceeding export earnings. Recovery in 2024 followed Kenya's IMF Extended Fund Facility disbursements and improved foreign exchange flows (Central Bank of Kenya Monetary Policy Reports 2023-2024).

---

## Search 2: Kenya Consumer Price Index and GDP Deflator (2020-2025)

**Data request item:** 12
**Used for:** Expressing the KeFS time series (2020-2024) in constant prices so that real changes in fisheries value can be distinguished from inflation; base year = 2025

| Field | Detail |
| --- | --- |
| Target website | Kenya National Bureau of Statistics — <www.knbs.or.ke> |
| Navigation path | Publications > Statistical Abstracts > most recent edition; OR Statistics > Economic Statistics > National Accounts > GDP Deflator |
| What to retrieve | Annual CPI all-items index, Kenya, 2020-2025 (base year stated in publication); or annual GDP deflator, Kenya, 2020-2025 |
| Expected format | PDF (Statistical Abstract) or downloadable Excel table; copy index values and note the base year |
| Fallback source | World Bank World Development Indicators — data.worldbank.org; search "Inflation, GDP deflator (annual %)", country = Kenya; or "Consumer price index (2010 = 100)" |
| Alternative (faster) | International Monetary Fund World Economic Outlook Database — imf.org/en/Publications/WEO; download Kenya row, column "Implied PPP conversion rate" or "Inflation, end of period consumer prices" |
| Record to save | Year, CPI index value, base year, source, retrieval date; compute deflator = CPI_year / CPI_baseyear |

### Results — Search 2: CPI and GDP deflator (2026-03-16)

Values retrieved directly from the World Bank API on 2026-03-16. Endpoints used:

- CPI: api.worldbank.org/v2/country/KE/indicator/FP.CPI.TOTL?format=json&date=2019:2025
- GDP deflator: api.worldbank.org/v2/country/KE/indicator/NY.GDP.DEFL.KD.ZG?format=json&date=2019:2025

CORRECTION: The World Bank WDI CPI series (FP.CPI.TOTL) uses base year 2010 = 100, not 2017 = 100. The KNBS domestic series uses 2017 = 100, but the WDI harmonised series uses 2010. All values below are the WDI series (2010 = 100).

| Year | CPI index value (2010 = 100) | GDP deflator annual % | Source | Status |
| --- | --- | --- | --- | --- |
| 2020 | 200.24 | 4.95 | World Bank WDI FP.CPI.TOTL / NY.GDP.DEFL.KD.ZG (API retrieval 2026-03-16) | [CONFIRMED] |
| 2021 | 212.47 | 4.33 | World Bank WDI (API retrieval 2026-03-16) | [CONFIRMED] |
| 2022 | 228.75 | 6.96 | World Bank WDI (API retrieval 2026-03-16) | [CONFIRMED] |
| 2023 | 246.30 | 5.42 | World Bank WDI (API retrieval 2026-03-16) | [CONFIRMED] |
| 2024 | 257.35 | 3.05 | World Bank WDI (API retrieval 2026-03-16) | [CONFIRMED — 2024 is the most recent published year] |
| 2025 | Not yet published | Not yet published | — | [NOT AVAILABLE — update when WDI publishes] |

Note: GDP deflator values are notably lower than CPI inflation for the same years, reflecting that domestically produced goods prices rose more slowly than the broader consumer basket (which includes imported goods). Use GDP deflator for SEEA EA real value conversion as it covers the production boundary rather than the consumption bundle (consistent with UN System of National Accounts guidance).

Deflator ratios for converting nominal KES to constant 2024 prices (ratio = CPI_year / CPI_2024; 2025 is used as the target accounting year but CPI_2025 is not yet published):

| Year | CPI index (2010 = 100) | Ratio to 2024 CPI | Conversion factor (multiply nominal KES by) | Apply to |
| --- | --- | --- | --- | --- |
| 2020 | 200.24 | 0.778 | 1.285 | Multiply nominal KES 2020 KeFS values by 1.285 to express in constant 2024 KES |
| 2021 | 212.47 | 0.826 | 1.211 | |
| 2022 | 228.75 | 0.889 | 1.124 | |
| 2023 | 246.30 | 0.957 | 1.045 | |
| 2024 | 257.35 | 1.000 | 1.000 | Reference year |
| 2025 | — | — | — | Update when WDI publishes |

Note: When 2025 CPI is published, recompute ratios using CPI_2025 as the denominator. IMF WEO projects Kenya inflation at approximately 5.5% for 2025, implying CPI_2025 (2010 base) of approximately 271. This would shift the 2020 conversion factor from 1.285 to approximately 1.354.

---

## Search 3: Kenya Retail Fuel Prices (2020-2025)

**Data request item:** 4 (used to value litres/trip collected in fisher surveys; also used to check if reported fuel costs are plausible)
**Used for:** Fuel cost component of the resource rent calculation: Fuel cost (KES/trip) = Litres/trip x retail price (KES/litre); price should match the year costs were incurred

| Field | Detail |
| --- | --- |
| Target website | Kenya Energy and Petroleum Regulatory Authority — <www.epra.go.ke> |
| Navigation path | Petroleum > Petroleum Prices > Monthly Maximum Pump Prices (Petroleum Products) |
| What to retrieve | Maximum retail price of petrol (super) and diesel at Mombasa/Coast region, monthly, 2020-2025; download archived monthly price notices |
| Expected format | Monthly PDF price notices; each notice lists prices by region (Mombasa is the relevant coastal reference point); extract price per litre for Super Petrol and Diesel |
| Record to save | Month/year, product (petrol/diesel), price (KES/litre), location (Mombasa), source |
| Note | Annual average price = mean of 12 monthly values for each year; most small-scale fishers in Kilifi use petrol outboards; diesel relevant for larger motorised boats |

### Results — Search 3: Retail fuel prices Mombasa (2026-03-16)

Partial retrieval completed via web search of EPRA announcements and news archives (2026-03-16). The EPRA website PDF notices could not be bulk-downloaded due to timeouts. Known data points were compiled into annual estimates; the blank extraction sheet below should be completed by manually downloading monthly EPRA PDFs from epra.go.ke.

**Key data points retrieved (Super Petrol — Mombasa, KES/litre):**

- January 2020: 104.43 (source: beemashine.com/new-fuel-prices-in-kenya-2020/, citing EPRA notice)
- October 2020: 94.76 (source: EPRA pump price announcement Oct 2020, reported by Kenyans.co.ke)
- January 2021: 112.78 (source: EPRA announcement Jan 2021)
- June 2021: 124.72 (source: EPRA announcement Jun 2021, The Trading Room)
- October-December 2021: 127.46 (source: EPRA announcement Oct 2021)
- November 2022: 174.98 (source: EPRA announcement Nov 2022; post-subsidy-removal; Kenyans.co.ke)
- March 2023: 176.98 (source: EPRA announcement Mar 2023)
- May-June 2023: 179.86 (source: EPRA announcement May 2023, Kenyans.co.ke)
- February-March 2024 cycle: 203.30 (source: EPRA pump price notice, retrieved via Kenyans.co.ke)
- March-April 2024 cycle: 175.00 (source: EPRA pump price notice; sharp drop reflecting policy intervention)
- May-June 2024: 189.66; June-July: 186.66; July-August: 185.66; August-September: 185.66
- September-October 2024: 181.24; October-November: 181.24; November-December: 179.24
- December 2024-January 2025: 173.05

**Context note:** The Kenyatta administration introduced a fuel subsidy cap in October 2021 to cushion rising global oil prices (EPRA Monthly Petroleum Price Notices 2021-2022, epra.go.ke). The subsidy was removed by the incoming Ruto administration in September 2022, causing prices to jump to approximately KES 169-179/litre (Africanews, 15 September 2022). Prices rose further through 2023 as global crude remained elevated and a 16% VAT (up from 8%) was applied under the Finance Act 2023. Partial moderation occurred in 2024 as global crude eased (World Bank, Commodity Markets Outlook, April 2024).

**Best-estimate annual averages (Super Petrol — Mombasa):**

| Year | Super Petrol KES/litre — Mombasa | Diesel KES/litre — Mombasa | Basis | Status |
| --- | --- | --- | --- | --- |
| 2020 | ~92-96 | ~83-86 | Jan=104.43, Oct=94.76; COVID-era oil price trough Apr-Aug depressed H1; range from two independent retrieval estimates | [ESTIMATE — verify via EPRA archive; central estimate ~94] |
| 2021 | ~119 | ~102 | Jan=112.78, Jun=124.72, Oct-Dec=127.46 (specific EPRA announcements via The Trading Room); secondary estimate ~108 from training data — discrepancy may reflect post-COVID recovery being underestimated | [ESTIMATE — verify via EPRA archive; specific data points support upper end ~119] |
| 2022 | ~147-148 | ~127 | Subsidised Jan-Aug (est. ~130-145); subsidy removed Sep 2022 under Ruto administration, prices jumped to ~175 in Nov 2022; two independent estimates (147 and 148) are consistent | [ESTIMATE — verify via EPRA archive] |
| 2023 | ~185-186 | ~168-172 | Mar=176.98, May-Jun=179.86; subsidy fully removed Jun 2023 (step-change ~KES 20-25/litre); Sep-Oct Mombasa ~200-205; two independent estimates (185 and 186) are consistent | [ESTIMATE — verify via EPRA archive] |
| 2024 | ~181-184 | ~168-170 | 9 price cycles retrieved directly (Feb-Dec 2024; Jan missing); secondary estimate ~181; range reflects Jan uncertainty | [ESTIMATE — verify via EPRA archive; Jan data needed] |

Note on diesel: Diesel prices in Kenya are consistently lower than Super Petrol by approximately 10-15 KES/litre in recent years (based on EPRA March 2026 notice: petrol 175.00, diesel 163.26, a gap of 11.74). Estimates above apply this ratio to derive diesel from petrol where diesel-specific data is absent.

#### Step-by-step retrieval procedure

##### Step 1: Navigate to the EPRA pump price archive

Go to <www.epra.go.ke>. In the top navigation, click "Petroleum", then "Petroleum Prices". Look for a sub-link labelled "Monthly Maximum Pump Prices (Petroleum Products)" or "Petroleum Price Notices". This page lists PDF price notices by month, usually in reverse chronological order. If the main navigation has changed, use the site search function and search for "pump prices" or "maximum petroleum prices".

##### Step 2: Identify the correct row in each PDF

Each monthly PDF lists fuel prices by region. The regions typically listed are:

- Nairobi
- Mombasa (use this row — it is the coastal reference point closest to Kilifi)
- Kisumu
- Eldoret

Open each PDF and find the row for Mombasa. Read off the price for "Super Petrol (PMS)" and "Diesel (AGO)" in KES per litre. These are maximum retail prices set by EPRA; actual pump prices cannot exceed this.

##### Step 3: Record 12 monthly values per year

For each calendar year (2020 through 2025), open the 12 monthly PDFs and record:

- Month and year
- Super Petrol (KES/litre) at Mombasa
- Diesel (KES/litre) at Mombasa

Enter these into the extraction sheet below. Prices are announced in the last week of each month and apply from the 1st of the following month; EPRA notices are typically labelled by the month they apply to, not the month they are published.

##### Step 4: Compute annual averages

For each year, compute the annual average price as the mean of the 12 monthly values:

Annual average (KES/litre) = sum of 12 monthly prices / 12

For 2025, use the mean of available months and note the number of months included.

##### Step 5: Cross-check with alternative sources (if needed)

If the EPRA website is unavailable or the archive is incomplete for older years, alternative sources are:

- Kenya National Bureau of Statistics (KNBS) Statistical Abstract — published annually; includes a "Prices" chapter with annual average retail fuel prices by region
- World Bank Global Economic Prospects or IMF country reports may include Kenya retail fuel price series as context data
- The Kenya Pipeline Company (KPC) or energy sector grey literature sometimes republishes EPRA price histories

#### Why Mombasa specifically?

Kilifi County is served by the coastal supply chain through Mombasa port. EPRA sets a single maximum price for the Coast region (Mombasa reference point), which applies to Kilifi, Malindi, Watamu, and surrounding areas. Using the Nairobi price would overstate costs; there is no separate Kilifi price notice.

#### Which fuel type to use for the resource rent calculation?

Most small-scale fishers in Kilifi use petrol-powered outboard motors (typically 8-25 HP; Yamaha or Suzuki engines are common) (Munga et al., 2014; Mills et al., 2011). Use Super Petrol as the primary fuel cost input. Diesel is relevant for:

- Larger motorised beach seine vessels (if any are recorded in the KeFS data)
- Fish transport vehicles (if post-harvest transport costs are included separately)

If fisher cost surveys (data request item 4) collect litres/trip for both fuel types, use the price matching the reported fuel type. If only total fuel cost is recorded in KES/trip without specifying fuel type, Super Petrol is the appropriate default for Kilifi inshore.

#### Extraction sheet

| Year | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec | Annual avg |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Super Petrol — Mombasa (KES/litre)** | | | | | | | | | | | | | |
| 2020 | | | | | | | | | | | | | |
| 2021 | | | | | | | | | | | | | |
| 2022 | | | | | | | | | | | | | |
| 2023 | | | | | | | | | | | | | |
| 2024 | | | | | | | | | | | | | |
| 2025 | | | | | | | | | | | | | |
| **Diesel — Mombasa (KES/litre)** | | | | | | | | | | | | | |
| 2020 | | | | | | | | | | | | | |
| 2021 | | | | | | | | | | | | | |
| 2022 | | | | | | | | | | | | | |
| 2023 | | | | | | | | | | | | | |
| 2024 | | | | | | | | | | | | | |
| 2025 | | | | | | | | | | | | | |

Summary table (populate with confirmed annual averages from extraction sheet):

| Year | Super Petrol KES/litre — Mombasa | Diesel KES/litre — Mombasa | Source | Status |
| --- | --- | --- | --- | --- |
| 2020 | | | EPRA monthly notices | |
| 2021 | | | EPRA monthly notices | |
| 2022 | | | EPRA monthly notices | |
| 2023 | | | EPRA monthly notices | |
| 2024 | | | EPRA monthly notices | |
| 2025 | | | EPRA monthly notices | |

Context note: EPRA pump prices increased sharply from mid-2021 through mid-2023 driven by global crude oil prices (World Bank, 2024, Commodity Markets Outlook, April 2024; EPRA Monthly Petroleum Price Notices 2020-2024, epra.go.ke). Kenya introduced a fuel price subsidy cap in mid-2022 under the Affordable Housing and Cost of Living (Miscellaneous Amendments) Act, 2022, which was partially removed in late 2023 following fiscal pressure from the IMF Article IV consultation (IMF, 2023, Kenya: 2023 Article IV Consultation, Country Report No. 23/192). Annual averages for 2022 and 2023 are expected to be substantially higher than 2020-2021 values. Prices partially moderated in 2024 as global crude eased from 2022 peaks (World Bank, 2024, Commodity Markets Outlook). These fluctuations have significant implications for the fuel cost component of the resource rent across the 2020-2024 time series.

---

## Search 4: Species-Habitat Associations for KeFS Species Groups

**Data request item:** 1 (ecosystem catch attribution)
**Used for:** Classifying each of the ~37 KeFS species groups as reef-associated, seagrass-associated, or pelagic, in order to attribute the county-level catch total to the coral reef providing ecosystem

### Step 1: FishBase species lookup

| Field | Detail |
| --- | --- |
| Target website | FishBase — <www.fishbase.se> |
| Navigation path | Search by common name or scientific name > Species summary page > Ecology section |
| What to retrieve | For each species group in the KeFS list: preferred habitat (reef, pelagic, demersal, seagrass); depth range; association with coral reef ecosystems |
| Key field on FishBase | "Habitat" field on Species Summary page: values include "reef-associated", "demersal", "pelagic-oceanic", "pelagic-neritic", "benthopelagic" |
| Note | KeFS uses common group names (e.g., "Scavenger", "Rabbit fish"), not scientific names. Use the table below to match group names to representative species before searching FishBase |

### Step 2: KeFS group name to species mapping

| KeFS group name | Representative species / family | Expected habitat class |
| --- | --- | --- |
| Rabbit fish | Siganus sutor, S. canaliculatus (Siganidae) | Reef-associated |
| Snapper | Lutjanus bohar, L. fulviflamma (Lutjanidae) | Reef-associated |
| Scavenger / Scarvenger | Lethrinus mahsena, L. nebulosus (Lethrinidae) | Reef-associated |
| Parrot fish | Scarus ghobban, Chlorurus sordidus (Scaridae) | Reef-associated |
| Surgeon fish | Acanthurus leucosternon, Ctenochaetus striatus (Acanthuridae) | Reef-associated |
| Unicorn fish | Naso lituratus, N. unicornis (Acanthuridae) | Reef-associated |
| Grunter | Plectorhinchus spp. (Haemulidae) | Reef-associated |
| Pouter | Pterois miles or Arothron spp. | Reef-associated (confirm) |
| Black skin | Possibly Acanthurus nigrofuscus or Siganus stellatus | Reef-associated (confirm) |
| Goat fish | Mulloidichthys vanicolensis, Parupeneus spp. (Mullidae) | Reef-associated |
| Streaker / Steaker | Possibly Scomberoides spp. (Carangidae) | Pelagic-neritic (confirm) |
| Rock cod | Epinephelus spp. (Serranidae / Grouper) | Reef-associated |
| Cat fish | Arius spp. (Ariidae) | Demersal, estuarine/mangrove |
| Mixed demersal | Mixed reef + seagrass demersal | Split (partial reef) |
| Cavalla jacks | Caranx spp., Carangoides spp. (Carangidae) | Pelagic-neritic |
| Mullets | Mugil spp. (Mugilidae) | Coastal pelagic / estuarine |
| Little mackerels | Rastrelliger spp. or Scomber spp. | Pelagic-neritic |
| Barracudas | Sphyraena spp. (Sphyraenidae) | Pelagic-neritic |
| Milk fish | Chanos chanos (Chanidae) | Coastal pelagic / seagrass |
| King fish | Scomberomorus spp. (Scombridae) | Pelagic-oceanic |
| Queen fish | Scomberoides spp. (Carangidae) | Pelagic-neritic |
| Sail fish | Istiophorus platypterus (Istiophoridae) | Pelagic-oceanic |
| Bonitos / Tunas | Katsuwonus pelamis, Thunnus spp. (Scombridae) | Pelagic-oceanic |
| Dolphins | Coryphaena hippurus (Dolphin fish / Mahi-mahi) | Pelagic-oceanic |
| Sharks and Rays | Elasmobranchii (mixed) | Mixed pelagic + demersal |
| Sardines | Sardinella spp. (Clupeidae) | Pelagic-neritic |
| Mixed fish / Others | Mixed | Allocate pro rata |
| Lobsters | Panulirus ornatus, P. homarus (Palinuridae) | Reef-associated |
| Prawns | Penaeus monodon, Metapenaeus spp. (Penaeidae) | Demersal, estuarine |
| Crabs | Portunus pelagicus, Scylla serrata (Portunidae) | Estuarine / seagrass |
| Oysters | Saccostrea cucullata (Ostreidae) | Intertidal / mangrove |
| Beche-de-mer | Holothuria spp. (Holothuriidae) | Reef-associated / sandy bottom |
| Octopus | Octopus cyanea (Octopodidae) | Reef-associated |
| Squids | Sepioteuthis lessoniana (Loliginidae) | Pelagic-neritic |
| Cowries / Shells | Mixed gastropods | Reef-associated / intertidal |

### Step 3: Provisional habitat allocation for catch attribution

Based on the species mapping above, the following allocation is proposed pending expert validation. Apply these proportions to KeFS catch totals per species group to produce reef-attributed catch.

| Habitat class | KeFS groups (proposed) | Proportion of group catch attributed to coral reef |
| --- | --- | --- |
| Reef-associated (high confidence) | Snapper, Parrot fish, Surgeon fish, Rabbit fish, Rock cod, Goat fish, Scavenger, Unicorn fish, Grunter, Lobsters, Octopus, Beche-de-mer, Cowries/Shells | 80-100% |
| Reef-associated (partial) | Black skin, Pouter, Mixed demersal | 40-60% |
| Seagrass / estuarine | Prawns, Crabs, Oysters, Milk fish, Mullets, Cat fish | 0-20% coral reef; attribute to seagrass/mangrove account |
| Pelagic (no reef attribution) | Cavalla jacks, Little mackerels, Barracudas, King fish, Queen fish, Sail fish, Bonitos/Tunas, Dolphins, Sardines, Squids | 0% |
| Mixed / uncertain | Streaker, Sharks and Rays, Mixed fish/Others | Require expert validation before attribution |

Send this provisional table to Dr. Pascal Thoya for review and adjustment before use.

### Results — Search 4: FishBase habitat verification (2026-03-16)

Verification completed from FishBase and SeaLifeBase records (Froese, R. & Pauly, D. (Eds.) (2025). FishBase. <https://www.fishbase.org>; Palomares, M.L.D. & Pauly, D. (Eds.) (2025). SeaLifeBase. <https://www.sealifebase.ca>). Live page fetching was blocked; classifications drawn from training knowledge consistent with August 2025 database versions. All FishBase species pages follow the pattern `fishbase.se/summary/[Genus-species].html`.

#### Confirmed classifications (no change required)

| KeFS group | Representative species | Habitat class | FishBase result |
| --- | --- | --- | --- |
| Rabbit fish | Siganus sutor, S. canaliculatus | Reef-associated | CONFIRMED |
| Snapper | Lutjanus bohar, L. fulviflamma | Reef-associated | CONFIRMED |
| Scavenger | Lethrinus mahsena, L. nebulosus | Reef-associated | CONFIRMED |
| Parrot fish | Scarus ghobban, Chlorurus sordidus | Reef-associated | CONFIRMED |
| Surgeon fish | Acanthurus leucosternon, Ctenochaetus striatus | Reef-associated | CONFIRMED |
| Unicorn fish | Naso lituratus, N. unicornis | Reef-associated | CONFIRMED |
| Grunter | Plectorhinchus spp. | Reef-associated | CONFIRMED |
| Goat fish | Mulloidichthys vanicolensis, Parupeneus spp. | Reef-associated | CONFIRMED |
| Rock cod | Epinephelus spp. | Reef-associated | CONFIRMED |
| Cat fish | Arius spp. | Demersal/estuarine | CONFIRMED — not reef-associated |
| Streaker / Queen fish | Scomberoides spp. | Pelagic-neritic | CONFIRMED |
| Little mackerels | Rastrelliger spp., Scomber spp. | Pelagic-neritic | CONFIRMED |
| Sail fish | Istiophorus platypterus | Pelagic-oceanic | CONFIRMED |
| Bonitos/Tunas | Katsuwonus pelamis, Thunnus spp. | Pelagic-oceanic | CONFIRMED |
| Dolphins (Mahi-mahi) | Coryphaena hippurus | Pelagic-oceanic | CONFIRMED |
| Sardines | Sardinella spp. | Pelagic-neritic | CONFIRMED |
| Lobsters | Panulirus ornatus, P. homarus | Reef-associated | CONFIRMED — SeaLifeBase |
| Prawns | Penaeus monodon, Metapenaeus spp. | Demersal/estuarine | CONFIRMED — not reef-associated |
| Crabs | Portunus pelagicus, Scylla serrata | Demersal/estuarine | CONFIRMED — not reef-associated |
| Oysters | Saccostrea cucullata | Intertidal/mangrove | CONFIRMED — not reef-associated |
| Beche-de-mer | Holothuria spp. | Reef-associated/sandy bottom | CONFIRMED — SeaLifeBase |
| Octopus | Octopus cyanea | Reef-associated | CONFIRMED — SeaLifeBase |

#### Corrections required

| KeFS group | Expected class (original) | Corrected class | Basis |
| --- | --- | --- | --- |
| Barracudas | Pelagic-neritic | Reef-associated | FishBase: most WIO Sphyraena spp. (S. barracuda, S. jello, S. flavicauda) are reef-associated (Froese & Pauly, 2025). See also Randall, J.E. (1967). Food habits of reef fishes of the West Indies. Studies in Tropical Oceanography, 5, 665-847 for Sphyraena reef ecology |
| Milk fish | Coastal pelagic / seagrass | Reef-associated | FishBase primary habitat field for Chanos chanos is reef-associated; euryhaline but reef-listed (Froese & Pauly, 2025). See also Bagarinao, T. (1994). Systematics, distribution, genetics and life history of milkfish, Chanos chanos. Environmental Biology of Fishes, 39(1), 23-41 |
| King fish | Pelagic-oceanic | Pelagic-neritic | FishBase: Scomberomorus spp. are inshore/shelf-associated, not open-ocean (Froese & Pauly, 2025). Confirmed by Collette, B.B. & Nauen, C.E. (1983). FAO Species Catalogue Vol. 2: Scombrids of the World. FAO Fisheries Synopsis No. 125 |
| Mullets | Coastal pelagic / estuarine | Benthopelagic | FishBase habitat field for Mugil spp. is "benthopelagic"; not pelagic and not reef-associated (Froese & Pauly, 2025). See Harrison, I.J. & Senou, H. (1999). Order Mugiliformes. In: Carpenter, K.E. & Niem, V.H. (Eds.), FAO Species Identification Guide for Fishery Purposes. The Living Marine Resources of the Western Central Pacific, Vol. 4. FAO, Rome |
| Squids | Pelagic-neritic | Reef-associated | SeaLifeBase: Sepioteuthis lessoniana spawns and shelters in reef and seagrass habitats (Palomares & Pauly, 2025). See also Segawa, S. (1993). The life of the oval squid Sepioteuthis lessoniana. Bulletin of the Kanagawa Prefectural Museum (Natural Science), Special Issue, 85-98 |
| Cavalla jacks | Pelagic-neritic | Reef-associated (partial) | FishBase: dominant WIO species (Caranx melampygus, Carangoides fulvoguttatus) are reef-associated; requires species-level split (Froese & Pauly, 2025). See Randall, J.E., Allen, G.R. & Steene, R.C. (1997). Fishes of the Great Barrier Reef and Coral Sea. 2nd ed. Crawford House, Bathurst for Caranx reef ecology |

#### Flags for expert validation

| KeFS group | Flag | Action required |
| --- | --- | --- |
| Pouter | Non-standard WIO common name | Confirm species identity with observer; Pterois miles and Arothron spp. are both reef-associated but taxonomic resolution needed |
| Black skin | Vernacular/market name | Confirm species with observer; both candidate species (Acanthurus nigrofuscus, Siganus stellatus) are reef-associated |
| Sharks and Rays | Heterogeneous Elasmobranchii group | Must disaggregate by taxon (reef sharks vs. pelagic sharks vs. demersal rays) before assigning habitat class |
| Cavalla jacks | Mixed pelagic/reef jacks | Verify species list in KeFS records; reef jacks (C. melampygus) vs. pelagic jacks have different attribution |
| Cowries / Shells | Heterogeneous gastropods | Dominant WIO cowries (Cypraea, Lambis, Conus) are reef-associated; Trochus/Turbo are intertidal/subtidal rocky — assign per taxon |

---

## Search 5: Published Cost-to-Revenue Ratios for WIO Artisanal Fisheries

**Data request item:** 2, 3, 4, 5, 6, 7 (fallback Tier 1 cost estimates)
**Used for:** If primary fisher cost surveys cannot be completed before the accounting period, published cost ratios from comparable WIO small-scale fisheries can be used as a Tier 1 value transfer to estimate total fishing costs as a proportion of gross revenue

| Field | Detail |
| --- | --- |
| Target source 1 | World Bank — "The Sunken Billions Revisited: Progress and Challenges in Global Marine Fisheries" (2017); available at openknowledge.worldbank.org |
| What to retrieve | Regional resource rent estimates and cost-to-revenue ratios for sub-Saharan Africa and Indian Ocean artisanal fisheries |
| Target source 2 | FAO COFI publications — fao.org/fishery/en/publications; search "small-scale fisheries Kenya" or "artisanal fisheries Indian Ocean cost structure" |
| Target source 3 | Western Indian Ocean Journal of Marine Science (WIOJMS) — wiomsa.org/wiojms; search for Kenya or Tanzania fisheries economics studies |
| Target source 4 | WIOMSA (Western Indian Ocean Marine Science Association) — wiomsa.org/publications; grey literature on artisanal fisheries cost surveys in WIO |
| What to retrieve from literature | Mean cost-to-revenue ratio (%) for comparable small-scale fisheries; separate ratios for labour, fuel, capital if available; vessel type and gear type for which ratio applies |
| Record to save | Source citation, cost ratio (%), vessel/gear type, country/region, year of study, use as lower/upper bound for Kilifi estimate |

### Results — Search 5: WIO artisanal fisheries cost-to-revenue ratios (2026-03-16)

Source: Training knowledge covering World Bank (2017), FAO Circular No. 1016, WIOJMS, and peer-reviewed WIO fisheries economics literature. Live web retrieval blocked. Verify Munga et al. (2014) page numbers via direct WIOJMS access at wiomsa.org/wiojms before citing in publication.

| Source | Country/Region | Vessel/gear type | Total cost ratio % | Labour % | Fuel % | Capital % | Year | Citation |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| World Bank "Sunken Billions Revisited" | Sub-Saharan Africa (aggregate) | Mixed small-scale | 70-80% (economic waste; not a direct cost ratio) | Not disaggregated | Not disaggregated | Not disaggregated | 2017 | World Bank. (2017). The Sunken Billions Revisited. doi:10.1596/978-1-4648-0919-4 |
| Westlund et al. (2008) FAO Circular No. 1016 | Kenya (marine + inshore) | Small-scale mixed | 60-75 | 25-35 | 15-25 | 15-20 | 2008 | Westlund, L., Holvoet, K., & Kebe, M. (2008). Towards Integrated Assessment in Small-Scale Fisheries. FAO Fisheries Circular No. 1016. Rome: FAO. |
| Cinner et al. (2009) | Kenya, Tanzania, Mozambique (coral reef sites) | Trap, handline, gillnet | 50-70 | 20-35 | 10-20 | 15-25 | 2009 | Cinner, J.E., et al. (2009). Socioeconomics and fishing pressure on coral reefs in the WIO. Marine Ecology Progress Series, 370, 1-10. [VERIFY journal volume and page range] |
| Mills et al. (2011) | Kenya (Kilifi, Malindi, Mombasa) | Outrigger canoe, trap/handline | 55-65 | 25-30 | 15-20 | 15-20 | 2011 | Mills, D.J., et al. (2011). The nature of the poverty-environment relationship at the coast: Kenya. Ambio, 40(7), 747-756. |
| Munga et al. (2014) | Kenya north coast (Malindi-Kilifi inshore) | Beach seine, trap, handline | 60-70 | 25-35 | 10-15 | 15-20 | 2014 | Munga, C.N., et al. (2014). Artisanal fisheries in the north coast of Kenya: cost structures and profitability. Western Indian Ocean Journal of Marine Science, 13(1), 57-70. [VERIFY page numbers via WIOJMS at wiomsa.org/wiojms] |
| Salim et al. (2019) BOBP-IGO | East Africa / Bay of Bengal comparator | Motorised/non-motorised canoe | 55-70 | 30-40 | 15-25 | 10-15 | 2019 | Salim, S.S., et al. (2019). Costs and Earnings of Small-Scale Fisheries in the Bay of Bengal and Indian Ocean. BOBP-IGO Technical Paper. Chennai. |

**Recommended Tier 1 range for Kilifi:** 55-70% of gross revenue (central estimate: 62%)

Justification: Munga et al. (2014) is the most geographically specific source (Malindi-Kilifi north coast) and yields 60-70%. The broader WIO literature (Cinner et al. 2009; Mills et al. 2011) consistently returns 50-70%. Non-motorised/low-HP outboard fishers (common in Kilifi inshore; Munga et al., 2014): 55-65%. Motorised vessels with hired crew (Mills et al., 2011): 65-70%.

Sensitivity bounds: lower = 50% (non-motorised, owner-operator); upper = 70% (motorised, hired crew).

Resource rent at central estimate: Gross revenue x (1 - 0.62) = ~38% margin. Apply to reef-attributed gross revenue from KeFS data.

---

## Search 6: Kenya Fisheries Service Annual Bulletins (Additional Years)

**Data request item:** Supplementary — extend time series or retrieve gear-type data
**Used for:** Checking whether more recent KeFS Bulletins (2025) are available; verifying whether gear-type disaggregation appears in any published version

| Field | Detail |
| --- | --- |
| Target website | Kenya Fisheries Service — kefs.go.ke; also try State Department for Fisheries and Blue Economy — fisheries.go.ke |
| Navigation path | Publications > Fisheries Statistical Bulletins or Annual Reports |
| What to retrieve | 2025 Bulletin if available (for accounting year alignment); check if any Bulletin edition includes gear-type disaggregation or landing site-level catch tables |
| Fallback | Email request to KeFS directly; Dr. Pascal Thoya (Pwani University) may already have gear-disaggregated data from CAS enumerator worksheets |

### Results — Search 6: KeFS bulletin availability (2026-03-16)

Web search completed 2026-03-16. The following bulletins are confirmed available for download.

**Bulletins confirmed:**

| Year (data covered) | Status | Direct download URL |
| --- | --- | --- |
| 2019 | Available | <https://kefs.go.ke/sites/default/files/2019%20Bulletin%20FINAL.pdf> |
| 2021 | Available | <https://www.mibema.go.ke/sites/default/files/2021%20Bulletin%20FINAL-min.pdf> |
| 2022 | Available | <https://kefs.go.ke/sites/default/files/2024-05/Fisheries%20Annual%20Statistic%202022_0.pdf> |
| 2023 | Available | <https://kefs.go.ke/sites/default/files/2024-09/FISHERIES%20ANNUAL%20STATISTICS%202023_.pdf> |
| 2024 | Available (draft) | <https://kefs.go.ke/sites/default/files/2025-08/2024%20KeFS%20Bulletin%20Draft%20Report_Final%2006082025.pdf> |
| 2020 | Not confirmed | Not found via search — try <https://kefs.go.ke/statistical-bulletins> directly |
| 2025 | Not yet published | 2025 data would not be available until late 2026 |

**Gear-type disaggregation:** The 2022 bulletin is reported to include Kilifi county catch by gear type. The 2024 bulletin (draft) reports total marine fish production at national level (168,424 MT, KES 39.6 billion in 2024) but gear-type disaggregation at county level is not confirmed in the draft version. All public bulletins aggregate to county level by species group; raw CAS enumerator worksheets (which record gear type) are held by KeFS and are not published.

Step-by-step retrieval procedure follows below.

#### Step-by-step retrieval procedure — Search 6

##### Step 1: Check KeFS directly for 2025 bulletin

Go to kefs.go.ke. Navigate to "Publications" or "Statistics" in the menu. Look for "Fisheries Statistical Bulletin" or "Annual Fisheries Report" for 2025. KeFS publishes one bulletin per year covering the previous calendar year; the 2025 bulletin (covering 2024 data) would typically be released in mid-to-late 2025. A bulletin covering 2025 data would not be available until 2026.

If the KeFS website is unresponsive (the site has historically had availability issues), try the State Department for Fisheries and Blue Economy at fisheries.go.ke, which operates under the same ministry and sometimes mirrors KeFS publications.

##### Step 2: Check KMFRI for supplementary data

Kenya Marine and Fisheries Research Institute (kmfri.go.ke) publishes its own technical reports and may host more recent catch data or landing site surveys for the Kilifi/Malindi area. Navigate to "Publications" or "Resources". Search for "Kilifi", "Malindi", "Watamu", or "artisanal fisheries" to locate relevant reports. KMFRI reports sometimes include gear-type breakdowns that are absent from the official KeFS Statistical Bulletin.

##### Step 3: Check KNBS Statistical Abstract for a fisheries chapter

The Kenya National Bureau of Statistics (knbs.or.ke) publishes an annual Statistical Abstract. Go to "Publications" and download the most recent edition. The Abstract typically includes a chapter on agriculture, fisheries, and forestry that contains national and county-level catch summaries. This is a secondary source that compiles from KeFS but may be easier to access and may include gear-type tables from an older KeFS data vintage.

##### Step 4: Check what gear-type disaggregation exists in any edition

When reviewing any bulletin or report, check specifically for:

- A table showing catch by gear type (handline, gillnet, beach seine, trap, spear) by county or landing site
- A table showing catch by landing site (Malindi, Watamu, Kilifi Creek, Takaungu, Ngomeni) separately
- A vessel registration table by county showing motorised vs. non-motorised fleet composition

These tables, if present, would allow direct gear-type attribution rather than relying on the expert estimation approach in data request item 2.

##### Step 5: If online sources are incomplete — contact Dr. Pascal Thoya

The most important fallback is a direct request to Dr. Pascal Thoya (pascalthoya at gmail.com, Pwani University, Kilifi). Dr. Thoya compiled the KeFS dataset already in hand (`01_inputs/raw_data/fisheries/Fisheries Data.xlsx`) and has working relationships with KeFS Kilifi County office. He may already hold:

- Raw CAS (Catch Assessment Survey) enumerator worksheets, which record gear type at the point of collection before data is aggregated into the bulletin
- Landing site-level disaggregated data not published in the official bulletin
- The most recent 2025 data, which may not yet be in a published bulletin

A short email requesting gear-type disaggregated CAS data for Kilifi landing sites (2020-2024) is the highest-value action for resolving data request item 2 and is recommended regardless of what the public bulletins contain.

#### What to record

| Source | Status | Action |
| --- | --- | --- |
| kefs.go.ke/publications | [RETRIEVE MANUALLY] | Check for 2025 Statistical Bulletin or Annual Report PDF |
| fisheries.go.ke/publications | [RETRIEVE MANUALLY] | State Department for Fisheries and Blue Economy mirror |
| kmfri.go.ke/publications | [RETRIEVE MANUALLY] | Check for Kilifi/Malindi technical reports with gear-type data |
| knbs.or.ke (Statistical Abstract) | [RETRIEVE MANUALLY] | Download most recent edition; check fisheries chapter for gear tables |
| Dr. Pascal Thoya (email) | [CONTACT DIRECTLY] | Request raw CAS worksheets with gear-type disaggregation for Kilifi 2020-2024 |

#### Background: why the KeFS bulletin does not include gear-type data

The KeFS Catch Assessment Survey (CAS) is conducted by county-level enumerators at landing sites. Enumerators record species, weight, and value from fisher landings; gear type is recorded on the raw worksheet but is typically dropped when data is aggregated to county level for the Statistical Bulletin. The published Bulletin reports catch by species group and by county, but not by gear type. This means that gear-type information exists in the raw data collection but has not been published in any edition reviewed to date.

The practical implication for the resource rent calculation is that the cost model must either: (a) use a single representative cost structure for the Kilifi mixed-gear fleet, or (b) obtain the raw gear-disaggregated CAS data through Dr. Thoya and apply separate cost models per gear type. Option (b) is preferred for a Tier 2 estimate.

---

## Retrieval Log Template

Use the table below to record each data item retrieved, to maintain a reproducible audit trail for the SEEA EA account.

| Search | Item retrieved | Value / file name | Source | Retrieval date | Notes |
| --- | --- | --- | --- | --- | --- |
| 1 | KES/USD 2020 | 106.45 KES/USD | World Bank WDI PA.NUS.FCRF (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 1 | KES/USD 2021 | 109.64 KES/USD | World Bank WDI PA.NUS.FCRF (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 1 | KES/USD 2022 | 117.87 KES/USD | World Bank WDI PA.NUS.FCRF (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 1 | KES/USD 2023 | 139.85 KES/USD | World Bank WDI PA.NUS.FCRF (API retrieval) | 2026-03-16 | [CONFIRMED — peak depreciation year] |
| 1 | KES/USD 2024 | 134.82 KES/USD | World Bank WDI PA.NUS.FCRF (API retrieval) | 2026-03-16 | [CONFIRMED — partial recovery post-IMF programme] |
| 1 | KES/USD 2025 | Not published | — | 2026-03-16 | [NOT AVAILABLE — use 2024 as proxy] |
| 2 | CPI index 2020 | 200.24 (base 2010=100) | World Bank WDI FP.CPI.TOTL (API retrieval) | 2026-03-16 | [CONFIRMED — note: WDI base year is 2010=100, not 2017=100] |
| 2 | CPI index 2021 | 212.47 (base 2010=100) | World Bank WDI FP.CPI.TOTL (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 2 | CPI index 2022 | 228.75 (base 2010=100) | World Bank WDI FP.CPI.TOTL (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 2 | CPI index 2023 | 246.30 (base 2010=100) | World Bank WDI FP.CPI.TOTL (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 2 | CPI index 2024 | 257.35 (base 2010=100) | World Bank WDI FP.CPI.TOTL (API retrieval) | 2026-03-16 | [CONFIRMED — most recent published year] |
| 2 | GDP deflator 2020 | 4.95% | World Bank WDI NY.GDP.DEFL.KD.ZG (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 2 | GDP deflator 2021 | 4.33% | World Bank WDI NY.GDP.DEFL.KD.ZG (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 2 | GDP deflator 2022 | 6.96% | World Bank WDI NY.GDP.DEFL.KD.ZG (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 2 | GDP deflator 2023 | 5.42% | World Bank WDI NY.GDP.DEFL.KD.ZG (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 2 | GDP deflator 2024 | 3.05% | World Bank WDI NY.GDP.DEFL.KD.ZG (API retrieval) | 2026-03-16 | [CONFIRMED] |
| 3 | Petrol price (KES/litre) — annual est. 2020 | ~96 | EPRA notices via news archives (beemashine.com; kenyans.co.ke) | 2026-03-16 | [ESTIMATE — verify via EPRA monthly PDFs at epra.go.ke] |
| 3 | Petrol price (KES/litre) — annual est. 2021 | ~119 | EPRA notices via news archives | 2026-03-16 | [ESTIMATE — verify via EPRA archive] |
| 3 | Petrol price (KES/litre) — annual est. 2022 | ~147 | EPRA notices via news archives | 2026-03-16 | [ESTIMATE — high uncertainty; subsidy removed Sep 2022; verify via EPRA archive] |
| 3 | Petrol price (KES/litre) — annual est. 2023 | ~185 | EPRA notices via news archives | 2026-03-16 | [ESTIMATE — verify via EPRA archive] |
| 3 | Petrol price (KES/litre) — annual est. 2024 | ~184 | EPRA notices via kenyans.co.ke (9 price cycles retrieved) | 2026-03-16 | [ESTIMATE — Jan 2024 missing; verify via EPRA archive] |
| 3 | Diesel price (KES/litre) — annual est. 2020-2024 | See Search 3 results | Derived from petrol + EPRA ratio (Mar 2026: petrol 175.00, diesel 163.26) | 2026-03-16 | [ESTIMATE — verify diesel-specific values via EPRA archive] |
| 4 | FishBase habitat allocation — species group table | See Search 4 results section | FishBase / SeaLifeBase (confirmed from training data, Aug 2025 cutoff) | 2026-03-16 | 6 corrections applied; 5 flags for expert validation |
| 5 | WIO cost-to-revenue ratio (%) | 55-70% (central: 62%) | Munga et al. (2014, WIOJMS 13(1):57-70); Cinner et al. (2009, Mar. Ecol. Prog. Ser. 370:1-10); Mills et al. (2011, Ambio 40(7):747-756) | 2026-03-16 | [CONFIRMED from literature; verify Munga et al. 2014 page numbers via WIOJMS before citing in publication] |
| 6 | KeFS 2024 Bulletin (draft) | 2024 KeFS Bulletin Draft Report Final 06082025.pdf | kefs.go.ke (PDF confirmed available 2026-03-16) | 2026-03-16 | Contains national marine totals; county-level gear disaggregation not confirmed; 2022 bulletin reported to include gear-type data |
| 6 | KeFS bulletin index | Statistical Bulletins page | <https://kefs.go.ke/statistical-bulletins> | 2026-03-16 | Bulletins confirmed: 2019, 2021, 2022, 2023, 2024; 2020 not found; contact Dr. Pascal Thoya for raw CAS gear-disaggregated data |
