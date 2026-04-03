# Participant Handout: Compiling Mangrove Ecosystem Accounts from Remote Sensing

## Mozambique SEEA EA Workshop -- Save Estuary and Morrumbene Estuary

---

## Normalisation Formula

### Linear Rescaling (poor-to-pristine)

```
CI = clamp((observed - poor) / (pristine - poor), 0, 1)

If result < 0: set CI = 0
If result > 1: set CI = 1
```

### Composite Condition Index

```
CCI = mean(CI_height, CI_cover, CI_agbd, CI_pai)
```

### Area-Weighted Site Aggregation

```
CCI_site = sum(CCI_i x area_ha_i) / sum(area_ha_i)
```

### Carbon Stock

```
Total carbon (Mg C) = carbon_density (Mg C/ha) x area (ha)
CO2 equivalent (Mg CO2) = total carbon x 3.664
```

---

## Reference Levels

| Indicator | GEDI Variable | Unit | Poor (CI=0) | Pristine (CI=1) | Confidence |
|-----------|--------------|------|-------------|-----------------|------------|
| Canopy height | mean_rh100 | m | 3 | 15 | HIGH |
| Canopy cover | mean_L2B_cover | Fraction (0-1) | 0.30 | 0.70 | LOW |
| Above-ground biomass density | mean_L4A_agbd | Mg/ha | 5 | 100 | MEDIUM |
| Plant Area Index | mean_L2B_pai | Unitless | 0.05 | 2.0 | LOW |
| Carbon stock | mean_L4A_carbono_mgha | Mg C/ha | -- | -- | -- (not normalised) |

---

## GEDI Confidence Ratings

| GEDI Footprints (Point_Count) | Confidence | Use |
|-------------------------------|------------|-----|
| >= 20 | HIGH | Reliable for baseline and trend analysis |
| 6-19 | MODERATE | Acceptable for baseline; flag in outputs |
| <= 5 | LOW | Descriptive only; exclude from trend analysis |

---

## Exercise 1: Condition Account from Raw GEDI Data (30 minutes)

**Task:** Calculate the condition index for one Save asset and one Morrumbene asset.

**Your Save asset:** _________________________ (Asset ID: _____)

| Indicator | Observed | Poor | Pristine | CI = (obs - poor)/(prist - poor) | Clamped CI |
|-----------|----------|------|----------|----------------------------------|-----------|
| Canopy height (m) | | 3 | 15 | | |
| Canopy cover (fraction) | | 0.30 | 0.70 | | |
| AGBD (Mg/ha) | | 5 | 100 | | |
| PAI | | 0.05 | 2.0 | | |
| **Composite CCI** | | | | | |

Point_Count: _________ Confidence rating: _________

**Your Morrumbene asset:** _________________________ (Asset ID: _____)

| Indicator | Observed | Poor | Pristine | CI = (obs - poor)/(prist - poor) | Clamped CI |
|-----------|----------|------|----------|----------------------------------|-----------|
| Canopy height (m) | | 3 | 15 | | |
| Canopy cover (fraction) | | 0.30 | 0.70 | | |
| AGBD (Mg/ha) | | 5 | 100 | | |
| PAI | | 0.05 | 2.0 | | |
| **Composite CCI** | | | | | |

Point_Count: _________ Confidence rating: _________

**Carbon stock for each asset:**

| Asset | Carbon density (Mg C/ha) | Area (ha) | Total carbon (Mg C) | CO2 eq (Mg CO2) |
|-------|--------------------------|-----------|---------------------|------------------|
| Save asset | | | | |
| Morrumbene asset | | | | |

**Interpretation questions:**

a. Which asset has the higher composite CCI? Is the comparison fair given the confidence ratings?

b. Did any indicator produce a negative value before clamping? What does this mean ecologically?

c. Which single indicator contributes most to the composite CCI at each asset?

---

## Exercise 2: Area-Weighted Aggregation (20 minutes)

**Task:** Calculate the site-level CCI for one site (Save or Morrumbene).

**Your site:** _________________________

| Asset | Area (ha) | CCI | CCI x Area |
|-------|-----------|-----|------------|
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| **Total** | | | |

**CCI_site = Total (CCI x Area) / Total Area = _________ / _________ = _________**

**Site total carbon:**

| Asset | Total carbon (Mg C) |
|-------|---------------------|
| | |
| | |
| | |
| **Site total** | |
| **CO2 equivalent** | |

**Interpretation questions:**

a. How much does the area-weighted CCI differ from a simple (unweighted) mean of asset CCIs?

b. Which asset has the most influence on the site-level CCI? Why?

---

## Exercise 3: Cross-Site and Cross-Country Comparison (20 minutes)

**Part A: Save vs. Morrumbene**

| Metric | Save | Morrumbene |
|--------|------|-----------|
| Composite CCI (area-weighted) | | |
| Total carbon (Mg C) | | |
| Average GEDI confidence | | |
| Number of assets | | |

Which site is in better condition? _________________________

Which site has more reliable data? _________________________

**Part B: Mozambique vs. Kenya**

Kenya mangrove composite CI = 0.397 (field-based: 5 indicators)
Mozambique composite CCI = _________ (GEDI-based: 4 indicators)

Can these be directly compared? (Circle one): YES / NO / PARTIALLY

Explain your answer:

_______________________________________________________________

_______________________________________________________________

What would you need to make the comparison fair?

_______________________________________________________________

---

## SEEA EA Condition Account Table Template

Fill in for your assigned site:

| Ecosystem | Site | Asset | Area (ha) | CI Height | CI Cover | CI AGBD | CI PAI | CCI | Confidence | Year |
|-----------|------|-------|-----------|-----------|----------|---------|--------|-----|------------|------|
| MFT1.2 | | | | | | | | | | 2025 |
| MFT1.2 | | | | | | | | | | 2025 |
| MFT1.2 | | | | | | | | | | 2025 |

---

## Key Data Quality Reminders

1. All condition and carbon values are **PROVISIONAL** pending field validation
2. Canopy cover CI = 0 at both sites; may be GEDI measurement artefact
3. AGBD standard errors are ~126-129% of the mean; report carbon with uncertainty bounds
4. Save Assets 2 and 4 have only 1-2 GEDI footprints; do not use for trend analysis
5. Carbon estimates use asset polygon areas, not full GMW 2020 estuary extents

---

## Key Contacts

| Role | Contact |
|------|---------|
| Data analysis | Project team |
| Field validation coordination | TBD (Mar-May 2026) |
| GMW 2020 mangrove extent | globalmangrovewatch.org |
| GEDI data access | lpdaac.usgs.gov |

---

*Workshop materials for: Compiling Mangrove Ecosystem Accounts from Remote Sensing*
*Date: _______________*
*Participant name: _______________*
