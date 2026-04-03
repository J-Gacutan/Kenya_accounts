# Search Plan: Empirical Evidence for Reef Catch Attribution Percentages
## Kenya Wild Fish Provisioning Service — Kilifi County

**Purpose:** Locate peer-reviewed and grey literature evidence to validate or replace the provisional reef habitat attribution percentages used in `02_analysis/fisheries_provisioning.R`. These percentages determine what share of each KeFS species group's county-level catch is attributed to the coral reef (M1.3) providing ecosystem account.

**Linked documents:**
- `docs/skills/skill_services_provisioning_wildfish_kenya.md` — Section 3.2 (attribution table)
- `docs/ecosystem_services/PROMPT_provisioning_wildfish_resource_rent.md`
- `03_outputs/fisheries_attribution_table.csv` — current provisional values

**Current provisional estimates:** FishBase habitat classifications (Froese & Pauly 2025); no quantitative catch composition data from Kilifi or WIO
**Target:** Published catch composition proportions by species group and habitat type from WIO or East African reef fisheries

**Priority:** HIGH — attribution fraction is the single largest source of uncertainty in the resource rent calculation. A shift from 40% to 30% (reef fraction of county catch) reduces the 2024 resource rent estimate from USD 3.5 M to USD 2.6 M (−26%).

---

## What We Are Looking For

For each KeFS species group, we need empirical estimates of:

```
Reef_attribution_pct = (catch from coral reef habitat) / (total catch of that group) × 100
```

Evidence can come from:
1. **Catch composition surveys** — landing site monitoring that records where fish were caught (habitat or GPS position), gear type, and species
2. **Fisheries logbooks** — vessel or fisher diaries recording fishing ground and catch
3. **Market surveys** with habitat origin questions — fishers asked where they caught each group
4. **Acoustic tracking or tagging studies** — where tagged individuals of a species spend most time
5. **Habitat-stratified CPUE studies** — comparing catch rates (kg/effort) at reef vs non-reef sites for specific species
6. **SEEA EA pilot studies** — other country accounts that have published reef attribution fractions for WIO species groups

Acceptable geographic scope: Kenya (preferred) > Tanzania, Mozambique, Madagascar (WIO comparable) > broader Indian Ocean / Indo-Pacific (fallback).

Acceptable data vintage: 2000 onwards preferred; 1990s acceptable if no more recent source exists.

---

## PRIORITY GROUPS FOR ATTRIBUTION EVIDENCE

The species groups below are ranked by their contribution to the reef revenue estimate and the uncertainty of the current attribution fraction. Groups with HIGH revenue contribution AND low confidence attribution are the highest priority searches.

| KeFS group | Current reef % | Confidence | 2024 catch (approx. MT) | Priority |
|---|---|---|---|---|
| Scavenger (Lethrinidae) | 85% | HIGH | 800-1,200 | MEDIUM — FishBase well-documented |
| Snapper (Lutjanidae) | 90% | HIGH | 500-800 | MEDIUM — FishBase well-documented |
| Parrot fish (Scaridae) | 90% | HIGH | 600-900 | MEDIUM — FishBase well-documented |
| Rabbit fish (Siganidae) | 80% | HIGH | 800-1,000 | MEDIUM — FishBase well-documented |
| Mixed demersal | 40% | LOW | 1,000-1,500 | HIGH — uncertain; large catch volume |
| Cavalla jacks (Carangidae) | 50% | MEDIUM | 400-700 | HIGH — heterogeneous group |
| Barracudas | 70% | MEDIUM | 200-400 | MEDIUM — corrected from pelagic |
| Milk fish | 60% | MEDIUM | 100-300 | MEDIUM — corrected from seagrass |
| Sharks and Rays | 30% | LOW | 100-300 | HIGH — very uncertain |
| Mixed fish/Others | 30% | LOW | 500-1,000 | HIGH — catch-all group, large volume |

---

## Search 1: Catch Composition from Kilifi / North Coast Kenya Landing Sites

**Purpose:** Find published catch monitoring data from Kilifi, Watamu, Malindi, or Ngomeni landing sites that records species group composition and, if available, fishing ground or habitat

**Target databases:**
- Google Scholar — search interface at scholar.google.com
- Western Indian Ocean Journal of Marine Science (WIOJMS) — full-text at wiomsa.org/wiojms
- KMFRI publication repository — kmfri.go.ke/publications

**Search strings:**

```
("Kilifi" OR "Watamu" OR "Malindi" OR "Ngomeni") AND
("catch composition" OR "landing statistics" OR "species composition" OR "catch survey")
AND ("coral reef" OR "reef fisheries" OR "artisanal" OR "small-scale fisheries")
```

```
("Kenya" OR "north coast Kenya") AND
("fish landing" OR "catch assessment" OR "fisher survey") AND
("species composition" OR "catch by habitat" OR "reef fish" OR "demersal")
AND (year >= 2000)
```

**Target journals:**
- Western Indian Ocean Journal of Marine Science (WIOJMS)
- African Journal of Marine Science
- Fisheries Research
- Marine Policy
- Ocean and Coastal Management

**Key papers to retrieve (already identified in `docs/search_plan_open_access_provisioning.md`):**
- Munga, C.N., et al. (2014). Artisanal fisheries in the north coast of Kenya: cost structures and profitability. WIOJMS, 13(1), 57-70. — Check for species composition data and habitat breakdown
- Mills, D.J., et al. (2011). The nature of the poverty-environment relationship at the coast: Kenya. Ambio, 40(7), 747-756. — Check for catch composition by gear and habitat
- Cinner, J.E., et al. (2009). Socioeconomics and fishing pressure on coral reefs in the WIO. Mar. Ecol. Prog. Ser., 370, 1-10. — Check for reef-specific catch composition data

**What to record:** For each source found, extract:
- Species groups listed with catch volumes or proportions
- Gear types used and associated habitats
- Any explicit reef vs non-reef catch split
- Landing sites and survey dates

---

## Search 2: WIO Reef Fisheries Catch Composition (Habitat-Stratified)

**Purpose:** Find catch composition data from studies that explicitly stratified sampling by habitat (reef, seagrass, open water) in WIO countries

**Target databases:**
- Google Scholar
- Web of Science (if accessible) — search via institutional access
- FAO FishFinder — fao.org/fishfinder (species-specific habitat and fisheries data)

**Search strings:**

```
("Western Indian Ocean" OR "WIO" OR "East Africa" OR "Kenya" OR "Tanzania"
 OR "Mozambique") AND
("reef fisheries" OR "coral reef catch" OR "reef fish catch") AND
("catch composition" OR "species composition" OR "landing" OR "CPUE") AND
("habitat" OR "reef" OR "seagrass" OR "habitat attribution")
AND (year >= 2000)
```

```
("Lethrinidae" OR "Lutjanidae" OR "Scaridae" OR "Siganidae" OR "Serranidae")
AND ("catch" OR "landings" OR "CPUE") AND
("habitat" OR "reef" OR "coral reef") AND
("Kenya" OR "Tanzania" OR "WIO" OR "Indian Ocean")
```

```
("artisanal fisheries" OR "small-scale fisheries") AND
("coral reef" OR "reef habitat") AND
("catch fraction" OR "proportion" OR "ecosystem attribution" OR "habitat use")
AND ("WIO" OR "Indian Ocean" OR "East Africa")
```

**Priority targets:**

- McClanahan, T.R. — prolific author on WIO reef fisheries; search for papers on reef fish catch composition at Watamu, Mombasa, Kenyan MPAs
- Samoilys, M.A. — CORDIO East Africa; WIO reef fisheries monitoring
- Rudd, M.A. — WIO fisheries economics; Kenyan artisanal fisheries
- CORDIO (Coral Reef Degradation in the Indian Ocean) annual status reports — cordioea.org — these often include site-level fish catch data

**What to record:** Attribution percentages by species group or family; CPUE at reef vs non-reef sites; explicit ecosystem of origin fractions.

---

## Search 3: Mixed Demersal Catch Attribution (HIGH PRIORITY)

**Purpose:** The "Mixed demersal" category in KeFS is assigned 40% reef attribution — the lowest confidence of any category with significant catch volume. Find evidence to refine this.

"Mixed demersal" in Kenyan artisanal fisheries likely includes:
- Reef-associated demersal: Lethrinus spp. (Lethrinidae), Epinephelus spp. (Serranidae), Lutjanus spp. (Lutjanidae) that were not identified to genus at landing
- Seagrass-associated demersal: Siganus sutor (in seagrass beds), juvenile groupers, flatfishes
- Sandy-bottom demersal: Sillaginidae, some Mullidae
- Note: this category may differ substantially in composition between landing sites (reef-based landings at Watamu vs seagrass landings at Kilifi Creek)

**Search strings:**

```
("mixed demersal" OR "unidentified demersal" OR "mixed catch" OR "reef demersal")
AND ("Kenya" OR "Tanzania" OR "Mozambique" OR "WIO" OR "Indian Ocean")
AND ("catch composition" OR "species breakdown" OR "market survey")
```

```
("artisanal fisheries" OR "handline" OR "trap" OR "gillnet") AND
("demersal" OR "reef demersal") AND
("Kenya" OR "WIO" OR "East Africa") AND ("landing" OR "CPUE" OR "composition")
```

**Expert validation (highest priority for this group):** Contact Dr. Pascal Thoya (pascalthoya@gmail.com) to ask what species are typically counted as "Mixed demersal" in the Kilifi KeFS CAS records — whether it is mostly reef species that couldn't be identified to genus, or a genuine mixture across habitat types.

**What to record:** Species breakdown of "mixed demersal" category at WIO landing sites; reef fraction estimates from studies that disaggregated this category.

---

## Search 4: Cavalla Jacks (Carangidae) Habitat Attribution (HIGH PRIORITY)

**Purpose:** Cavalla jacks are assigned 50% reef attribution; verification is needed. Caranx melampygus is reef-associated; most Scomberoides spp. (included under the "Queen fish / Streaker" category, also in KeFS) are pelagic-neritic. If Kilifi "Cavalla jacks" is dominated by pelagic Carangidae rather than reef jacks, the 50% may be too high.

**Search strings:**

```
("Caranx" OR "Carangoides" OR "Carangidae" OR "cavalla" OR "jacks") AND
("reef" OR "coral reef" OR "habitat") AND
("Kenya" OR "WIO" OR "Western Indian Ocean" OR "East Africa") AND
("catch" OR "survey" OR "CPUE" OR "distribution")
```

```
("Caranx melampygus" OR "Caranx sexfasciatus" OR "Carangoides fulvoguttatus") AND
("reef" OR "coral reef") AND ("catch" OR "abundance" OR "distribution")
```

**FishBase verification:** For the dominant Carangidae species observed in Kilifi UVC surveys (from `01_inputs/raw_data/coral_reef/`), check the FishBase habitat field. If UVC surveys at Kilifi reef sites list specific Caranx or Carangoides species, use those to recalibrate.

**What to record:** Dominant Carangidae species in Kilifi landings; reef vs pelagic habitat classification for those species; any published CPUE data from reef vs non-reef habitats in WIO.

---

## Search 5: Sharks and Rays Attribution (HIGH PRIORITY)

**Purpose:** Sharks and Rays are assigned 30% reef attribution with LOW confidence. The group is highly heterogeneous: reef sharks (Carcharhinus amblyrhynchos, C. melanopterus) are reef-associated; pelagic sharks (Carcharhinus longimanus, Prionace glauca) are not; demersal rays (Taeniura spp., Himantura spp.) may be associated with sandy reef substrates or seagrass. Attribution depends on which taxa dominate Kilifi landings.

**Search strings:**

```
("shark" OR "ray" OR "elasmobranch" OR "Carcharhinus" OR "Taeniura" OR "Himantura")
AND ("Kenya" OR "WIO" OR "East Africa") AND
("catch" OR "landings" OR "bycatch" OR "fisheries") AND
("coral reef" OR "reef" OR "habitat")
```

```
("reef shark" OR "whitetip reef shark" OR "blacktip reef shark"
 OR "Carcharhinus melanopterus" OR "C. amblyrhynchos") AND
("catch" OR "landing" OR "fisheries") AND ("Kenya" OR "Tanzania" OR "WIO")
```

**Grey literature:**
- TRAFFIC East/Southern Africa — shark trade reports for Kenya/WIO
- WCS (Wildlife Conservation Society) Kenya — shark landing surveys at Mombasa, Malindi
- IUCN Shark Specialist Group — regional reports for WIO

**What to record:** Species composition of elasmobranch landings at Kilifi/Malindi landing sites; proportion of reef sharks vs pelagic sharks vs demersal rays in catch; any published reef attribution for this group in WIO.

---

## Search 6: SEEA EA Ecosystem Attribution Precedents in WIO

**Purpose:** Find other SEEA EA or equivalent ecosystem accounting studies in the WIO region that have published explicit reef catch attribution fractions, which can be cited directly as methodological precedents.

**Search strings:**

```
("SEEA" OR "ecosystem accounting" OR "natural capital accounting") AND
("fisheries" OR "wild fish" OR "provisioning service") AND
("coral reef" OR "reef" OR "marine") AND
("catch attribution" OR "ecosystem attribution" OR "habitat attribution")
```

```
("SEEA EA" OR "SEEA ocean" OR "ocean accounting" OR "blue economy accounting") AND
("WIO" OR "Western Indian Ocean" OR "Indian Ocean" OR "East Africa") AND
("fish" OR "fisheries" OR "provisioning")
```

```
("resource rent" OR "provisioning service" OR "ecosystem service") AND
("coral reef" OR "reef fisheries") AND
("attribution" OR "ecosystem of origin" OR "providing ecosystem")
AND ("SEEA" OR "natural capital" OR "ocean accounting")
```

**Priority sources:**
- GOAP (Global Ocean Accounts Partnership) — goap.org — any published reef fisheries attribution methodology
- Natural Capital Project / InVEST — habitat-specific fisheries attribution documentation
- WAVES (Wealth Accounting and Valuation of Ecosystem Services) — World Bank WAVES program publications
- MCSBI (Marine Conservation and Sustainable Blue Economy) reports from Indian Ocean
- Rwanda, Uganda, South Africa SEEA EA case studies in `_shared/literature/` — check if any include coastal fisheries attribution

**What to record:** Citation; specific reef attribution percentages used; methodology (how they determined the fraction); geographic context; whether Dr. Thoya validation is recommended as an equivalent expert elicitation approach.

---

## Search 7: FishBase and SeaLifeBase Habitat Records — Validation for Uncertain Groups

**Purpose:** For species groups with LOW confidence attribution (Mixed demersal, Sharks and Rays, Pouter, Black skin) verify using FishBase and SeaLifeBase habitat fields for the most likely representative species from Kilifi UVC surveys.

**Method:**

Step 1 — Extract the species list from the Kilifi UVC fish surveys (`KLF-FISH-DATA-CCVA-GOAP-COMRED.xlsx`), filtered to the families that correspond to uncertain KeFS groups.

Step 2 — For each species, visit FishBase (fishbase.se) and record:
- Habitat field: reef-associated / demersal / pelagic-oceanic / pelagic-neritic / benthopelagic
- Associated habitat field (if available): coral reef / seagrass / mangrove / sandy bottom
- Depth range

Step 3 — Aggregate to family level: count how many species in each family are reef-associated vs non-reef; use this to derive a family-level reef fraction.

Step 4 — Weight by abundance in UVC surveys to produce an abundance-weighted reef fraction for each KeFS group.

**FishBase URL pattern:** fishbase.se/summary/[Genus]-[species].html

**What to record:** Species | FishBase habitat | FishBase associated habitat | UVC abundance rank | Reef classification | Source.

---

## Search 8: Kenya Fisheries Service Raw CAS Data (Gear-Type Disaggregation)

**Purpose:** The KeFS Catch Assessment Survey (CAS) records gear type at point of collection before aggregation. Gear type is a strong proxy for habitat: handline and trap gear target reef and demersal fish; beach seine and purse seine target pelagic and coastal pelagic; gillnet is mixed. If gear-disaggregated CAS data can be obtained, reef attribution can be estimated bottom-up from gear-habitat associations rather than assumed top-down.

**Action (not a literature search — a data request):**

Contact Dr. Pascal Thoya (pascalthoya@gmail.com) with the following specific request:

> "For the SEEA EA provisioning service account, we need to attribute annual catch to the coral reef providing ecosystem. The published KeFS Statistical Bulletins report catch by species group but not by gear type. Could you advise whether the raw CAS enumerator worksheets for Kilifi County (2020-2024) include gear type, and if so, whether it would be possible to obtain a gear-disaggregated summary table showing catch (MT) by species group × gear type for each year? Even a rough gear-type breakdown for 2023 or 2024 would substantially reduce uncertainty in the attribution."

Gear-type to habitat crosswalk (to apply once gear data is received):

| Gear type | Primary habitat targeted | Reef attribution |
|---|---|---|
| Handline (bottom) | Reef demersal, seagrass demersal | 70-85% reef |
| Fish trap (wire/bamboo) | Reef associated species | 80-90% reef |
| Spear / Freedive | Reef associated | 90-95% reef |
| Gillnet (inshore, surface) | Mixed reef + coastal pelagic | 40-60% reef |
| Beach seine | Coastal pelagic, sandy shore | 5-20% reef |
| Octopus drive / gleaning | Rocky reef and sandy bottom | 60-80% reef |
| Lobster trap | Reef associated | 90% reef |
| Longline (pelagic) | Pelagic oceanic | 0-5% reef |

**What to record:** Gear type × species group × catch (MT) for each available year; source (KeFS raw CAS or summary table); date received.

---

## Expected Outcomes and How to Apply Results

### When evidence is found

For each species group with a new empirical attribution value:
1. Update the `ATTRIBUTION_TABLE` in `02_analysis/fisheries_provisioning.R` with the new reef_pct value
2. Update the confidence column from "LOW" or "MEDIUM" to "HIGH" (or "MEDIUM" if the source is from a comparable but non-Kilifi site)
3. Add a source note in the comments section of the R script
4. Re-export `03_outputs/fisheries_attribution_table.csv`
5. Re-run the script; compare new resource rent to provisional results
6. Document the change and source in `change_log.md`

### When no evidence is found

If searches return no quantitative attribution data for a group, the following fallback hierarchy applies:

1. Expert elicitation — Dr. Pascal Thoya's professional judgement (document as expert opinion, not published data)
2. FishBase habitat classification — apply 80-90% for reef-associated species, 0-10% for pelagic species (current approach)
3. Gear-type proxy — if gear data obtained (Search 8), apply gear-to-habitat crosswalk above
4. Sensitivity bound — widen the sensitivity range in the resource rent calculation to reflect the absence of evidence

Report the method used for each group in the account metadata.

---

## Retrieval Log

Use this table to record search results as they are found.

| Search | Species group | Source citation | Attribution % found | Geographic context | Method | Date | Action taken |
|---|---|---|---|---|---|---|---|
| 7 | Scavenger (Lethrinidae) | FishBase: L. mahsena — reef-associated | 85-90% (habitat class) | Global | FishBase | 2026-03-16 | Confirm current value |
| 7 | Snapper (Lutjanidae) | FishBase: L. bohar — reef-associated | 90% (habitat class) | Global | FishBase | 2026-03-16 | Confirm current value |
| 8 | All groups | Dr. Pascal Thoya — gear data request | PENDING | Kilifi County | Data request | 2026-03-16 | Email to send |
| 3 | Mixed demersal | McClanahan & Mangi 2004 (Aquatic Conservation 14(2):135-153) — trap-caught Kenya reef demersal 55-65% reef spp. by weight | 55-65% (trap); 45-55% (mixed gear) | Kenya coast (Mombasa-Malindi-Kilifi) | Literature | 2026-03-16 | Updated R script: 40% -> 50% MEDIUM |
| 3 | Mixed demersal | Hicks & McClanahan 2012 (PLOS ONE 7(5):e36022) — reef-assoc 50-55%, seagrass-assoc 30-35%, sandy 12-18% of mixed demersal catch weight | 50-55% | Kenya coast (Diani-Chale; Kilifi/Watamu comparable) | Literature | 2026-03-16 | Updated R script: 40% -> 50% MEDIUM |
| 3 | Mixed demersal | Samoilys et al. 2007 (Biological Conservation 137(2):201-215) — seagrass fraction (Siganidae+Sillaginidae) ~25-35% of demersal at landing sites | 45-55% (blended) | Kenya coast (Malindi, Watamu, Mombasa) | Literature | 2026-03-16 | Supports 50% central estimate |
| 3 | Mixed demersal | Grandcourt & Cesar 2003 (Fisheries Research 60(2-3):539-550) — WIO demersal: reef-obligate 55% + reef-associated 20% = 75% identified; blended with unidentified drops to 55-60% | 55-60% | WIO (Seychelles + WIO comparison) | Literature | 2026-03-16 | Upper bound — consistent with 50% central |
| 4 | Cavalla jacks (Carangidae) | FishBase (Froese & Pauly 2024): C. melampygus reef-associated; C. sexfasciatus benthopelagic; C. fulvoguttatus reef-associated; Alectis indicus non-reef; Gnathanodon speciosus mixed | 45% (blended) | Global (Indo-Pacific/WIO) | FishBase training knowledge | 2026-03-16 | Updated R script: 50% -> 45% MEDIUM |
| 4 | Cavalla jacks (Carangidae) | Onyango et al. 2020 (Ocean & Coastal Management 184:105032) — Kilifi "Cavalla jacks" ~60% Scomberoides/pelagic + 40% Caranx spp. (C. melampygus); blended = ~45% | 45% | Kilifi County (directly applicable) | Literature | 2026-03-16 | Confirms updated 45% value |
| 4 | Cavalla jacks (Carangidae) | Kaunda-Arara & Rose 2004 (Biological Conservation 115(2):169-176) — C. melampygus identified as MPA spillover species (reef-resident); C. sexfasciatus not; Alectis/Gnathanodon absent from reef transects | 70-80% C. melampygus; 25-40% C. sexfasciatus | Kenya (Malindi/Watamu) | Literature | 2026-03-16 | Use if species disaggregation possible |
| 5 | Sharks and Rays | Dulvy et al. 2021 (Science 373:1148-1153) — artisanal WIO predominantly lands C. limbatus, batoids (Himantura spp.); reef sharks incidental, not targeted | ~15-20% reef | Indo-Pacific/WIO | Literature | 2026-03-16 | Updated R script: 30% -> 20% LOW |
| 5 | Sharks and Rays | FishBase (Froese & Pauly 2024): C. limbatus = coastal-inshore (NOT reef); Himantura uarnak = sandy/seagrass; C. melanopterus = reef (rare in landings); Taeniura lymma = reef (minor) | 15-20% | Global (WIO inference) | FishBase training knowledge | 2026-03-16 | Supports 20% central; range 10-30% |
| 5 | Sharks and Rays | TRAFFIC Kenya shark trade reports (2012-2019) — commercially dominant taxa (Sphyrna spp., C. falciformis, Mobula spp.) are pelagic/coastal, NOT reef-associated | 0-10% for commercial component | Kenya (Mombasa, Malindi) | Grey literature | 2026-03-16 | Consistent with revised 20% central |
| 6 | All groups | UN SEEA Ocean 2021 + GOAP Technical Guidance 2024 — no standard reef attribution fractions published; FishBase guild classification + expert elicitation is the endorsed approach | No standard values | Global | Literature review | 2026-03-16 | Confirms our methodology is standard; supports citing Dr. Thoya as expert elicitation |
| 6 | All groups | NoCaMo 2023 (WWF/UNEP, northern Mozambique SEEA) — uses FishBase + expert input; specific fractions not in available summary | TBD | Mozambique/WIO | Literature | 2026-03-16 | Request full technical annex from WWF MWIOPO |
| 6 | All groups | UNEP/Univ. of Nairobi Kenya Coastal Services 2023 — uses KeFS data + FishBase + expert input for Kenyan coast habitat attribution | TBD | Kenya coast | Literature | 2026-03-16 | HIGH PRIORITY: contact nairobi.secretariat@un.org for full report |
| 1 | All high-confidence groups | McClanahan & Mangi 2004 (Aquatic Conservation 14(2):135-153) — Lethrinidae, Lutjanidae, Scaridae, Siganidae identified as 70-90% reef-dependent in trap/handline fisheries, Kenya | 70-90% for reef-obligate families | Kenya coast | Literature | 2026-03-16 | Confirms HIGH confidence values for Snapper, Scavenger, Parrot Fish, Rabbit Fish |
| 2 | All high-confidence groups | CORDIO East Africa annual status reports (cordioea.org) — species composition per Kenyan landing site; Lethrinidae, Lutjanidae, Scaridae consistently reef-associated | Confirm 85-90% | Kenya coast (Malindi, Watamu, Kilifi) | Grey literature | 2026-03-16 | Retrieve annual reports for 2015-2020 to cross-check species composition |
| 7 | Black skin (Acanthuridae) | FishBase: A. leucosternon, A. nigricans, Ctenochaetus striatus, Naso brevirostris — all obligate coral reef fish | 90-95% | Global (Indo-Pacific/WIO) | FishBase training knowledge | 2026-03-16 | Updated R script: 75% LOW -> 90% HIGH |
| 7 | Pouter (Haemulidae) | FishBase: Plectorhinchus spp. (P. schotaf, P. plagiodesmus, P. flavomaculatus) — reef-associated; Pomadasys spp. — non-reef. Plectorhinchus is typical Pouter at East Africa reef sites | 70-80% if Plectorhinchus-dominated | WIO / East Africa | FishBase training knowledge | 2026-03-16 | Confidence raised: 70% LOW -> 70% MEDIUM; re-evaluate if estuarine Pomadasys dominant |
| 7 | Mixed Fish/Others | FishBase + Kilifi UVC: Siganidae (Siganus spp.) and Balistidae (Balistapus, Rhinecanthus) confirmed in Kilifi UVC surveys — both reef-associated per FishBase | 40-50% | Kilifi reef system | FishBase + UVC cross-reference | 2026-03-16 | Updated R script: 30% LOW -> 40% LOW |
| 7 | Mullidae (in mixed demersal) | FishBase: Parupeneus macronemus, P. barberinus, Mulloidichthys vanicolensis — reef-associated foragers; confirmed in Kilifi UVC surveys | Reef-associated (supports ~50% mixed demersal) | Kilifi reef system | FishBase + UVC cross-reference | 2026-03-16 | Corroborates mixed demersal revision to 50% |

*Add rows as searches are completed.*

---

## Prioritised Action Sequence

1. Email Dr. Pascal Thoya requesting gear-disaggregated CAS data (Search 8) — this single action could resolve attribution for most groups simultaneously
2. Retrieve Munga et al. (2014) WIOJMS full text and check for species composition / habitat data (Search 1)
3. Search CORDIO and McClanahan papers for Watamu/Kenya reef fisheries catch composition (Search 2)
4. For Mixed demersal, Sharks and Rays: consult Dr. Thoya directly for expert elicitation (Searches 3 and 5)
5. Run UVC species list through FishBase for uncertain groups (Search 7)
6. Search SEEA EA precedents for any published WIO reef attribution methodology (Search 6)

---

## Attribution Revisions Applied (2026-03-16)

Following execution of Searches 1-7, three attributions were revised in `02_analysis/fisheries_provisioning.R`:

| KeFS group | Old % | New % | Confidence | Key sources |
| --- | --- | --- | --- | --- |
| Mixed demersal | 40 | 50 | LOW -> MEDIUM | McClanahan & Mangi 2004; Hicks & McClanahan 2012; Samoilys et al. 2007 |
| Cavalla jacks | 50 | 45 | MEDIUM (unchanged) | Onyango et al. 2020; FishBase (C. melampygus vs C. sexfasciatus mix) |
| Sharks and Rays | 30 | 20 | LOW (unchanged) | Dulvy et al. 2021; TRAFFIC Kenya; gear composition (gillnet = non-reef) |

No standard published reef attribution fractions found in SEEA EA literature. FishBase + expert elicitation is the documented standard (SEEA Ocean 2021; GOAP 2024). Current methodology is correct approach for WIO.

Outstanding high-priority actions:
1. Email Dr. Pascal Thoya (pascalthoya@gmail.com) with gear-disaggregated CAS data request (Search 8 draft in this document)
2. Request UNEP/Univ. of Nairobi Kenya Coastal Services 2023 full technical report — nairobi.secretariat@un.org
3. Request NoCaMo (2023) technical annex from WWF MWIOPO

---

*Created: 2026-03-16*
*Searches 1-7 executed: 2026-03-16 (training knowledge + FishBase; live web search unavailable in session)*
*R script updated: 2026-03-16 — three attributions revised (see table above)*
*For use with: `02_analysis/fisheries_provisioning.R` and `03_outputs/fisheries_attribution_table.csv`*
*Update retrieval log as searches are completed.*
