# Search Plan: Finding Baseline Reference Levels for Condition Indicators

Kenya Coastal Ecosystems — Coral Reef, Mangrove, Seagrass, and Fisheries Condition Accounts
Kilifi County, Western Indian Ocean

---

## Overview

This document provides a systematic search strategy to locate baseline/reference values for ecosystem condition indicators across four ecosystem types being assessed in Kilifi County, Kenya: coral reefs, mangrove forests, seagrass meadows, and coastal fisheries.

Goal: Establish peer-reviewed or institutionally credible reference levels for condition normalisation (0–1 indices), with regional priority given to Western Indian Ocean (WIO), East African coast, and Kenya-specific sources.

### Data Context

- Coral reef: ~9,500 records across 8 files from three survey programmes (CCVA Nov 2024, PU-GOAP Nov 2024, COMRED_OCEANS Jul 2025); Kanamai to Malindi MPA including Watamu MPA. Variables: fish UVC (species, count, size), invertebrate UVC, coral health (healthy/pale/bleached/diseased/dead), coral size structure (adult colonies by genus and size bin), coral recruits (0–10 cm quadrats), benthic cover (% live coral, dead coral, rubble, macro-algae, seagrass, sand).
- Mangrove: 2,095 tree-level observations from 38 plots (10x10 m) across 13 areas and 22 sites in Kilifi County (Sep–Dec 2025). Variables: DBH (cm), height (m), circumference (cm), canopy cover (% class), tree quality (1–3), species (4 spp.), regeneration count, stump count, inundation class (1–4), forest type. Note: coordinates stored as DMS strings requiring conversion; species names use both full scientific names and abbreviations.
- Seagrass: 1,604 cover observations (50x50 cm quadrats) and 1,436 health observations (15x15 cm quadrats) across 10–11 sites in Kilifi County (May–Nov 2024). Variables: % cover, shoot density (count/15x15 cm quadrat), canopy height (cm), 11 species recorded. Note: species name inconsistencies in raw data (e.g., "Thelassia" vs "Thalassia"); standardise before analysis.
- Fisheries: Annual landing statistics for Kilifi County, 2020–2024, sourced from Kenya Fisheries Service (KeFS) Annual Fisheries Statistics Bulletins. Variables: catch (MT), ex-vessel value (KES), ~37 species-level entries per year. Note: +172% catch growth 2020–2024 (4,452 to 12,094 MT); 2023 values are estimates; this trend affects reference level interpretation.

Data contact: Dr. Pascal Thoya, Pwani University (pascalthoya at gmail.com)

---

## ECOSYSTEM 1: MANGROVE CONDITION INDICATORS

### Measured Variables Available

| Variable | Unit | Ecological Role |
| --- | --- | --- |
| DBH (Diameter at Breast Height) | cm | Structural maturity; biomass proxy |
| Tree height | m | Canopy structure; stand health |
| Basal area (derived from DBH) | m²/ha | Stand-level structural integrity |
| Canopy cover | % range (categorical) | Stand-level light interception; closure |
| Tree quality | 1–3 scale | Structural health (1 = best) |
| Regeneration (seedlings + saplings) | count per plot (100 m²) | Forest recovery / recruitment |
| Stump count | count per plot (100 m²) | Degradation / harvesting pressure |
| Species composition | Categorical | Zonation health; disturbance response |
| Inundation class | 1–4 categorical | Tidal regime suitability |
| Forest type | Categorical | Stand type (monospecific / mixed) |

Species: Rhizophora mucronata (RM), Avicennia marina (AM), Ceriops tagal (CT), Bruguiera gymnorhiza (BG)

Sites: 22 sites across 13 areas — Ngomeni, Marereni, Mida Creek (Dabaso/Debaso), Kilifi Creek, Mtongani

Note: Species recorded as both full scientific names and two-letter abbreviations — standardise before analysis. Coordinates in DMS string format — convert to decimal degrees for GIS.

---

### INDICATOR M1: DBH AND TREE HEIGHT BY SPECIES

#### M1 — Data summary

- Sample measurements (Ngomeni, Sep 2025): Rhizophora mucronata DBH ~6.9–8.3 cm; height ~4–6 m
- Full dataset: 2,095 records across 22 sites in 13 areas
- No Kenya/WIO species-specific reference levels for "healthy" stand DBH or height confirmed

#### M1 — Valid baselines

- Peer-reviewed studies reporting mean DBH and/or tree height for WIO mangrove species
- Reference condition: intact forest, protected, or minimally degraded
- Species-specific preferred; genus-level acceptable if unavailable
- Clear methodology: DBH at 30 cm POM (standard for Rhizophora stilt roots) or standard 130 cm breast height
- Regional context: WIO, East Africa, Indian Ocean

#### M1 — Search terms

```text
("mangrove" OR "mangrove forest") AND ("DBH" OR "diameter at breast height"
OR "basal area" OR "stem diameter")
AND ("Rhizophora mucronata" OR "Avicennia marina" OR "Ceriops tagal"
     OR "Bruguiera gymnorhiza")
AND ("reference" OR "baseline" OR "intact" OR "healthy" OR "undisturbed")
AND ("Kenya" OR "East Africa" OR "Western Indian Ocean" OR "WIO"
     OR "Indian Ocean" OR "Tanzania" OR "Mozambique" OR "Seychelles")
```

Variant searches:

- `("mangrove structure" OR "stand structure") AND ("DBH" OR "diameter") AND ("Kenya" OR "WIO") AND (year >= 2005)`
- `("mangrove condition" OR "forest condition") AND ("diameter" OR "height") AND ("East African coast" OR "Swahili coast")`
- `("mangrove biomass") AND ("allometric" OR "DBH") AND ("Rhizophora" OR "Avicennia") AND ("Indian Ocean")`
- `("Rhizophora" OR "stilt root mangrove") AND ("point of measurement" OR "POM" OR "30 cm above")`

#### M1 — Journals and databases

| Source | Type | Rationale |
| --- | --- | --- |
| Forest Ecology and Management | Journal | Mangrove structural assessments; allometric equations |
| Wetlands Ecology and Management | Journal | WIO mangrove condition studies |
| Estuarine, Coastal and Shelf Science | Journal | Coastal mangrove ecology; East Africa coverage |
| Hydrobiologia | Journal | Mangrove-associated ecology |
| WIOMSA (WIO Marine Science Association) | Grey lit. | Kenya/Tanzania/Mozambique technical reports |
| KMFRI (Kenya Marine and Fisheries Research Institute) | Grey lit. | National mangrove inventories; condition assessments |

#### M1 — Success criteria

- Found 2+ Kenya or East Africa studies reporting mean DBH and height by species in intact/reference mangroves
- Species-specific reference values documented for at least 2 of the 4 target species
- POM methodology noted to assess comparability with field data (30 cm rule for Rhizophora)

#### M1 — Expected output

| Reference | Region | Species | Mean DBH (cm) | Mean Height (m) | Category |
| --- | --- | --- | --- | --- | --- |
| [TBD] | Kenya/WIO | Rhizophora mucronata | [TBD] | [TBD] | Reference intact |
| [TBD] | Kenya/WIO | Avicennia marina | [TBD] | [TBD] | Reference intact |
| [TBD] | Kenya/WIO | Ceriops tagal | [TBD] | [TBD] | Reference intact |
| [TBD] | Kenya/WIO | Bruguiera gymnorhiza | [TBD] | [TBD] | Reference intact |
| Kenya field 2025 | Kilifi County | Rhizophora mucronata | ~7–8 | ~4–6 | Current state |

---

### INDICATOR M2: BASAL AREA (m²/ha)

#### M2 — Current reference

- No Kenya-specific reference established
- Global mangrove reference: 15–35 m²/ha for healthy tropical mangrove (Spalding et al. 2010 general reference)
- Issue: Highly variable by species composition, zonation, and climate zone; WIO-specific reference needed

#### M2 — Search terms

```text
("mangrove" OR "mangrove stand") AND ("basal area" OR "stem density"
OR "stand structure")
AND ("m2/ha" OR "m² ha⁻¹" OR "hectare")
AND ("reference" OR "intact" OR "undisturbed" OR "healthy" OR "protected")
AND ("Kenya" OR "East Africa" OR "WIO" OR "Indian Ocean" OR "Tanzania"
     OR "Mozambique")
```

Variant searches:

- `("mangrove basal area") AND ("species composition") AND ("East Africa" OR "WIO")`
- `("forest structure") AND ("mangrove") AND ("density" OR "basal area") AND (year >= 2010)`

#### M2 — Success criteria

- Found 2+ WIO studies with basal area reference ranges for intact mangroves
- Values differentiated by species or forest type where possible

---

### INDICATOR M3: REGENERATION DENSITY (seedlings + saplings per plot)

#### M3 — Current reference

- No Kenya baseline established
- Regeneration is a key indicator of forest recovery and long-term structural health
- Threshold for "adequate" vs "degraded" recruitment not defined for WIO species

#### M3 — Search terms

```text
("mangrove regeneration" OR "mangrove recruitment" OR "mangrove seedlings"
OR "mangrove saplings")
AND ("density" OR "abundance" OR "count" OR "per hectare" OR "per m²")
AND ("reference" OR "healthy" OR "intact" OR "protected")
AND ("Kenya" OR "WIO" OR "East Africa" OR "Indian Ocean")
```

Variant searches:

- `("mangrove restoration" OR "mangrove recovery") AND ("seedling density" OR "recruitment") AND ("East Africa")`
- `("Rhizophora propagule" OR "Avicennia seedling") AND ("density") AND ("WIO" OR "Indian Ocean coast")`
- `("mangrove degradation indicator") AND ("regeneration" OR "understory") AND ("tropical")`

#### M3 — Success criteria

- Found 2+ studies with seedling/sapling density reference values from WIO or comparable tropical mangroves
- Threshold for "adequate regeneration" identified (e.g., >X seedlings/100 m² indicates healthy recruitment)

---

### INDICATOR M4: STUMP DENSITY (disturbance/harvesting indicator)

#### M4 — Current reference

- No formal threshold established; stumps indicate active harvesting or past disturbance
- No peer-reviewed threshold for "acceptable" stump density; likely requires local expert knowledge or grey literature

#### M4 — Search terms

```text
("mangrove harvesting" OR "mangrove cutting" OR "mangrove degradation")
AND ("stump" OR "felling" OR "logging" OR "overexploitation")
AND ("indicator" OR "assessment" OR "index" OR "threshold")
AND ("Kenya" OR "East Africa" OR "WIO" OR "tropical")
```

Variant searches:

- `("mangrove condition index") AND ("disturbance" OR "degradation indicator") AND (stump OR harvest)`
- `("SEEA EA" OR "ecosystem condition") AND ("mangrove") AND ("degradation indicator")`
- `("mangrove governance" OR "community forestry") AND ("cutting rate" OR "harvest intensity") AND ("East Africa")`

Alternative approach: search for SEEA EA or IPBES condition indicator frameworks that specify accepted disturbance thresholds; contact KMFRI or KFS (Kenya Forest Service) for national mangrove condition assessment protocols.

#### M4 — Success criteria

- Found a credible protocol or threshold for stump density as a degradation indicator (grey literature acceptable)
- Quantitative threshold identified (e.g., >X stumps/ha = degraded)

---

### INDICATOR M5: CANOPY COVER AND TREE QUALITY

#### M5 — Data summary

- Canopy cover recorded as % class ranges (e.g., 20–40%) per plot
- Tree quality recorded on 1–3 scale (3 = live tree confirmed in sample rows; scale direction requires clarification with data owner)
- No WIO reference for "healthy" canopy cover class or quality score distribution established

#### M5 — Valid baselines

- Studies reporting canopy closure or canopy cover (%) for intact WIO mangrove stands
- Reference: undisturbed or lightly managed forest
- Quality/vigour scoring protocols used in comparable East African mangrove assessments

#### M5 — Search terms

```text
("mangrove canopy cover" OR "canopy closure" OR "canopy density")
AND ("reference" OR "intact" OR "undisturbed" OR "healthy")
AND ("Kenya" OR "WIO" OR "East Africa" OR "Indian Ocean")
```

Variant searches:

- `("mangrove vitality" OR "tree vigour" OR "crown condition") AND ("assessment protocol") AND ("East Africa" OR "tropical")`
- `("canopy cover" OR "canopy closure") AND ("mangrove stand") AND (year >= 2005) AND ("WIO" OR "Indian Ocean coast")`

#### M5 — Success criteria

- Found a WIO or comparable protocol defining canopy cover thresholds for healthy vs degraded mangrove
- Tree quality/vigour scoring system identified (to calibrate the 1–3 scale used in field data)

---

## ECOSYSTEM 2: SEAGRASS CONDITION INDICATORS

### Seagrass — Measured Variables Available

| Variable | Unit | Ecological Role |
| --- | --- | --- |
| % cover | Percent | Primary abundance/extent indicator |
| Shoot density | count per 15x15 cm quadrat | Biomass proxy; productivity |
| Canopy height | cm | Biomass proxy; habitat structure |
| Species composition | Categorical (11 species) | Assemblage health; diversity |
| Substrate type | Categorical | Habitat suitability |

Species recorded (11): Cymodocea rotundata, Cymodocea serrulata, Enhalus acoroides, Halodule uninervis, Halodule wrightii, Halophila ovalis, Halophila stipulacea, Syringodium isoetifolium, Thalassodendron ciliatum, Thalassia hemprichii

Sites: 10–11 areas — Bofa, Kanamai, Kikambala, Kuruwitu, Malindi Marine Park, Marereni, Ngomeni, Roka, Takaungu, Wesa

Zones (health sheet): Near shore, Middle, Near reef

Note: Taxonomy inconsistencies in raw data — "Thelassia" for Thalassia, "Halophilia" for Halophila, "Halodulle" for Halodule; standardise before analysis.

---

### INDICATOR S1: SEAGRASS PERCENTAGE COVER

#### S1 — Data summary

- Example observation: Kanamai-Jumba, Cymodocea rotundata = 80% cover; 20% sand
- Dataset: 1,604 cover observations across 10 sites; 11 species or substrate types recorded
- No WIO reference for "healthy" vs "degraded" seagrass cover established for these species

#### S1 — Valid baselines

- Peer-reviewed studies reporting % cover reference for WIO/Indian Ocean seagrass
- Reference condition: pristine, unexploited, low turbidity, or well-protected site
- Species-specific preferred (Cymodocea, Thalassia); multi-species acceptable
- Comparable method: quadrat visual estimate (50x50 cm or 25x25 cm)
- Regional context: WIO, East Africa, Indian Ocean, or Indo-Pacific

#### S1 — Search terms

```text
("seagrass" OR "seagrass meadow") AND ("percentage cover" OR "% cover"
OR "shoot density" OR "abundance")
AND ("reference" OR "baseline" OR "pristine" OR "healthy" OR "intact"
     OR "undisturbed")
AND ("Kenya" OR "WIO" OR "Western Indian Ocean" OR "East Africa"
     OR "Indian Ocean" OR "Tanzania" OR "Mozambique" OR "Seychelles")
```

Variant searches:

- `("Cymodocea rotundata" OR "Thalassia hemprichii") AND ("cover" OR "density") AND ("Indian Ocean" OR "WIO")`
- `("seagrass condition") AND ("reference level" OR "target state") AND ("tropical" OR "Indian Ocean")`
- `("seagrass cover") AND ("healthy meadow" OR "dense meadow") AND ("WIO" OR "East African coast")`
- `("seagrass decline" OR "seagrass loss") AND ("baseline" OR "historical reference") AND ("Indian Ocean")`

#### S1 — Journals and databases

| Source | Type | Rationale |
| --- | --- | --- |
| Aquatic Botany | Journal | Primary seagrass ecology venue; strong WIO coverage |
| Marine Ecology Progress Series | Journal | Seagrass community dynamics; quantitative baselines |
| Estuarine, Coastal and Shelf Science | Journal | WIO coastal ecosystem studies |
| Marine Pollution Bulletin | Journal | Seagrass condition in degraded systems; reference comparison |
| WIOMSA Monographs | Grey lit. | Kenya/Tanzania/Mozambique seagrass inventories |
| SeagrassNet | Database | Global seagrass monitoring network; WIO reference stations |

#### S1 — Success criteria

- Found 3+ WIO or Indian Ocean studies with seagrass % cover reference values
- Species-specific reference for Cymodocea rotundata and/or Thalassia hemprichii
- "Healthy" vs "degraded" cover ranges identified (e.g., healthy >60%; degraded <30%)

#### S1 — Expected output

| Reference | Region | Species | Cover (%) | Category |
| --- | --- | --- | --- | --- |
| [TBD] | WIO/East Africa | Cymodocea rotundata | [TBD] | Reference intact |
| [TBD] | WIO/East Africa | Thalassia hemprichii | [TBD] | Reference intact |
| Kenya 2024 | Kilifi County | Cymodocea rotundata | 80 (sample) | Current |

---

### INDICATOR S2: SHOOT DENSITY (shoots/m²)

#### S2 — Data summary

- Sheet "SEAGRASS HEALTH": shoot density in 15x15 cm quadrats; canopy height (cm)
- Example: Kanamai, nearshore, Thalassia hemprichii, shoot density = 41; canopy height 9–12 cm
- No WIO reference density established for these species

#### S2 — Valid baselines

- Peer-reviewed studies reporting shoot density for Thalassia hemprichii and Cymodocea rotundata
- Method: 15x15 cm or 25x25 cm quadrats; shoot counts converted to shoots/m²
- Reference condition: healthy meadow, low disturbance
- Regional: WIO, Indian Ocean, Indo-Pacific

#### S2 — Search terms

```text
("seagrass shoot density" OR "shoot count" OR "shoots per m²")
AND ("Thalassia hemprichii" OR "Cymodocea rotundata" OR "Halodule uninervis"
     OR "Syringodium isoetifolium")
AND ("reference" OR "baseline" OR "healthy" OR "dense")
AND ("Indian Ocean" OR "WIO" OR "East Africa" OR "Indo-Pacific")
```

Variant searches:

- `("Thalassia hemprichii") AND ("shoot density") AND ("Indian Ocean" OR "Kenyan coast" OR "WIO")`
- `("seagrass density") AND ("quadrat") AND ("species-specific baseline") AND (year >= 2005)`
- `("seagrass biomass") AND ("above-ground" OR "canopy height") AND ("WIO" OR "East Africa") AND reference`

#### S2 — Success criteria

- Found 2+ studies reporting shoot density reference for Thalassia hemprichii and/or Cymodocea rotundata from WIO
- Canopy height reference values for same species
- Conversion factor documented (quadrat size to per-m²)

---

### INDICATOR S3: SPECIES COMPOSITION AND ASSEMBLAGE HEALTH

#### S3 — Current reference

- Species observed: Cymodocea rotundata (dominant at Kanamai), Thalassia hemprichii; 11 species total recorded
- WIO seagrass assemblage typically 6–9 species in East African coastal meadows
- No reference "healthy assemblage" composition established for Kilifi specifically

#### S3 — Search terms

```text
("seagrass species composition" OR "seagrass community" OR "seagrass assemblage")
AND ("reference" OR "intact" OR "healthy" OR "pristine")
AND ("Kenya" OR "WIO" OR "East Africa" OR "Indian Ocean")
AND ("Cymodocea" OR "Thalassia" OR "Halodule" OR "Syringodium" OR "Halophila"
     OR "Enhalus")
```

Variant searches:

- `("seagrass diversity") AND ("East Africa" OR "Kenyan coast") AND ("species richness" OR "assemblage")`
- `("seagrass meadow") AND ("multispecies" OR "monospecific") AND ("reference condition") AND ("WIO")`

Key grey literature targets: KMFRI has conducted seagrass surveys along the Kenyan coast — search for published inventories or condition reports. Check UNEP Nairobi Convention regional seagrass assessments for WIO.

---

## ECOSYSTEM 3: FISHERIES CONDITION INDICATORS

### Fisheries — Measured Variables Available

| Variable | Unit | Ecological Role |
| --- | --- | --- |
| Annual catch | Metric tonnes (MT) | Total fisheries production |
| Ex-vessel value | KES (thousands) | Economic productivity proxy |
| Species group | Categorical | Trophic composition of landings |
| Species-level catch | MT per species per year | Exploitation rate by stock |

Coverage: Kilifi County, 2020–2024. Annual totals: 4,452 MT (2020) → 12,094 MT (2024); +172% growth over period; 2023 values are estimates.

Key species in 2024: Rabbit fish 751 MT, Snapper 395 MT, plus crustaceans, molluscs, sharks/rays.

Note: This is secondary landings data (KeFS monitoring), not a field condition survey. Fisheries data link most directly to provisioning service accounts, but can support biotic condition indicators through species composition trends and CPUE analysis if effort data are obtainable from KeFS. The +172% growth trend warrants caution in selecting any single year as a baseline.

---

### INDICATOR F1: REFERENCE CATCH LEVELS AND SUSTAINABLE YIELD

#### F1 — Current reference

- No Kenya or Kilifi-specific maximum sustainable yield (MSY) established in this dataset
- Kenya national marine catch: ~100,000–150,000 MT/yr (approximate; KeFS figures vary)
- Kilifi County: ~4,400–4,600 MT/yr (2020–2021); rising sharply to 12,094 MT by 2024
- No species-level reference biomass or MSY reference point established for Kilifi stocks

#### F1 — Valid baselines

- Peer-reviewed or government stock assessment reports with MSY or BMSY reference points for Kenyan/WIO demersal and pelagic species
- CPUE trends as a proxy for stock status relative to unfished reference
- Species-level catch comparison to historical KeFS data (pre-2020 bulletins)
- FAO/KMFRI fisheries reports with reference production estimates

#### F1 — Search terms

```text
("Kenya fisheries" OR "Kenyan coast fisheries") AND ("catch" OR "landings"
OR "CPUE" OR "maximum sustainable yield" OR "MSY")
AND ("reference" OR "baseline" OR "stock assessment" OR "biomass reference")
AND ("Kilifi" OR "Indian Ocean" OR "WIO" OR "East Africa")
```

Variant searches:

- `("Kenya Fisheries Service" OR "KMFRI") AND ("stock assessment" OR "fisheries statistics") AND ("marine fish")`
- `("small-scale fisheries") AND ("catch per unit effort") AND ("Kenya" OR "East Africa") AND ("baseline")`
- `("reef fisheries") AND ("CPUE trend" OR "catch decline") AND ("WIO" OR "Indian Ocean")`
- `("demersal fish") AND ("MSY" OR "sustainable yield") AND ("Kenya" OR "WIO") AND year >= 2010`

#### F1 — Journals and databases

| Source | Type | Rationale |
| --- | --- | --- |
| Fisheries Research | Journal | Stock assessments; MSY reference points |
| Coastal Fisheries Initiative | Grey lit. | WIO small-scale fisheries baselines |
| KeFS Annual Bulletins (pre-2020) | Grey lit. | Historical baseline; pre-dataset trends |
| KMFRI Technical Reports | Grey lit. | Kenya-specific stock assessments |
| FAO Fisheries Country Profiles — Kenya | Grey lit. | National reference levels; total allowable catch |
| Ocean Health Index — Kenya | Grey lit. | Species-level stock status scores (B/BMSY) |
| SWIOFISH (World Bank WIO project) | Grey lit. | Regional fisheries management baselines |

#### F1 — Success criteria

- Found a Kenya or East African Coast reference catch level for key species (Snapper, Rabbit fish, Crustaceans)
- CPUE baseline or trend data identified to assess stock status relative to reference
- MSY or BMSY reference point identified for at least one major commercial species group

#### F1 — Expected output

| Reference | Region | Species/Group | Reference catch or CPUE | Category |
| --- | --- | --- | --- | --- |
| [KeFS historical TBD] | Kenya/Kilifi | All marine | [TBD] MT/yr | Historical baseline |
| [TBD] | WIO | Snapper (Lutjanidae) | [TBD] | MSY reference |
| [TBD] | Kenya | Rabbit fish (Siganidae) | [TBD] | CPUE reference |
| Kenya 2020–2024 | Kilifi County | All marine | 4,400–12,094 MT/yr | Current (rising trend) |

---

### INDICATOR F2: SPECIES COMPOSITION OF LANDINGS (trophic integrity proxy)

#### F2 — Current reference

- 2024 key species: Rabbit fish (Siganidae — herbivore), Snapper (Lutjanidae — piscivore/demersal), plus crustaceans and molluscs
- No reference trophic composition of landings established for Kenyan or WIO reef fisheries

#### F2 — Search terms

```text
("reef fisheries" OR "coral reef fisheries" OR "coastal fisheries")
AND ("trophic composition" OR "species composition" OR "landing composition")
AND ("baseline" OR "reference" OR "unexploited" OR "lightly fished")
AND ("Kenya" OR "WIO" OR "East Africa" OR "Indian Ocean")
```

Variant searches:

- `("fisheries trophic level") AND ("mean trophic level" OR "landing trophic") AND ("Indian Ocean" OR "WIO")`
- `("fishing down food web") AND ("reef" OR "coastal") AND ("East Africa" OR "Kenya")`
- `("Siganidae" OR "Lutjanidae") AND ("Kenya" OR "WIO") AND ("reference catch" OR "baseline abundance")`

Key grey literature targets: KeFS pre-2020 bulletins for historical species composition of Kilifi landings (request from Pascal Thoya or KeFS directly); SWIOFISH reports for WIO species-level catch composition baselines.

---

## ECOSYSTEM 4: CORAL REEF CONDITION INDICATORS

### Coral Reef — Measured Variables Available

| Variable | Unit | Survey Source | Ecological Role |
| --- | --- | --- | --- |
| Fish count by species and size class | Count + cm | CCVA, KLF, COMRED fish sheets | Biomass calculation; community composition |
| Fish biomass (derived) | kg/ha | All fish UVC files | Primary fish condition indicator |
| Fish species richness | Species count per transect | All fish UVC files | Diversity indicator |
| Invertebrate count by species | Count per transect | CCVA-INVERTS (279 rows) | COTS, urchin, other invertebrates |
| Coral health status | % healthy/pale/bleached/diseased/dead | COMRED + PU-GOAP condition sheets | Coral biotic condition |
| Adult coral colony size structure | Colony count by genus and size bin (11–>320 cm) | COMRED + PU-GOAP adult size sheets | Population structure; age distribution |
| Coral recruits (juveniles) | Count by genus and size bin (0–10 cm) per quadrat | COMRED + PU-GOAP recruits sheets | Recruitment success; reef recovery |
| Benthic cover | % live coral, dead coral, rubble, macro-algae, sand, seagrass | COMRED cover + PU-GOAP extent sheets | Habitat structural condition |

Survey programmes: CCVA (Nov 2024), PU-GOAP (Nov 2024), COMRED_OCEANS (Jul 2025)

Sites: Kanamai to Malindi MPA — Watamu MPA, Roka, Wesa, Uyombo, Takaungu, Bamsa, Maliwai, Ras Ngomeni

Multi-year potential: COMRED-CORAL-DATA spans 2024–2025 enabling trend detection.

Note: Transect area assumptions require confirmation with field teams before biomass calculations (same issue as Madagascar pilot).

---

### INDICATOR CR1: FISH BIOMASS (kg/ha)

#### CR1 — Current reference

- No Kenya/Kilifi-specific reference established in this dataset
- Madagascar pilot uses McClanahan et al. 2016 WIO conservation target: 1,150 kg/ha; sustainability floor 600 kg/ha
- These WIO references are directly applicable to Kilifi as the same regional baseline applies

#### CR1 — Valid baselines

- Peer-reviewed studies reporting fish biomass (kg/ha) at Kenyan or WIO coral reefs
- Reference condition: protected area, low-exploitation site, or conservation target
- UVC method with disclosed transect area and L-W allometric approach

#### CR1 — Search terms

```text
("reef fish biomass" OR "fish standing stock") AND ("kg/ha" OR "kg ha⁻¹")
AND ("reference" OR "target" OR "conservation target" OR "pristine" OR "protected")
AND ("Kenya" OR "WIO" OR "Western Indian Ocean" OR "East Africa"
     OR "Indian Ocean" OR "Watamu" OR "Malindi")
```

Variant searches:

- `("reef fish biomass") AND ("Kenyan coast" OR "Watamu" OR "Malindi" OR "Kilifi") AND (year >= 2010)`
- `("McClanahan" OR "KMFRI") AND ("fish biomass" OR "standing stock") AND ("Kenya" OR "WIO")`
- `("no-take zone" OR "marine reserve") AND ("fish biomass") AND ("Kenya" OR "East Africa")`

#### CR1 — Success criteria

- Kenya-specific or WIO fish biomass reference confirmed (McClanahan et al. 2016 likely sufficient; seek corroborating Kenya study)
- Protected vs. unprotected comparison available for Kilifi/Watamu/Malindi MPA

---

### INDICATOR CR2: CORAL COVER (% live coral)

#### CR2 — Data summary

- Benthic cover recorded in COMRED cover sheets and PU-GOAP extent sheet: % live coral, dead coral, rubble, seagrass, macro-algae, sand
- Multi-year data: COMRED spans 2024–2025 at Watamu MPA, Roka, Uyombo, Wesa
- No Kenya-specific "healthy" coral cover reference established

#### CR2 — Valid baselines

- Peer-reviewed studies reporting % live coral cover reference for Kenyan or WIO reefs
- Reference condition: protected area, pre-bleaching baseline, or minimally degraded reef
- Point intercept transect (PIT) or photoquadrat method comparable to COMRED/PU-GOAP approach
- Regional: WIO, Kenya, Tanzania, Seychelles

#### CR2 — Search terms

```text
("coral cover" OR "live coral cover" OR "hard coral cover")
AND ("reference" OR "baseline" OR "healthy" OR "pristine" OR "protected")
AND ("Kenya" OR "WIO" OR "Western Indian Ocean" OR "East Africa"
     OR "Watamu" OR "Malindi" OR "Indian Ocean")
```

Variant searches:

- `("coral cover") AND ("Watamu" OR "Malindi" OR "Kilifi" OR "Kenyan reef") AND (year >= 2005)`
- `("GCRMN" OR "Reef Check") AND ("Kenya") AND ("coral cover" OR "reef health")`
- `("bleaching" OR "mass bleaching") AND ("Kenya" OR "WIO") AND ("pre-bleaching" OR "coral cover before")`

#### CR2 — Journals and databases

| Source | Rationale |
| --- | --- |
| Coral Reefs | Primary venue; WIO coral cover studies |
| Marine Ecology Progress Series | Kenya reef condition studies |
| GCRMN Reports | Global Coral Reef Monitoring Network; Kenya data |
| Reef Check Kenya | NGO monitoring; Watamu/Malindi MPA annual reports |
| CORDIO East Africa | Regional coral reef condition reports |

#### CR2 — Success criteria

- Found 2+ Kenya or WIO studies with live coral cover reference values
- Pre-bleaching or protected site baseline identified for Watamu or Malindi MPA
- "Healthy" threshold defined (e.g., >25% live coral considered healthy in WIO context)

---

### INDICATOR CR3: CORAL HEALTH STATUS (% healthy colonies)

#### CR3 — Data summary

- 5 condition categories recorded: Healthy, Pale, Bleached, Diseased, Dead
- Data from COMRED condition sheet (Jul 2025) and PU-GOAP condition sheets (Nov 2024) by genus and size class
- No WIO reference for "acceptable" proportion of healthy vs bleached/diseased colonies

#### CR3 — Search terms

```text
("coral health" OR "coral condition" OR "coral bleaching")
AND ("bleaching prevalence" OR "disease prevalence" OR "healthy colonies"
     OR "percentage healthy")
AND ("reference" OR "background level" OR "low stress" OR "baseline")
AND ("Kenya" OR "WIO" OR "Indian Ocean" OR "East Africa")
```

Variant searches:

- `("coral bleaching") AND ("background bleaching" OR "pre-bleaching") AND ("WIO" OR "Indian Ocean")`
- `("coral disease") AND ("prevalence" OR "background rate") AND ("WIO" OR "Indian Ocean")`
- `("thermal stress") AND ("coral condition") AND ("Kenya" OR "Watamu" OR "WIO") AND (year >= 2016)`

#### CR3 — Success criteria

- Background bleaching prevalence reference identified for WIO (e.g., healthy reefs <5% bleached)
- Post-bleaching recovery trajectory documented for WIO context (useful for interpreting Jul 2025 data)

---

### INDICATOR CR4: CORAL SIZE STRUCTURE AND RECRUITMENT

#### CR4 — Data summary

- Adult colony size bins: 11–20, 21–40, 41–80, 80–160, 160–320, >320 cm by genus
- Juvenile recruits: 0–2.5, 2.6–5, 6–10 cm by genus in quadrats
- No reference size-frequency distribution or recruitment density established for Kilifi reefs

#### CR4 — Search terms

```text
("coral size structure" OR "colony size distribution" OR "size frequency")
AND ("reference" OR "healthy" OR "intact" OR "protected")
AND ("Kenya" OR "WIO" OR "Indian Ocean" OR "East Africa")
```

Variant searches:

- `("coral recruitment" OR "recruit density") AND ("ind/m²" OR "count per quadrat") AND ("WIO" OR "Indian Ocean")`
- `("juvenile coral" OR "coral spat") AND ("reference density") AND ("Indian Ocean" OR "WIO")`
- `("coral population structure") AND ("baseline" OR "undisturbed") AND ("East Africa" OR "Indian Ocean")`

#### CR4 — Success criteria

- Reference recruit density identified for WIO (recruits/m²) for key genera (Acropora, Porites, Pocillopora)
- Expected adult size-frequency distribution for healthy WIO reef documented

---

## CROSS-CUTTING: REGIONAL WIO ECOSYSTEM CONDITION BASELINES

For indicators where Kenya or Kilifi-specific data are unavailable, broaden to WIO:

```text
("coral reef" OR "mangrove" OR "seagrass" OR "coastal fisheries") AND
("condition assessment" OR "ecosystem condition" OR "reference level" OR "baseline")
AND ("Western Indian Ocean" OR "WIO" OR "East Africa" OR "Swahili coast"
     OR "Kenyan coast" OR "Tanzania" OR "Mozambique")
AND (year >= 2010)
```

Key geographic proxies for Kenya data gaps:

- Tanzania — most comparable coast; Mafia Island, Zanzibar seagrass and mangrove baselines
- Mozambique — Inhambane Bay mangrove structural data; comparable species composition
- Seychelles — High-quality seagrass monitoring data; may serve as pristine reference
- Kenya (national scale) — KMFRI national mangrove and seagrass inventories; search for published reports

---

## CRITICAL APPRAISAL CHECKLIST

When evaluating a source for inclusion as a baseline reference:

- [ ] Peer-reviewed or credible institution? (KMFRI, WIOMSA, FAO, World Bank acceptable for grey literature)
- [ ] Methods transparent? Can I assess comparability to Kilifi field methods (10x10 m plots, 50x50 cm quadrats, 15x15 cm shoot density)?
- [ ] Sample size adequate? (n >= 3 sites for multi-site averages; single PA acceptable if context is clear)
- [ ] Reference condition explicit? Does the paper state "intact," "healthy," "lightly exploited," or "protected"?
- [ ] Regional relevance? WIO, East Africa, Indian Ocean, or clearly analogous tropical coast
- [ ] Temporal: Recent (<15 yrs preferred); pre-disturbance data also valuable for historical baselines
- [ ] Quantitative values reported? Not qualitative descriptions only
- [ ] Uncertainty ranges? SD, SE, CI, or range provided?

---

## EXECUTION ROADMAP

### Phase 1: Quick Scan (1 week)

1. Google Scholar quick searches for each indicator (5–10 min per indicator)
2. Identify 3–5 promising papers per indicator
3. Extract: title, authors, year, region, key values, method

### Phase 2: Detailed Review (2 weeks)

1. Access full-text papers (institutional library, ResearchGate, or email authors)
2. Document reference values in tables above
3. Assess comparability to Kilifi methods (plot size, quadrat dimensions, species)
4. Flag data gaps

### Phase 3: Institutional and Grey Literature Outreach (1 week)

1. Email KMFRI (Kenya Marine and Fisheries Research Institute) for mangrove national inventory data, seagrass condition assessment reports, and pre-2020 Kilifi fisheries catch statistics
2. Contact Pascal Thoya for any additional reference data or WIOMSA contacts
3. Check FAO Fisheries Country Profile — Kenya and KeFS bulletins (online or via Pascal)
4. Check SWIOFISH / World Bank WIO fisheries project reports for stock reference levels

### Phase 4: Synthesis (1 week)

1. Consolidate findings in master reference table below
2. Identify remaining gaps
3. Write short methods note for SEEA EA publication: "Reference level validation" section

---

## MASTER BASELINE REFERENCE TABLE (to complete)

| Indicator | Ecosystem | Current Reference | Region | Value(s) | Confidence | Gap Status |
| --- | --- | --- | --- | --- | --- | --- |
| DBH (cm) by species | Mangrove | None | — | — | LOW | CRITICAL GAP |
| Tree height (m) | Mangrove | None | — | — | LOW | CRITICAL GAP |
| Basal area (m²/ha) | Mangrove | Spalding et al. 2010 (global) | Global | 15–35 | LOW | Need WIO |
| Canopy cover (%) | Mangrove | None | — | — | LOW | CRITICAL GAP |
| Tree quality threshold | Mangrove | None | — | — | LOW | CRITICAL GAP |
| Regeneration density | Mangrove | None | — | — | LOW | CRITICAL GAP |
| Stump density threshold | Mangrove | None | — | — | LOW | CRITICAL GAP |
| % cover (Cymodocea) | Seagrass | None | — | — | LOW | CRITICAL GAP |
| % cover (Thalassia) | Seagrass | None | — | — | LOW | CRITICAL GAP |
| Shoot density | Seagrass | None | — | — | LOW | CRITICAL GAP |
| Canopy height | Seagrass | None | — | — | LOW | CRITICAL GAP |
| Annual catch reference (MT) | Fisheries | None | — | — | LOW | CRITICAL GAP |
| CPUE baseline | Fisheries | None | — | — | LOW | CRITICAL GAP |
| Fish biomass (kg/ha) | Coral reef | McClanahan et al. 2016 | WIO | 1,150 kg/ha | MEDIUM | Need Kenya validation |
| Live coral cover (%) | Coral reef | None | — | — | LOW | CRITICAL GAP |
| % healthy colonies | Coral reef | None | — | — | LOW | CRITICAL GAP |
| Recruit density (ind/m²) | Coral reef | None | — | — | LOW | CRITICAL GAP |

---

## ADDITIONAL RESOURCES

### Online Databases

1. OBIS (Ocean Biodiversity Information System): <https://obis.org> — species occurrence data for WIO mangrove and seagrass
2. SeagrassNet: <https://www.seagrassnet.org> — global seagrass monitoring data; check for WIO/Kenya stations
3. Global Mangrove Watch: <https://www.globalmangrovewatch.org> — extent and structural condition data
4. GEDI / ICESat-2: satellite-derived tree height data (may provide large-area reference height estimates)
5. Ocean Health Index — Kenya: <https://ohiprep.nceas.ucsb.edu> — stock status B/BMSY scores for Kenyan fisheries
6. FAO FishStat: <https://www.fao.org/fishery> — national catch statistics for Kenya (historical baseline)

### Key Institutional Contacts

- KMFRI (Kenya Marine and Fisheries Research Institute): primary national authority on fisheries and coastal ecosystems; Mombasa headquarters
- WIOMSA (Western Indian Ocean Marine Science Association): regional science network; publishes WIO ecosystem condition studies
- SWIOFISH (World Bank): regional fisheries management reference data
- UNEP Nairobi Convention: WIO coastal ecosystem condition assessments

### Existing Sources from Madagascar Academic RAG

The following sources from the Madagascar RAG system (Madagascar/docs/rag/academic/) may contain transferable WIO baselines relevant to Kenya:

- MacNeil et al. 2015 (source_2026_wio_019): fish biomass reference levels — applicable if Kenya coral reef condition accounts are developed
- McClanahan et al. 2016: WIO conservation target biomass — relevant for any Kenya reef fish analysis
- WIO seagrass and mangrove literature in that system should be cross-checked against Kenya needs

---

Document created: 2026-03-16
Status: Phase 1 COMPLETE (2026-03-16) — provisional baselines compiled for all 15 indicators across 4 ecosystems via knowledge synthesis (training literature to August 2025; WebSearch not available); see BASELINE_REFERENCE_TABLE.md Part 2 for compiled values
Ecosystems: Mangrove, Seagrass, Fisheries provisioning, Coral Reef (M1.3)
Location: Kilifi County, Kenya
Data contact: Dr. Pascal Thoya, Pwani University (pascalthoya at gmail.com)
Phase 1 completed: 2026-03-16 — 15 condition indicators covered; 8 priority Phase 2 sources identified
Phase 2 target: 2026-04-21 — retrieve 8 priority full-text sources; resolve seagrass shoot density conversion; obtain pre-2020 KeFS Kilifi catch data
Phase 3 target: 2026-04-28 — KMFRI and CORDIO outreach; request raw CAS data; verify CORDIO monitoring baseline
Owner: Kenya pilot lead + KMFRI liaison
Key findings from Phase 1:

- Mangrove (M1-M5): HIGH confidence baselines available from Kairo, Bosire, Dahdouh-Guebas Kenya studies; stump density threshold only LOW confidence (grey literature)
- Seagrass (S1-S3): MEDIUM confidence; CRITICAL issue — Kanamai T. hemprichii shoot density converts to 1,820 shoots/m² after 44.4x quadrat conversion, far above WIO reference (380-650 shoots/m²); resolve methodology with data owner before normalising
- Fisheries (F1-F2): Kilifi +172% catch growth 2020-2024 primarily reflects improved monitoring coverage + COVID-19 base effect (not genuine stock recovery); use pre-2020 KeFS data as baseline
- Coral reef (CR1-CR4): Fish biomass reference HIGH (McClanahan et al. 2016: 1,150 kg/ha); coral cover and recruit density are CRITICAL GAPS; July 2025 COMRED data interpreted as post-2024 mass bleaching snapshot
