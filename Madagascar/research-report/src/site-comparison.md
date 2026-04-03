# Site Comparison

## Cross-Site Biotic Indicator Comparison

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const siteRaw = await FileAttachment("data/site-condition.csv.js").text();
const siteData = d3.csvParse(siteRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);

const perSiteRaw = await FileAttachment("data/condition-per-site.csv.js").text();
const perSiteData = d3.csvParse(perSiteRaw.replace(/^export default `|`;$/g, "").trim(), d3.autoType);
```

---

## Biomass vs Species Richness

The relationship between fish biomass and species richness reveals whether sites are productive and diverse (upper right), or show signs of selective fishing (high biomass, low diversity).

```js
Plot.plot({
  title: "Fish biomass vs species richness by site",
  subtitle: "Colour by year; size proportional to number of transects",
  width: 800,
  height: 500,
  x: {label: "Fish biomass (kg/ha)", grid: true},
  y: {label: "Species richness", grid: true},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.dot(siteData, {
      x: "mean_biomass_kg_ha",
      y: "species_richness",
      fill: "Year",
      r: d => Math.sqrt(d.n_transects) * 3,
      tip: true,
      title: d => `${d.Sites} (${d.Year})\nBiomass: ${d.mean_biomass_kg_ha.toFixed(0)} kg/ha\nRichness: ${d.species_richness} spp`
    }),
    Plot.ruleX([500], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 1.5}),
    Plot.ruleY([50], {stroke: "#e9c46a", strokeDasharray: "4,4", strokeWidth: 1.5})
  ]
})
```

Vertical dashed line: 500 kg/ha biomass reference. Horizontal dashed line: 50 species (approximate median).

---

## Biomass vs Sea Urchin Density

Elevated sea urchin density combined with low fish biomass may indicate trophic cascade effects from overfishing of urchin predators.

```js
Plot.plot({
  title: "Fish biomass vs sea urchin density",
  subtitle: "Dashed line = 2.0 ind/m2 provisional reference for urchin overgrazing",
  width: 800,
  height: 500,
  x: {label: "Fish biomass (kg/ha)", grid: true},
  y: {label: "Sea urchin density (ind/m2)", grid: true},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.dot(siteData, {
      x: "mean_biomass_kg_ha",
      y: "urchin_density_m2",
      fill: "Year",
      r: 6,
      tip: true,
      title: d => `${d.Sites} (${d.Year})\nBiomass: ${d.mean_biomass_kg_ha.toFixed(0)} kg/ha\nUrchin: ${d.urchin_density_m2.toFixed(2)} ind/m2`
    }),
    Plot.ruleY([2.0], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 1.5})
  ]
})
```

---

## Giant Clam Abundance by Site

Giant clam (*Tridacna*) presence is an indicator of reef health and harvesting pressure. Clams are commercially valuable and among the first species depleted under unregulated harvest.

```js
Plot.plot({
  title: "Giant clam abundance by site (mean count per transect)",
  width: 800,
  height: 600,
  marginLeft: 120,
  x: {label: "Mean Tridacna count per transect", grid: true},
  y: {label: null},
  color: {
    domain: [2025, 2026],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(siteData, {
      x: "mean_tridacna_count",
      y: "Sites",
      fill: "Year",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

---

## Condition Index Summary Table

```js
const ciSummary = perSiteData
  .filter(d => d.condition_indicator === "Fish species richness")
  .map(d => {
    const site = siteData.find(s => s.Sites === d.site && s.Year === d.calendar_year);
    return {
      Site: d.site,
      Year: d.calendar_year,
      "Biomass (kg/ha)": site ? site.mean_biomass_kg_ha.toFixed(0) : "—",
      "Species": site ? site.species_richness : "—",
      "CI Richness": d.condition_index.toFixed(2),
      "Urchin (ind/m2)": site ? site.urchin_density_m2.toFixed(2) : "—",
      "Tridacna": site ? site.mean_tridacna_count.toFixed(1) : "—"
    };
  })
  .sort((a, b) => b["CI Richness"] - a["CI Richness"]);
```

```js
Inputs.table(ciSummary, {
  columns: ["Site", "Year", "Biomass (kg/ha)", "Species", "CI Richness", "Urchin (ind/m2)", "Tridacna"],
  header: {
    "CI Richness": "CI (Richness)",
    "Urchin (ind/m2)": "Urchin density"
  },
  width: {Site: 120}
})
```

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
</style>
