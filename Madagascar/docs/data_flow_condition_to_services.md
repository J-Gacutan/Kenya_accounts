# Data Flow: Condition Accounts → Ecosystem Service Accounts
## Madagascar Coral Reef M1.3 — SEEA EA Integration

**Purpose:** Map condition account outputs to ecosystem service account inputs, identify coverage gaps, and establish data linkages.

**Scope:** Madagascar coral reef (M1.3), 2025–2026
**Framework:** UN SEEA EA Section 6 (Service Accounts)
**Last updated:** 2026-03-04

---

## Executive Summary

Your **condition accounts produce fish and invertebrate community metrics** that directly feed into:

1. **Fisheries Nursery Service** — Uses fish biomass + density directly
2. **Coral Reef Recreation** — Uses reef condition indicators (fish richness, COTS density) as proxies for tourism value
3. **Coastal Protection** — Coral condition is relevant but not fish community metrics
4. **Wild Fish Provisioning** — Fish data has bearing but requires external catch/landings data

**Gap:** Your condition accounts lack:
- Carbon sequestration metrics (mangroves, seagrass not in scope)
- Sediment nourishment indicators
- Direct tourism/recreation data
- Catch and landings records

---

## Part 1: Condition Account Outputs (AFRICA — Madagascar Project)

### Current Outputs by Ecosystem

**Ecosystem Asset:** Photic Coral Reef (M1.3)
**Survey coverage:** 27 sites, 2 transects per site
**Accounting period:** 2025–2026

### 1a. Fish Community Indicators (Site-Level)

| Indicator | Unit | Reference Level | Mean (2025) | Range | Notes |
|-----------|------|-----------------|-------------|-------|-------|
| **Biomass (total)** | kg/ha | 500 | 1,928.9 | 1,200–2,500 | By functional group available |
| **Abundance (total)** | ind/ha | — | ~3,500–5,000 (est.) | — | Calculated from size-class counts |
| **Species richness** | count | 103 | 55 | 32–68 | Per site |
| **Trophic composition** | % biomass | — | Herbivore 40.6%, Carnivore 30%, others | — | 7 functional groups |

**Available Functional Groups:**
- Herbivore (40.6%)
- Carnivore (30.0%)
- Planktivore (15.2%)
- Corallivore (8.7%)
- Omnivore (5.5%)
- Piscivore (<0.1%)
- Detritivore (<0.1%)

### 1b. Invertebrate Community Indicators (Site-Level)

| Indicator | Unit | Measured Value (Mean 2025) | Notes |
|-----------|------|---------------------------|-------|
| **COTS density** | ind/ha | 6.7 | Inverted CI: 0.82 (lower = better) |
| **Sea urchin density** | ind/m² | 1.83 | Range 0–15.6 across sites |
| **Macroinvertebrate richness** | count | ~15–20 | 59 species pool |
| **Giant clam abundance** | count/transect | Low (descriptive only) | Not quantified as formal indicator |

### 1c. Output Files

**Raw values:**
- `fish_invert_site_condition.csv` — 27 sites × indicators
- `fish_invert_site_fg_condition.csv` — 27 sites × 7 functional groups

**SEEA EA condition account:**
- `fish_invert_seea_condition.csv` — 3 indicators (fish biomass, richness, COTS)

**Temporal scope:**
- Opening year: 2025
- Closing year: 2026
- Single accounting period (not multi-year trend)

---

## Part 2: Ecosystem Service Account Input Requirements

### Service 1: Fisheries Nursery (Wild-Caught Fish, Regulating)

**SEEA EA Section:** 6.2
**CICES Class:** 6.1.1 Maintenance of life cycle processes
**Providing ecosystem:** Coral reef (confirmed)

#### Inputs Required

| Input | Source | Your Condition Account | Gap? | Notes |
|-------|--------|------------------------|------|-------|
| **Fish biomass (total)** | Condition account | Fish biomass: 1,928.9 kg/ha (2025) | NO | Direct input; normalised to per-hectare |
| **Fish abundance** | Condition account | Calculated from size-class counts | NO | Can derive from condition data |
| **Species composition** | Condition account | 227 species recorded; 85 families | NO | Available in raw data |
| **Functional group breakdown** | Condition account | 7 groups (herbivore, carnivore, etc.) | NO | Critical for fishing impact; have all |
| **Fish density in non-nursery areas** | Reference data | NOT in condition account | **YES** | Needed to establish counterfactual baseline |
| **Log Response Ratio (LRR)** | Literature | NOT in condition account | **YES** | Use standard: Coral reef LRR = 31% |
| **Juvenile survival rate** | Ecological parameter | NOT in condition account | **YES** | Use standard: 5% survival to harvest |
| **Market price of landed fish** | Fisheries data | NOT in condition account | **YES** | Must obtain from local fisheries market data |

#### Calculation (Simplified)

```
Enhanced juvenile biomass = Total fish biomass × LRR (0.31)
Harvestable nursery contribution = Enhanced juvenile biomass × 0.05 (survival)
Nursery value (USD/yr) = Harvestable contribution × Market price (USD/kg)
```

**Your action:**
1. Use your fish biomass value (1,928.9 kg/ha) directly
2. Obtain market price of landed fish from local fisheries records (missing)
3. Confirm whether your survey area fish are nursery-stage or adult-dominant (infer from size distribution in your 6 size-class bins)

---

### Service 2: Wild Fish Provisioning (Direct Harvest, Provisioning)

**SEEA EA Section:** 6.1
**CICES Class:** 3.1.1 Capture fisheries
**Providing ecosystem:** Coral reef

#### Inputs Required

| Input | Source | Your Condition Account | Gap? | Notes |
|-------|--------|------------------------|------|-------|
| **Current catch (landings)** | Fisheries agency records | NOT in condition account | **YES** | Essential; no survey data on actual harvest |
| **Catch composition (by species/family)** | Fisheries data | NOT in condition account | **YES** | Needed to link condition metrics to harvested taxa |
| **Fish biomass (reference)** | Condition account | 1,928.9 kg/ha (your ecosystem) | NO | Provides context for potential supply |
| **Fish abundance (by functional group)** | Condition account | Available in functional group breakdown | NO | Can stratify catch by trophic role |
| **Unit value (price per kg)** | Market data | NOT in condition account | **YES** | Needed for monetary valuation |

#### Why Your Condition Data Are Relevant

Your fish metrics establish the **ecological baseline** — showing that the reef is species-rich (55 species, CI 0.59) and biomass-productive (1,928.9 kg/ha, CI 1.0). This informs provisioning service valuation by:
- Defining the productivity ceiling (what can sustainably be harvested)
- Stratifying by functional group (different taxa have different market values)
- Tracking ecosystem condition changes that affect future harvest potential

**Your action:**
1. Document fish composition from your 227-species dataset
2. Link to external fisheries catch data (landings records from Madagascar fisheries authority)
3. Obtain market prices for main commercial families

---

### Service 3: Coral Reef Recreation (Cultural)

**SEEA EA Section:** 6.6
**CICES Class:** 7.1.1 Recreational activities in natural settings
**Providing ecosystem:** Coral reef

#### Inputs Required

| Input | Source | Your Condition Account | Gap? | Notes |
|-------|--------|------------------------|------|-------|
| **Reef condition indicators** | Condition account | Fish richness: 55 spp. (CI 0.59) | NO | Reef health metric |
| **Fish biomass** | Condition account | 1,928.9 kg/ha (CI 1.0) | NO | Diver attraction proxy |
| **COTS density** | Condition account | 6.7 ind/ha (CI 0.82) | NO | Coral damage indicator |
| **Coral cover** | Benthic condition data | NOT in fish/invert account | **YES** | Direct attribute for dive tourism |
| **Coral bleaching** | Benthic condition data | NOT in fish/invert account | **YES** | Seasonal tourism impact |
| **Visitor count** | Tourism records | NOT in condition account | **YES** | Primary input (not ecological) |
| **Visitor expenditure** | Tourism survey | NOT in condition account | **YES** | Primary input (not ecological) |
| **Trip frequency** | Tourism operator logs | NOT in condition account | **YES** | Primary input (not ecological) |

#### How Your Condition Data Add Value

Your fish and invertebrate indicators are **proxies for reef attractiveness** to divers/snorkellers:
- High fish richness (55 spp.) → more charismatic megafauna for tourists to observe
- High biomass (1,928.9 kg/ha) → stronger visual impressions of reef abundance
- Low COTS density (6.7/ha, not outbreak level) → minimal coral damage (positive for tourism)

This supports a **condition-linked valuation** approach: reef service value is partially a function of fish condition state.

**Your action:**
1. Use fish richness + biomass + COTS as condition proxies in service account
2. Obtain external coral cover + bleaching data (from benthic condition account — see `skill_condition_biotic_coral.md`)
3. Obtain tourism data separately (resort visitor records, dive centre logs, etc.)

---

### Service 4: Coastal Protection (Regulating)

**SEEA EA Section:** 6.4
**CICES Class:** 2.2.6 Coastal protection and erosion control
**Providing ecosystem:** Coral reef (partial)

#### Inputs Required

| Input | Source | Your Condition Account | Gap? | Notes |
|-------|--------|------------------------|------|-------|
| **Reef extent** | Extent account | NOT in condition account | **YES** | Spatial scope needed (GIS layer) |
| **Reef structural complexity** | Benthic morphology | NOT in condition account | **YES** | Wave attenuation depends on structural form, not fish density |
| **Building/infrastructure footprints** | Cadastral data | ❌ NOT in condition account | **YES** | Define zone of protection |
| **Replacement cost (engineering)** | Cost data | ❌ NOT in condition account | **YES** | Valuation input |
| **Fish/invertebrate condition** | Your account | ✅ Available | NO | Secondary relevance (habitat degradation → wave attenuation decline) |

#### Connection to Your Data

**Weak linkage:** Fish condition reflects reef *biological* health, not *structural* integrity. However:
- Degraded reef (low fish biomass, high COTS) → coral damage → reduced structural complexity
- Improved reef (high fish biomass, healthy trophic balance) → intact corals → maintained wave attenuation

Your condition data **inform trends** in coastal protection service but do not directly calculate it.

**Your action:**
1. ⚠️ Use fish condition as a *contextual indicator* of reef structural health (infer from richness + biomass)
2. ⚠️ Obtain external structural data (reef morphology GIS layer, wave modelling)

---

### Service 5: Sediment Nourishment (Regulating)

**SEEA EA Section:** 6.5
**CICES Class:** 2.2.3 Lifecycle maintenance of aquatic species
**Providing ecosystem:** Mangroves, seagrass (NOT coral reef)

#### Inputs Required

| Input | Your Condition Account | Gap? |
|-------|------------------------|------|
| **Sediment production rate** (CaCO3 or clastic) | ❌ NOT in account | **YES** |
| **Sediment transport rates** | ❌ NOT in account | **YES** |
| **Beach nourishment engineering cost** | ❌ NOT in account | **YES** |

**Status:** Not applicable to your coral reef account. Sediment nourishment is relevant only if you include mangrove or seagrass ecosystem assets (which your current scope excludes).

---

## Part 3: Data Linkages and Coverage Matrix

### Summary: Which Service Accounts Can Use Your Condition Data?

| Service Account | Data Coverage | Linkage Strength | Next Steps |
|-----------------|---------------|-----------------|----|
| **Fisheries Nursery** | ✅ 70% | STRONG | Use fish biomass + functional groups directly; obtain market price |
| **Wild Fish Provisioning** | ✅ 50% | STRONG | Fish composition establishes baseline; link to external catch data |
| **Coral Reef Recreation** | ✅ 40% | MEDIUM | Fish richness + biomass as proxies; supplement with tourism data |
| **Coastal Protection** | ✅ 20% | WEAK | Infer structural health from condition; obtain GIS morphology data |
| **Carbon Sequestration** | ❌ 0% | N/A | Out of scope (requires mangrove/seagrass data) |
| **Sediment Nourishment** | ❌ 0% | N/A | Out of scope (requires mangrove/seagrass data) |

---

## Part 4: Detailed Data Mapping Tables

### 4a. Fisheries Nursery Service — Input Checklist

```
CONDITION ACCOUNT INPUTS:
├── ✅ Fish biomass (kg/ha)                    → From fish_invert_seea_condition.csv
├── ✅ Fish abundance (ind/ha)                 → Calculate from size-class data
├── ✅ Species composition (227 spp.)          → From raw Fishdata_OASIS_M.xlsx
├── ✅ Functional group breakdown              → From fish_invert_site_fg_condition.csv
│
EXTERNAL INPUTS REQUIRED:
├── ⚠️ Market price of landed fish (USD/kg)    → Obtain from: Madagascar fisheries market surveys
├── ⚠️ Nursery habitat LRR (%)                 → Use literature: 31% for coral reef
├── ⚠️ Juvenile survival rate (%)              → Use standard: 5%
└── ⚠️ Baseline fish density (non-nursery)     → Obtain from: literature or offshore reef surveys

CALCULATION PATHWAY:
   Fish biomass (1,928.9 kg/ha)
   × Nursery LRR (0.31)
   = Enhanced juvenile biomass (597.6 kg/ha)
   × Survival rate (0.05)
   = Harvestable contribution (29.9 kg/ha)
   × Market price (USD/kg)
   = Monetary nursery value (USD/ha/yr)
```

**Data file to create:**
`Madagascar/03_outputs/fish_invert_nursery_service_input.csv`

| Site | Year | Biomass (kg/ha) | Abundance (ind/ha) | Primary Families | Herbivore (%) | Carnivore (%) | Piscivore (%) | Notes |
|------|------|-----------------|-------------------|------------------|---------------|---------------|---------------|-------|
| S001 | 2025 | 1,950 | 3,200 | Scaridae, Serranidae | 41 | 29 | 0.1 | ... |
| S002 | 2025 | 1,850 | 3,100 | Scaridae, Labridae | 39 | 31 | 0.2 | ... |

---

### 4b. Wild Fish Provisioning — Input Checklist

```
CONDITION ACCOUNT INPUTS:
├── ✅ Fish biomass by family (kg/ha)          → Derive from Fishdata_OASIS_M.xlsx
├── ✅ Species richness (55 spp.)              → From fish_invert_seea_condition.csv
├── ✅ Abundance by functional group           → From fish_invert_site_fg_condition.csv
│
EXTERNAL INPUTS REQUIRED:
├── ⚠️ Current catch (landings, kg/yr)         → Obtain from: Madagascar fisheries authority (MPRH)
├── ⚠️ Catch composition (species/family %)    → Obtain from: fish market surveys, fisher interviews
├── ⚠️ Market price by species (USD/kg)        → Obtain from: local fish markets
└── ⚠️ Historical catch trends                 → Obtain from: national fisheries statistics

CALCULATION PATHWAY:
   Current catch (kg/yr) [external data]
   ÷ Reef extent (ha)
   × Fish condition index (0–1)
   = Ecosystem service value (kg/yr/ha, normalised)
   × Market price (USD/kg)
   = Monetary provisioning value (USD/yr)
```

**Data file to create:**
`Madagascar/03_outputs/fish_family_biomass_distribution.csv`

| Species | Family | Count | Biomass (kg) | Biomass (%) | Commercial? | Market Price (USD/kg) | Notes |
|---------|--------|-------|--------------|-------------|-------------|----------------------|-------|
| *Scarus psittacus* | Scaridae | 450 | 325.5 | 18.2% | Yes | 2.50 | Primary harvest target |
| *Lutjanus campechanus* | Lutjanidae | 120 | 280.2 | 15.7% | Yes | 3.75 | ... |

---

### 4c. Coral Reef Recreation — Input Checklist

```
CONDITION ACCOUNT INPUTS:
├── ✅ Fish richness (55 spp., CI 0.59)        → From fish_invert_seea_condition.csv
├── ✅ Fish biomass (1,928.9 kg/ha, CI 1.0)    → From fish_invert_seea_condition.csv
├── ✅ COTS density (6.7 ind/ha, CI 0.82)      → From fish_invert_seea_condition.csv
├── ✅ Trophic integrity (herbivore 40.6%)     → From fish_invert_seea_condition.csv
│
EXTERNAL INPUTS REQUIRED (from benthic condition):
├── ⚠️ Coral cover (%)                         → From skill_condition_biotic_coral.md outputs
├── ⚠️ Coral bleaching index                   → From skill_condition_biotic_coral.md outputs
│
EXTERNAL INPUTS REQUIRED (from tourism data):
├── ⚠️ Visitor count (trips/yr)                → Obtain from: resort visitor logs, tour operator records
├── ⚠️ Visitor expenditure per trip (USD)      → Obtain from: tourist surveys, resort billing records
├── ⚠️ Trip frequency                          → Obtain from: dive centre activity logs
├── ⚠️ Tourist motivation segments             → Obtain from: visitor surveys
└── ⚠️ Seasonal variation                      → Obtain from: tourism records

CALCULATION PATHWAY:
   Visitor count (trips/yr) [external data]
   × Visitor expenditure per trip (USD)
   × Reef condition index (composite of fish richness + biomass + coral health)
   = Total recreation value (USD/yr)
   ÷ Reef extent (ha)
   = Per-hectare recreation service value (USD/ha/yr)
```

**Data file to create:**
`Madagascar/03_outputs/reef_condition_recreation_proxy.csv`

| Site | Year | Fish Richness (CI) | Fish Biomass (CI) | COTS Density (CI) | Composite Reef Health Index (0–1) | Estimated Tourism Attractiveness | Notes |
|------|------|-----------------|-----------------|-------------------|----------------------------------|----------------------------------|-------|
| S001 | 2025 | 0.59 | 1.00 | 0.82 | 0.80 | High | Good baseline for tourism potential |
| S002 | 2025 | 0.54 | 0.98 | 0.85 | 0.79 | High | ... |

---

## Part 5: Missing Data and Acquisition Strategy

### Priority 1: Critical for Multiple Services

| Missing Data | Why Needed | Service(s) | Acquisition Method | Timeline |
|--------------|-----------|-----------|-------------------|----------|
| **Market price of landed fish (USD/kg)** | Essential for economic valuation of both nursery and provisioning services | Nursery, Provisioning | Local fish market surveys; fisher interviews (Laza, Maka can facilitate) | Next month |
| **Current fish catch (landings, kg/yr)** | Establishes actual provisioning service supply (vs. potential) | Provisioning | Request from Madagascar MPRH (Ministry of Blue Economy); port landing records | Next month |
| **Catch composition by species/family** | Links landings to your 227-species dataset | Provisioning | Fish market surveys; sale records; fisher logbooks | Next month |

### Priority 2: Tourism-Dependent Services

| Missing Data | Why Needed | Service(s) | Acquisition Method | Timeline |
|--------------|-----------|-----------|-------------------|----------|
| **Visitor count (annual trips)** | Core physical input for recreation service | Recreation | Resort visitor logs; tour operator activity sheets; dive centre records | This month |
| **Visitor expenditure (USD/trip)** | Monetary valuation of recreation service | Recreation | Tourist receipts; willingness-to-pay surveys | Next 2 months |
| **Tourist motivation** | Segment value by activity type (diving vs. snorkelling) | Recreation | Visitor surveys at resorts/dive centres | Next 2 months |

### Priority 3: Complementary Ecosystem Data

| Missing Data | Why Needed | Service(s) | Acquisition Method | Timeline |
|--------------|-----------|-----------|-------------------|----------|
| **Coral cover + bleaching** | Reef structural attribute for tourism & coastal protection | Recreation, Coastal Protection | From companion `skill_condition_biotic_coral.md`; use satellite + ground truthing | Already in scope |
| **Reef extent (GIS layer)** | Spatial accounting unit | All | From benthic habitat map (Yves Amoros Mitondrasoa, IHSM) | Already available |
| **Building/infrastructure footprint** | Define zone of coastal protection | Coastal Protection | Cadastral/satellite imagery; local government records | Future phase |

---

## Part 6: Recommended Implementation Pathway

### Phase 1: Immediate (Within 1 Month)

**Goal:** Quantify Fisheries Nursery service using existing condition data

1. ✅ **Document fish family composition** from your 227-species dataset
   - Output: `fish_family_biomass_distribution.csv`
   - Use: Link fish condition to harvest targets

2. ⚠️ **Acquire market price data**
   - Contact: Laza (field observer) or local fish markets in SW Madagascar
   - Output: `market_price_data.csv` (price per kg by family)
   - Timeline: 2–3 weeks

3. ✅ **Calculate enhanced juvenile biomass**
   - Use your fish biomass (1,928.9 kg/ha) × Coral reef LRR (31%)
   - Apply standard juvenile survival (5%)
   - Output: `fish_invert_nursery_service_input.csv`
   - Timeline: 1 week (once market price available)

### Phase 2: Medium-Term (Within 2–3 Months)

**Goal:** Quantify Wild Fish Provisioning & Coral Reef Recreation

1. ⚠️ **Acquire fisheries catch data**
   - Contact: Madagascar MPRH (Ministry of Blue Economy); request national catch statistics by province/district
   - Output: `fisheries_landings_madagascar.csv` (by year, species, gear type)
   - Timeline: 4 weeks

2. ⚠️ **Acquire tourism data**
   - Contact: Local resorts, dive centres, tourism associations in SW Madagascar
   - Survey: Visitor logs, expenditure receipts, trip frequency
   - Output: `tourism_visitor_data.csv` (annual trips, expenditure, seasonal pattern)
   - Timeline: 4–6 weeks

3. ✅ **Create recreation attractiveness index**
   - Combine: Fish richness + biomass + COTS density (already have)
   - Supplement: Coral cover (from companion skill) + bleaching index
   - Output: `reef_condition_recreation_proxy.csv`
   - Timeline: 2 weeks (once coral data obtained)

### Phase 3: Integration (Within 3–4 Months)

**Goal:** Produce preliminary ecosystem service accounts linked to condition accounts

1. **Fisheries Nursery Account**
   - Inputs: Your fish biomass (kg/ha) + market price data
   - Output: SEEA EA service account (physical + monetary)

2. **Wild Fish Provisioning Account**
   - Inputs: MPRH catch data + your fish composition + market prices
   - Output: SEEA EA service account (physical + monetary)

3. **Coral Reef Recreation Account**
   - Inputs: Tourism data + reef condition indices (from your account + coral data)
   - Output: SEEA EA service account (physical + monetary)

---

## Part 7: Template Files to Create

### Output 1: Fisheries Nursery Service Input

**File:** `Madagascar/03_outputs/fish_invert_nursery_service_input.csv`

```csv
Site,Year,Total_Biomass_kg_ha,Total_Abundance_ind_ha,Primary_Families,Herbivore_pct,Carnivore_pct,Piscivore_pct,Nursery_LRR_pct,Juvenile_Survival_pct,Enhanced_Juvenile_Biomass_kg_ha,Harvestable_Contribution_kg_ha,Market_Price_USD_kg,Nursery_Value_USD_ha_yr,Notes
S001,2025,1950,3200,"Scaridae, Serranidae, Labridae",41,29,0.1,31,5,604.5,30.2,2.85,86.07,"Well-structured fish community"
S002,2025,1850,3100,"Scaridae, Lutjanidae",39,31,0.2,31,5,573.5,28.7,2.85,81.80,"Commercial families present"
```

### Output 2: Fish Family Biomass Distribution

**File:** `Madagascar/03_outputs/fish_family_biomass_distribution.csv`

```csv
Family,Common_Name,Num_Species,Total_Count,Total_Biomass_kg,Pct_Total_Biomass,Commercial_Value_Yes_No,Est_Market_Price_USD_kg,Notes
Scaridae,Parrotfish,12,2100,425.3,23.8,Yes,2.50,"Primary herbivore; major harvest target"
Serranidae,Grouper,8,180,320.5,17.9,Yes,5.75,"High-value commercial species"
Labridae,Wrasse,15,950,285.2,15.9,No,1.50,"Mostly bycatch; low market value"
Lutjanidae,Snapper,6,120,210.3,11.8,Yes,4.25,"Highly commercial; prized for export"
```

### Output 3: Reef Condition Recreation Proxy

**File:** `Madagascar/03_outputs/reef_condition_recreation_proxy.csv`

```csv
Site,Year,Fish_Richness_CI,Fish_Biomass_CI,COTS_Density_CI,Herbivore_CI,Coral_Cover_pct,Coral_Bleaching_CI,Composite_Reef_Health_Index,Tourism_Attractiveness_Rank,Notes
S001,2025,0.59,1.00,0.82,0.81,65,0.90,0.82,High,"Excellent baseline for tourism; healthy herbivore community supports resilience"
S002,2025,0.54,0.98,0.85,0.79,62,0.88,0.81,High,"Slightly lower richness but high biomass; good dive site potential"
```

---

## Part 8: Data Dictionary

### Condition Account Indicators → Service Account Inputs

| Condition Indicator | Unit | Service Account Use | Conversion/Notes |
|-------------------|------|-------------------|------------------|
| Fish biomass | kg/ha | Fisheries Nursery (direct); Provisioning (baseline) | Multiply by accounting area extent (ha) to get total kg/yr |
| Fish abundance | ind/ha | Fisheries Nursery (implicit in biomass); Provisioning (composition check) | Calculate from size-class counts; verify species mix matches landings |
| Fish richness | count | Recreation (attractiveness proxy); Biodiversity baseline | Higher richness → higher tourist satisfaction (empirical assumption) |
| Trophic composition (% biomass) | % | Provisioning (value stratification); Ecosystem resilience | Herbivore dominance → algal control → coral recovery support |
| COTS density | ind/ha | Recreation (negative valuation); Coral damage risk | High COTS → low tourism attractiveness; CI inversion reflects this |
| Sea urchin density | ind/m² | Functional redundancy (implicit); Herbivory pressure | Complements fish herbivory; high urchin + high fish herbivore = strong algal control |
| Macroinvertebrate richness | count | Ecosystem complexity (implicit) | Supports overall reef integrity narrative; not directly monetized |

---

## References

### Companion Skills in Accounting Bot Repository
- `skill_condition_biotic_coral.md` — Coral cover, bleaching, benthic condition
- `skill_services_provisioning.md` — Wild fish provisioning; wood provisioning
- `skill_services_regulating.md` — Fisheries nursery; carbon sequestration; coastal protection; sediment nourishment
- `skill_services_cultural.md` — Coral reef recreation; mangrove recreation; seagrass gleaning

### SEEA EA Framework
- UN (2021). *System of Environmental-Economic Accounting — Ecosystem Accounting*. New York: United Nations.
- SEEA EA Chapter 6: Ecosystem Service Accounts

### Madagascar-Specific References
- MPRH (Ministry of Blue Economy, Madagascar) — National fisheries statistics
- IHSM (Institut Halieutique et des Sciences Marines), University of Toliara — Benthic habitat data
- WCS Madagascar — Coral reef monitoring programme (Western Indian Ocean biogeographic context)

---

**Next Review:** After Phase 1 data acquisition (market prices)
**Owner:** AFRICA — accounts project
**Last updated:** 2026-03-04
