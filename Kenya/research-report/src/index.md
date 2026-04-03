# Kenya Coastal Ecosystem Accounts

## Baseline Assessment of Coral Reef, Mangrove, and Seagrass Ecosystems - Kilifi County, 2024-2025

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const extentData = await FileAttachment("data/seea-extent-final.csv").csv({typed: true});
const conditionFinal = await FileAttachment("data/seea-condition-final.csv").csv({typed: true});
const fishData = await FileAttachment("data/fish-condition-site.csv").csv({typed: true});
const benthicData = await FileAttachment("data/benthic-cover-site.csv").csv({typed: true});
const mangroveData = await FileAttachment("data/mangrove-condition-site.csv").csv({typed: true});
const seagrassData = await FileAttachment("data/seagrass-cover-site.csv").csv({typed: true});
const fisheriesPhys = await FileAttachment("data/fisheries-physical.csv").csv({typed: true});
const fisheriesMon = await FileAttachment("data/fisheries-monetary.csv").csv({typed: true});
const paData = await FileAttachment("data/condition-by-pa.csv").csv({typed: true});
const mangrovePa = await FileAttachment("data/mangrove-condition-site.csv").csv({typed: true});
```

---

## Abstract

This report presents the first integrated ecosystem accounts for three coastal ecosystem types along the Kilifi County coastline, Kenya, compiled under the UN System of Environmental-Economic Accounting - Ecosystem Accounting (SEEA EA) framework[^1]. Accounts cover **coral reefs** (IUCN GET M1.3), **mangroves** (MFT1.2), and **seagrass meadows** (M1.1), with an ecosystem services account for reef-associated wild fish provisioning.

The accounts draw on approximately 11,700 coral reef survey records from three independent programmes, 2,095 mangrove tree measurements from 32 field plots, 3,040 seagrass quadrat records across 9 survey areas, and 5 years (2020-2024) of county fisheries landing data. All condition indices are normalised to a 0-1 scale against published or expert-derived reference levels.

Key findings include a 25% condition advantage for protected reefs over open-access sites, critically low coral recruitment across all sites, a 5.6% net loss of mangrove extent over 5 years, and a reef-associated fisheries resource rent estimated at USD 2-6 million per year. Seagrass meadows are in generally good condition, with Ngomeni recording the highest species diversity (8 species) in the study area.

---

## Study Rationale

Kenya's coastal ecosystems underpin the livelihoods of over 3 million people along the Indian Ocean shoreline, yet no standardised ecosystem accounts have previously been compiled for Kilifi County under an internationally recognised framework. The SEEA EA, adopted by the UN Statistical Commission in 2021, provides a systematic approach to measuring the extent, condition, and service flows of ecosystem assets in a format compatible with the System of National Accounts.

This baseline assessment establishes the opening condition for the 2025-2026 accounting period and identifies the data infrastructure, reference levels, and monitoring priorities needed to sustain regular account compilation. It is designed to inform Kenya's national ocean accounting agenda, the Western Indian Ocean regional SEEA EA programme, and local governance decisions affecting marine protected areas, mangrove conservation, and artisanal fisheries management in Kilifi County.

---

## Study Area

<div class="grid grid-cols-3">

<div class="card">

### Coral Reefs (M1.3)
**Kanamai to Malindi MPA** - fringing and patch reefs

- **2 survey periods** (Nov 2024, Jul 2025)
- **53** reef survey sites across 3 programmes (48 in Nov 2024, 8 in Jul 2025; 3 overlap)
- Fish biomass, benthic cover, coral health, recruitment
- 4 protected area categories (no-take, managed, community, open access)

</div>

<div class="card">

### Mangroves (MFT1.2)
**Kilifi Creek, Marereni, Mida Creek, Ngomeni**

- **6,083 ha** opening extent (GMW 2020)
- **5,742 ha** closing extent (2025)
- **32** field plots across 4 areas
- Stem density, DBH, canopy height, canopy cover, tree quality

</div>

<div class="card">

### Seagrass (M1.1)
**9 survey areas** along Kilifi coast

- **3,040** quadrat records
- **8 species** recorded (maximum at Ngomeni)
- Shoot density, canopy height, total cover
- Species composition by area and zone

</div>

</div>

---

## Key Metrics at a Glance

```js
const nReefSites = new Set(fishData.map(d => d.site)).size;
const meanFishBiomass = d3.mean(fishData.filter(d => d.survey_period === "Jul_2025"), d => d.mean_biomass_kg_ha);
const nSeagrassAreas = seagrassData.length;
const latestCatch = fisheriesPhys[fisheriesPhys.length - 1];
const latestRent = fisheriesMon[fisheriesMon.length - 1];
const meanSeagrassCover = d3.mean(seagrassData, d => d.Total_Cover_pct);
const meanMangroveCI = d3.mean(mangroveData, d => d.ci_composite);
```

<div class="grid grid-cols-4">
<div class="card">
<h3>Reef Survey Sites</h3>
<p class="big">${nReefSites}</p>
<p class="note">across 2 survey periods</p>
</div>
<div class="card">
<h3>Fish Biomass (Jul 2025)</h3>
<p class="big">${meanFishBiomass ? meanFishBiomass.toLocaleString("en-US", {maximumFractionDigits: 0}) : "-"} kg/ha</p>
<p class="note">WIO target: 1,150 kg/ha</p>
</div>
<div class="card">
<h3>Mangrove Extent (2025)</h3>
<p class="big">5,742 ha</p>
<p class="note">-341 ha (-5.6%) since 2020</p>
</div>
<div class="card">
<h3>Reef Fisheries Rent (2024)</h3>
<p class="big">USD ${latestRent ? latestRent.resource_rent_central_usd.toLocaleString("en-US", {maximumFractionDigits: 0}) : "-"}</p>
<p class="note">resource rent method</p>
</div>
</div>

<div class="grid grid-cols-4">
<div class="card">
<h3>Seagrass Areas</h3>
<p class="big">${nSeagrassAreas}</p>
<p class="note">mean cover: ${meanSeagrassCover ? meanSeagrassCover.toFixed(0) : "-"}%</p>
</div>
<div class="card">
<h3>Mangrove Condition</h3>
<p class="big">${meanMangroveCI ? meanMangroveCI.toFixed(2) : "-"}</p>
<p class="note">composite CI (0-1 scale)</p>
</div>
<div class="card">
<h3>Reef Catch (2024)</h3>
<p class="big">${latestCatch ? latestCatch.reef_catch_adjusted_mt.toLocaleString("en-US", {maximumFractionDigits: 0}) : "-"} mt</p>
<p class="note">${latestCatch ? latestCatch.reef_fraction_pct.toFixed(0) : "-"}% of county catch</p>
</div>
<div class="card">
<h3>Protected Area Coverage</h3>
<p class="big">66%</p>
<p class="note">of mangrove within PAs</p>
</div>
</div>

---

## Headline Findings

<div class="grid grid-cols-2">

<div class="card finding-good">

### Protected areas deliver measurable benefits

Watamu Marine Park (no-take MPA) recorded a composite reef condition index of **0.79** compared to **0.63** for unprotected sites - a 25% advantage. Mida Creek Marine National Reserve showed a **23% condition advantage** over unprotected mangrove stands. Protection status is the strongest single predictor of ecosystem condition across all three ecosystem types.

</div>

<div class="card finding-risk">

### Coral recruitment is critically low

Recruitment density across all reef sites ranged from **0.00 to 0.14 recruits/m$^2$**, far below the WIO benchmark of 1-3 recruits/m$^2$. This is the single most concerning finding: even where adult coral and fish communities show post-bleaching recovery, the supply of new coral colonies is insufficient to sustain reef structure over decadal timescales.

</div>

<div class="card finding-risk">

### Mangrove extent declining despite high PA coverage

Net loss of **341 ha (-5.6%)** between 2020 and 2025, despite 66% of remaining mangrove falling within protected areas. Condition indices indicate post-disturbance regenerating stands (high stem density, low DBH) across most sites - consistent with recent clearing followed by regrowth rather than mature forest.

</div>

<div class="card finding-good">

### Seagrass meadows in good condition

Mean cover across 9 areas is high, with Ngomeni recording **8 species** - the highest diversity in the study area. Seagrass condition indices range from 0.69 to 0.94, though all reference levels carry LOW confidence pending WIO-specific baseline validation.

</div>

</div>

---

## Mangrove Extent Account (2020-2025)

Between 2020 and 2025, Kilifi County lost a net **341 ha** of mangrove (-5.6%), with 928 ha of reductions partially offset by 589 ha of additions. 66.3% of remaining mangrove (3,806 ha) falls within protected areas.

```js
Plot.plot({
  title: "Mangrove extent account, 2020-2025",
  width: 700,
  height: 200,
  marginLeft: 200,
  x: {label: "Area (ha)", grid: true},
  y: {label: null, domain: ["Opening (2020)", "Additions", "Reductions", "Closing (2025)"]},
  marks: [
    Plot.barX([
      {label: "Opening (2020)", value: 6083.04, type: "extent"},
      {label: "Additions", value: 589.10, type: "gain"},
      {label: "Reductions", value: 927.84, type: "loss"},
      {label: "Closing (2025)", value: 5741.64, type: "extent"}
    ], {
      x: "value",
      y: "label",
      fill: d => d.type === "loss" ? "#e76f51" : d.type === "gain" ? "#2a9d8f" : "#264653",
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

---

## SEEA EA Condition Accounts

Condition indices are normalised to a 0-1 scale against established reference levels. Coral reef has two time points (opening and closing); mangrove and seagrass are single-year baselines.

### Coral Reef (M1.3) - Nov 2024 to Jul 2025

Only three sites -- Roka, Watamu Coral Garden, and Wesa -- were surveyed in both periods, enabling direct opening-vs-closing comparison. The matched indicators are limited to coral health metrics; fish biomass, live coral cover, and invertebrate indicators were not measured at these same sites in both periods.

```js
const coralCondition = [
  {indicator: "Coral bleaching", opening: 0.927, closing: 1.000, change: 0.073},
  {indicator: "Coral health (% healthy)", opening: 0.845, closing: 0.988, change: 0.142},
  {indicator: "Coral disease", opening: 1.000, closing: 1.000, change: 0.000},
  {indicator: "Coral recruitment", opening: 0.030, closing: 0.049, change: 0.019},
  {indicator: "Composite (matched)", opening: 0.701, closing: 0.759, change: 0.058}
];
```

```js
Inputs.table(coralCondition, {
  columns: ["indicator", "opening", "closing", "change"],
  header: {
    indicator: "Indicator",
    opening: "Opening (Nov 2024)",
    closing: "Closing (Jul 2025)",
    change: "Change"
  },
  format: {
    opening: d => d.toFixed(3),
    closing: d => d.toFixed(3),
    change: d => (d >= 0 ? "+" : "") + d.toFixed(3)
  }
})
```

Composite condition at the three overlapping sites improved from 0.701 to 0.759 (+0.058), driven by post-bleaching recovery in coral health and bleaching indices. Coral recruitment remains critically low (CI 0.049), well below the WIO benchmark. Fish biomass, live coral cover, and invertebrate indicators are available for each period separately but cannot be compared temporally as they were measured at different sites.

### Mangrove (MFT1.2) - 2025 baseline

Mangrove condition is a single-year snapshot (December 2025). Composite CI of **0.40** reflects a regenerating-stand signature: high stem density (CI 0.91) offset by low structural maturity (DBH CI 0.17, height CI 0.28). No temporal comparison is available until resurvey.

### Seagrass (M1.1) - 2024 baseline

Seagrass condition is a single-year snapshot (2024). Composite CI of **0.78** reflects high total cover (CI 0.96) with moderate species richness (CI 0.54). All reference levels carry LOW confidence pending WIO-specific validation. Repeat survey planned for 2026 to enable change detection.

---

## Fish Biomass by Site

```js
Plot.plot({
  title: "Reef fish biomass by survey site (kg/ha)",
  subtitle: "Nov 2024 and Jul 2025 shown side by side; dashed line = 500 kg/ha sustainability threshold",
  width: 800,
  height: 650,
  marginLeft: 160,
  x: {label: "Fish biomass (kg/ha)", grid: true},
  fy: {label: null, domain: d3.groupSort(fishData, v => -d3.max(v, d => d.mean_biomass_kg_ha), d => d.site)},
  y: {label: null},
  color: {
    domain: ["Nov_2024", "Jul_2025"],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(fishData, {
      x: "mean_biomass_kg_ha",
      fy: "site",
      y: "survey_period",
      fill: "survey_period",
      tip: true
    }),
    Plot.ruleX([500], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 2}),
    Plot.ruleX([0])
  ]
})
```

Richard Bennett (Watamu Marine Park, no-take MPA) stands out at over 3,000 kg/ha - six times the sustainability threshold. Most open-access sites fall well below 500 kg/ha, underscoring the biomass gradient between protected and unprotected reefs.

---

## Reef-Associated Fisheries (2020-2024)

```js
Plot.plot({
  title: "Reef-associated fish catch, 2020-2024",
  subtitle: "Physical supply (metric tonnes) with uncertainty bounds",
  width: 800,
  height: 350,
  x: {label: "Year", tickFormat: "d"},
  y: {label: "Reef catch (mt)", grid: true},
  marks: [
    Plot.areaY(fisheriesPhys, {
      x: "year",
      y1: "reef_catch_lower_mt",
      y2: "reef_catch_upper_mt",
      fill: "#2a9d8f",
      fillOpacity: 0.2
    }),
    Plot.lineY(fisheriesPhys, {
      x: "year",
      y: "reef_catch_adjusted_mt",
      stroke: "#2a9d8f",
      strokeWidth: 2.5
    }),
    Plot.dot(fisheriesPhys, {
      x: "year",
      y: "reef_catch_adjusted_mt",
      fill: "#2a9d8f",
      r: 5,
      tip: true,
      title: d => `${d.year}\nReef catch: ${d.reef_catch_adjusted_mt.toLocaleString("en-US", {maximumFractionDigits: 0})} mt\nTotal county: ${d.total_county_catch_mt.toLocaleString()} mt`
    }),
    Plot.ruleY([0])
  ]
})
```

---

## Report Structure

<div class="grid grid-cols-3">

<div class="card">

### [Mangrove Extent & Condition](./mangrove)
Mangrove extent change (2020-2025) and field-based condition indices for stem density, DBH, canopy height, and canopy cover.

</div>

<div class="card">

### [Coral Reef Condition](./coral-reef)
Benthic cover, coral health, fish biomass, and recruitment indices across reef sites and protected area categories.

</div>

<div class="card">

### [Seagrass Condition](./seagrass)
Seagrass total cover, species richness, shoot density, and canopy height across 9 survey areas.

</div>

<div class="card">

### [Fisheries Provisioning](./fisheries)
Reef-associated fisheries catch (physical supply) and monetary valuation using resource rent method, 2020-2024.

</div>

<div class="card">

### [Cross-Ecosystem Synthesis](./synthesis)
Protected area effectiveness, seascape integration at Ngomeni, data confidence assessment, and policy implications.

</div>

<div class="card">

### [SEEA EA Accounts](./seea-accounts)
Integrated extent and condition accounts in UN SEEA EA format across all three ecosystem types.

</div>

<div class="card">

### [Methods](./methods)
Survey design, data processing pipeline, reference levels, and known limitations.

</div>

<div class="card">

### [Data Tables](./data-tables)
Interactive, sortable tables of all underlying datasets.

</div>

</div>

---

**Study area:** Kilifi County, Kenya | **Framework:** UN SEEA EA | **Compilation date:** March 2026 | [About and partners](./about)

[^1]: United Nations (2021). System of Environmental-Economic Accounting - Ecosystem Accounting (SEEA EA). United Nations, New York.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.note {
  font-size: 0.8rem;
  color: #666;
  margin: 0.2rem 0 0 0;
}
.card h3 { margin-top: 0; }
.finding-good {
  border-left: 4px solid #2a9d8f;
}
.finding-risk {
  border-left: 4px solid #e76f51;
}
</style>
