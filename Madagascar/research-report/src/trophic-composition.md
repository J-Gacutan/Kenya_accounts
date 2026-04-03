# Trophic Composition

## Functional Group Breakdown by Site

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const fgRaw = await FileAttachment("data/functional-groups.csv.js").text();
const fgData = d3.csvParse(fgRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);
```

Trophic composition provides insight into reef community structure and fishing pressure. Healthy WIO reefs typically show herbivore dominance (30--50% of biomass), with carnivores as the second-largest group. Reduced herbivore biomass or absence of large carnivores may indicate selective fishing.

---

## Accounting-Area Trophic Composition

```js
const fgTotals = d3.rollups(fgData, v => d3.sum(v, d => d.mean_biomass_kg_ha), d => d.Functional_Group_Std)
  .map(([group, total]) => ({group, total}))
  .sort((a, b) => b.total - a.total);
const grandTotal = d3.sum(fgTotals, d => d.total);
const fgPct = fgTotals.map(d => ({...d, pct: (d.total / grandTotal * 100).toFixed(1)}));
```

```js
Plot.plot({
  title: "Trophic composition -- all sites pooled (% biomass)",
  width: 800,
  height: 300,
  marginLeft: 120,
  x: {label: "Total biomass (kg/ha)", grid: true},
  y: {label: null},
  color: {
    domain: ["Herbivore", "Carnivore", "Planktivore", "Corallivore", "Omnivore", "Piscivore", "Detritivore"],
    range: ["#2a9d8f", "#264653", "#e9c46a", "#e76f51", "#a8dadc", "#457b9d", "#f4a261"],
    legend: true
  },
  marks: [
    Plot.barX(fgTotals, {
      x: "total",
      y: "group",
      fill: "group",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

---

## Trophic Composition by Site (2025)

```js
const fg2025 = fgData.filter(d => d.Year === 2025);
const siteTotals2025 = d3.rollups(fg2025, v => d3.sum(v, d => d.mean_biomass_kg_ha), d => d.Sites)
  .map(([site, total]) => ({site, total}));
const siteTotalMap2025 = new Map(siteTotals2025.map(d => [d.site, d.total]));
const fg2025pct = fg2025.map(d => ({
  ...d,
  pct_biomass: d.mean_biomass_kg_ha / siteTotalMap2025.get(d.Sites) * 100
}));
```

```js
Plot.plot({
  title: "Trophic composition by site -- 2025 opening period",
  subtitle: "Stacked proportion of fish biomass by functional group",
  width: 800,
  height: 500,
  marginLeft: 120,
  x: {label: "% of total biomass", domain: [0, 100]},
  y: {label: null},
  color: {
    domain: ["Herbivore", "Carnivore", "Planktivore", "Corallivore", "Omnivore", "Piscivore", "Detritivore"],
    range: ["#2a9d8f", "#264653", "#e9c46a", "#e76f51", "#a8dadc", "#457b9d", "#f4a261"],
    legend: true
  },
  marks: [
    Plot.barX(fg2025pct, Plot.stackX({
      x: "pct_biomass",
      y: "Sites",
      fill: "Functional_Group_Std",
      order: ["Herbivore", "Carnivore", "Planktivore", "Corallivore", "Omnivore", "Piscivore", "Detritivore"],
      tip: true
    })),
    Plot.ruleX([0])
  ]
})
```

---

## Trophic Composition by Site (2026)

```js
const fg2026 = fgData.filter(d => d.Year === 2026);
const siteTotals2026 = d3.rollups(fg2026, v => d3.sum(v, d => d.mean_biomass_kg_ha), d => d.Sites)
  .map(([site, total]) => ({site, total}));
const siteTotalMap2026 = new Map(siteTotals2026.map(d => [d.site, d.total]));
const fg2026pct = fg2026.map(d => ({
  ...d,
  pct_biomass: d.mean_biomass_kg_ha / siteTotalMap2026.get(d.Sites) * 100
}));
```

```js
Plot.plot({
  title: "Trophic composition by site -- 2026 closing period",
  subtitle: "Stacked proportion of fish biomass by functional group",
  width: 800,
  height: 450,
  marginLeft: 120,
  x: {label: "% of total biomass", domain: [0, 100]},
  y: {label: null},
  color: {
    domain: ["Herbivore", "Carnivore", "Planktivore", "Corallivore", "Omnivore", "Piscivore", "Detritivore"],
    range: ["#2a9d8f", "#264653", "#e9c46a", "#e76f51", "#a8dadc", "#457b9d", "#f4a261"],
    legend: true
  },
  marks: [
    Plot.barX(fg2026pct, Plot.stackX({
      x: "pct_biomass",
      y: "Sites",
      fill: "Functional_Group_Std",
      order: ["Herbivore", "Carnivore", "Planktivore", "Corallivore", "Omnivore", "Piscivore", "Detritivore"],
      tip: true
    })),
    Plot.ruleX([0])
  ]
})
```

---

## Herbivore Biomass by Site

Herbivore biomass is a key indicator of reef resilience. Herbivorous fish control macroalgal overgrowth, enabling coral recruitment and recovery after disturbance events.

```js
const herbData = fgData.filter(d => d.Functional_Group_Std === "Herbivore");
```

```js
Plot.plot({
  title: "Herbivore biomass by site (kg/ha)",
  subtitle: "Colour by survey year",
  width: 800,
  height: 600,
  marginLeft: 120,
  x: {label: "Herbivore biomass (kg/ha)", grid: true},
  y: {label: null},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(herbData, {
      x: "mean_biomass_kg_ha",
      y: "Sites",
      fill: "Year",
      sort: {y: "-x"},
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
</style>
