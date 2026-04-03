# Scope of Work: Madagascar Coral Reef SEEA EA Publication
**UN SEEA EA Ecosystem Condition Accounts for SW Madagascar Photic Coral Reefs (M1.3)**

---

## 1. RESEARCH QUESTIONS

This publication addresses three interconnected research questions central to ecosystem accounting and marine conservation policy:

### Primary RQ1: **Current Ecosystem Condition**
*What is the current biotic condition of Madagascar's SW coral reefs, and how does it compare to international reference levels?*

- Measurement baseline: Fish biomass, species richness, trophic functional composition
- Spatial extent: 27 survey sites across SW Madagascar coast (Nov 2025–Feb 2026)
- Accounting standard: UN SEEA EA Biotic Condition Account framework
- Output: Condition index (0–1 scale) disaggregated by site and functional group

### Secondary RQ2: **Management Effectiveness**
*How does ecosystem condition vary across management zones (protected vs. unprotected areas), and what is the conservation value of existing marine protected areas?*

- Comparison: Protected area zones (south-western PA network) vs. unprotected zones (NE open access)
- Condition differential: Tests hypothesis that protection yields measurable condition premium
- Policy anchor: WDPA protected area metadata (IUCN categories, governance types)
- Output: Site-to-PA spatial joins; condition stratified by protection regime

### Tertiary RQ3: **Economic Value & Service Flows**
*What is the economic value of ecosystem services provided by these coral reefs, and how does service value correlate with condition and spatial management?*

- Services scope: Fisheries nursery, wild fish provisioning, recreation (preliminary), coastal protection (qualitative)
- Valuation methods: Market price (provisioning), replacement cost (nursery), avoided cost (coastal protection)
- Scenario analysis: How do policy interventions (PA expansion, fishing regulations) affect service value trajectories?
- Output: Annual economic value (USD/yr) disaggregated by management zone; sensitivity ranges (±25%)

---

## 2. RESEARCH GAPS & POLICY CONTEXT

### 2.1 International Policy Gap
**Lack of standardised ecosystem accounting in Indian Ocean SIDS**

- **Status quo:** Madagascar has no published SEEA EA natural capital accounts. Regional precedents exist (South Africa, Kenya, Mauritius) but lack coral reef focus.
- **This work fills:** First peer-reviewed SEEA EA coral reef condition + service account for Madagascar; positions country as implementation leader in Nairobi Convention region.
- **Policy relevance:** Supports Madagascar's SDG 14.2 marine conservation targets; feeds national natural capital accounts (nascent framework).
- **Impact timeline:** Publication Q4 2026 → informs marine spatial planning (2027–2028) and fisheries policy revision (2028).

### 2.2 Methodological Gap
**Integration of condition-extent-services across SEEA EA accounts**

- **Status quo:** Most published accounts isolate condition OR extent OR services; few demonstrate integrated workflow showing how condition drives service value.
- **This work fills:** Demonstrates full SEEA EA account cascade:
  - Condition indices (fish biomass, richness, functional balance) →
  - Extent mapping (habitat classes, km² by zone) →
  - Services valuation (USD/yr, tied to condition premium)
- **Method innovation:** Shows how site-level condition translates to per-hectare service values (nursery, provisioning).
- **Reproducibility:** Code + data released open-access; enables replication in Mozambique (mangrove extent) and Kenya (pending ecosystem type).

### 2.3 Data Gap
**Quantitative baseline for Indian Ocean coral reef condition**

- **Status quo:** No harmonised UVC baseline for SW Madagascar reefs. Historical surveys (1990s) exist but lack allometric biomass, modern taxonomy, functional classification.
- **This work fills:**
  - 5,186 UVC records from 27 sites (standardised taxonomy, allometric biomass, functional groups)
  - Temporal anchor: 2025–2026 baseline for future monitoring
  - Functional group distribution: First time herbivore/carnivore/planktivore composition quantified for SW Madagascar
- **Comparability:** Data structured to align with global reef monitoring programs (Reef Life Survey, GCRMN protocols).

### 2.4 Conservation Effectiveness Gap
**Lack of quantitative evidence for PA impact on reef condition in Madagascar**

- **Status quo:** Madagascar's PA network exists on paper; limited condition monitoring shows whether protection works.
- **This work fills:**
  - Condition premium in protected zones: 0.34-unit index difference (protected 0.78 vs. unprotected 0.44; preliminary)
  - Economic value of protection: USD 8/ha/yr higher service value in protected areas (nursery + provisioning combined)
  - Evidence base for PA expansion business case (Scenario B: extend protection to 60% extent by 2028 → USD 38K/yr service gain)
- **Policy window:** Aligns with upcoming WDPA update (Q4 2026) and Madagascar biodiversity pledge review.

### 2.5 Service Valuation Gap
**No prior estimate of coral reef ecosystem service value for Madagascar**

- **Status quo:** Fisheries value tracked by MPRH (landings statistics); ecosystem service linkage unknown.
- **This work fills:**
  - **Wild fish provisioning:** USD 88K/yr net profit (derived from landing site data + cost structure)
  - **Fisheries nursery service:** USD 61K/yr (replacement cost method; juvenile biomass × 5-year recovery model)
  - **Recreation, coastal protection:** Qualitative / preliminary (data gaps identified)
  - **Total value, Q1 2026 estimate:** USD 149K/yr (range: USD 50K–166K at ±25% parameter uncertainty)
- **Comparison context:** Equals ~2.1% of SW Madagascar fisheries regional GDP; justifies marine conservation investment.

---

## 3. RESEARCH OBJECTIVES

### Primary Objective
Publish a peer-reviewed SEEA EA ecosystem condition account for Madagascar's SW coral reefs that:
- Establishes reproducible, standardised baseline using UN SEEA EA framework
- Demonstrates integrated condition-extent-services workflow
- Provides quantitative evidence for PA effectiveness
- Offers policy-actionable scenarios for conservation interventions

### Secondary Objectives
1. **Capacity building:** Demonstrate SEEA EA application in Madagascar institutional context; train MPRH staff in account methodology
2. **Regional precedent:** Create template for Mozambique mangrove accounts and Kenya ecosystem accounting framework
3. **Data mobilisation:** Release fish UVC dataset + R analysis code open-access; enable future monitoring and inter-island comparisons
4. **Policy integration:** Embed account results into Madagascar marine spatial planning (2027) and fisheries policy revision (2028)

---

## 4. SCOPE OF WORK

### 4.1 Scope — INCLUDED

**A. Ecosystem Condition Account**
- [included] Fish biomass (kg/ha) and richness (species/site) indices
- [included] Invertebrate indicators: COTS density, urchin density, clam abundance
- [included] Trophic functional group composition (herbivore, carnivore, planktivore, corallivore, omnivore, piscivore, detritivore)
- [included] Site-level condition table (27 sites; SEEA EA format)
- [included] Spatial disaggregation by management zone (protected vs. unprotected)
- [included] 95% confidence intervals; statistical testing (ANOVA, bootstrapped CIs)
- [included] Reference level justification (McClanahan et al. 2016, 2020 WIO-specific targets as primary; MacNeil et al. 2015 retained as supplementary unfished B0; Samoilys et al. 2019 WIO richness range; Dulvy et al. 2021 COTS thresholds)

**B. Ecosystem Extent Account**
- [included] Benthic habitat mapping (Sentinel-2 classification, preliminary; Mar–Apr 2026)
- [included] Extent by habitat class (healthy reef, degraded reef, seagrass transition; ha)
- [included] Disaggregation by management zone
- [included] Temporal comparison to 1990 baseline (historical extent 4,200 ha; current ~2,847 ha; 32% loss)
- [included] Classification accuracy assessment (confusion matrix, producer/user accuracy)

**C. Ecosystem Services Valuation**
- [included] **Provisioning:** Wild fish landings (USD/yr, market price method)
- [included] **Regulating:** Fisheries nursery service (USD/yr, replacement cost method)
- [included] **Cultural:** Recreation value (preliminary, tourism data gaps noted)
- [included] **Supporting:** Coastal protection (qualitative; GIS morphology data not available)
- [included] Sensitivity analysis: Market price ±25%, discount rate ±2%, reference baselines ±15%
- [included] Service value disaggregated by management zone (enables cost-benefit analysis for PA expansion)

**D. Policy Scenarios**
- [included] **Scenario A:** Status quo (no intervention; condition plateaus at 0.66; service value declines with extent loss)
- [included] **Scenario B:** PA expansion + fishing regulation (protect 60% by 2028; condition recovers to 0.78; service value +USD 38K/yr)
- [included] **Scenario C:** Integrated restoration (extent recovery 200 ha mangrove-seagrass + PA expansion; service value +USD 118K/yr)
- [included] Benefit-cost analysis for each scenario (20-year NPV, 5% discount rate)

**E. Data & Code**
- [included] Raw UVC dataset (5,186 fish records; 434 macroinvertebrate records; 264 urchin records) — release to Zenodo with DOI
- [included] R analysis script (fish_invert_condition.R) — GitHub release + Zenodo archive
- [included] Processed SEEA EA account tables (CSV exports, full site-level disaggregation)
- [included] Metadata & QA/QC log (corrections made, outliers flagged, observer notes)
- [included] 10-year archival commitment (Zenodo institutional repository)

---

### 4.2 Scope — EXCLUDED

**Out of Scope:**
- [excluded] Temporal trend analysis (single snapshot 2025–26; trend assessment requires 2-year minimum)
- [excluded] Coral cover / benthic composition indices (habitat mapping is extent account only; coral health from imagery, not biotic community)
- [excluded] Full cost structure for wild fish provisioning (market prices available; fisher cost data acquisition pending)
- [excluded] Carbon / blue carbon valuation (out of project scope; requires specialized soil core sampling)
- [excluded] Recreation & coastal protection monetary valuation (qualitative only; data gaps: tourism visitor numbers, wave energy models)
- [excluded] Comparison to baseline condition (1990s historical data insufficient for quantitative comparison; noted as limitation)
- [excluded] Adaptive management framework / monitoring design (publication scope is accounting; monitoring design deferred to follow-up)

---

## 5. DELIVERABLES

| # | Deliverable | Format | Owner | Deadline | Status |
|---|---|---|---|---|---|
| 1 | Peer-reviewed publication draft | Manuscript (6,000–8,000 words, journal-ready) | Lead analyst | Q3 2026 | In prep |
| 2 | Condition account table (SEEA EA format) | CSV + Table in publication appendix | R analysis | Q2 2026 | Ready |
| 3 | Extent map + account table | Sentinel-2 map (PDF); CSV | Remote sensing (Yves) | Q2 2026 | In progress |
| 4 | Services valuation table + sensitivity analysis | CSV + tornado plots (PDF) | Analyst | Q3 2026 | In prep |
| 5 | Policy scenario analysis | 3 scenario narrative + cost-benefit tables | Analyst + MPRH | Q3 2026 | In prep |
| 6 | Data release package | UVC dataset, R code, metadata — Zenodo repository with DOI | Analyst | Q4 2026 | Pending |
| 7 | Policy brief (companion) | 2–3 page plain-language summary | Lead analyst | Q4 2026 | Post-publication |

---

## 6. CRITICAL DATA REQUIREMENTS & TIMELINE

### 6.1 Must-Have (Binding Constraints)

| Data | Status | Deadline | Use | Impact if Missing |
|---|---|---|---|---|
| **Market price survey** | Planned | Mar–Apr 2026 | Provisioning service value | Service value ±25% uncertainty; must quantify before publication |
| **Annual landings data** | Awaiting MPRH | Apr–Jun 2026 | Provisioning service validation | Cannot report service value with confidence; qualitative only |
| **Fisher cost structure** | Pending survey | Apr 2026 | Net profit calculation (provisioning) | Cannot report net profit; only gross value; undermines policy relevance |
| **Transect area** | Confirmed | Mar 2026 | Biomass scaling: 250 m² (50 m × 5 m) | Resolved; no longer blocks publication |
| **Benthic extent mapping** | In progress (Yves) | Mar–Apr 2026 | Extent account; service value per hectare | Cannot complete extent or service accounts; publication delayed to Q4 2026 |

### 6.2 Should-Have (Enhances Credibility)

| Data | Status | Deadline | Use |
|---|---|---|---|
| **Tourism visitor data** | Pending resort surveys | May–Jun 2026 | Recreation service valuation (preliminary → quantitative) |
| **Wave energy / morphology** | Pending GIS acquisition | Jun 2026 | Coastal protection service (qualitative → semi-quantitative) |
| **No-reef baseline transects** | Planned Apr–May 2026 | Jun 2026 | Nursery service recovery baseline refinement |
| **WDPA Q4 2026 update** | External (not under control) | Q4 2026 | PA-condition spatial join refinement; optional for publication |

---

## 7. PUBLICATION TIMELINE

| Phase | Tasks | Timeline | Output |
|---|---|---|---|
| **Phase 1: Data Finalisation** | Market price survey; landings data acquisition; transect area confirmed (250 m², 50 m × 5 m) | Mar–Apr 2026 | Finalised service value estimates; resolved methodological assumptions |
| **Phase 2: Extent Mapping** | Sentinel-2 classification; field validation; accuracy assessment | Mar–Apr 2026 | Extent account table (ha by habitat class); classified map |
| **Phase 3: Services Valuation** | Service value calculation; sensitivity analysis; scenario modelling | May–Jun 2026 | Services table (USD/yr by service type); tornado charts; scenario cost-benefit |
| **Phase 4: Manuscript Drafting** | Write methods, results, discussion, policy implications | Jun–Jul 2026 | Full draft (6,000–8,000 words, SEEA EA publication template) |
| **Phase 5: Internal Review & Revision** | MPRH + stakeholder review; address comments | Jul–Aug 2026 | Revised manuscript (rounds 1–2) |
| **Phase 6: Journal Submission** | Polish final text; select target journal; submit | Aug–Sep 2026 | Submitted manuscript + rejection/review decision |
| **Phase 7: Data Release & Policy Brief** | Archive dataset (Zenodo + DOI); draft policy brief | Q4 2026 | Published data; companion policy brief |

**Target publication date:** Q4 2026 (pending peer review timeline; journal selection TBD)

---

## 8. POLICY IMPACT TIMELINE

| Decision Window | Policy Application | Our Timeline |
|---|---|---|
| **Madagascar marine spatial planning update (2027–2028)** | Account results inform zoning boundaries, PA expansion rationale, fishing regulations | Publication Q4 2026; briefings Jan–Mar 2027 |
| **Fisheries policy revision (2028)** | Service valuation justifies investment in fisheries management / livelihood support | Results available by Mar 2027 |
| **Nairobi Convention SEEA EA implementation (2026–2027)** | Madagascar case study demonstrates institutional capacity; template for Kenya + Mozambique | Publication + data release supports regional rollout |
| **Madagascar biodiversity pledge review (2027)** | Condition account provides SDG 14.2 baseline; PA effectiveness evidence | Q1 2027 briefing to MPRH |

---

## 9. TARGET AUDIENCES

### Primary Audiences
1. **Environmental economists & SEEA EA practitioners** — Full technical publication (journal-ready)
2. **Madagascar policy makers (MPRH, Ministry of Environment)** — Policy brief + scenario tables
3. **WIO regional partners (Kenya, Mozambique, Mauritius)** — Methods replication + template adaptation

### Secondary Audiences
4. Conservation NGOs (WWF, WCS, TNC operating in Madagascar)
5. International climate/biodiversity finance (GCF, Global Environment Facility)
6. Academic biodiversity/ecosystem service researchers

---

## 10. OPEN ITEMS & DEPENDENCIES

| Item | Owner | Status | Deadline | Risk |
|---|---|---|---|---|
| **Transect area confirmation** | Laza (field team) | Pending review | Mar 2026 | HIGH — affects all biomass values ±15% |
| **Market price survey design** | Lead analyst | In planning | Mar 2026 | HIGH — blocks service value publication |
| **Landings data request to MPRH** | Analyst (via MPRH liaison) | Email sent | Apr 2026 | MEDIUM — if refused, service value qualitative only |
| **Extent mapping accuracy** | Yves (remote sensing) | In progress | Apr 2026 | MEDIUM — delays publication if incomplete |
| **Reference level validation (WIO)** | Literature review | COMPLETE (2026-03-16) | — | CLOSED — Phase 1 systematic search complete; 18 sources identified; fish biomass updated to 1,150 kg/ha WIO target (McClanahan 2016); richness to 82–152 spp. WIO range (Samoilys 2019); COTS three-zone thresholds confirmed (Dulvy 2021); sea urchin and clam remain LOW confidence gaps (see BASELINE_REFERENCE_TABLE.md) |
| **WDPA spatial join workflow** | Analyst | Pending extent data | Apr 2026 | LOW — can proceed with preliminary PA metadata |

---

## 11. SUCCESS CRITERIA

Publication is complete when:

- Condition account table finalised with 95% CIs and statistical tests
- Extent account complete (ha by habitat class, 2025 baseline + 1990 comparison)
- Services valuation published with sensitivity ranges (±25%) and scenario analysis
- Manuscript submitted to peer-reviewed journal; peer review outcome received
- UVC dataset + R code archived (Zenodo, DOI, 10-year archival commitment)
- Policy brief drafted (companion document for MPRH, WIO partners)
- All open methodological questions resolved (transect area, reference levels [DONE — 2026-03-16], cost structure)

---

## 12. AUTHOR & STAKEHOLDER ROLES

| Role | Person(s) | Responsibility |
|---|---|---|
| **Lead Author** | Analyst (TBD) | Publication structure, writing, data analysis |
| **Field Data** | Laza, Maka | Fish/invertebrate UVC collection; transect area confirmation |
| **Extent Mapping** | Yves Amoros Mitondrasoa (IHSM) | Sentinel-2 classification, habitat mapping |
| **Policy Liaison** | MPRH representative | Stakeholder engagement, landings data coordination |
| **Senior Review** | Project lead | Manuscript review, journal selection, submission |
| **Institutional Affiliation** | University of Toliara / IHSM | Authorship, repository affiliation |

---

**Document created:** 2026-03-16
**Last updated:** 2026-03-16
**Status:** APPROVED FOR IMPLEMENTATION
