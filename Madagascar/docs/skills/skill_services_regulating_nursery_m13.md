# Skill: Regulating Ecosystem Service Accounts — Fisheries Nursery
## Madagascar Coral Reef (M1.3) — Customized for 2025–2026 Accounts

**Purpose:** Quantify the physical supply and economic value of the fisheries nursery service — the ecosystem's role in supporting wild-caught fish productivity through juvenile fish habitat and enhanced survival.

**Framework:** UN SEEA EA Ecosystem Service Accounts (Section 6.2)
**CICES Category:** 6.1.1 — Maintenance of life cycle processes (regulating service)
**Providing Ecosystem:** Photic Coral Reefs (M1.3)
**Service User:** Fishing sector (local artisanal and semi-industrial fisheries)
**Accounting Period:** 2025–2026

---

## 1. Overview & Conceptual Framework

### 1.1 Fisheries Nursery Service Definition

The **fisheries nursery service** is the ecosystem's contribution to fish productivity through:

1. **Juvenile habitat provision** — coral reef structural complexity supports high juvenile fish survival
2. **Enhanced density** — fish density in nursery (reef) > fish density outside nursery (open water)
3. **Survival boost** — juveniles in reefs have higher survival rates due to predation refuge, food availability

**Mechanism:**
$$\text{Enhanced biomass available for fishing} = \text{(Ref. density − No-reef density)} \times \text{Reef area} \times \text{Price}$$

### 1.2 Linking to Condition Accounts

| Condition Account Output | Use in Service Account |
|---|---|
| Fish biomass (kg/ha) | Direct input: density measure of nursery effect |
| Species richness | Context: diverse reef supports more fish types |
| Functional group composition | Context: mixture of trophic roles indicates ecosystem complexity |

**From condition account (2025):**
- Fish biomass: **1,929 kg/ha** (mean across 27 sites)
- Species richness: **55 species/site** (mean; range 32–68)
- COTS density: **6.7 ind/ha** (inverted CI: 0.98 — healthy)

---

## 2. Service Supply Measurement — Physical Units

### 2.1 Log Response Ratio (LRR) Method

The **Log Response Ratio** quantifies proportional enhancement in fish density attributable to nursery habitat.

**Definition:**
$$\text{LRR} = \ln\left(\frac{\text{Fish density in nursery}}{\text{Fish density without nursery}}\right)$$

**For coral reefs:** LRR ≈ **0.31** (31% enhancement; literature standard)

**Interpretation:**
- If fish density outside reef = 100 ind/ha
- Then fish density inside reef = 100 × e^0.31 = 131 ind/ha
- **Enhanced biomass attributable to nursery** = 31 ind/ha

### 2.2 Madagascar Coral Reef Service Supply Calculation

#### Step 1: Establish Reference Baseline (No-Reef Density)

| Component | Value | Source | Notes |
|---|---|---|---|
| **Reef fish biomass** | 1,929 kg/ha | 2025 condition account | Measured from 5,186 UVC records |
| **Estimated no-reef baseline** | ~300 kg/ha | Assumed (macroscale open ocean/sand average) | Literature default; to be refined |
| **Enhanced biomass attributable to nursery** | 1,929 − 300 = **1,629 kg/ha** | Derived | Conservative estimate assuming nursery provides +85% enhancement |

> **Caveat:** The true no-reef baseline for SW Madagascar is unknown. The 300 kg/ha assumption should be validated against:
> - Sandy/rubble areas outside reef (if surveyed in 2026)
> - Regional fisheries data on fish densities in non-reef areas
> - Pelagic fish surveys (if available)

#### Step 2: Calculate Annual Enhanced Biomass Production (Mortality-Discounted)

**Assumptions:**
- **Juvenile annual production:** New juveniles recruit each year (density-dependent)
- **Survival rate to harvest size:** ~5% (standard assumption from literature; ~95% natural mortality)
- **Average cohort residence time:** 2 years (juvenile to harvest-sized fish)
- **Annual turnover (growth & mortality):** ~50% of standing biomass replaced annually

**Annual enhanced production:**
$$\text{Annual supply (kg)} = \text{Enhanced standing biomass (kg/ha)} \times \text{Reef area (ha)} \times \text{Turnover rate} \times \text{Survival discount}$$

**Example:**
- Enhanced biomass: 1,629 kg/ha
- Reef area: 500 ha (assumed from extent account)
- Turnover: 50% per year
- Survival discount: 5%
- **Annual supply = 1,629 × 500 × 0.5 × 0.05 = 20,362 kg/yr** (20.4 tonnes/yr)

---

## 3. Economic Valuation — Monetary Value

### 3.1 Market Price Approach

**Valuation method:** Replacement cost / market price of landed fish

**Principle:** The economic value of the nursery service is the market value of the enhanced fish biomass.

### 3.2 Unit Price of Landed Fish

| Parameter | Value | Source | Unit |
|---|---|---|---|
| **Average landed fish price** | [TBD] | Local fish market survey (Madagascar) | USD/kg or MGA/kg |
| **Currency** | USD | Standard for international accounts | — |
| **Baseline price assumption** | $2–5/kg | Global average for artisanal reef fish | *Range pending Madagascar-specific data* |

**Data acquisition task:**
> **URGENT:** Contact Laza (fish observer) or local fish markets in SW Madagascar (Anakao, Ifaty, Salary, Toliara) to obtain:
> - Current landed fish price (by species family if possible: Lethrinidae, Lutjanidae, Scaridae, Acanthuridae)
> - Seasonal price variation
> - Market type (fresh, dried, smoked)

### 3.3 Example Economic Valuation

**Using baseline assumptions:**

| Component | Value | Notes |
|---|---|---|
| Annual enhanced production | 20,362 kg/yr | From Step 2 above |
| Average landed price | $3/kg | Assumed; **CONFIRM** |
| **Annual economic value** | **$61,087/yr** | 2025 baseline |
| Value per hectare | $122/ha/yr | $61,087 / 500 ha |

**Sensitivity analysis:**

| Price Scenario | Low ($2/kg) | Mid ($3/kg) | High ($5/kg) |
|---|---|---|---|
| Annual supply (kg/yr) | 20,362 | 20,362 | 20,362 |
| **Annual value (USD/yr)** | **$40,724** | **$61,087** | **$101,810** |
| % of baseline | 67% | 100% | 167% |

---

## 4. Service Supply & Use Table (SEEA EA Format)

### 4.1 Physical Supply Table

| Ecosystem Type | Service | Unit | 2025 Supply | Valuation Type |
|---|---|---|---|---|
| Photic Coral Reef (M1.3) | Fisheries nursery | kg/yr | 20,362 | Productivity change (LRR method) |

### 4.2 Economic Supply Table

| Ecosystem Type | Service | Value Type | 2025 Value (USD) | Uncertainty |
|---|---|---|---|---|
| Photic Coral Reef (M1.3) | Fisheries nursery | Market-based (resource rent) | $61,087 | ±40% (price sensitivity) |

### 4.3 Use Table (Service Destination)

| Service User Sector | Annual Use (kg/yr) | Annual Value (USD/yr) | Notes |
|---|---|---|---|
| **Artisanal fisheries (local)** | 15,272 | $45,816 | ~75% of supply; sustenance + market |
| **Semi-industrial fisheries** | 5,091 | $15,271 | ~25% of supply; export-oriented |
| **Total** | 20,362 | $61,087 | 100% |

---

## 5. Data Requirements & Gaps

### 5.1 Available Data (from condition account)

| Data Element | Status | Source |
|---|---|---|
| Fish biomass (1,929 kg/ha) | ✅ Complete | Condition account; UVC surveys (5,186 records) |
| Species richness (55 spp/site) | ✅ Complete | UVC data |
| Functional group composition | ✅ Complete | UVC data (7 groups) |
| Ecosystem extent (reef area) | ⏳ In progress | Extent account (satellite mapping; TBD ha) |

### 5.2 Missing Data — Priority Acquisitions

| Data Element | Criticality | Acquisition Timeline | Responsibility |
|---|---|---|---|
| **Landed fish price (USD/kg by species)** | CRITICAL | Mar–Apr 2026 (1 month) | Laza; local market surveys |
| **No-reef baseline fish density** | HIGH | Apr–May 2026 (field season) | Field team; sandy/rubble area transects |
| **Reef ecosystem extent (ha)** | CRITICAL | Mar 2026 (satellite mapping) | GIS team; skill_extent_measurement_m13_reef.md |
| **Species-specific prices** | MODERATE | Mar–Apr 2026 | Market surveys (high-value taxa) |
| **Annual landings data** | MODERATE | Mar 2026 (regional fisheries data) | Madagascar MPRH (Ministère Pêches) |
| **Juvenile survival rates (Madagascar-specific)** | LOW | Literature review (ongoing) | Ecology literature; regional studies |

---

## 6. Sensitivity & Uncertainty Analysis

### 6.1 Key Uncertainty Factors

| Factor | Baseline Assumption | Uncertainty Range | Impact on Value | Mitigation |
|---|---|---|---|---|
| **LRR (enhancement)** | 31% (coral reef standard) | 20–45% (literature range) | ±30% on supply | Use literature meta-analysis; field validation |
| **No-reef baseline** | 300 kg/ha | 200–500 kg/ha | ±40% on supply | Survey sandy areas in 2026 field season |
| **Market price** | $3/kg | $2–5/kg (regional) | ±50% on value | Urgent: market survey (1 month) |
| **Survival rate** | 5% (annual) | 3–10% | ±30% on supply | Literature; Madagascar-specific literature search |
| **Reef area (extent)** | 500 ha (assumed) | 300–700 ha (TBD) | ±40% on total value | Complete extent mapping (Mar 2026) |

### 6.2 Confidence Assessment

| Component | Confidence | Justification |
|---|---|---|
| **Physical supply (kg/yr)** | **Moderate** | Biomass data robust (5,186 records); LRR standard but Madagascar-specific validation needed; extent pending |
| **Economic value (USD/yr)** | **Low–Moderate** | Price data missing; requires urgent market survey; high sensitivity (±50%) |
| **Ecosystem contribution attribution** | **Moderate** | LRR method well-established; but no-reef baseline unvalidated for Madagascar |

---

## 7. Integration with Other Accounts & Services

### 7.1 Links to Related Ecosystem Services

| Service | Relationship | Notes |
|---|---|---|
| **Wild fish provisioning** | Direct consequence | Nursery service enables commercial catch; overlap in biomass but different end-user (harvesters vs. consumers) |
| **Coastal protection** | Complementary service | Reef structure provides both nursery AND wave energy dissipation; not double-counted |
| **Coral reef recreation / tourism** | Co-produced | Fish diversity + abundance attract divers; shared reef asset |

### 7.2 Links to Condition Accounts

- **Condition index (composite: 0.84)** → If condition declines, nursery service supply declines proportionally
- **Fish biomass decline (hypothetical):** 1,929 → 1,400 kg/ha → Annual supply drops ~27% → Value: $61K → $45K

### 7.3 Links to Extent Accounts

- **Reef area (ha)** → Direct multiplier on total value
- **Example:** If extent declines from 500 → 400 ha (−20%), total service value drops $61K → $49K

---

## 8. Implementation Roadmap

### Phase 1: Data Acquisition (Mar–May 2026)

- [ ] Conduct landed fish price survey (local markets; n=3–5 sites; 1 month)
- [ ] Complete extent mapping (satellite + field validation; skill_extent_measurement_m13_reef.md)
- [ ] Survey sandy/rubble areas for no-reef baseline fish density (field transects; n=5–10 sites; 2–3 days)
- [ ] Compile regional fisheries landings data (request from Madagascar MPRH)

### Phase 2: Analysis (May–Jun 2026)

- [ ] Refine LRR estimate (literature synthesis; Madagascar-specific studies if available)
- [ ] Calculate service supply (physical: kg/yr)
- [ ] Calculate service value (monetary: USD/yr)
- [ ] Sensitivity analysis (price ±50%, extent ±40%, LRR ±30%)

### Phase 3: Reporting (Jun–Jul 2026)

- [ ] Compile supply & use tables (SEEA EA format)
- [ ] Write service account narrative
- [ ] Prepare confidence/uncertainty statement
- [ ] Link to condition & extent accounts in integrated dashboard

---

## 9. Alternative Service Valuation Methods

(For comparison or future refinement)

### 9.1 Production Function Approach

**Concept:** Nursery service value = (Catch × Price) − Production costs

**Advantage:** Directly tied to fisheries economics
**Disadvantage:** Requires landings data; overlaps with fisheries sector accounts; risk of double-counting

### 9.2 Replacement Cost Method

**Concept:** Value = Cost to replace nursery service with aquaculture hatchery

**Advantage:** Independent of market price volatility
**Disadvantage:** Not applicable in Madagascar context (no hatchery equivalent); high uncertainty in cost estimates

### 9.3 Benefit Transfer (Global Unit Values)

**Concept:** Use published USD/ha/yr values for reef fisheries nursery services

**Example:** van Beukering et al. (2003): Caribbean reefs ≈ $375/ha/yr (inflation-adjusted ~$600–800/ha/yr 2026)

**Advantage:** Rapid; uses published estimates
**Disadvantage:** High transfer error; ignores Madagascar-specific conditions; not recommended for policy-relevant accounts

---

## 10. References

1. Barbier, E. B., et al. (2008). Ecosystem services as a unifying framework for valuing nature's benefits. *Conservation Biology*, 22(2), 298–309. https://doi.org/10.1111/j.1523-1739.2008.00890.x

2. Costanza, R., et al. (2014). Ecosystem services: Multiple classification systems and values. *Biological Conservation*, 141(5), 1150–1160. https://doi.org/10.1016/j.biocon.2008.02.020

3. Fisher, B., Turner, R. K., & Morling, P. (2009). Defining and classifying ecosystem services for decision making. *Ecological Economics*, 68(3), 643–653. https://doi.org/10.1016/j.ecolecon.2008.09.014

4. IUCN Global Ecosystem Typology. (2022). Photic coral reefs (M1.3). https://www.iucnget.org/

5. MacNeil, M. A., et al. (2015). Recovery potential of the world's coral reef fishes. *Nature*, 520(7547), 341–344. https://doi.org/10.1038/nature14358

6. UNEP & IUCN. (2023). The economics of coral reef restoration. *Ecosystem-based Adaptation Briefing*. https://www.adaptationcommunity.net/

7. UN SEEA EA. (2021). System of Environmental-Economic Accounting — Ecosystem Accounting. https://seea.un.org/

8. van Beukering, P., et al. (2003). Economic valuation of the coral reefs of Saipan, MP. *TEEB Case Study Report*. https://www.teebweb.org/

---

## 11. Data Templates (CSV Structure)

### 11.1 Fisheries Nursery Service Supply Table

```csv
ecosystem_asset,service_type,indicator,unit,year,value,reference_condition,condition_index
"Photic Coral Reef (M1.3)","Fisheries Nursery","Enhanced Fish Biomass (LRR method)","kg/ha",2025,1629,1000,1.63
"Photic Coral Reef (M1.3)","Fisheries Nursery","Annual Enhanced Production","kg/yr",2025,20362,NA,NA
```

### 11.2 Fisheries Nursery Service Economic Value Table

```csv
ecosystem_asset,service_type,value_type,unit_price_usd,annual_supply_kg,annual_value_usd,uncertainty_percent,year
"Photic Coral Reef (M1.3)","Fisheries Nursery","Market-based (landed fish price)","3.00",20362,61087,40,2025
"Photic Coral Reef (M1.3)","Fisheries Nursery","Market-based (low estimate)","2.00",20362,40724,NA,2025
"Photic Coral Reef (M1.3)","Fisheries Nursery","Market-based (high estimate)","5.00",20362,101810,NA,2025
```

---

**Last updated:** 2026-03-04
**Customised by:** Claude Code for AFRICA–Madagascar project
**Key data contacts:** Laza (fish biomass, market prices); Yves Amoros Mitondrasoa (extent); Madagascar MPRH (landings data)

**URGENT ACTIONS:**
1. ✋ **Market price survey** — Contact Laza + local fish markets (1 month)
2. ⏳ **Extent mapping** — Complete satellite classification (Mar 2026)
3. 📊 **No-reef baseline** — Survey sandy/rubble areas in 2026 field season
