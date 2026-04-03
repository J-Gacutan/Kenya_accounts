# Compiling Coastal Ecosystem Accounts: Workshop Facilitator Guide

## Kenya SEEA EA -- Coral Reef, Mangrove, and Seagrass Condition Accounts

---

## Slide 1: Title

Compiling Coastal Ecosystem Condition Accounts for Kenya

A practical workshop on turning field survey data into SEEA EA condition account tables -- covering coral reefs, mangroves, and seagrass meadows in Kilifi County.

Speaker notes: Welcome participants. This session teaches the steps between raw indicator values (produced by R analysis scripts from multi-programme field data) and the final condition account tables. By the end, participants will be able to compile a condition account for any ecosystem type, protected area, or subregion. The Kenya pilot is distinctive because it covers three ecosystem types simultaneously, enabling cross-ecosystem comparison and integrated seascape analysis.

---

## Slide 2: What is a condition account?

A condition account records the state of an ecosystem at one or more points in time.

For each indicator:

1. Measure a value at the opening period (e.g., Nov 2024) and the closing period (e.g., Jul 2025).
2. Compare each value against a reference level that represents a healthy ecosystem.
3. The ratio gives a condition index between 0 and 1.
4. The change between periods tells us if the ecosystem is improving, stable, or declining.

Speaker notes: Emphasize that the condition index is relative to the reference level, not absolute. A CI of 0.30 for fish biomass means the reef has 30% of the healthy biomass target (1,150 kg/ha from McClanahan et al. 2016). This makes different indicators -- fish biomass in kg/ha, coral cover in %, mangrove stem density in trees/ha -- comparable on the same 0 to 1 scale. This comparability is a core strength of the SEEA EA framework.

---

## Slide 3: The Kenya pilot -- three ecosystems

| Ecosystem | IUCN GET | Indicators | Periods |
|-----------|----------|------------|---------|
| Coral reef (M1.3) | Photic Coral Reefs | Fish biomass, coral cover, coral health, bleaching, recruitment | Nov 2024 + Jul 2025 |
| Mangrove (MFT1.2) | Intertidal Forests | Stem density, DBH, height, canopy cover, tree quality | Dec 2025 |
| Seagrass (M1.1) | Seagrass Meadows | Total cover, species richness, shoot density, canopy height | 2024 |

Speaker notes: Draw this as three columns on the board. Note that coral reef is the only ecosystem with two periods (enabling change detection). Mangrove and seagrass are single-period baselines -- the accounts can report opening values but cannot yet assess change. Emphasize that this is normal for early-stage accounts; the first survey establishes the baseline, and future resurveys will populate the closing column.

---

## Slide 4: The three steps (all ecosystems)

```
Step 1: Raw field data --> QA/QC --> Clean indicators per site
        (R analysis scripts handle this)

Step 2: Site-level indicators --> Normalise to CI (0-1) using reference levels
        (This workshop covers this step)

Step 3: Aggregate by geographic unit or PA --> Assemble SEEA EA table
        (This workshop covers this step)
```

Speaker notes: Draw this as a flow diagram on the board. The R pipeline handles everything up to producing site-level indicator values (Step 1). This workshop focuses on Steps 2 and 3 -- the normalisation and aggregation that turn ecological measurements into a standardised accounting table. Participants will practice with real Kenya data.

---

## Slide 5: Normalisation formulas

There are three types of normalisation used across the Kenya accounts:

**Type 1 -- Higher is better (standard):**

Condition Index = min(measured value / reference level, 1.0)

Used for: fish biomass, coral cover, % healthy colonies, recruitment, seagrass cover, shoot density

**Type 2 -- Higher is worse (inverted):**

Condition Index = max(1 - measured value / reference level, 0.0)

Used for: bleaching %, disease %, COTS density, macroalgae

**Type 3 -- Linear rescaling (poor-to-pristine range):**

Condition Index = (value - poor) / (pristine - poor), clamped to [0, 1]

Used for: mangrove indicators (stem density, DBH, height, canopy cover)

Speaker notes: Write all three formulas on the board. For Type 1, the min() caps at 1.0 so values above the reference do not exceed 1. We are measuring "how close to reference," not "how much above." For Type 2, the max() prevents negative values. For Type 3, note that it requires TWO reference points (poor and pristine) rather than one. Ask participants: "Why do mangroves use a different formula?" Answer: because mangrove indicators have a meaningful "poor" threshold below which the ecosystem is functionally degraded, not just "zero."

---

## Slide 6: Reference levels -- why they matter

| Indicator | Reference level | Source | Confidence |
|-----------|----------------|--------|------------|
| Fish biomass | 1,150 kg/ha | McClanahan et al. (2016) | HIGH |
| Live coral cover | 30% | GCRMN (2021) | MEDIUM |
| Mangrove stem density | Pristine: 3,000; Poor: 200 trees/ha | Kirui et al. (2006) | MEDIUM |
| Total seagrass cover | 60% | Duarte (1991) | MEDIUM |
| Sea urchin density | Optimum: 1.75 ind/m2 | McClanahan (1987+) | LOW |

Speaker notes: Reference levels are the single most important methodological choice in condition accounting. If we change the coral cover reference from 30% to 50%, the CI drops from 0.91 to 0.55 for the same measured value. Ask participants: "How would you decide which reference level is more appropriate?" Key points: (a) peer-reviewed WIO/regional references are preferred, (b) confidence ratings must be reported alongside the CI, (c) LOW confidence means the CI should be treated as provisional and flagged in outputs. The Kenya seagrass account has mostly LOW confidence reference levels -- this is honest, not a failure. It identifies the research gap.

---

## Slide 7: Guided example -- coral reef, live coral cover

Let us work through one site together.

Site: Watamu Coral Garden, Watamu Marine Park, Nov 2024 (opening period).

Live coral cover = 27.15%. Reference level = 30%.

CI = min(27.15 / 30, 1.0) = min(0.905, 1.0) = 0.91

This means the site has 91% of the reference coral cover.

Speaker notes: Ask participants to calculate this on paper or a calculator. Wait for them to get the answer before showing it. Ask: "Is this a healthy reef?" (Yes, close to the reference -- but note the reference is already a moderate threshold, not pristine. A 30% cover reference represents an acceptable reef, not an excellent one.) Then ask: "What would happen if we used 50% as the reference?" (CI = 27.15 / 50 = 0.54 -- a very different picture.) This illustrates why documenting the reference choice is essential.

---

## Slide 8: Guided example -- coral bleaching (inverted)

Same site, same period.

Bleached colonies = 18.6%. Reference level = 5% (background bleaching threshold).

CI = max(1 - 18.6 / 5, 0.0) = max(1 - 3.72, 0.0) = 0.00

This means the site exceeds the background bleaching threshold -- condition index is 0 (poor).

Speaker notes: Walk through the inversion carefully. A reef with 0% bleaching scores CI = 1.0 (best). A reef at 5% bleaching scores CI = 0.0 (at the threshold). At 18.6%, we are well beyond the threshold, so the CI floors at 0.0 -- the max() prevents negative values. Ask: "Does this mean the reef is dead?" No -- it means bleaching prevalence far exceeds the non-bleaching baseline. Explain the post-bleaching context: the Nov 2024 data was collected during/after the 2023-2024 global bleaching event. This is not a normal baseline year.

---

## Slide 9: Guided example -- mangrove stem density (linear rescaling)

Site: Boardwalk, Mida Creek MNR.

Stem density = 2,600 trees/ha. Reference: Pristine = 3,000; Poor = 200.

CI = (2,600 - 200) / (3,000 - 200) = 2,400 / 2,800 = 0.86

This means the site is at 86% of the pristine-to-poor range for stem density.

Speaker notes: Ask participants to calculate. Then ask: "What would the CI be for a site with 200 trees/ha?" (CI = 0.0.) "And for 3,000 trees/ha?" (CI = 1.0.) "What about 4,000 trees/ha?" (CI = (4,000-200)/(3,000-200) = 1.36, but clamped to 1.0.) This is the same cap logic as the standard formula. A site can exceed the pristine reference and still score 1.0.

Now ask: "Is high stem density always good?" No -- very high stem density with very low DBH can indicate a young, regenerating stand after clearing. This is what we see across most of the Kenya mangrove sites: high density (CI ~0.9) but low DBH (CI ~0.17). The composite CI (equal-weight mean) captures both signals.

---

## Slide 10: Guided example -- seagrass shoot density

Site: Ngomeni. Species: Thalassia hemprichii.

Mean shoot density = 720 shoots/m2. Reference level = 800 shoots/m2.

CI = min(720 / 800, 1.0) = min(0.90, 1.0) = 0.90

Speaker notes: Remind participants that the reference level for seagrass shoot density is PROVISIONAL (LOW-MEDIUM confidence). Ask: "Why does this matter for how we report the result?" Answer: we must flag the CI as provisional in the SEEA EA output table and include the confidence rating. If a future study publishes a Kenya-specific reference of 600 shoots/m2, the CI would change to 1.0. The actual field measurement (720 shoots/m2) does not change -- only the CI changes because of the reference.

Also explain the quadrat scaling: the raw field data records shoot counts per 15 cm x 15 cm quadrat (area = 0.0225 m2). The R script divides by 0.0225 to express as shoots/m2 BEFORE normalisation. If the quadrat is misspecified, all densities are wrong. This is a high-priority confirmation item.

---

## Slide 11: Aggregation -- site to accounting area

For each geographic unit (protected area, county, ecosystem asset), calculate the mean and standard error across sites.

Mean CI = sum of site CI values / N

Standard error (SE) = standard deviation of site CIs / sqrt(N)

**Example -- mangrove composite CI by PA status:**

| PA status | Sites | Mean CI | SE |
|-----------|-------|---------|-----|
| Mida Creek MNR | 7 | 0.455 | calculated |
| Unprotected | 15 | 0.370 | calculated |

Speaker notes: If the audience is not comfortable with standard deviation, explain it as "how spread out the values are." The SE tells us how confident we are in the mean. With more sites, the SE gets smaller and our estimate gets more precise. Ask: "Why does Mida Creek MNR have higher condition than unprotected sites?" Discuss protection effectiveness. Then ask: "With 7 sites for MNR and 15 for unprotected, which mean do we trust more?" (The unprotected mean, because more sites = smaller SE = more precise estimate.)

---

## Slide 12: Multi-period change detection

Absolute change = Closing CI - Opening CI

Percent change = (change / Opening CI) x 100

**Interpretation rules:**

1. Calculate the SE threshold = average of opening and closing SE of the CI.
2. If the absolute change is smaller than the SE threshold: **Stable** (the change could be noise).
3. If the change is positive and exceeds the threshold: **Improving**.
4. If the change is negative and exceeds the threshold: **Declining**.

**Kenya application:** Only coral reef has two periods. Mangrove and seagrass are single-period baselines.

Speaker notes: The SE threshold is a simple way to distinguish real change from measurement noise. For coral reef, the composite CI improved from 0.547 (Nov 2024) to 0.645 (Jul 2025), a change of +0.098. But this must be interpreted with caution: Jul 2025 was collected ~15 months after the 2023-2024 bleaching event peak. The improvement may reflect post-bleaching recovery, not a secular improvement. Always report the temporal context alongside the numbers.

For mangrove and seagrass (single period), the change column is left blank. The 2024/2025 values serve as the opening baseline. This is standard practice in early-stage SEEA EA accounts.

---

## Slide 13: The SEEA EA condition account table

The final output is a standardised table with one row per indicator per period:

| Ecosystem | Indicator | Period | Measured value | Unit | CI (0-1) | Reference level | Confidence | Note |
|-----------|-----------|--------|----------------|------|----------|----------------|------------|------|
| Coral reef M1.3 | Live coral cover | Nov 2024 | 27.15 | % | 0.905 | 30% (GCRMN 2021) | MEDIUM | |
| Coral reef M1.3 | Live coral cover | Jul 2025 | 21.90 | % | 0.730 | 30% (GCRMN 2021) | MEDIUM | Post-bleaching |
| Mangrove MFT1.2 | Stem density | Dec 2025 | 2,747 | trees/ha | 0.910 | 200-3,000 (Kirui 2006) | MEDIUM | Single period |
| Seagrass M1.1 | Total cover | 2024 | 57.8 | % | 0.963 | 60% (Duarte 1991) | MEDIUM | Provisional ref |

Speaker notes: Walk through each column. Emphasize that the Note column is essential for caveats: post-bleaching context, provisional reference levels, pending transect area confirmation. These notes prevent misinterpretation. Ask: "If you were a policymaker reading this table, what would you want to know that is NOT in the numbers?" (Temporal context, confidence in the reference, whether the change is statistically meaningful, what management actions could improve condition.)

---

## Slide 14: Protected area disaggregation

All three Kenya ecosystems include a PA comparison:

| Ecosystem | Protected | CI | Unprotected | CI | Difference |
|-----------|-----------|-----|-------------|-----|------------|
| Coral reef | Watamu MPA (no-take) | Higher | Open access sites | Lower | To be calculated |
| Mangrove | Mida Creek MNR | 0.455 | Unprotected | 0.370 | +23% |
| Seagrass | Malindi Marine Park | 0.826 | Unprotected mean | ~0.75 | To be calculated |

Speaker notes: PA disaggregation is one of the most policy-relevant outputs of ecosystem accounting. It directly answers: "Is protection working?" In Kenya, protected mangrove sites show 23% higher composite condition than unprotected sites. The strongest effects are in canopy cover and tree height. Ask participants: "Why might stem density be HIGHER in unprotected sites?" (Post-harvest regeneration produces many small stems.) This illustrates why composite indices are more informative than single indicators.

---

## Slide 15: Exercise time -- coral reef condition account

You will now build a condition account for a coral reef site using real Kenya survey data.

You have:

1. A printed handout with instructions, blank tables, and the normalisation formulas.
2. The site-level data from KEN_site_condition_all_indicators.csv (pre-loaded in Excel).

Work through the handout:
- Calculate the CI for each of the 6 core indicators at one site (both periods)
- Calculate the composite CI (unweighted mean)
- Classify the change as Stable, Improving, or Declining

You have 40 minutes. We will compare answers afterward.

Speaker notes: Circulate during the exercise. Common mistakes to watch for: (a) forgetting to invert bleaching and COTS indicators, (b) dividing by the wrong reference level, (c) using population SD instead of sample SD, (d) not clamping the CI to [0, 1], (e) interpreting post-bleaching change as a secular trend without noting the context. Encourage participants to check that all CI values are between 0 and 1.

---

## Slide 16: Exercise time -- mangrove condition account

Using KEN_mangrove_condition_by_site.csv:

1. Pick one Mida Creek MNR site and one unprotected site
2. Calculate the CI for each of the 5 indicators using the linear rescaling formula
3. Calculate the composite CI for each site
4. Compare: which site has better condition? Which individual indicator drives the difference?

You have 25 minutes.

Speaker notes: This exercise reinforces the linear rescaling formula (Type 3) and the interpretation of the composite index. Watch for participants forgetting to clamp negative values to 0 or values above 1 to 1.0. When reviewing answers, ask: "What does it mean that a site has CI = 0.93 for stem density but CI = 0.15 for DBH?" (Dense but small trees -- regeneration after disturbance.) This is ecologically meaningful and should be flagged in the account narrative.

---

## Slide 17: Exercise time -- seagrass and cross-ecosystem

Using KEN_seagrass_cover_site.csv and KEN_seea_condition_account_seagrass.csv:

1. Identify the site with the highest and lowest seagrass cover CI
2. For Ngomeni (the multi-ecosystem site), look up the coral reef composite CI and the seagrass composite CI side by side
3. Discuss: is Ngomeni in better condition as a reef or as a seagrass meadow?

You have 20 minutes.

Speaker notes: This exercise introduces cross-ecosystem comparison. Ngomeni has the highest seagrass CI (0.942) but its reef CI should be looked up from the reef account. Ask: "Can we directly compare a seagrass CI of 0.94 with a reef CI of 0.55?" Technically yes -- both are normalised to the same 0-1 scale against their respective reference levels. But the confidence levels differ (seagrass references are mostly LOW; reef references are MEDIUM-HIGH). So the seagrass CI carries more uncertainty. This is an important nuance for policy communication.

---

## Slide 18: Review and discussion

Show the answer keys for all three exercises. Walk through each indicator.

Discussion questions:

1. Across all three ecosystems, which ecosystem has the highest composite CI? Is that comparison fair given the different confidence levels?
2. For coral reef: which indicator showed the largest improvement between Nov 2024 and Jul 2025? What is the post-bleaching caveat?
3. For mangrove: why does Mida Creek MNR have lower stem density CI but higher composite CI than unprotected sites?
4. For seagrass: if the Thalassia hemprichii density reference were changed from 800 to 600 shoots/m2, how would the CI change for Ngomeni?
5. What additional data would you need to compile a complete SEEA EA condition account (i.e., to fill in the missing closing values for mangrove and seagrass)?

Speaker notes: For question 4, recalculate together: if density = 720 and reference = 600, CI = min(720/600, 1.0) = 1.0 instead of 0.90. The reference level choice matters. For question 5, the answer is: a resurvey at the same sites using the same protocols in 2026-2027. Emphasize that SEEA EA accounts grow in value over time as the time series lengthens.

---

## Slide 19: Extent accounts -- the other half

Condition tells us the quality of the ecosystem. Extent tells us the quantity.

**Kenya mangrove extent account (2020-2025):**

| Entry | Area (ha) |
|-------|-----------|
| Opening (GMW 2020) | 6,083 |
| Additions | +589 |
| Reductions | -928 |
| Closing (2025) | 5,742 |
| Net change | -341 (-5.6%) |

**Protection coverage:**
- 66% of mangroves within protected areas
- 34% unprotected (priority for community management)

Speaker notes: Explain that extent accounts use GIS workflows (satellite imagery + WDPA spatial data), not field surveys. The two data sources (GMW 2020 and 2025 project classification) use different methods, so some observed "change" may be methodological artefact rather than real land cover change. This caveat must be documented. Ask: "If mangrove extent declined by 5.6% but condition at remaining sites is moderate (CI = 0.40), what are the policy implications?" (Both the loss of area AND the degraded condition of remaining area are concerning; restoration should target both.)

---

## Slide 20: Ecosystem service accounts -- fisheries

The provisioning service account connects condition to economic value.

**Method: Resource rent**

Resource Rent = Gross Revenue x (1 - cost ratio)

**Kenya provisional estimate (2024):**

| Component | Value |
|-----------|-------|
| Total KeFS catch | 12,094 MT |
| Reef-attributed catch (40%) | ~4,838 MT |
| Adjusted for unreported (+25%) | ~6,047 MT |
| Resource rent (Tier 1, 62% cost) | USD 3.5 million/yr |

Speaker notes: Explain that the 40% reef attribution fraction is the key uncertainty. It comes from classifying KeFS species groups by habitat using FishBase. Some species (Snapper, Parrot fish, Rock cod) are clearly reef-associated (90% attribution). Others (Cavalla jacks) split between reef and pelagic (50%). The cost ratio (62%) is from published WIO literature (Munga et al. 2014). A local fisher cost survey would enable a Tier 2 estimate. Ask: "If the reef attribution fraction were 30% instead of 40%, what would the resource rent be?" (USD 3.5M x 0.75 = ~USD 2.6M -- a 25% reduction from the same catch data.)

---

## Slide 21: Linking condition to services

```
Condition Account          Service Account
Fish biomass (kg/ha)  -->  Reef-attributed catch (MT/yr)
Coral cover (%)       -->  Reef structural integrity --> Coastal protection value
Species richness      -->  Tourism attractiveness --> Recreation value
Mangrove extent (ha)  -->  Carbon stock (tC) --> Carbon market value
```

Speaker notes: The condition-to-service linkage is what makes SEEA EA accounts useful for policy beyond simple environmental monitoring. When fish biomass declines (condition worsens), the provisioning service supply should also decline over time. When mangrove extent shrinks, the carbon stock decreases. These linkages enable "what if" analysis: what is the economic cost of further reef degradation? What is the return on investment from mangrove restoration? This is the long-term goal of the accounting system.

---

## Slide 22: Data quality and confidence

| Rating | Criteria |
|--------|----------|
| HIGH | Kenya-specific published reference; multi-period data; >10 matched sites |
| MEDIUM | Regional (WIO) published reference; replicated transects; 5-10 sites |
| LOW-MEDIUM | Provisional reference from nearest literature; single period |
| LOW | In-sample relative index only; no published baseline; single period |

**Current Kenya confidence by ecosystem:**

| Ecosystem | Confidence | Binding constraint |
|-----------|------------|-------------------|
| Coral reef | MEDIUM | Transect area unconfirmed; post-bleaching framing |
| Mangrove | MEDIUM | Canopy cover and quality references LOW |
| Seagrass | LOW-MEDIUM | No published WIO density baselines |
| Fisheries | LOW-MEDIUM | Attribution fraction pending expert validation |

Speaker notes: Being honest about confidence is not a weakness -- it is a strength of the SEEA EA framework. It tells users exactly how much weight to put on each number. A LOW confidence CI is still more useful than no CI at all, as long as the uncertainty is clearly communicated. Ask: "What would it take to upgrade seagrass from LOW to MEDIUM?" (Peer-reviewed East African shoot density baselines from KMFRI or WIOMSA monitoring data.)

---

## Slide 23: Policy communication

Key messages for Kilifi County decision-makers:

1. **Coral reef:** Fish biomass at all Kilifi reef sites is below 40% of the conservation target (1,150 kg/ha). Protected reefs in Watamu and Malindi MPAs show higher condition than open-access sites.

2. **Mangrove:** 341 hectares of mangrove lost between 2020 and 2025 (5.6% decline). Protected mangroves in Mida Creek MNR are in 23% better condition than unprotected sites.

3. **Seagrass:** Seagrass meadows across 10 sites are in moderate-to-high condition (CI 0.69-0.94). Ngomeni is the healthiest site with the highest species diversity.

4. **Fisheries:** Coral reef-associated fish catch is worth an estimated USD 2.8-4.1 million/yr in resource rent for Kilifi County.

Speaker notes: Ask participants to practice delivering these messages to a partner in 60 seconds, as if briefing a County Governor. The numbers should be memorable and actionable. Avoid jargon (say "condition score" not "normalised condition index"). Lead with the policy implication ("protected areas are working") not the methodology ("we used a linear rescaling formula").

---

## Slide 24: Looking ahead

What comes next for Kenya SEEA EA accounts:

1. **Resurvey 2026-2027:** Repeat coral reef, mangrove, and seagrass surveys at the same sites to populate closing values and enable change detection for all three ecosystems.

2. **Extent mapping:** Seagrass and coral reef extent accounts (satellite + field validation) to complement the completed mangrove extent account.

3. **Tier 2 fisheries:** Fisher cost survey at Kilifi landing sites (30-50 interviews) to replace literature-based cost ratios with local data.

4. **Additional ecosystem services:** Tourism/recreation value, coastal protection, carbon storage (mangrove).

5. **National scale-up:** Replicate the Kilifi methodology at other Kenyan coastal counties; contribute to the Kenya National Natural Capital Accounts.

Speaker notes: Emphasize that the accounts are not a one-off exercise. Each new survey campaign extends the time series and strengthens the change analysis. The condition, extent, and service accounts established here form the foundation. The Kenya pilot (3 ecosystems, 5 account types, ~50 output files) demonstrates that comprehensive coastal ecosystem accounting is achievable with existing field programmes and official statistics. The methodology is transferable to other WIO countries -- Madagascar and Mozambique pilots are already underway using the same framework.

---

## Appendix A: Facilitator Preparation Checklist

### Before the workshop

- [ ] Print handouts with blank condition account tables (one per participant)
- [ ] Pre-load Excel workbooks with site-level data from Kenya/03_outputs/:
  - KEN_site_condition_all_indicators.csv (coral reef exercise)
  - KEN_mangrove_condition_by_site.csv (mangrove exercise)
  - KEN_seagrass_cover_site.csv (seagrass exercise)
  - KEN_SEEA_EA_condition_account_final.csv (cross-ecosystem)
- [ ] Prepare answer keys for all three exercises
- [ ] Print the reference level summary table (Slide 6) as a separate handout
- [ ] Print the normalisation formula sheet (Slide 5) as a separate handout
- [ ] Test the projector and ensure slides are legible from the back of the room
- [ ] Prepare whiteboard markers for live calculations
- [ ] Ensure calculators or laptops with Excel are available for all participants

### Materials list

| Item | Quantity | Purpose |
|------|----------|---------|
| Printed handout: blank account tables | 1 per participant | Exercises |
| Printed handout: formula sheet | 1 per participant | Reference during exercises |
| Printed handout: reference level table | 1 per participant | Reference during exercises |
| Excel workbooks (USB or shared drive) | 1 per participant | Data exercises |
| Answer keys | 1 per facilitator | Review sessions |
| Calculators | 1 per participant (or use phones) | Manual calculations |
| Whiteboard + markers | 1 set | Live worked examples |
| Projector | 1 | Slide presentation |

### Timing guide

| Slides | Content | Duration |
|--------|---------|----------|
| 1-4 | Introduction and framework | 30 min |
| 5-10 | Normalisation formulas and guided examples | 45 min |
| 11-12 | Aggregation and change detection | 20 min |
| 13-14 | SEEA EA table structure and PA disaggregation | 20 min |
| -- | Break | 15 min |
| 15 | Exercise: coral reef condition account | 40 min |
| 16 | Exercise: mangrove condition account | 25 min |
| 17 | Exercise: seagrass and cross-ecosystem | 20 min |
| 18 | Review and discussion | 30 min |
| -- | Break | 15 min |
| 19-21 | Extent, services, and linkages | 30 min |
| 22-23 | Data quality and policy communication | 20 min |
| 24 | Looking ahead and wrap-up | 15 min |
| -- | **Total** | **~5.5 hours (full day with breaks)** |

---

## Appendix B: Exercise Answer Keys

### Exercise 1: Coral Reef (Slide 15)

Using data for Watamu Coral Garden, both periods:

| Indicator | Nov 2024 measured | Reference | Formula | CI (Nov 2024) | Jul 2025 measured | CI (Jul 2025) | Change |
|-----------|-------------------|-----------|---------|----------------|-------------------|---------------|--------|
| Live coral cover | 27.15% | 30% | Standard | 0.905 | 21.90% | 0.730 | -0.175 |
| Coral health (% healthy) | 76.9% | 95% | Standard | 0.809 | 92.8% | 0.977 | +0.168 |
| Coral recruitment | 0.01 rec/m2 | 1.0 rec/m2 | Standard | 0.010 | 0.054 rec/m2 | 0.054 | +0.044 |
| Fish biomass | 345 kg/ha | 1,150 kg/ha | Standard | 0.300 | 437 kg/ha | 0.380 | +0.080 |
| Fish richness | * | max obs | Standard | 0.629 | * | 0.728 | +0.098 |
| Coral bleaching | * | 5% | Inverted | 0.628 | * | 1.000 | +0.372 |
| **Composite** | | | Mean | **0.547** | | **0.645** | **+0.098** |

Note: Measured values marked * should be looked up from the exercise data file.

### Exercise 2: Mangrove (Slide 16)

Hypothetical worked example:

| Indicator | Measured | Poor | Pristine | CI |
|-----------|----------|------|----------|-----|
| Stem density | 2,600 trees/ha | 200 | 3,000 | (2600-200)/(3000-200) = 0.857 |
| Mean DBH | 6.5 cm | 3 | 20 | (6.5-3)/(20-3) = 0.206 |
| Mean height | 4.2 m | 2 | 12 | (4.2-2)/(12-2) = 0.220 |
| Canopy cover | 55% | 30 | 90 | (55-30)/(90-30) = 0.417 |
| Tree quality | 0.35 | -- | -- | 0.350 (direct) |
| **Composite** | | | | **0.410** |

### Exercise 3: Seagrass (Slide 17)

Ngomeni seagrass: total cover = 90.75%, richness = 8 (max observed = 8)

- Cover CI = min(90.75 / 60, 1.0) = 1.0
- Richness CI = 8 / 8 = 1.0
- But note: richness CI is a RELATIVE index (in-sample maximum); not comparable outside this dataset

---

## Appendix C: Common Participant Questions

**Q: Why do different indicators use different normalisation formulas?**
A: The formula depends on the indicator's relationship to ecosystem health. For most indicators, higher values mean better condition (standard formula). For stressors like bleaching or algal overgrowth, higher values mean worse condition (inverted formula). Mangrove indicators use a two-point rescaling because there is a meaningful "poor" threshold below which the forest is functionally degraded.

**Q: Can I compare condition indices across different ecosystems?**
A: Yes, the 0-1 scale is designed to make different indicators comparable. But always note the confidence levels. A seagrass CI of 0.94 with LOW confidence is not directly comparable to a reef CI of 0.55 with MEDIUM confidence.

**Q: What if my measured value exceeds the reference level?**
A: The CI is capped at 1.0. A reef with 40% coral cover against a 30% reference scores CI = 1.0, not 1.33. We measure proximity to reference condition, not exceedance.

**Q: Why are some reference levels "provisional"?**
A: No published Kenya- or WIO-specific baseline exists for these indicators. We use the best available regional or global estimate and flag it as provisional. As more WIO monitoring data are published, these references can be updated. The field measurements remain valid; only the CI interpretation changes.

**Q: How many sites do I need for a reliable condition account?**
A: Minimum 4-5 sites per geographic unit for a basic account. 10+ sites for reliable SE estimates. The Kenya coral reef account has ~20 sites (good). Some mangrove sites have only 1 plot (flagged as low-sample-size).

**Q: Can I use this methodology for a different country or ecosystem?**
A: Yes. The SEEA EA framework is universal. The normalisation formulas are generic. You need to (a) select indicators appropriate for your ecosystem type, (b) identify reference levels from relevant literature, and (c) document your choices. The Kenya, Madagascar, and Mozambique pilots provide templates for adaptation.

---

*Version: 1.0*
*Created: 2026-03-29*
*Adapted from: Belize Coral Reef Condition Accounts Workshop Guide (facilitator_guide.1cdda751.docx)*
*Companion documents: KEN_SEEA_EA_METHODOLOGY.md, KEN_TRAINING_GUIDELINES.md*
