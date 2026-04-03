# Participant Handout: Compiling Coral Reef Condition Accounts

## Madagascar SEEA EA Workshop -- SW Madagascar Barrier Reef

---

## Normalisation Formulas

### Type 1 -- Standard (higher is better)
```
CI = min(measured / reference, 1.0)
```
Used for: fish biomass (ref: 1,150 kg/ha), species richness (ref: max observed)

### Type 2 -- Inverted (higher is worse)
```
CI = max(1 - measured / reference, 0.0)
```
Used for: COTS density (ref: 15 ind/ha outbreak threshold)

### Composite
```
Composite CI = mean(CI_biomass, CI_richness, CI_COTS)
```

---

## Reference Levels

| Indicator | Reference | Formula | Confidence |
|-----------|-----------|---------|------------|
| Fish biomass | 1,150 kg/ha | Standard | HIGH |
| Species richness | 103 species (max observed) | Standard | MEDIUM |
| COTS density | 15 ind/ha (outbreak) | Inverted | MEDIUM |
| Sea urchin density | 1.75 ind/m2 (provisional) | Optimum range | LOW |

---

## Fish Biomass Quick Reference

```
W = a x L^b  (grams per fish)

Size class midpoints:
    5-10 cm  = 7.5 cm
    10-20 cm = 15 cm
    20-30 cm = 25 cm
    30-40 cm = 35 cm
    40-50 cm = 45 cm
    50-60 cm = 55 cm

Per-ha conversion:
    biomass_kg_ha = (sum of biomass_g) / 1000 / (transect_area_m2 / 10000)
    If transect = 250 m2: divide by 0.025 ha
```

---

## Exercise 1: Site-Level Condition Account (35 minutes)

Choose 3 sites from MDG_fish_invert_site_condition.csv.

**Site 1:** _________________________

| Indicator | Measured | Reference | Formula | CI |
|-----------|----------|-----------|---------|-----|
| Fish biomass (kg/ha) | | 1,150 | Standard | |
| Species richness | | 103 | Standard | |
| COTS density (ind/ha) | | 15 | Inverted | |
| **Composite** | | | Mean | |

**Site 2:** _________________________

| Indicator | Measured | Reference | Formula | CI |
|-----------|----------|-----------|---------|-----|
| Fish biomass (kg/ha) | | 1,150 | Standard | |
| Species richness | | 103 | Standard | |
| COTS density (ind/ha) | | 15 | Inverted | |
| **Composite** | | | Mean | |

**Site 3:** _________________________

| Indicator | Measured | Reference | Formula | CI |
|-----------|----------|-----------|---------|-----|
| Fish biomass (kg/ha) | | 1,150 | Standard | |
| Species richness | | 103 | Standard | |
| COTS density (ind/ha) | | 15 | Inverted | |
| **Composite** | | | Mean | |

**Questions:**
a. Which site has the highest composite CI?
b. Which individual indicator shows the most variation across your 3 sites?
c. If the transect area were 100 m2 instead of the confirmed 250 m2, how would the biomass CI change?

---

## Exercise 2: Accounting-Area Aggregation (20 minutes)

Using all 2025 sites, calculate the accounting-area mean for each indicator, then the CI.

| Indicator | Accounting-area mean | Reference | CI |
|-----------|---------------------|-----------|-----|
| Fish biomass (kg/ha) | | 1,150 | |
| Species richness | | 103 | |
| COTS density (ind/ha) | | 15 | |
| **Composite** | | | |

---

## Exercise 3: Trophic Composition (15 minutes)

Pick one site from MDG_fish_invert_site_fg_condition.csv.

**Site:** _________________________

| Functional Group | Biomass (kg/ha) | % of total |
|------------------|----------------|-----------|
| Herbivore | | |
| Carnivore | | |
| Planktivore | | |
| Corallivore | | |
| Omnivore | | |
| Other | | |
| **Total** | | 100% |

Is the trophic composition balanced? Does herbivore dominance suggest good algal control?

---

## SEEA EA Condition Account Table Template

| Ecosystem | Indicator | Year | Measured | Unit | CI | Reference | Confidence | Note |
|-----------|-----------|------|----------|------|-----|-----------|------------|------|
| M1.3 | | | | | | | | |
| M1.3 | | | | | | | | |
| M1.3 | | | | | | | | |

---

*Workshop materials: Compiling Coral Reef Condition Accounts for SW Madagascar*
*Date: _______________ | Participant: _______________*
