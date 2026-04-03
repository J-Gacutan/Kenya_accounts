# Coral Reef Condition

## Kilifi County Reef Condition Indices

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const fishData = await FileAttachment("data/fish-condition-site.csv").csv({typed: true});
const benthicData = await FileAttachment("data/benthic-cover-site.csv").csv({typed: true});
const healthData = await FileAttachment("data/coral-health-site.csv").csv({typed: true});
const recruitData = await FileAttachment("data/coral-recruitment-site.csv").csv({typed: true});
const paData = await FileAttachment("data/condition-by-pa.csv").csv({typed: true});
const siteAll = await FileAttachment("data/site-condition-all.csv").csv({typed: true});
```

Coral reefs along the Kilifi coastline were surveyed by three independent programmes: CCVA/KMFRI (Nov 2024), PU-GOAP (Nov 2024), and COMRED Oceans (Jul 2025). The two survey periods sampled largely different site sets: November 2024 covered 48 sites across CCVA and PU-GOAP programmes, while July 2025 covered 8 sites under the COMRED programme. Only three sites -- Roka, Watamu Coral Garden, and Wesa -- were surveyed in both periods, enabling direct temporal comparison at those locations. The remaining sites provide independent cross-sectional snapshots for each period. The 8-month interval between survey periods captures post-bleaching recovery dynamics following the 2024 marine heatwave. Condition indices normalise raw biophysical measurements to a 0-1 scale against established reference levels. A value of 1.0 indicates the reference level is met or exceeded; values below 1.0 indicate departure from reference condition.

Three headline findings emerge: (1) fish biomass in the no-take Watamu Marine Park exceeds 3,000 kg/ha - six times the sustainability threshold - while most open-access sites fall below 500 kg/ha; (2) coral colony health shows strong post-bleaching recovery by July 2025 (0% bleached colonies at COMRED sites); and (3) coral recruitment is critically low across all sites (0.00-0.14 recruits/m2 against a 1-3/m2 WIO benchmark), signalling a structural bottleneck in reef recovery.

---

## Live Coral Cover by Site

Live hard coral cover is the primary structural indicator. The reference level is 30% (GCRMN 2021; Obura et al. 2022 WIO benchmark).

```js
const benthicWithCI = benthicData.filter(d => d.live_coral_pct != null);
```

```js
Plot.plot({
  title: "Live hard coral cover by site (%)",
  subtitle: "Dashed line = 30% GCRMN reference level; colour by survey period",
  width: 800,
  height: 450,
  marginLeft: 160,
  x: {label: "Live coral cover (%)", grid: true},
  y: {label: null},
  color: {
    domain: ["Nov_2024", "Jul_2025"],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(benthicWithCI, {
      x: "live_coral_pct",
      y: "site",
      fill: "survey_period",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([30], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 2}),
    Plot.ruleX([0])
  ]
})
```

November 2024 sites (Kilifi, Kanamai, Mtwapa, Malindi MPA) generally exceed the 30% threshold. July 2025 COMRED sites show lower cover, with Roka 1 at just 8% - potentially reflecting post-bleaching recovery dynamics.

---

## Benthic Composition (July 2025)

```js
const jul2025 = benthicData.filter(d => d.survey_period === "Jul_2025" && d.live_coral_pct != null);
const benthicLong = jul2025.flatMap(d => [
  {site: d.site, category: "Live coral", pct: d.live_coral_pct},
  {site: d.site, category: "Dead coral", pct: d.dead_coral_pct},
  {site: d.site, category: "Macroalgae", pct: d.macroalgae_pct},
  {site: d.site, category: "Rubble", pct: d.rubble_pct}
].filter(r => r.pct != null));
```

```js
Plot.plot({
  title: "Benthic composition by site - July 2025 (COMRED survey)",
  subtitle: "Stacked proportion of benthic cover categories",
  width: 800,
  height: 350,
  marginLeft: 160,
  x: {label: "Cover (%)", domain: [0, 100]},
  y: {label: null},
  color: {
    domain: ["Live coral", "Dead coral", "Macroalgae", "Rubble"],
    range: ["#2a9d8f", "#6c757d", "#e76f51", "#e9c46a"],
    legend: true
  },
  marks: [
    Plot.barX(benthicLong, Plot.stackX({
      x: "pct",
      y: "site",
      fill: "category",
      order: ["Live coral", "Dead coral", "Macroalgae", "Rubble"],
      tip: true
    })),
    Plot.ruleX([0])
  ]
})
```

---

## Coral Colony Health (% by Status)

```js
const healthClean = healthData.filter(d => d.site != null && d.n_total > 0);
const healthLong = healthClean.flatMap(d => [
  {site: d.site, period: d.survey_period, status: "Healthy", pct: d.pct_healthy},
  {site: d.site, period: d.survey_period, status: "Pale", pct: d.pct_pale},
  {site: d.site, period: d.survey_period, status: "Bleached", pct: d.pct_bleached},
  {site: d.site, period: d.survey_period, status: "Dead", pct: d.pct_dead}
].filter(r => r.pct != null && !isNaN(r.pct)));
```

```js
Plot.plot({
  title: "Coral colony health status by site",
  subtitle: "Proportion of surveyed colonies by health category",
  width: 800,
  height: 500,
  marginLeft: 160,
  x: {label: "% of colonies", domain: [0, 100]},
  y: {label: null},
  color: {
    domain: ["Healthy", "Pale", "Bleached", "Dead"],
    range: ["#2a9d8f", "#e9c46a", "#f4a261", "#e76f51"],
    legend: true
  },
  marks: [
    Plot.barX(healthLong, Plot.stackX({
      x: "pct",
      y: "site",
      fill: "status",
      order: ["Healthy", "Pale", "Bleached", "Dead"],
      tip: true
    })),
    Plot.ruleX([0])
  ]
})
```

July 2025 data shows high post-bleaching recovery: zero bleaching at all COMRED sites, but mortality rates of 4-15% at some Watamu sites.

---

## Fish Biomass by Site

```js
Plot.plot({
  title: "Reef fish biomass by site (kg/ha)",
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

Richard Bennett (Watamu Marine Park, no-take MPA) stands out at 3,085 kg/ha - six times the sustainability threshold. Most open-access sites fall well below 500 kg/ha.

---

## Fish Biomass vs Species Richness

```js
Plot.plot({
  title: "Fish biomass vs species richness by site",
  subtitle: "Size proportional to number of transects",
  width: 800,
  height: 500,
  x: {label: "Fish biomass (kg/ha)", grid: true, type: "log"},
  y: {label: "Mean species richness", grid: true},
  color: {
    domain: ["Nov_2024", "Jul_2025"],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.dot(fishData, {
      x: "mean_biomass_kg_ha",
      y: "mean_richness",
      fill: "survey_period",
      r: d => Math.sqrt(d.n_transects) * 4,
      tip: true,
      title: d => `${d.site} (${d.survey_period})\nBiomass: ${d.mean_biomass_kg_ha.toFixed(0)} kg/ha\nRichness: ${d.mean_richness}`
    }),
    Plot.ruleX([500], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 1.5})
  ]
})
```

---

## Coral Recruitment by Site

Coral recruitment (recruits/m$^2$) is a key recovery indicator. Low recruitment suggests limited capacity for reef recovery following disturbance. Sites marked with * recorded **zero recruits** and are excluded from the chart: Richard Bennett*, Watamu Coral Garden*, Bamsa*, Maliwai*, Ngomeni Outer*, Ras Ngomeni Inner*, and Roka 2* (all 0.00 recruits/m$^2$).

```js
const recruitClean = recruitData.filter(d => d.site != null && d.mean_recruits_m2 > 0);
```

```js
Plot.plot({
  title: "Coral recruit density by site (recruits/m\u00B2)",
  subtitle: "Reference: 1-3 recruits/m\u00B2 for healthy WIO reefs (Hughes et al. 2010). Sites with zero recruits excluded (see text).",
  width: 800,
  height: 400,
  marginLeft: 160,
  x: {label: "Recruits/m\u00B2", grid: true},
  fy: {label: null, domain: d3.groupSort(recruitClean, v => -d3.max(v, d => d.mean_recruits_m2), d => d.site)},
  y: {label: null},
  color: {
    domain: ["Nov_2024", "Jul_2025"],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(recruitClean, {
      x: "mean_recruits_m2",
      fy: "site",
      y: "survey_period",
      fill: "survey_period",
      tip: true
    }),
    Plot.ruleX([1], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 1.5}),
    Plot.ruleX([0])
  ]
})
```

Recruitment rates across all sites are critically low (0.00-0.14 recruits/m$^2$), well below the 1-3 recruits/m$^2$ WIO benchmark. Seven of 16 site-period combinations recorded zero recruits. This is the single most concerning finding for reef recovery prospects.

---

## Condition by Protected Area Type

```js
const paJul = paData.filter(d => d.survey_period === "Jul_2025");
```

```js
Inputs.table(paJul.map(d => ({
  "PA Name": d.pa_name,
  "PA Type": d.pa_type,
  "N Sites": d.n_sites,
  "Mean Coral (%)": d.mean_live_coral_pct != null ? (+d.mean_live_coral_pct).toFixed(1) : "-",
  "Mean Healthy (%)": d.mean_pct_healthy != null ? (+d.mean_pct_healthy).toFixed(1) : "-",
  "CI Coral Cover": d.mean_ci_coral_cover != null ? (+d.mean_ci_coral_cover).toFixed(3) : "-",
  "CI Recruitment": d.mean_ci_recruitment != null ? (+d.mean_ci_recruitment).toFixed(3) : "-"
})), {
  columns: ["PA Name", "PA Type", "N Sites", "Mean Coral (%)", "Mean Healthy (%)", "CI Coral Cover", "CI Recruitment"]
})
```

[^1]: Obura, D. et al. (2022). Coral reef condition in the Western Indian Ocean. *GCRMN Status of Coral Reefs of the World*.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
