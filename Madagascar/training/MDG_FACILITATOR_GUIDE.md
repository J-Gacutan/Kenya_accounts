# Compiling Coral Reef Condition Accounts: Workshop Facilitator Guide

## Madagascar SEEA EA -- Fish and Invertebrate Biotic Condition, SW Madagascar

---

## Slide 1: Title

Compiling Coral Reef Condition Accounts for Southwest Madagascar

A practical workshop on turning fish and invertebrate field survey data into SEEA EA condition account tables -- covering 27 reef sites along the SW Madagascar barrier reef.

Speaker notes: Welcome participants. This session teaches the steps between raw UVC (Underwater Visual Census) indicator values and the final SEEA EA condition account tables. Madagascar is the most data-rich pilot in the AFRICA-accounts project: 5,186 fish records, 27 sites, 227 species. By the end, participants will be able to compile a condition account for any reef site or subregion.

---

## Slide 2: What is a condition account?

A condition account records the state of an ecosystem at two points in time.

For each indicator:

1. Measure a value at the opening year (2025) and the closing year (2026).
2. Compare each value against a reference level that represents a healthy reef.
3. The ratio gives a condition index between 0 and 1.
4. The change between periods tells us if the reef is improving, stable, or declining.

Speaker notes: Emphasize that the CI is relative to the reference level. A CI of 0.43 for fish biomass means the site has 43% of the WIO conservation target (1,150 kg/ha). The CI makes different indicators -- kg/ha, species counts, ind/ha -- comparable on the same 0-1 scale.

---

## Slide 3: The Madagascar dataset

| Dimension | Value |
|-----------|-------|
| Sites | 27 across SW Madagascar |
| Survey stations | 85 (2 transects each = 170 transects) |
| Fish records | 5,186 |
| Fish species | 227 (39 families) |
| Invertebrate records | 434 (post-QA/QC) |
| Sea urchin records | 264 (post-QA/QC) |
| Observer (fish) | Laza |
| Observer (invertebrates) | Maka |
| Depth range | 3.6-16.5 m |

Speaker notes: This is one of the largest reef UVC datasets in the WIO for SEEA EA accounting. The 27 sites span the entire SW Madagascar barrier reef from Morombe to Ambohibola. Two survey periods (2025 and 2026) enable opening-to-closing change detection. Note that fish and invertebrate surveys were done by different observers -- this is standard practice but means inter-observer variability is not quantifiable.

---

## Slide 4: The three steps

```
Step 1: Raw field data --> QA/QC --> Clean indicators per site
        (R script handles this: fish_invert_condition.R)

Step 2: Site-level indicators --> Normalise to CI (0-1) using reference levels
        (This workshop covers this step)

Step 3: Aggregate by site / accounting area --> Assemble SEEA EA table
        (This workshop covers this step)
```

Speaker notes: The R script (962 lines) handles everything from Excel ingestion through biomass calculation to CSV export. This workshop focuses on understanding what the script produces and how to interpret and assemble the outputs into SEEA EA tables.

---

## Slide 5: Fish biomass -- the core indicator

**How biomass is calculated:**

```
For each fish observed:
    L = size class midpoint (e.g., "10-20 cm" = 15 cm)
    W = a x L^b  (grams; allometric parameters from FishBase)
    biomass_g = W x number_of_individuals

Per transect (250 m2):
    biomass_kg_ha = total_biomass_g / 1000 / 0.025 ha

Per site:
    mean biomass = average across transects
```

Speaker notes: The allometric relationship W = a x L^b converts fish length to weight using species-specific parameters. The Madagascar dataset has 124 unique a values and 55 unique b values across 227 species. Emphasize the size class midpoint approach: we do not know the exact length of each fish, only which 10 cm bin it falls in. This introduces uncertainty but is standard practice for UVC surveys. Ask: "Why do we divide by 0.025?" (Because 250 m2 = 0.025 ha; we want kg per hectare.)

---

## Slide 6: Normalisation formulas

**Type 1 -- Standard (higher is better):**

Condition Index = min(measured / reference, 1.0)

Used for: fish biomass, species richness

**Type 2 -- Inverted (higher is worse):**

Condition Index = max(1 - measured / reference, 0.0)

Used for: COTS density

Speaker notes: Write both on the board. The min() cap at 1.0 is important: Madagascar mean biomass is 1,929 kg/ha against a 1,150 kg/ha reference. Without the cap, the CI would be 1.68. We cap at 1.0 because the CI measures "how close to reference," not "how much above." A site that exceeds the reference is in excellent condition (CI = 1.0), but we do not distinguish between "slightly above" and "far above."

---

## Slide 7: Reference levels

| Indicator | Reference level | Source | Confidence |
|-----------|----------------|--------|------------|
| Fish biomass | 1,150 kg/ha | McClanahan et al. (2016) -- WIO conservation target | HIGH |
| Species richness | 103 species (max observed) | Dataset-internal | MEDIUM |
| COTS density | 15 ind/ha (outbreak threshold) | Dulvy et al. (2021) | MEDIUM |
| Sea urchin density | 1.75 ind/m2 (provisional) | Kenya/WIO studies | LOW |

Speaker notes: The fish biomass reference of 1,150 kg/ha comes from a WIO-wide study covering 15 countries. It represents the conservation target -- the biomass level needed to sustain reef ecosystem functions. A sustainability floor of 600 kg/ha exists below which fisheries collapse is likely. Ask: "If we used 600 kg/ha as the reference instead of 1,150, how would the CI change for a site with 900 kg/ha biomass?" (CI = 900/600 = 1.0 instead of 900/1150 = 0.78.) Reference level choice matters enormously.

---

## Slide 8: Guided example -- fish biomass

Site: Ambatomilo, 2025. The lowest-biomass site.

Mean biomass = 498 kg/ha. Reference = 1,150 kg/ha.

CI = min(498 / 1,150, 1.0) = min(0.433, 1.0) = 0.43

This site has 43% of the WIO conservation target biomass.

Now compare: Ambitiky, 2025. The highest-biomass site.

Mean biomass = 4,707 kg/ha. Reference = 1,150 kg/ha.

CI = min(4,707 / 1,150, 1.0) = min(4.093, 1.0) = 1.00

Speaker notes: Ask participants to calculate both. The 9.4x difference between the lowest and highest sites (498 vs. 4,707 kg/ha) shows enormous site-level heterogeneity -- but both get reduced to a 0-1 scale. Ask: "Is it useful that Ambitiky scores the same CI (1.0) as a site with 1,200 kg/ha? What information is lost by capping?" (We lose the distinction between "healthy" and "exceptionally healthy." For conservation, this matters -- Ambitiky may be a source population for neighbouring depleted reefs.)

---

## Slide 9: Guided example -- COTS density (inverted)

Site: Anakao, 2025. One of only 3 sites with COTS.

Observed: 1 COTS individual on a 250 m2 transect. Scaled: 40 ind/ha.

Wait -- this seems high for 1 individual.

This is the **scaling sensitivity problem**: 1 individual / 0.025 ha = 40 ind/ha, well above the 15 ind/ha outbreak threshold. CI = max(1 - 40/15, 0) = 0.

Speaker notes: Walk through this carefully. The scaling issue is relevant for Madagascar COTS data. With only 1-2 COTS observed at 3 sites on 250 m2 transects, the per-hectare extrapolation produces high densities. The accounting-area mean is more sensible because it averages across all 27 sites (24 of which had zero COTS). Ask: "How would you handle this in a policy report?" Recommended: report the accounting-area mean with a note that scaling from 250 m2 to 1 ha amplifies single-individual counts. The CI at the accounting-area level is more appropriate for policy use than site-level CIs based on 1-2 individuals.

---

## Slide 10: Trophic composition

| Group | % Biomass |
|-------|-----------|
| Herbivore | 40.6 |
| Carnivore | 30.0 |
| Planktivore | 15.2 |
| Corallivore | 8.7 |
| Omnivore | 5.5 |

Speaker notes: Trophic composition is not normalised to a CI because there is no single "reference" composition. Instead, it provides ecological context. Herbivores at 41% suggest strong algal grazing capacity -- critical for reef resilience after bleaching events. Carnivores at 30% indicate functional predator-prey dynamics. Ask: "If herbivores were only 10% of biomass, what would that suggest?" (Reduced algal control; potential phase shift to algal-dominated reef.)

---

## Slide 11: SEEA EA condition account table

| Indicator | 2025 (Opening) | 2026 (Closing) | Change |
|-----------|----------------|----------------|--------|
| Fish biomass CI | 1.00 | 1.00 | 0.00 |
| Fish richness CI | 0.54 | 0.54 | 0.00 |
| COTS density CI | 0.55 | 1.00 | +0.45 |
| Composite CI | 0.70 | 0.85 | +0.15 |

Speaker notes: The composite improved from 0.70 to 0.85, driven entirely by COTS density (which dropped from 6.7 ind/ha to 0 ind/ha between years). Fish biomass and richness were stable. Ask: "Should we interpret the COTS improvement as a real ecological change?" Probably not -- it may reflect natural variation in low-abundance populations (only 1-2 COTS at 3 sites). With such small counts, year-to-year variation is expected.

---

## Slide 12: Site-level heterogeneity

The accounting-area mean masks enormous variation:

| Site | Biomass (kg/ha) | CI | Richness | CI |
|------|----------------|-----|----------|-----|
| Ambitiky | 4,707 | 1.00 | 52 | 0.50 |
| Andavadoaky | 1,891 | 1.00 | 82 | 0.80 |
| Befasy | 635 | 0.55 | 33 | 0.32 |
| Ambatomilo | 498 | 0.43 | 36 | 0.35 |

Speaker notes: Site-level reporting is essential. Ambatomilo (CI = 0.43) needs different management than Ambitiky (CI = 1.0). The SEEA EA framework supports both accounting-area and site-level tables. For policy, both are needed: the accounting-area summary gives the headline, and the site-level table identifies priorities.

---

## Slide 13: Transect area — confirmed

**Resolved:** Transect area is 250 m2 (50 m x 5 m), confirmed with field team.

Speaker notes: This was previously the most important open item in the Madagascar pilot. It has now been confirmed as 250 m2 (50 m x 5 m). Emphasize to participants the importance of verifying field parameters before publishing accounts -- a different transect area would change all biomass and density scaling.

---

## Slide 14: Exercise -- condition account from site-level data

You will now build a condition account for 3 Madagascar reef sites using real data.

You have:
1. A printed handout with formulas and reference levels.
2. Site-level data from MDG_fish_invert_site_condition.csv (pre-loaded in Excel).

**Task:**
1. Choose 3 sites (one high-biomass, one medium, one low).
2. Calculate CI for fish biomass, species richness, and COTS density.
3. Calculate the composite CI (unweighted mean of 3 indicators).
4. Compare: which site has the best condition? Which has the worst?

You have 35 minutes.

Speaker notes: Circulate during the exercise. Common mistakes: (a) forgetting to invert COTS, (b) using 500 kg/ha reference instead of 1,150 kg/ha (the old value is still in some CSVs), (c) not capping at 1.0, (d) trying to calculate urchin CI without checking that the reference is provisional. Encourage participants to try Anakao (which has COTS) to see the scaling issue firsthand.

---

## Slide 15: Exercise -- accounting-area aggregation

Using all 27 sites (or as many as available for one year):

1. Calculate the accounting-area mean biomass across sites.
2. Calculate the CI for the accounting-area mean.
3. Compare: is the accounting-area CI the same as the mean of site-level CIs?

You have 20 minutes.

Speaker notes: There is an important subtlety here. The accounting-area CI calculated from the mean biomass is NOT the same as the mean of site-level CIs (because the min() cap is nonlinear). For example, if 10 sites have biomass above 1,150 kg/ha (CI = 1.0 each) and 5 sites have 500 kg/ha (CI = 0.43 each), the mean of CIs is (10 x 1.0 + 5 x 0.43) / 15 = 0.81. But the overall mean biomass might be 1,400 kg/ha, giving CI = 1.0. Both approaches are valid but produce different numbers. The SEEA EA standard calculates CI from the area-level mean indicator value.

---

## Slide 16: Exercise -- trophic composition

Using MDG_fish_invert_site_fg_condition.csv:

1. Pick one site and calculate the % biomass in each functional group.
2. Compare with the accounting-area composition (Slide 10).
3. Discuss: does your site have a healthy trophic balance?

You have 15 minutes.

Speaker notes: This exercise builds ecological interpretation skills. A site with <20% herbivore biomass may have reduced algal control. A site with no piscivores may indicate overfishing of large predators. Trophic structure is not normalised to a CI, but it provides context that pure CIs cannot.

---

## Slide 17: Review and discussion

Show answer keys. Walk through key calculations.

Discussion questions:

1. Madagascar mean biomass (1,929 kg/ha) exceeds the WIO reference (1,150 kg/ha). Does this mean all reefs are healthy?
2. Only 3 of 27 sites had COTS. Is the COTS indicator useful at such low prevalence?
3. How does the transect area uncertainty (100 vs. 400 m2) affect your confidence in the account?
4. Compare Madagascar composite CI (0.70-0.85) with Kenya coral reef composite CI (0.55-0.65). Which reef system is in better condition?
5. What additional data would upgrade this account from Tier 2 to Tier 3?

Speaker notes: For Q4, the comparison is informative but not fully standardised: Madagascar uses different indicators (no benthic cover, no coral health) and different sites. Both are M1.3 coral reefs under the same SEEA EA framework, but indicator selection differs based on data availability. For Q5: permanent transects, stereo-BRUV validation, locally-derived historical baseline, annual resurvey.

---

## Slide 18: Linking condition to ecosystem services

```
Condition Account             Service Account
Fish biomass (kg/ha)     -->  Nursery: Enhanced production via LRR (31%)
                              ~$61,000/yr (preliminary)
Fish biomass + catch     -->  Provisioning: Resource rent from wild fish
                              ~$88,000/yr (preliminary)
Species richness         -->  Recreation: Tourism attractiveness proxy
Reef extent (ha)         -->  All services require extent for scaling
```

Speaker notes: The service accounts are preliminary because market prices and reef extent are not yet confirmed. But the condition account provides the biological foundation for all three service accounts. If biomass declines, nursery and provisioning services decline with it. This linkage is what makes SEEA EA accounts useful for economic policy -- it puts a dollar value on reef degradation.

---

## Slide 19: Looking ahead

What comes next for Madagascar SEEA EA accounts:

1. **Transect area** -- RESOLVED: confirmed as 250 m2 (50 m x 5 m) with field team
2. **Re-export CSVs** with 1,150 kg/ha reference (currently show 500)
3. **Complete Sentinel-2 extent mapping** (Mar 2026)
4. **Market price survey** at Anakao, Ifaty, Salary, Toliara (Mar-Apr 2026)
5. **PA stratification** -- compare protected vs. unprotected reef condition
6. **Benthic habitat mapping** from Yves Amoros (University of Toliara)
7. **Ecosystem service accounts** -- nursery + provisioning with real prices and extent

Speaker notes: The Madagascar pilot has the richest biotic dataset in the project. The condition accounts are analytically complete (Steps 1-7 done). The remaining work is validation (transect area, market prices) and integration (extent, services, PA stratification). Emphasize that the 27-site, 227-species dataset is a major asset for WIO reef science beyond the SEEA EA framework.

---

## Appendix A: Facilitator Preparation Checklist

### Materials

- [ ] Print handouts: formula sheet, reference levels, blank account tables
- [ ] Pre-load Excel with MDG_fish_invert_site_condition.csv, MDG_fish_invert_site_fg_condition.csv
- [ ] Prepare answer keys for all 3 exercises
- [ ] Whiteboard + markers for live biomass calculation walkthrough
- [ ] Calculators or laptops with Excel for all participants

### Timing guide

| Slides | Content | Duration |
|--------|---------|----------|
| 1-4 | Introduction, dataset, steps | 25 min |
| 5-7 | Biomass calculation, formulas, reference levels | 30 min |
| 8-10 | Guided examples (biomass, COTS, trophic) | 30 min |
| 11-13 | SEEA EA table, heterogeneity, transect area | 20 min |
| -- | Break | 15 min |
| 14 | Exercise: site-level condition account | 35 min |
| 15 | Exercise: accounting-area aggregation | 20 min |
| 16 | Exercise: trophic composition | 15 min |
| 17 | Review and discussion | 25 min |
| 18-19 | Services linkage and looking ahead | 15 min |
| -- | **Total** | **~4 hours (half day with break)** |

---

## Appendix B: Exercise Answer Keys

### Exercise 1: Site-Level CIs

Example sites:

| Site | Biomass (kg/ha) | CI biomass | Richness | CI richness | COTS (ind/ha) | CI COTS | Composite |
|------|----------------|-----------|----------|-------------|---------------|---------|-----------|
| Ambitiky | 4,707 | 1.00 | 52 | 0.50 | 0 | 1.00 | 0.84 |
| Befasy | 635 | 0.55 | 33 | 0.32 | 0 | 1.00 | 0.62 |
| Ambatomilo | 498 | 0.43 | 36 | 0.35 | 0 | 1.00 | 0.59 |

### Exercise 2: Accounting-Area CI

2025 accounting-area mean biomass = 1,929 kg/ha
CI = min(1929 / 1150, 1.0) = 1.00

Mean of site-level CIs (many sites at 1.0, some below) will differ from 1.0.

---

## Appendix C: Common Participant Questions

**Q: Why is fish biomass CI = 1.0 for so many sites?**
A: The WIO reference (1,150 kg/ha) is a conservation target, not a pristine baseline. Many SW Madagascar sites exceed this level, which is good news ecologically. If you want to distinguish between "healthy" and "exceptionally healthy," use a higher reference (e.g., unfished baseline ~3,000 kg/ha from pristine no-take zones).

**Q: Why are there only 3 indicators in the Madagascar account?**
A: Benthic cover, coral health, and coral recruitment data are not yet available. The Madagascar pilot focuses on fish and invertebrate biotic condition. Additional indicators will be added when benthic habitat mapping (Yves Amoros) is integrated.

**Q: Can I use this methodology for freshwater fish?**
A: The biomass calculation (W = a x L^b) and CI normalisation are universal. You would need freshwater-specific allometric parameters (from FishBase) and appropriate reference levels for your ecosystem type.

---

*Version: 1.0*
*Created: 2026-03-29*
*Companion documents: MDG_SEEA_EA_METHODOLOGY.md, MDG_TRAINING_GUIDELINES.md*
