# Madagascar Coral Reef Condition Accounts

## Biotic Condition Baseline, Atsimo-Andrefana Region, 2025--2026

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const siteRaw = await FileAttachment("data/site-condition.csv.js").text();
const siteData = d3.csvParse(siteRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);

const seeaRaw = await FileAttachment("data/seea-condition.csv.js").text();
const seeaData = d3.csvParse(seeaRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);
```

This report presents baseline ecosystem condition accounts for photic coral reefs (M1.3) across 27 survey sites in southwest Madagascar, compiled under the UN System of Environmental-Economic Accounting -- Ecosystem Accounting (SEEA EA) framework[^1]. Biotic condition indicators are derived from underwater visual census (UVC) surveys conducted between November 2025 and February 2026.

---

## Study Area

<div class="grid grid-cols-2">

<div class="card">

### Survey Programme
**Atsimo-Andrefana Region** -- SW Madagascar barrier and fringing reefs

- **27** coastal survey sites
- **85** stations nested within sites
- **2** transects per station (50 m x 5 m UVC belt)
- **5,186** fish records (227 species, 39 families)
- **434** macroinvertebrate records (59 species)
- **264** sea urchin records (8 species)

</div>

<div class="card">

### Accounting Period
**Opening period:** November 2025 (Year 1, 15 sites)
**Closing period:** January--February 2026 (Year 2, 13 sites)

- Depth range: 3.6--16.5 m
- Primary observers: Laza (fish), Maka (invertebrates)
- Framework: UN SEEA EA Ecosystem Condition Accounts
- Ecosystem type: Photic Coral Reefs (IUCN GET M1.3)

</div>

</div>

---

## Key Metrics at a Glance

```js
const sites2025 = siteData.filter(d => d.Year === 2025);
const sites2026 = siteData.filter(d => d.Year === 2026);
const allSites = new Set(siteData.map(d => d.Sites));
const meanBiomass = d3.mean(siteData, d => d.mean_biomass_kg_ha);
const meanRichness = d3.mean(siteData, d => d.species_richness);
const totalTransects = d3.sum(siteData, d => d.n_transects);
```

<div class="grid grid-cols-4">
<div class="card">
<h3>Survey Sites</h3>
<p class="big">${allSites.size}</p>
</div>
<div class="card">
<h3>Mean Fish Biomass</h3>
<p class="big">${meanBiomass.toLocaleString("en-US", {maximumFractionDigits: 0})} kg/ha</p>
</div>
<div class="card">
<h3>Mean Species Richness</h3>
<p class="big">${meanRichness.toFixed(0)} species</p>
</div>
<div class="card">
<h3>Total Transects</h3>
<p class="big">${totalTransects}</p>
</div>
</div>

---

## Fish Biomass by Site

```js
Plot.plot({
  title: "Fish biomass by survey site (kg/ha)",
  subtitle: "Colour indicates survey year; dashed line = 500 kg/ha reference level",
  width: 800,
  height: 600,
  marginLeft: 120,
  x: {label: "Fish biomass (kg/ha)", grid: true},
  y: {label: null},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(siteData, {
      x: "mean_biomass_kg_ha",
      y: "Sites",
      fill: "Year",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([500], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 2}),
    Plot.ruleX([0])
  ]
})
```

## SEEA EA Condition Account Summary

```js
const seeaMetrics = seeaData.map(d => ({
  ...d,
  ci_numeric: parseFloat(d.condition_index),
  label: `${d.condition_indicator} (${d.calendar_year})`
}));
```

```js
Plot.plot({
  title: "SEEA EA condition indices by indicator and year",
  subtitle: "Higher = better condition (1.0 = reference level met or exceeded)",
  width: 800,
  height: 300,
  marginLeft: 200,
  x: {label: "Condition Index", domain: [0, 1]},
  y: {label: null},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(seeaMetrics, {
      x: "ci_numeric",
      y: "label",
      fill: "calendar_year",
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

---

## Report Structure

<div class="grid grid-cols-3">

<div class="card">

### [Condition Analysis](./condition-analysis)
Site-level condition indices for fish biomass, species richness, and COTS density across all 27 survey locations.

</div>

<div class="card">

### [Trophic Composition](./trophic-composition)
Functional group breakdown (herbivore, carnivore, planktivore, corallivore, omnivore) by site and survey year.

</div>

<div class="card">

### [Site Comparison](./site-comparison)
Head-to-head comparison of key biotic indicators across sites, identifying high- and low-condition locations.

</div>

<div class="card">

### [Data Tables](./data-tables)
Interactive, sortable tables of all underlying datasets: site-level metrics, SEEA EA condition indices, and functional group composition.

</div>

<div class="card">

### [Methods](./methods)
UVC survey methodology, SEEA EA framework, QA/QC protocols, reference levels, and known limitations.

</div>

</div>

---

**Study period:** November 2025 -- February 2026 UVC surveys | **Framework:** UN SEEA EA | **Compilation date:** March 2026

[^1]: United Nations (2021). System of Environmental-Economic Accounting -- Ecosystem Accounting (SEEA EA). United Nations, New York. The SEEA EA provides a framework for organising biophysical data on ecosystems, measuring ecosystem services, and tracking changes in ecosystem extent and condition.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
