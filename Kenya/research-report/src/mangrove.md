# Mangrove Extent

## Kilifi County Mangrove Extent Account

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const extentChange = await FileAttachment("data/mangrove-extent-change.csv").csv({typed: true});
const speciesData = await FileAttachment("data/mangrove-species.csv").csv({typed: true});
```

Mangrove extent along the Kilifi coastline was assessed using satellite-derived mapping (GMW 2020 baseline vs 2025 project classification). Despite 66% of mangrove falling within protected areas, extent declined by 5.6% over 5 years. See [Mangrove Condition](mangrove-condition) for field-based condition survey results.

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

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
