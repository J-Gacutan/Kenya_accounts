# Condition Analysis

## Site-Level Condition Indices

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const perSiteRaw = await FileAttachment("data/condition-per-site.csv.js").text();
const perSiteData = d3.csvParse(perSiteRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);

const siteRaw = await FileAttachment("data/site-condition.csv.js").text();
const siteData = d3.csvParse(siteRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);
```

Condition indices normalise raw biophysical measurements to a 0--1 scale against established reference levels. A value of 1.0 indicates the reference level is met or exceeded; values below 1.0 indicate departure from reference condition.

---

## Fish Species Richness -- Condition Index by Site

Species richness is the primary indicator of selective fishing pressure. The reference level is the maximum observed richness within each survey year (94 species in 2025, 103 in 2026).

```js
const richnessData = perSiteData.filter(d => d.condition_indicator === "Fish species richness");
```

```js
Plot.plot({
  title: "Fish species richness condition index by site",
  subtitle: "CI = observed / max observed; colour by survey year",
  width: 800,
  height: 600,
  marginLeft: 120,
  x: {label: "Condition Index (0-1)", domain: [0, 1]},
  y: {label: null},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(richnessData, {
      x: "condition_index",
      y: "site",
      fill: "calendar_year",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([0.5], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 1.5}),
    Plot.ruleX([0])
  ]
})
```

Sites below the dashed line (CI = 0.5) have fewer than half the species observed at the most diverse site -- a signature of selective fishing pressure that removes large, slow-reproducing species.

---

## COTS Density -- Condition Index by Site

Crown-of-thorns starfish (COTS) density is an inverted indicator: CI = 1.0 when no COTS are present (ideal), declining toward 0 as density approaches the outbreak threshold of 15 ind/ha[^1].

```js
const cotsData = perSiteData.filter(d => d.condition_indicator === "COTS density");
```

```js
Plot.plot({
  title: "COTS density condition index by site (inverted scale)",
  subtitle: "CI = 1 - (density / 15 ind/ha); 0 = outbreak threshold exceeded",
  width: 800,
  height: 600,
  marginLeft: 120,
  x: {label: "Condition Index (0-1)", domain: [0, 1]},
  y: {label: null},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(cotsData, {
      x: "condition_index",
      y: "site",
      fill: "calendar_year",
      sort: {y: "x"},
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

Three sites recorded COTS in 2025: **Retsela** (50 ind/ha, CI = 0.00), **Anakao** (25 ind/ha, CI = 0.17), and **Beheloky** (25 ind/ha, CI = 0.17). All three exceed the updated outbreak threshold of 15 ind/ha. No COTS were detected at any site in 2026.

---

## Fish Biomass Distribution

```js
Plot.plot({
  title: "Fish biomass distribution across all sites",
  subtitle: "Histogram of site-level mean biomass (kg/ha); dashed line = 500 kg/ha reference",
  width: 800,
  height: 350,
  x: {label: "Fish biomass (kg/ha)"},
  y: {label: "Number of sites"},
  marks: [
    Plot.rectY(siteData, Plot.binX({y: "count"}, {x: "mean_biomass_kg_ha", fill: "#2a9d8f", thresholds: 15})),
    Plot.ruleX([500], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 2}),
    Plot.ruleY([0])
  ]
})
```

Nearly all sites exceed the 500 kg/ha minimum reference level. The distribution is right-skewed, with a cluster of high-biomass sites above 2,000 kg/ha and a smaller group of lower-biomass sites (Ambatomilo, Fitsitika, Ifaty, Befasy) approaching the threshold.

---

## Sea Urchin Density by Site

Sea urchin density (ind/m2) is a supplementary biotic indicator. Elevated densities (above 1.5--2.0 ind/m2) may indicate overgrazing pressure on reef substrates.

```js
Plot.plot({
  title: "Sea urchin density by site (ind/m2)",
  subtitle: "Dashed line = provisional reference level (2.0 ind/m2)",
  width: 800,
  height: 600,
  marginLeft: 120,
  x: {label: "Sea urchin density (ind/m2)", grid: true},
  y: {label: null},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(siteData, {
      x: "urchin_density_m2",
      y: "Sites",
      fill: "Year",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([2.0], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 1.5}),
    Plot.ruleX([0])
  ]
})
```

[^1]: Dulvy et al. (2021) updated the COTS outbreak threshold from the conventional 30 ind/ha to 15 ind/ha based on Western Indian Ocean survey data.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
</style>
