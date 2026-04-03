# Mangrove Extent & Condition

## Kilifi County Mangrove Accounts

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const extentChange = await FileAttachment("data/mangrove-extent-change.csv").csv({typed: true});
const conditionSite = await FileAttachment("data/mangrove-condition-site.csv").csv({typed: true});
const speciesData = await FileAttachment("data/mangrove-species.csv").csv({typed: true});
```

Mangroves along the Kilifi coastline were assessed through two complementary approaches: satellite-derived extent mapping (GMW 2020 baseline vs 2025 project classification) and field-based condition surveys across 32 plots in 4 areas. The accounts reveal a paradox: despite 66% of mangrove falling within protected areas, extent declined by 5.6% over 5 years. Field data show a regenerating-stand signature - high stem density but low DBH - consistent with recent disturbance followed by regrowth rather than mature forest.

---

## Extent Account (2020-2025)

The mangrove extent account tracks change between the Global Mangrove Watch (GMW) v4 2020 baseline (Sentinel-2 analysis at 10 m spatial resolution) and the 2025 project classification.

```js
Inputs.table(extentChange, {
  columns: ["Component", "Year", "Polygons", "Area_ha", "Source"],
  header: {
    Component: "Entry",
    Area_ha: "Area (ha)"
  },
  width: {Component: 250, Source: 200}
})
```

<div class="grid grid-cols-4">
<div class="card">
<h3>Opening (2020)</h3>
<p class="big">6,083 ha</p>
</div>
<div class="card">
<h3>Additions</h3>
<p class="big" style="color:#2a9d8f">+589 ha</p>
</div>
<div class="card">
<h3>Reductions</h3>
<p class="big" style="color:#e76f51">-928 ha</p>
</div>
<div class="card">
<h3>Closing (2025)</h3>
<p class="big">5,742 ha</p>
</div>
</div>

Net loss of 341 ha (-5.6%) over 5 years. 66.3% of remaining mangrove (3,806 ha) falls within protected areas.

---

## Extent Change (2020-2025)

```js
Plot.plot({
  title: "Mangrove extent account",
  subtitle: "Opening, additions, reductions, and closing extent (hectares)",
  width: 700,
  height: 200,
  marginLeft: 250,
  x: {label: "Area (ha)", grid: true},
  y: {label: null, domain: ["Opening extent (GMW 2020)", "Additions (new in 2025)", "Reductions (lost since 2020)", "Closing extent (2025)"]},
  marks: [
    Plot.barX([
      {label: "Opening extent (GMW 2020)", value: 6083.04, type: "extent"},
      {label: "Additions (new in 2025)", value: 589.10, type: "gain"},
      {label: "Reductions (lost since 2020)", value: 927.84, type: "loss"},
      {label: "Closing extent (2025)", value: 5741.64, type: "extent"}
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

## Protected Area Coverage (2025)

```js
Plot.plot({
  title: "Mangrove extent by protection status",
  subtitle: "66.3% of remaining mangrove falls within protected areas",
  width: 700,
  height: 150,
  marginLeft: 250,
  x: {label: "Area (ha)", grid: true},
  y: {label: null, domain: ["Within protected areas", "Outside protected areas"]},
  marks: [
    Plot.barX([
      {label: "Within protected areas", value: 3806.46},
      {label: "Outside protected areas", value: 1935.18}
    ], {
      x: "value",
      y: "label",
      fill: d => d.label.includes("Within") ? "#2a9d8f" : "#e9c46a",
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

---

## Field-Based Condition Indices by Site

Condition indices are normalised to 0-1 against reference values. Five indicators are measured: stem density, mean DBH, mean height, canopy cover, and tree quality index.

```js
const condClean = conditionSite.filter(d => d.site != null);
```

```js
Plot.plot({
  title: "Composite condition index by site",
  subtitle: "Weighted average of 5 structural indicators; higher = better condition",
  width: 800,
  height: 600,
  marginLeft: 160,
  x: {label: "Composite Condition Index (0-1)", domain: [0, 1], grid: true},
  y: {label: null},
  color: {
    domain: ["Unprotected", "Mida Creek MNR"],
    range: ["#e76f51", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(condClean, {
      x: "ci_composite",
      y: "site",
      fill: "pa_status",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

---

## Individual Condition Indicators

```js
const indicatorLong = condClean.flatMap(d => [
  {site: d.site, area: d.area, indicator: "Stem density", ci: d.ci_stem_density, pa: d.pa_status},
  {site: d.site, area: d.area, indicator: "Mean DBH", ci: d.ci_mean_dbh, pa: d.pa_status},
  {site: d.site, area: d.area, indicator: "Mean height", ci: d.ci_mean_height, pa: d.pa_status},
  {site: d.site, area: d.area, indicator: "Canopy cover", ci: d.ci_canopy_cover, pa: d.pa_status},
  {site: d.site, area: d.area, indicator: "Tree quality", ci: d.ci_quality_index, pa: d.pa_status}
]);
```

```js
Plot.plot({
  title: "Condition indices by indicator and site",
  subtitle: "Faceted by indicator; 1.0 = reference level met",
  width: 800,
  height: 800,
  marginLeft: 160,
  fx: {label: null},
  x: {label: "Condition Index (0-1)", domain: [0, 1]},
  y: {label: null},
  color: {
    domain: ["Unprotected", "Mida Creek MNR"],
    range: ["#e76f51", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(indicatorLong, {
      x: "ci",
      y: "site",
      fill: "pa",
      fx: "indicator",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

Key findings:
- **Stem density** is generally high (many sites at CI = 1.0), indicating dense regeneration
- **Mean DBH** is uniformly low (CI < 0.35), reflecting young, small-diameter stands
- **Canopy cover** is highly variable, with some sites at 0 (sparse canopy)
- Sites in **Mida Creek MNR** tend to outperform unprotected sites on structural complexity

---

## Condition by Area

```js
const areaAgg = d3.rollups(condClean, v => ({
  n_sites: v.length,
  mean_composite: d3.mean(v, d => d.ci_composite),
  mean_height: d3.mean(v, d => d.mean_height_m),
  mean_dbh: d3.mean(v, d => d.mean_dbh_cm),
  mean_density: d3.mean(v, d => d.mean_stem_density_ha),
  mean_cover: d3.mean(v, d => d.mean_canopy_cover_pct)
}), d => d.area).map(([area, v]) => ({Area: area, ...v}));
```

```js
Inputs.table(areaAgg, {
  columns: ["Area", "n_sites", "mean_composite", "mean_density", "mean_dbh", "mean_height", "mean_cover"],
  header: {
    n_sites: "Sites",
    mean_composite: "Mean CI",
    mean_density: "Stem density (/ha)",
    mean_dbh: "Mean DBH (cm)",
    mean_height: "Mean height (m)",
    mean_cover: "Canopy cover (%)"
  },
  format: {
    mean_composite: d => d.toFixed(3),
    mean_density: d => d.toFixed(0),
    mean_dbh: d => d.toFixed(1),
    mean_height: d => d.toFixed(1),
    mean_cover: d => d.toFixed(0)
  }
})
```

---

## Full Site-Level Condition Data

```js
Inputs.table(condClean.map(d => ({
  Area: d.area,
  Site: d.site,
  Plots: d.n_plots,
  "Stems/ha": d.mean_stem_density_ha.toFixed(0),
  "DBH (cm)": d.mean_dbh_cm.toFixed(1),
  "Height (m)": d.mean_height_m.toFixed(1),
  "Cover (%)": d.mean_canopy_cover_pct,
  "CI composite": d.ci_composite.toFixed(3),
  PA: d.pa_status,
  "Low sample": d.low_sample
})), {
  sort: "Area"
})
```

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
