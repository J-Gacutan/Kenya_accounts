# Data Request: Wild Fish Provisioning Service Account — Kilifi County, Kenya

**Purpose:** Identify datasets required to complete the SEEA EA wild fish provisioning service account for Kilifi coral reef (M1.3), using the resource rent method. Updated to reflect data already in hand.

**Framework:** UN SEEA EA Ecosystem Service Accounts, Section 6.1
**Valuation method:** Resource rent = Gross Revenue − Total Costs
**Accounting period:** 2025–2026

---

## Status Summary

| Account component | Data needed | Status |
|---|---|---|
| Annual catch volume (kg/yr) | KeFS landing records | Available (2020-2024) |
| Catch by species group | KeFS species breakdown | Available (~37 groups/yr) |
| Gross landed value (KES) | Ex-vessel value by species | Available (2020-2024) |
| Implied market price (KES/kg) | Derived from catch + value | Derivable from existing data |
| Catch by ecosystem type | Reef vs seagrass vs pelagic split | NOT available — county aggregate only |
| Catch by gear type | Gear-level disaggregation | NOT available |
| Labour costs | Fisher wages / crew costs | NOT available |
| Capital costs | Vessel + gear depreciation | NOT available |
| Fuel costs | Litres/trip × fuel price | NOT available |
| Equipment and maintenance | Repairs, nets, hooks, ice | NOT available |
| Fishing effort distribution | Spatial map of fishing grounds | NOT available |

---

## What Is Already In Hand

### KeFS Annual Fisheries Statistics (2020-2024)
**Source:** Kenya Fisheries Service Catch Assessment Surveys; compiled by Dr. Pascal Thoya, Pwani University
**File:** `01_inputs/raw_data/fisheries/Fisheries Data.xlsx`

- Annual catch (MT) and value (KES '000) by species group, 2020-2024
- ~37 species groups per year covering demersal reef fish, pelagics, and invertebrates
- Landing sites included: Malindi, Watamu, Kilifi Creek, Takaungu, Ngomeni
- Summary trend: 4,452 MT (2020) to 12,094 MT (2024); +172% growth

This dataset directly provides:
- Physical account: total annual catch (MT/yr) by species group — usable as-is
- Monetary account: gross landed value (KES '000/yr) — usable as proxy for gross revenue
- Implied average price per species group (KES/kg) can be derived: Price = Value / Catch

Known limitations of this dataset:
- County-level aggregate only; not disaggregated by ecosystem type (reef, seagrass, pelagic)
- No fishing effort data (vessel days, gear type)
- Species name inconsistencies between years require standardisation before multi-year analysis
- 2023 values are estimates
- Subsistence and unreported landings not captured

---

## Data Still Required

The table below lists each missing data item, what it is and why it is needed, the specific estimate and unit to request, and who to approach. Items are ordered by priority for completing the resource rent calculation.

| # | Data item | Description and why needed | Estimate to request | Unit | Potential sources |
| --- | --- | --- | --- | --- | --- |
| 1 | Ecosystem catch attribution | The KeFS landings data is a county-level aggregate and does not indicate where fish were caught. For SEEA EA, catch must be attributed to a specific providing ecosystem (coral reef, seagrass, or pelagic open water). Without this split, the full county catch cannot be assigned to the coral reef account. Reef-associated species groups from the KeFS list (snapper, parrot fish, rock cod, surgeon fish, rabbit fish, scavenger, goat fish) likely derive most catch from reef habitat, but the proportion must be confirmed. | For each of the ~37 species groups in the KeFS data: estimated % of annual catch taken on or near coral reefs vs. seagrass beds vs. open water | % per species group per ecosystem type | Dr. Pascal Thoya, Pwani University (local expert validation); KeFS enumerators at Malindi, Watamu, Kilifi Creek, Takaungu, Ngomeni landing sites; FishBase species-habitat associations as fallback |
| 2 | Gear type by species group | The KeFS Bulletins report catch by species but do not disaggregate by gear type. Gear type (handline, gillnet, beach seine, trap, spear) determines cost structure — motorised vessels using nets have far higher fuel and capital costs than non-motorised handline fishers. This is needed for both the physical supply table and to select the correct cost model. | For each species group or landing site: dominant gear type used, and approximate % of catch taken by each gear | Gear type name; % catch share by gear per species group | Kenya Fisheries Service Kilifi County Fisheries Officer (raw CAS survey forms may already contain gear data); Dr. Pascal Thoya; CCVA and PU-GOAP field teams at landing sites |
| 3 | Labour cost per vessel per trip | Labour is the largest single cost component in artisanal fisheries and the primary deduction in the resource rent formula. It includes both hired crew wages and the opportunity cost of the vessel owner's own time. In share-based crew arrangements (common in Kenya), crew receive a fixed proportion of landed value rather than a daily wage; the share ratio is therefore the key value to collect. | Average crew size per vessel (number of people); daily crew wage rate OR crew share of landed value (% of gross catch value); number of fishing days per year per vessel | KES/person/day; OR % share of gross value; fishing days/yr | Fisher interviews at Kilifi landing sites (30-50 respondents); CCVA / COMRED / PU-GOAP field teams can administer during existing fieldwork; Kenya National Bureau of Statistics agricultural wage data as alternative proxy |
| 4 | Fuel cost per trip | Fuel is the largest operational (variable) cost for motorised vessels and is highly sensitive to trip length and engine size. Non-motorised dugout canoes (common inshore) have zero fuel cost but higher labour intensity. Collecting both motorised and non-motorised costs separately, then weighting by vessel fleet composition, gives the most accurate fuel cost estimate. | Litres of petrol or diesel consumed per fishing trip (by vessel type: motorised outboard, motorised inboard, non-motorised); current retail fuel price at nearest filling station | Litres/trip; KES/litre | Fisher interviews; Kenya Energy and Petroleum Regulatory Authority (EPRA) pump price data for Kilifi/Malindi (published monthly) |
| 5 | Vessel capital value and lifespan | Capital cost (depreciation) represents the annual consumption of fishing vessel value. In SEEA EA resource rent, it is deducted from gross revenue as consumption of fixed capital. The standard approach is to collect current replacement cost and expected useful lifespan, then apply straight-line depreciation (annual depreciation = replacement cost / lifespan). Vessel types in Kilifi range from non-motorised fibreglass canoes (~KES 30,000-80,000) to motorised fibreglass boats (~KES 150,000-400,000). | Current purchase price or replacement cost of a new vessel of the same type (by vessel type); expected working lifespan in years; current second-hand market value if available | KES per vessel; years | Fisher interviews; local boat builders or chandleries in Mombasa / Malindi; CCVA / PU-GOAP field teams |
| 6 | Gear capital value and replacement frequency | Fishing gear (nets, handlines, traps, hooks) depreciates rapidly in the marine environment. Gear depreciation is calculated as replacement cost divided by replacement interval. For gillnets this may be 1-2 years; for handlines 3-5 years; for wire traps 3-7 years. This cost is typically small relative to vessel and labour but is required for a complete cost account. | Replacement cost of a full set of primary gear (by gear type); how often gear is fully replaced (months or years) | KES per gear set; replacement interval in months | Fisher interviews; local fishing supply shops in Kilifi, Malindi, or Mombasa |
| 7 | Engine and equipment maintenance costs | Ongoing maintenance (engine servicing, net repair, rope replacement, hull antifouling) represents recurring operational expenditure that reduces resource rent. It is typically collected as an average monthly or annual expenditure across all maintenance categories combined. A recall period of 3-6 months is appropriate. | Average total maintenance and repair expenditure per vessel per month, covering: engine servicing, hull repair, net or gear repair, and any other regular maintenance | KES/vessel/month | Fisher interviews; motor mechanic workshops at Kilifi and Malindi landing areas |
| 8 | Ice and post-harvest handling costs | Perishable fish require ice, cool boxes, or transport to market to maintain quality and price. These are variable costs per trip that reduce net revenue. In Kilifi, ice supply is likely purchased at landing sites or nearby towns. Where fish are sold live or immediately (common for subsistence), this cost may be zero or minimal but should be confirmed. | Cost of ice per fishing trip (KES); whether cool boxes or refrigerated transport are used and their cost per trip | KES/trip; yes/no for cool box use | Fisher interviews at landing sites; ice suppliers at Malindi and Watamu |
| 9 | Number of active fishing vessels and trips per year | To scale per-vessel cost estimates to the full Kilifi fleet, the total number of active fishing vessels and their average annual fishing effort is needed. KeFS may publish vessel registration data by county. This figure, combined with per-trip costs, gives total annual fishing costs for the county as a whole. | Total number of registered or active motorised and non-motorised fishing vessels in Kilifi County; average number of fishing trips per vessel per month | Number of vessels; trips/vessel/month | Kenya Fisheries Service vessel registration data (KeFS Annual Bulletin); Kilifi County Fisheries Office; Dr. Pascal Thoya |
| 10 | Subsistence and unreported catch estimate | The KeFS Catch Assessment Survey captures landings at formal sites but does not record subsistence catch consumed within households or informal sales. For SEEA EA, the physical account should cover total extraction including non-marketed fish. Published studies on unreported catch in Kenyan coastal fisheries suggest informal landings may add 20-40% above recorded volumes. An expert estimate from local researchers is sufficient for a Tier 1 adjustment. | Estimated % of total catch that is consumed for subsistence or sold informally and therefore not captured in KeFS records; approximate species composition of subsistence catch | % of formal landings; dominant species groups | Dr. Pascal Thoya, Pwani University; CCVA socio-economic surveys; peer-reviewed literature on Kenya coastal fisheries (e.g., McClanahan and Mangi 2004; Samoilys et al. 2017) |
| 11 | KES/USD exchange rate (2020-2024) | All SEEA EA monetary accounts should be expressed in both local currency (KES) and a standard international currency (USD) to enable cross-country comparison. Annual average exchange rates are needed for each year in the time series (2020-2024) and for the current accounting year (2025-2026). | Annual average KES/USD exchange rate for 2020, 2021, 2022, 2023, 2024, and current rate | KES per 1 USD, annual average | Central Bank of Kenya (CBK) website — exchange rates published monthly and archived; World Bank World Development Indicators |
| 12 | Kenya CPI or GDP deflator (2020-2024) | To express the time series in constant prices (removing inflation), a Kenya-specific price deflator is required. The Consumer Price Index (CPI) or GDP deflator can be used; for fisheries accounts, CPI for food or CPI all-items is appropriate. Base year should be aligned with the accounting period (2025 or 2026). | Annual CPI index values for Kenya for 2020-2024, with base year stated; or annual GDP deflator values for the same period | Index value (dimensionless); base year = 100 | Kenya National Bureau of Statistics (KNBS) — Statistical Abstract published annually; World Bank World Development Indicators |

---

## Resource Rent Calculation — Readiness Assessment

Using existing KeFS data (items 1-2 above resolved) plus literature-based habitat attribution, a Tier 1 resource rent estimate can be produced without new fieldwork:

```
Step 1: Classify 37 species groups into reef, seagrass, pelagic (literature + expert validation)
Step 2: Sum reef-associated catch (MT/yr) and value (KES '000/yr) from KeFS data
Step 3: Derive implied average price per species group: Price (KES/kg) = Value / Catch
Step 4: Apply published cost-to-revenue ratio (40-70%) from WIO artisanal fishery literature
Step 5: Resource Rent = Gross Revenue x (1 - cost ratio); report as range
```

A Tier 2 estimate with domestically collected cost data requires items 3-9 above (fisher cost survey). This can be appended to existing CCVA / PU-GOAP / COMRED fieldwork in Kilifi without separate mobilisation.

---

## Contacts

| Dataset | Contact | Notes |
|---|---|---|
| Ecosystem attribution; fleet and effort data | Dr. Pascal Thoya, Pwani University | pascalthoya at gmail.com |
| Gear type disaggregation from raw CAS forms | Kenya Fisheries Service, Kilifi County Fisheries Officer | Raw survey forms may already contain gear data |
| Fisher cost survey (items 3-9) | CCVA / PU-GOAP / COMRED field teams | Add structured cost questionnaire to existing fieldwork |
| Fuel price data | Kenya Energy and Petroleum Regulatory Authority (EPRA) | Monthly pump prices published at epra.go.ke |
| KES/USD exchange rates | Central Bank of Kenya (CBK) | Archived monthly rates at centralbank.go.ke |
| CPI / GDP deflator | Kenya National Bureau of Statistics (KNBS) | Statistical Abstract at knbs.or.ke |
