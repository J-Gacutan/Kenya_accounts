# Participant Handout: Compiling Coastal Ecosystem Condition Accounts

## Kenya SEEA EA Workshop -- Kilifi County

---

## Normalisation Formulas

### Type 1 -- Standard (higher is better)

```
Condition Index = min(measured value / reference level, 1.0)
```

Use for: fish biomass, coral cover, % healthy colonies, recruitment density, seagrass cover, shoot density, species richness

### Type 2 -- Inverted (higher is worse)

```
Condition Index = max(1 - measured value / reference level, 0.0)
```

Use for: bleaching %, disease %, COTS density, macroalgae %

### Type 3 -- Linear rescaling (poor-to-pristine)

```
Condition Index = (value - poor) / (pristine - poor), clamped to [0, 1]
```

Use for: mangrove stem density, DBH, height, canopy cover

### Composite Index

```
Composite CI = mean of all individual CIs (equal weight)
```

---

## Reference Levels

### Coral Reef (M1.3)

| Indicator | Reference level | Formula type | Confidence |
|-----------|----------------|-------------|------------|
| Fish biomass | 1,150 kg/ha | Standard | HIGH |
| Fish species richness | Max observed in dataset | Standard | MEDIUM |
| Live coral cover | 30% | Standard | MEDIUM |
| % Healthy colonies | 95% | Standard | MEDIUM |
| Bleached colonies | 5% | Inverted | MEDIUM |
| Diseased colonies | 2% | Inverted | MEDIUM |
| Coral recruitment | 1.0 recruits/m2 | Standard | LOW-MEDIUM |
| COTS density | 15 ind/ha | Inverted | MEDIUM |
| Sea urchin density | 1.75 ind/m2 (optimum) | Optimum range | LOW |

### Mangrove (MFT1.2)

| Indicator | Poor | Pristine | Formula type | Confidence |
|-----------|------|----------|-------------|------------|
| Stem density (trees/ha) | 200 | 3,000 | Linear rescaling | MEDIUM |
| Mean DBH (cm) | 3 | 20 | Linear rescaling | MEDIUM |
| Mean canopy height (m) | 2 | 12 | Linear rescaling | MEDIUM |
| Canopy cover (%) | 30 | 90 | Linear rescaling | LOW |
| Tree quality index | -- | -- | Direct (already 0-1) | LOW |

### Seagrass (M1.1)

| Indicator | Reference level | Formula type | Confidence |
|-----------|----------------|-------------|------------|
| Total seagrass cover | 60% | Standard | MEDIUM |
| Thalassia hemprichii density | 800 shoots/m2 | Standard | LOW-MEDIUM |
| Cymodocea serrulata density | 500 shoots/m2 | Standard | LOW |
| Halodule uninervis density | 1,000 shoots/m2 | Standard | LOW |
| Enhalus acoroides density | 100 shoots/m2 | Standard | LOW |
| Species richness | Max observed (in-sample) | Standard | LOW |
| Canopy height | Max observed per species | Standard | LOW |

---

## Exercise 1: Coral Reef Condition Account (40 minutes)

**Task:** Build a condition account for one coral reef site using the pre-loaded data in KEN_site_condition_all_indicators.csv.

**Instructions:**

1. Choose a site from the dataset (your facilitator will assign one).
2. For each of the 6 core indicators listed below, find the measured value for Nov 2024 (opening) and Jul 2025 (closing).
3. Apply the correct normalisation formula using the reference levels above.
4. Record your CI values in the table below.
5. Calculate the composite CI (unweighted mean of all available indicators).
6. Calculate the change (Closing CI - Opening CI).

**Your site:** ________________________________

| Indicator | Nov 2024 measured | Reference | Formula type | CI (Nov 2024) | Jul 2025 measured | CI (Jul 2025) | Change |
|-----------|-------------------|-----------|-------------|----------------|-------------------|---------------|--------|
| Live coral cover | | 30% | Standard | | | | |
| Coral health (% healthy) | | 95% | Standard | | | | |
| Coral recruitment | | 1.0 rec/m2 | Standard | | | | |
| Coral bleaching | | 5% | Inverted | | | | |
| Fish biomass | | 1,150 kg/ha | Standard | | | | |
| Fish species richness | | max obs | Standard | | | | |
| **Composite** | | | **Mean** | | | | |

**Interpretation questions:**

a. Which indicator has the highest CI at your site? Which has the lowest?

b. Is your site improving, stable, or declining? (Compare change to SE threshold)

c. Does your site fall within a protected area? If yes, how does its composite CI compare to nearby unprotected sites?

d. Note: Jul 2025 data was collected ~15 months after the 2023-2024 bleaching event. How does this context affect your interpretation of the change values?

---

## Exercise 2: Mangrove Condition Account (25 minutes)

**Task:** Calculate condition indices for two mangrove sites -- one protected (Mida Creek MNR), one unprotected.

**Instructions:**

1. From KEN_mangrove_condition_by_site.csv, select one Mida Creek MNR site and one unprotected site.
2. For each site, apply the linear rescaling formula to all 5 indicators.
3. Record your CI values. Tree quality index is already 0-1 (use directly).
4. Calculate the composite CI.
5. Compare the two sites.

**Protected site:** _________________________ (Mida Creek MNR)

| Indicator | Measured | Poor | Pristine | CI |
|-----------|----------|------|----------|-----|
| Stem density (trees/ha) | | 200 | 3,000 | |
| Mean DBH (cm) | | 3 | 20 | |
| Mean height (m) | | 2 | 12 | |
| Canopy cover (%) | | 30 | 90 | |
| Tree quality index | | -- | -- | |
| **Composite** | | | | |

**Unprotected site:** _________________________

| Indicator | Measured | Poor | Pristine | CI |
|-----------|----------|------|----------|-----|
| Stem density (trees/ha) | | 200 | 3,000 | |
| Mean DBH (cm) | | 3 | 20 | |
| Mean height (m) | | 2 | 12 | |
| Canopy cover (%) | | 30 | 90 | |
| Tree quality index | | -- | -- | |
| **Composite** | | | | |

**Interpretation questions:**

a. Which site has the higher composite CI?

b. For which individual indicator is the difference largest?

c. The protected site may have lower stem density but higher DBH. What does this combination suggest about the forest structure?

---

## Exercise 3: Seagrass and Cross-Ecosystem Comparison (20 minutes)

**Task:** Explore the seagrass condition data and compare with coral reef results.

**Part A: Seagrass**

Using KEN_seagrass_cover_site.csv:

1. Find the site with the highest total seagrass cover (%).
2. Calculate its cover CI: min(cover / 60, 1.0) = ___________
3. Find the site with the lowest species richness.
4. The maximum richness observed across all sites is: ___________
5. Calculate the richness CI for that site: richness / max = ___________

**Part B: Cross-ecosystem at Ngomeni**

Look up these values from the account tables:

| Ecosystem | Composite CI | Confidence |
|-----------|-------------|------------|
| Coral reef (from KEN_SEEA_EA_condition_account_final.csv) | | |
| Seagrass (from KEN_seea_condition_account_seagrass.csv) | | |

**Discussion questions:**

a. Is Ngomeni in better condition as a reef or as a seagrass meadow?

b. Can these two CIs be directly compared, given their different confidence levels?

c. If you were advising the Kilifi County government on where to focus conservation investment, what would you recommend based on the accounting results across all three ecosystems?

---

## Aggregation and Change Detection

### Aggregation formula

```
Mean CI = sum(site CIs) / N
SE = SD(site CIs) / sqrt(N)
```

### Change interpretation

```
Absolute change = Closing CI - Opening CI
SE threshold = mean(Opening SE, Closing SE)

If |change| < SE threshold  -->  Stable
If change > SE threshold    -->  Improving
If change < -SE threshold   -->  Declining
```

---

## SEEA EA Condition Account Table Template

Fill in for your assigned ecosystem and geographic unit:

| Ecosystem type | Indicator | Period | Measured value | Unit | CI (0-1) | Reference level | Confidence | Note |
|----------------|-----------|--------|----------------|------|----------|----------------|------------|------|
| | | | | | | | | |
| | | | | | | | | |
| | | | | | | | | |
| | | | | | | | | |
| | | | | | | | | |
| | | | | | | | | |

---

## Key Contacts

| Role | Name | Affiliation |
|------|------|-------------|
| Coral reef surveys | Dr. Juliet Karisa | Pwani University |
| Data coordination | Dr. Pascal Thoya | Pwani University |
| Fish UVC (CCVA) | KMFRI Mombasa | Kenya Marine and Fisheries Research Institute |
| Coral surveys (COMRED) | COMRED Oceans | |
| Fisheries data | Kenya Fisheries Service | KeFS Kilifi County |

---

*Workshop materials for: Compiling Coastal Ecosystem Condition Accounts for Kenya*
*Date: _______________*
*Participant name: _______________*
