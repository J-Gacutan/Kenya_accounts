# Data Tables

## Interactive Data Explorer

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const siteRaw = await FileAttachment("data/site-condition.csv.js").text();
const siteData = d3.csvParse(siteRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);

const seeaRaw = await FileAttachment("data/seea-condition.csv.js").text();
const seeaData = d3.csvParse(seeaRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);

const perSiteRaw = await FileAttachment("data/condition-per-site.csv.js").text();
const perSiteData = d3.csvParse(perSiteRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);

const fgRaw = await FileAttachment("data/functional-groups.csv.js").text();
const fgData = d3.csvParse(fgRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);
```

---

## Dataset Summary

<div class="grid grid-cols-4">
<div class="card">
<h3>Sites</h3>
<p class="big">${new Set(siteData.map(d => d.Sites)).size}</p>
</div>
<div class="card">
<h3>Site-Year Records</h3>
<p class="big">${siteData.length}</p>
</div>
<div class="card">
<h3>SEEA Indicators</h3>
<p class="big">${seeaData.length}</p>
</div>
<div class="card">
<h3>Functional Group Records</h3>
<p class="big">${fgData.length}</p>
</div>
</div>

---

## SEEA EA Condition Account

The aggregate ecosystem condition account in UN SEEA EA format, showing measured values against reference levels.

```js
Inputs.table(seeaData, {
  columns: ["calendar_year", "condition_indicator", "reference_level", "measured_value", "condition_index"],
  header: {
    calendar_year: "Year",
    condition_indicator: "Indicator",
    reference_level: "Reference Level",
    measured_value: "Measured Value",
    condition_index: "CI"
  }
})
```

---

## Site-Level Condition Indices

```js
const yearFilter = view(Inputs.select([2025, 2026], {label: "Survey year", value: 2025}));
```

```js
const filteredPerSite = perSiteData.filter(d => d.calendar_year === yearFilter);
```

```js
Inputs.table(filteredPerSite, {
  columns: ["site", "condition_indicator", "measured_value", "condition_index"],
  header: {
    site: "Site",
    condition_indicator: "Indicator",
    measured_value: "Measured",
    condition_index: "CI"
  },
  sort: "site"
})
```

---

## Site-Level Summary Data

All raw biotic metrics by site and year.

```js
const siteTable = siteData.map(d => ({
  Year: d.Year,
  Site: d.Sites,
  "Biomass (kg/ha)": d.mean_biomass_kg_ha.toFixed(1),
  "Abundance (ind/ha)": d.mean_abundance_ha.toFixed(0),
  "Species": d.species_richness,
  "CI Biomass": d.ci_fish_biomass.toFixed(2),
  "CI Richness": d.ci_fish_richness.toFixed(2),
  "COTS (ind/ha)": d.cots_density_ha.toFixed(1),
  "CI COTS": d.ci_cots.toFixed(2),
  "Tridacna": d.mean_tridacna_count.toFixed(1),
  "Invert spp": d.species_richness_invert,
  "Urchin (ind/m2)": d.urchin_density_m2.toFixed(2),
  Transects: d.n_transects
}));
```

```js
Inputs.table(siteTable, {
  sort: "Site"
})
```

---

## Functional Group Composition

Trophic biomass breakdown by site, year, and functional group.

```js
const fgTable = fgData.map(d => ({
  Year: d.Year,
  Site: d.Sites,
  Group: d.Functional_Group_Std,
  "Biomass (kg/ha)": d.mean_biomass_kg_ha.toFixed(1),
  "Abundance (ind/ha)": d.mean_abundance_ha.toFixed(0),
  Transects: d.n_transects
}));
```

```js
Inputs.table(fgTable, {
  sort: "Site"
})
```

---

## Export

To export any table as CSV, right-click the table and select "Copy" or use the download buttons provided by Observable's table component.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
