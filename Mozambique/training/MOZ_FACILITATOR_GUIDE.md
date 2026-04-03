# Compiling Mangrove Ecosystem Accounts from Remote Sensing: Workshop Facilitator Guide

## Mozambique SEEA EA -- Mangrove Condition and Carbon Accounts Using NASA GEDI LiDAR

---

## Slide 1: Title

Compiling Mangrove Ecosystem Condition and Carbon Accounts for Mozambique

A practical workshop on turning NASA GEDI spaceborne LiDAR data into SEEA EA condition and carbon account tables -- covering Save Estuary and Morrumbene Estuary.

Speaker notes: Welcome participants. This session demonstrates how to build ecosystem condition and carbon accounts from satellite remote sensing data, without field surveys. The Mozambique pilot uses NASA GEDI LiDAR as the primary data source for four structural indicators. By the end, participants will be able to normalise GEDI outputs to condition indices, aggregate across assets, derive carbon stocks, and assemble SEEA EA tables. This approach is applicable anywhere GEDI data are available -- participants can replicate it for other mangrove sites in the WIO region.

---

## Slide 2: What is different about remote-sensing accounts?

| Dimension | Field-based (e.g., Kenya) | Remote sensing (Mozambique) |
|-----------|--------------------------|----------------------------|
| What you measure | Species, health, DBH, quality | Height, cover, biomass, leaf area |
| Spatial coverage | 10-30 sites with plots | Entire estuary system |
| Cost | High (field team) | Low (open-access satellite data) |
| Species data | Yes | No |
| Temporal resolution | Fixed survey dates | Satellite overpass windows |
| Validation | Direct measurement | Requires field ground-truthing |

Both approaches produce SEEA EA condition accounts on the same 0-1 scale. They are complementary, not competing.

Speaker notes: The key message is that remote sensing accounts are not inferior to field-based accounts -- they answer different questions at different scales. GEDI gives you structural condition across the whole estuary. Field surveys give you biotic detail at specific sites. The ideal approach combines both: GEDI for wall-to-wall mapping, field surveys for calibration and species data. Mozambique starts with GEDI and adds field data later (planned March-May 2026).

---

## Slide 3: The four GEDI indicators

| Indicator | GEDI Variable | Unit | What it tells you |
|-----------|--------------|------|-------------------|
| Canopy height | mean_rh100 | m | How tall are the trees? (forest maturity) |
| Canopy cover | mean_L2B_cover | Fraction 0-1 | How closed is the canopy? (forest density) |
| Biomass density | mean_L4A_agbd | Mg/ha | How much wood is there? (standing stock) |
| Plant Area Index | mean_L2B_pai | m2/m2 | How much leaf surface? (photosynthetic capacity) |

Plus a fifth metric -- carbon density (mean_L4A_carbono_mgha) -- which is NOT normalised but used in the carbon account.

Speaker notes: GEDI stands for Global Ecosystem Dynamics Investigation -- a LiDAR instrument on the International Space Station. Each GEDI "footprint" is ~25 m in diameter. The instrument fires laser pulses at the Earth's surface and measures the return signal. Tall, dense forests produce strong returns from the canopy top (giving height) and multiple returns through the canopy (giving cover and PAI). The L4A product combines height with allometric models to estimate biomass. Show participants a diagram of a GEDI footprint if available.

---

## Slide 4: The asset framework

```
Estuary (e.g., Save)
    |
    +-- Asset 1 (841 ha, 17 GEDI footprints)
    +-- Asset 2 (27 ha, 2 footprints) <-- LOW confidence
    +-- Asset 3 (104 ha, 3 footprints) <-- Standout: tallest, densest
    +-- Asset 4 (6 ha, 1 footprint) <-- LOW confidence
    +-- Asset 5 (117 ha, 17 footprints)
    +-- Asset 6 (248 ha, 31 footprints) <-- HIGH confidence
    +-- Asset 7 (236 ha, 7 footprints)
    +-- Asset 8 (299 ha, 6 footprints) <-- Second-highest productivity
```

Each mangrove asset is a contiguous polygon from GMW boundaries with its own GEDI measurements.

Speaker notes: The asset concept is central to this methodology. Instead of treating the estuary as one uniform block, we subdivide it into discrete forest units. This reveals heterogeneity: Save Asset 3 has 7.8 m canopy height and 27 Mg/ha biomass, while Asset 6 has only 4.6 m height and 9 Mg/ha biomass. This heterogeneity is invisible in a site-level average. Ask participants: "Why does heterogeneity matter for conservation policy?" Answer: it identifies which patches are high-value (priority for protection) and which are degraded (priority for restoration).

---

## Slide 5: GEDI confidence ratings

| Rating | GEDI Footprints | Use in accounting |
|--------|-----------------|-------------------|
| HIGH | >= 20 | Reliable for baseline AND trend analysis |
| MODERATE | 6-19 | Acceptable for baseline; flag in outputs |
| LOW | <= 5 | Descriptive only; exclude from trend analysis |

Speaker notes: GEDI samples discretely -- not every pixel has a measurement. Some assets have many footprints (Morrumbene Asset 2: 95 footprints = HIGH confidence) while others have very few (Save Asset 4: 1 footprint = LOW confidence). With 1 footprint, the "mean" is just a single measurement -- it could be from the tallest tree or the shortest. Always check Point_Count before interpreting an asset's condition. Ask participants: "If you had to advise a government on carbon credits, would you use an estimate from 1 footprint or 95 footprints?" This makes the confidence framework intuitive.

---

## Slide 6: Normalisation formula

Same formula as the Kenya mangrove account -- linear rescaling:

```
CI = clamp((observed - poor) / (pristine - poor), 0, 1)
```

If observed < poor: CI = 0 (below minimum condition)
If observed > pristine: CI = 1 (at or above reference condition)

Speaker notes: Write the formula on the board. Remind participants that this is the same Type 3 formula used for Kenya mangroves (stem density, DBH, height, cover). The only difference is that Kenya uses field measurements and Mozambique uses GEDI measurements. The normalisation framework is universal -- it works with any data source as long as you have appropriate reference levels.

---

## Slide 7: Reference levels

| Indicator | Poor (CI=0) | Pristine (CI=1) | Confidence |
|-----------|-------------|-----------------|------------|
| Canopy height | 3 m | 15 m | HIGH |
| Canopy cover | 0.30 | 0.70 | LOW |
| AGBD | 5 Mg/ha | 100 Mg/ha | MEDIUM |
| PAI | 0.05 | 2.0 | LOW |

Speaker notes: Two of four reference levels are LOW confidence (canopy cover and PAI). This is a significant limitation. The canopy height reference is HIGH because published WIO/Mozambique studies support the 3-15 m range (Fatoyinbo 2008, Lagomasino 2015, Sitoe 2016). The AGBD reference is MEDIUM because the degraded lower bound is supported by Godoy & De Lacerda (2015) but the pristine upper bound (100 Mg/ha) is from general tropical literature, not Mozambique-specific data.

Ask participants: "Both sites have canopy cover below the poor threshold (0.30). The CI is 0 for cover. Does this mean the mangroves have no canopy?" No -- it means the GEDI-measured cover (4-9%) is below the threshold. But GEDI 25 m footprints may systematically underestimate cover in patchy mangroves. This is why Sentinel-2 cross-validation is needed before publishing cover-based CIs.

---

## Slide 8: Guided example -- canopy height, Save Estuary Asset 3

Save Asset 3, the standout patch.

Mean canopy height (rh100) = 7.80 m. Reference: Poor = 3 m, Pristine = 15 m.

```
CI = (7.80 - 3) / (15 - 3) = 4.80 / 12 = 0.40
```

This means the asset is at 40% of the pristine-to-poor range for canopy height.

Speaker notes: Ask participants to calculate this on paper. Then compare with Save Asset 6 (height = 4.64 m): CI = (4.64 - 3) / (15 - 3) = 1.64 / 12 = 0.14. Asset 3 has nearly 3x the height CI of Asset 6. Ask: "Which asset would you prioritise for protection?" (Asset 3 -- it is the most mature, productive patch.) "Which would you prioritise for restoration?" (Asset 6 -- it has HIGH confidence data (31 footprints) and low condition, meaning restoration potential is clear.)

---

## Slide 9: Guided example -- biomass density, Morrumbene Asset 2

Morrumbene Asset 2, best-sampled asset (95 footprints).

Mean AGBD = 10.79 Mg/ha. Reference: Poor = 5 Mg/ha, Pristine = 100 Mg/ha.

```
CI = (10.79 - 5) / (100 - 5) = 5.79 / 95 = 0.061
```

This means the asset is at 6% of the pristine biomass range.

Speaker notes: This is a very low CI. Ask participants: "Does this mean the mangrove is dead?" No -- it means biomass is very low compared to what an intact tropical mangrove could hold. There are two explanations: (a) the forest is genuinely degraded/sparse, or (b) the GEDI-derived AGBD underestimates true biomass (note the SE is 14 Mg/ha -- higher than the mean estimate of 10.8 Mg/ha). This is why the account is PROVISIONAL. Field validation will tell us which explanation is correct.

---

## Slide 10: Composite condition index

Four CIs combined into one composite per asset:

```
CCI = mean(CI_height, CI_cover, CI_agbd, CI_pai)
```

**Save Asset 3 example:**

| Indicator | Observed | CI |
|-----------|----------|-----|
| Height | 7.80 m | 0.400 |
| Cover | 0.434 | 0.336 |
| AGBD | 27.33 Mg/ha | 0.235 |
| PAI | 1.742 | 0.868 |
| **Composite** | | **0.460** |

Compare: most other Save assets have composite CCI of 0.04-0.07.

Speaker notes: Asset 3 is an outlier -- it scores 6-10x higher than its neighbours. This demonstrates why the asset framework matters: a site-level average would mask this productive patch. In conservation terms, Asset 3 is a "bright spot" that may be protecting itself through dense canopy structure. But note: it has only 3 GEDI footprints (LOW confidence). The high values could be real or could reflect sampling bias. Field validation at Asset 3 is a priority.

---

## Slide 11: Area-weighted aggregation to site level

Assets are weighted by area when computing site-level CCI:

```
CCI_site = sum(CCI_i x area_ha_i) / sum(area_ha_i)
```

**Save Estuary:**

| Asset | Area (ha) | CCI | CCI x Area |
|-------|-----------|-----|------------|
| 1 | 841 | 0.059 | 49.6 |
| 2 | 27 | 0.061 | 1.6 |
| 3 | 104 | 0.427 | 44.4 |
| 4 | 6 | 0.066 | 0.4 |
| 5 | 117 | 0.126 | 14.7 |
| 6 | 248 | 0.045 | 11.2 |
| 7 | 236 | 0.066 | 15.6 |
| 8 | 299 | 0.279 | 83.4 |
| **Total** | **1,878** | | **220.9** |

CCI_site = 220.9 / 1,878 = **0.118**

Speaker notes: Walk through the weighting calculation. Asset 1 (841 ha, low CCI) dominates the weighted average because of its size. Asset 3 (104 ha, high CCI) contributes less despite being the best patch. Ask: "Is this fair?" Yes -- area-weighting reflects the actual state of the ecosystem asset. A small excellent patch inside a large degraded forest does not make the forest healthy overall. But it DOES identify where to focus restoration investment.

---

## Slide 12: Carbon account

Carbon stock = carbon density x area

**Save Estuary example (Asset 6, HIGH confidence):**

Carbon density = 4.27 Mg C/ha. Area = 248 ha.

```
Total carbon = 4.27 x 248 = 1,059 Mg C
CO2 equivalent = 1,059 x 3.664 = 3,880 Mg CO2
```

Speaker notes: Walk through the multiplication. Then ask: "If a voluntary carbon credit is worth USD 10-30 per tonne CO2, what is Asset 6 worth?" (3,880 x $10 = $38,800 to $116,400 at the low end -- illustrative only; actual credit pricing requires additionality, permanence, and certification). Note that this is the STOCK, not the annual sequestration rate. Carbon credits are usually issued for sequestration (annual flow), not standing stock. Standing stock is relevant for REDD+ (avoided deforestation) rather than afforestation credits. Always report carbon with uncertainty bounds (mean +/- 1 SE).

---

## Slide 13: SEEA EA condition account table

Final output structure:

| Ecosystem | Site | Asset | Area (ha) | CI Height | CI Cover | CI AGBD | CI PAI | CCI | Confidence | Year |
|-----------|------|-------|-----------|-----------|----------|---------|--------|-----|------------|------|
| MFT1.2 | Save | 3 | 104 | 0.400 | 0.207 | 0.235 | 0.868 | 0.427 | LOW | 2025 |
| MFT1.2 | Save | 6 | 248 | 0.137 | 0.000 | 0.043 | 0.000 | 0.045 | HIGH | 2025 |
| MFT1.2 | Morrumbene | 2 | 448 | 0.191 | 0.000 | 0.061 | 0.038 | 0.073 | HIGH | 2025 |

Speaker notes: Show the full 11-row table from the CSV output. Emphasize the contrast between Asset 3 (CCI = 0.43, LOW confidence) and Asset 6 (CCI = 0.05, HIGH confidence). Ask: "For a policy report, which value would you trust more?" (Asset 6 -- the data is more reliable even though the condition is lower.) Then ask: "What would you recommend for the SEEA EA publication?" (Report both, with the confidence flag prominently displayed. Do not hide uncertain data -- report it transparently.)

---

## Slide 14: Save vs. Morrumbene comparison

| Dimension | Save | Morrumbene |
|-----------|------|-----------|
| Area (assets) | 1,878 ha | 1,069 ha |
| Composite CCI | 0.118 | 0.072 |
| Total carbon | ~11,150 Mg C | ~5,500 Mg C |
| GEDI coverage | Uneven (1-31 per asset) | Uniform (15-95 per asset) |
| Heterogeneity | High (CCI 0.04-0.43) | Low (CCI 0.07-0.08) |

Speaker notes: Save is larger, denser, more carbon-rich, and more variable. Morrumbene is smaller, sparser, but much better-sampled by GEDI. Ask: "If you had to choose one site for a carbon project, which would you pick?" Save has more total carbon, but Morrumbene has more reliable data and uniform structure (easier to monitor). This is a real tradeoff in conservation planning. Ask: "If you had to choose one site for a field validation mission, which would you pick?" Save -- because it has LOW confidence assets (2 and 4) and high heterogeneity that needs ground-truthing.

---

## Slide 15: Exercise -- condition account from raw GEDI data

You will now build a condition account from raw GEDI values.

You have:
1. A printed handout with the normalisation formula and reference level table.
2. The asset-level data from MOZ_mangrove_condition_by_asset.csv (pre-loaded in Excel).

**Task:**

1. Choose one Save asset and one Morrumbene asset.
2. For each, calculate the CI for all 4 indicators using the reference levels.
3. Calculate the composite CCI (mean of 4 CIs).
4. Calculate the carbon stock (carbon density x area).
5. Assign a confidence rating based on Point_Count.

You have 30 minutes.

Speaker notes: Circulate during the exercise. Common mistakes: (a) forgetting to clamp negative CIs to 0 (especially canopy cover, which falls below the poor threshold), (b) using 0-1 normalisation instead of poor-to-pristine range, (c) confusing carbon density (Mg C/ha) with AGBD (Mg/ha) -- carbon is ~47% of biomass, (d) not checking Point_Count before assigning confidence. Encourage participants to try one LOW-confidence asset and one HIGH-confidence asset.

---

## Slide 16: Exercise -- area-weighted aggregation

Using the full asset-level dataset for one site (Save or Morrumbene):

1. Calculate the area-weighted CCI for the entire site.
2. Calculate the total carbon stock for the site (sum of asset totals).
3. Express the carbon stock in CO2 equivalents.

You have 20 minutes.

Speaker notes: This exercise reinforces the area-weighting concept. If participants use Save, they should find that the site-level CCI is pulled down by the large, low-condition assets despite the high-condition outliers (Assets 3 and 8). If they use Morrumbene, the uniform structure means area-weighting barely changes the result. Both outcomes are instructive.

---

## Slide 17: Exercise -- cross-site and cross-country comparison

Using the site-level results:

1. Compare Save CCI (0.118) with Morrumbene CCI (0.072). Which site is in better condition?
2. Now compare with Kenya mangrove composite CI (0.397). The Kenya account uses field-based indicators (stem density, DBH, height, cover, quality). Can these be directly compared?
3. Discuss: what would you need to make the comparison fair?

Speaker notes: This is the most conceptually challenging exercise. The Kenya CI of 0.40 uses different indicators and different reference levels than the Mozambique CI of 0.07-0.12. The 0-1 scale is comparable in theory (both measure "fraction of reference condition") but the reference levels and indicators are different. A fair comparison would require either (a) measuring the same indicators at both sites, or (b) using GEDI for Kenya mangroves to create a comparable structural account. This is an active area of SEEA EA methodology development.

---

## Slide 18: Review and discussion

Show answer keys. Walk through key calculations.

Discussion questions:

1. Why is canopy cover CI = 0 at both Mozambique sites? Is this ecological reality or a measurement artefact?

2. Save Asset 3 has the highest CCI (0.43) but only 3 GEDI footprints (LOW confidence). How should this be reported?

3. If field validation shows that GEDI underestimates biomass by 50%, what happens to the condition indices? (Recalculate: if true AGBD = 20 Mg/ha instead of 12.6, CI_agbd = (20-5)/(100-5) = 0.16 instead of 0.08. Composite increases slightly but remains low.)

4. What is the minimum number of GEDI footprints you would accept for a policy-relevant carbon estimate? (No fixed rule, but >= 20 is the HIGH confidence threshold used in this project.)

5. How does the carbon account link to potential revenue? (REDD+, voluntary carbon markets, blue carbon initiatives -- all require additionality and permanence, not just stock estimation.)

Speaker notes: For question 1, the answer is likely both: the mangroves may genuinely be sparse/open-canopy woodland, AND GEDI may underestimate cover in patchy structure where 25 m footprints include water or bare ground. This is why Sentinel-2 cross-validation is flagged as a priority action.

---

## Slide 19: Field validation -- what comes next

**Planned: March-May 2026**

Field data to collect at each asset (minimum 3 plots per asset):
- Canopy height (clinometer -- compare with GEDI rh100)
- DBH of all stems >= 2.5 cm in 10 m radius plot
- Stem density (stems/m2)
- Species composition (Rhizophora, Ceriops, Avicennia, Bruguiera)
- Regeneration density (seedlings < 1.3 m)
- Disturbance indicators (logging scars, erosion)

Speaker notes: Field validation will answer three critical questions: (1) Are GEDI canopy cover values real or artefacts? (2) Does GEDI AGBD match field-derived biomass from allometric equations? (3) What species are present, and does species composition affect the reference levels? Once field data are collected, the PROVISIONAL label can be removed and the accounts become CONFIRMED. This is the standard progression for remote-sensing accounts: provisional baseline (satellite), then validated baseline (satellite + field), then trend analysis (multi-year satellite).

---

## Slide 20: Looking ahead

What comes next for Mozambique SEEA EA accounts:

1. **Field validation (Mar-May 2026):** Ground-truth GEDI with in-situ plots; upgrade PROVISIONAL to CONFIRMED.

2. **Sentinel-2 canopy cover cross-check:** Validate low cover estimates; derive independent cover map.

3. **Multi-period GEDI (2026-2027):** Future satellite passes for temporal change detection.

4. **Species mapping:** Optical imagery or field-based species identification.

5. **Ecosystem services:** Carbon market valuation, fisheries nursery linkage, coastal protection.

6. **Extent trends:** Update GMW-based extent mapping for 2025-2026.

7. **Replication:** Apply the same GEDI methodology to other WIO mangrove sites (Kenya, Tanzania, Madagascar).

Speaker notes: The Mozambique pilot demonstrates that a credible baseline condition and carbon account can be produced from freely available satellite data. The methodology is transferable to any GEDI-covered mangrove site. Participants from other WIO countries can adapt these scripts and reference levels for their own sites. The key investment is field validation -- without it, the account remains provisional. But even a provisional account is useful for prioritising conservation areas and estimating carbon stock magnitudes.

---

## Appendix A: Facilitator Preparation Checklist

### Before the workshop

- [ ] Print handouts with blank condition account tables and formula sheet
- [ ] Pre-load Excel workbooks with data from Mozambique/03_outputs/:
  - MOZ_mangrove_condition_by_asset.csv (main exercise)
  - MOZ_mangrove_condition_by_site.csv (aggregation exercise)
  - MOZ_mangrove_carbon_account.csv (carbon exercise)
  - MOZ_mangrove_seea_condition_account.csv (SEEA EA format)
- [ ] Prepare answer keys for all exercises
- [ ] Print reference level table (Slide 7) as a separate handout
- [ ] Print GEDI confidence table (Slide 5) as a separate handout
- [ ] Prepare GEDI footprint diagram (if available)
- [ ] Ensure calculators or laptops with Excel for all participants

### Timing guide

| Slides | Content | Duration |
|--------|---------|----------|
| 1-3 | Introduction, remote sensing vs. field, GEDI indicators | 25 min |
| 4-5 | Asset framework and confidence ratings | 15 min |
| 6-7 | Normalisation formula and reference levels | 20 min |
| 8-10 | Guided examples (height, AGBD, composite) | 30 min |
| 11-12 | Aggregation and carbon account | 20 min |
| -- | Break | 15 min |
| 13-14 | SEEA EA table and site comparison | 15 min |
| 15 | Exercise: condition account from raw GEDI | 30 min |
| 16 | Exercise: area-weighted aggregation | 20 min |
| 17 | Exercise: cross-site and cross-country comparison | 20 min |
| 18 | Review and discussion | 25 min |
| 19-20 | Field validation and looking ahead | 15 min |
| -- | **Total** | **~4.5 hours (half day with breaks)** |

---

## Appendix B: Exercise Answer Keys

### Exercise 1: Condition Account (Slide 15)

Example: Save Asset 6 (HIGH confidence, 31 footprints)

| Indicator | Observed | Poor | Pristine | CI |
|-----------|----------|------|----------|-----|
| Height | 4.64 m | 3 | 15 | (4.64-3)/(15-3) = 0.137 |
| Cover | 0.015 | 0.30 | 0.70 | (0.015-0.30)/(0.70-0.30) = negative, clamp to 0.000 |
| AGBD | 9.08 Mg/ha | 5 | 100 | (9.08-5)/(100-5) = 0.043 |
| PAI | 0.032 | 0.05 | 2.0 | (0.032-0.05)/(2.0-0.05) = negative, clamp to 0.000 |
| **Composite** | | | | **(0.137+0+0.043+0)/4 = 0.045** |
| **Confidence** | | | | **HIGH** |

Carbon: 4.27 Mg C/ha x 248 ha = 1,059 Mg C. CO2 eq = 3,880 Mg CO2.

Example: Morrumbene Asset 1 (HIGH confidence, 85 footprints)

| Indicator | Observed | Poor | Pristine | CI |
|-----------|----------|------|----------|-----|
| Height | 5.16 m | 3 | 15 | 0.180 |
| Cover | 0.046 | 0.30 | 0.70 | 0.000 (below poor) |
| AGBD | 11.26 Mg/ha | 5 | 100 | 0.066 |
| PAI | 0.115 | 0.05 | 2.0 | 0.033 |
| **Composite** | | | | **0.070** |

### Exercise 2: Area-Weighted Aggregation

Morrumbene site:

| Asset | Area (ha) | CCI | CCI x Area |
|-------|-----------|-----|------------|
| 1 | 512 | 0.070 | 35.8 |
| 2 | 448 | 0.073 | 32.7 |
| 3 | 109 | 0.081 | 8.8 |
| **Total** | **1,069** | | **77.3** |

CCI_site = 77.3 / 1,069 = 0.072

Total carbon = 2,711 + 2,271 + 522 = 5,504 Mg C. CO2 eq = 20,160 Mg CO2.

---

## Appendix C: Common Participant Questions

**Q: Can I use GEDI for any forest, not just mangroves?**
A: Yes. GEDI covers forests globally between 51.6 deg N and 51.6 deg S (the ISS orbit). The same normalisation approach works for terrestrial forests with appropriate reference levels.

**Q: Why are the CIs so low (0.04-0.12)?**
A: The reference levels assume intact, mature tropical mangrove forests. Both study sites may be naturally sparse or degraded. Also, GEDI may underestimate cover and PAI in patchy canopy. Field validation will clarify which factor dominates.

**Q: Is a CI of 0.07 "bad"?**
A: It means the ecosystem is at 7% of the pristine reference condition. Whether this is "bad" depends on context: if the forest has always been sparse open woodland, a low CI may be natural. If it was recently cleared and is regenerating, the CI will improve over time. Always interpret condition in ecological context.

**Q: Why is carbon not normalised to 0-1?**
A: Carbon stock is a physical quantity (Mg C), not a condition indicator. It feeds into the monetary valuation of ecosystem services (carbon markets) where the absolute value matters, not a relative index.

**Q: Can I replicate this for my country?**
A: Yes. You need: (1) GMW 2020 mangrove extent polygons for your site, (2) GEDI data (freely available from NASA LP DAAC), (3) reference levels appropriate for your region, (4) the R scripts from this project (adaptable). The methodology is fully transferable.

---

*Version: 1.0*
*Created: 2026-03-29*
*Adapted from: Belize Coral Reef Condition Accounts Workshop Guide (facilitator_guide template)*
*Companion documents: MOZ_SEEA_EA_METHODOLOGY.md, MOZ_TRAINING_GUIDELINES.md*
