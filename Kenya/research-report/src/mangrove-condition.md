# Mangrove Condition

## Kilifi County Field-Based Condition Account

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const conditionSite = await FileAttachment("data/mangrove-condition-site.csv").csv({typed: true});
```

Field-based condition surveys across 32 plots in 4 areas along the Kilifi coastline. Five structural indicators are normalised to 0-1 against reference values: stem density, mean DBH, mean height, canopy cover, and tree quality index. The data show a regenerating-stand signature - high stem density but low DBH - consistent with recent disturbance followed by regrowth rather than mature forest. See [Mangrove Extent](mangrove) for the satellite-derived extent account.

---

## Composite Condition Index by Site

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
