# Cross-Ecosystem Synthesis

## Protected Area Effectiveness, Seascape Integration, and Data Confidence

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const paData = await FileAttachment("data/condition-by-pa.csv").csv({typed: true});
const mangroveSite = await FileAttachment("data/mangrove-condition-site.csv").csv({typed: true});
const seagrassCover = await FileAttachment("data/seagrass-cover-site.csv").csv({typed: true});
const fishData = await FileAttachment("data/fish-condition-site.csv").csv({typed: true});
const condSummary = await FileAttachment("data/seea-condition-summary.csv").csv({typed: true});
const condFinal = await FileAttachment("data/seea-condition-final.csv").csv({typed: true});
const fisheriesPhys = await FileAttachment("data/fisheries-physical.csv").csv({typed: true});
const fisheriesMon = await FileAttachment("data/fisheries-monetary.csv").csv({typed: true});
```

This page integrates findings across all three ecosystem types to address four cross-cutting questions: (1) do protected areas deliver measurable condition benefits? (2) what does the Ngomeni seascape - the only site with data from all ecosystems - reveal about ecosystem linkages? (3) what confidence should be placed in the account results? and (4) what are the implications for policy and finance?

---

## 1. Protected Area Effectiveness

### Coral reefs: no-take MPA vs open access (July 2025)

```js
const paJul = paData.filter(d => d.survey_period === "Jul_2025");
const paLong = paJul.flatMap(d => [
  {category: d.pa_name, indicator: "Coral cover", value: +d.mean_ci_coral_cover},
  {category: d.pa_name, indicator: "Recruitment", value: +d.mean_ci_recruitment},
  {category: d.pa_name, indicator: "Bleaching", value: +d.mean_ci_bleaching},
  {category: d.pa_name, indicator: "Disease", value: +d.mean_ci_disease}
].filter(r => !isNaN(r.value)));
```

```js
Inputs.table(paLong.map(d => ({
  "PA Category": d.category,
  Indicator: d.indicator,
  "Condition Index": d.value.toFixed(3)
})), {
  columns: ["PA Category", "Indicator", "Condition Index"]
})
```

```js
Plot.plot({
  title: "Reef condition indices: Watamu MPA vs unprotected (Jul 2025)",
  subtitle: "Higher = better condition (1.0 = reference level met)",
  width: 800,
  height: 350,
  marginLeft: 120,
  x: {label: "Condition Index (0-1)", domain: [0, 1], grid: true},
  fy: {label: null, domain: ["Coral cover", "Recruitment", "Bleaching", "Disease"]},
  y: {label: null},
  color: {
    domain: ["Watamu Marine Park", "Unprotected"],
    range: ["#2a9d8f", "#e76f51"],
    legend: true
  },
  marks: [
    Plot.barX(paLong, {
      x: "value",
      fy: "indicator",
      y: "category",
      fill: "category",
      tip: true,
      title: d => `${d.category}\n${d.indicator}: ${d.value.toFixed(3)}`
    }),
    Plot.ruleX([0])
  ]
})
```

Watamu Marine Park outperforms unprotected sites on coral cover (CI 0.79 vs 0.63) and bleaching/disease resistance (both at 1.0). Recruitment is critically low in both categories, though slightly lower in protected areas - a pattern consistent with larval supply limitation rather than local management failure.

### Mangroves: Mida Creek MNR vs unprotected

```js
const mgrProtected = mangroveSite.filter(d => d.pa_status === "Mida Creek MNR");
const mgrUnprotected = mangroveSite.filter(d => d.pa_status === "Unprotected");
const mgrPaMean = [
  {status: "Mida Creek MNR", ci: d3.mean(mgrProtected, d => d.ci_composite), n: mgrProtected.length},
  {status: "Unprotected", ci: d3.mean(mgrUnprotected, d => d.ci_composite), n: mgrUnprotected.length}
];
```

```js
Plot.plot({
  title: "Mangrove composite condition: protected vs unprotected",
  subtitle: "Mean composite CI across all field plots",
  width: 600,
  height: 200,
  marginLeft: 200,
  x: {label: "Composite Condition Index (0-1)", domain: [0, 1], grid: true},
  y: {label: null},
  marks: [
    Plot.barX(mgrPaMean, {
      x: "ci",
      y: "status",
      fill: d => d.status === "Mida Creek MNR" ? "#2a9d8f" : "#e76f51",
      tip: true,
      title: d => `${d.status}\nCI: ${d.ci.toFixed(3)}\nn = ${d.n} sites`
    }),
    Plot.ruleX([0])
  ]
})
```

Mida Creek Marine National Reserve shows a 23% condition advantage over unprotected sites (CI 0.455 vs 0.370). The protected area advantage is driven primarily by higher canopy cover and tree quality, suggesting that protection reduces selective harvesting pressure even where stem density is similar.

### Summary: PA effectiveness across ecosystems

```js
const paEffectiveness = [
  {ecosystem: "Coral reef (M1.3)", protected_ci: 0.794, unprotected_ci: 0.635, advantage_pct: 25, pa_name: "Watamu Marine Park", metric: "Composite reef CI"},
  {ecosystem: "Mangrove (MFT1.2)", protected_ci: 0.455, unprotected_ci: 0.370, advantage_pct: 23, pa_name: "Mida Creek MNR", metric: "Composite structural CI"}
];
```

```js
Inputs.table(paEffectiveness, {
  columns: ["ecosystem", "pa_name", "protected_ci", "unprotected_ci", "advantage_pct", "metric"],
  header: {
    ecosystem: "Ecosystem",
    pa_name: "Protected Area",
    protected_ci: "Protected CI",
    unprotected_ci: "Unprotected CI",
    advantage_pct: "Advantage (%)",
    metric: "Metric"
  },
  format: {
    protected_ci: d => d.toFixed(3),
    unprotected_ci: d => d.toFixed(3)
  }
})
```

Both ecosystem types show a consistent 23-25% condition advantage for protected areas. Seagrass PA-disaggregated analysis is available but not yet comparable due to the absence of a matched unprotected control for seagrass sites within protected areas.

---

## 2. Ngomeni Seascape Profile

**Ngomeni is the only site where all four data streams converge:** coral reef surveys (Nov 2024), seagrass cover and health (2024), mangrove field plots (Dec 2025), and KeFS fisheries landing data (2020-2024). This makes it the highest-priority site for integrated seascape accounting.

```js
const ngomeniReef = fishData.filter(d => d.site && d.site.toLowerCase().includes("ngomeni"));
const ngomeniSeagrass = seagrassCover.filter(d => d.Area && d.Area.toLowerCase().includes("ngomeni"));
const ngomeniMangrove = mangroveSite.filter(d => d.area && d.area.toLowerCase().includes("ngomeni"));
```

<div class="grid grid-cols-3">

<div class="card">

### Coral Reef at Ngomeni

```js
if (ngomeniReef.length > 0) {
  const nr = ngomeniReef[0];
  display(html`<p><strong>Fish biomass:</strong> ${nr.mean_biomass_kg_ha ? nr.mean_biomass_kg_ha.toFixed(0) : "N/A"} kg/ha</p>
  <p><strong>Species richness:</strong> ${nr.mean_richness || "N/A"}</p>
  <p><strong>Survey:</strong> ${nr.survey_period}</p>`);
} else {
  display(html`<p>Ngomeni reef data available in CCVA/KLF/PU-GOAP datasets (Nov 2024). Site name may differ in consolidated outputs.</p>`);
}
```

</div>

<div class="card">

### Seagrass at Ngomeni

```js
if (ngomeniSeagrass.length > 0) {
  const ns = ngomeniSeagrass[0];
  display(html`<p><strong>Total cover:</strong> ${ns.Total_Cover_pct}%</p>
  <p><strong>Species richness:</strong> ${ns.Species_Richness} species</p>
  <p><strong>Quadrats:</strong> ${ns.n_quadrats_cover}</p>`);
} else {
  display(html`<p>No Ngomeni seagrass data in loaded dataset.</p>`);
}
```

</div>

<div class="card">

### Mangrove at Ngomeni

```js
if (ngomeniMangrove.length > 0) {
  const meanCI = d3.mean(ngomeniMangrove, d => d.ci_composite);
  const nPlots = d3.sum(ngomeniMangrove, d => d.n_plots);
  display(html`<p><strong>Mean CI:</strong> ${meanCI.toFixed(3)}</p>
  <p><strong>Sites:</strong> ${ngomeniMangrove.length}</p>
  <p><strong>Total plots:</strong> ${nPlots}</p>`);
} else {
  display(html`<p>No Ngomeni mangrove data in loaded dataset.</p>`);
}
```

</div>

</div>

Ngomeni's triple-ecosystem coverage makes it the natural candidate for a seascape-scale condition narrative: reef condition drives fisheries productivity, seagrass meadows provide nursery habitat for reef-associated juveniles, and mangrove stands buffer sediment and nutrient inputs to adjacent reef and seagrass systems. The co-location of all three ecosystems and a fisheries landing site enables future analysis of condition-service linkages that cannot be tested at other Kilifi sites.

---

## 3. Data Confidence Assessment

Not all indicators carry the same weight of evidence. The table below summarises the confidence level for each major account component, based on data volume, reference level robustness, and temporal coverage.

```js
const confidence = [
  {component: "Fish biomass (kg/ha)", confidence: "MEDIUM", basis: "25 site-periods; FishBase allometry; McClanahan 2016 reference", caveat: "Transect area (250 m2) pending field confirmation"},
  {component: "Live coral cover (%)", confidence: "MEDIUM", basis: "12 site-periods; GCRMN 2021 / Obura 2022 reference (30%)", caveat: "Nov 2024 and Jul 2025 are different site sets, not repeated measures"},
  {component: "Coral recruitment", confidence: "LOW-MEDIUM", basis: "16 site-periods; Hughes 2010 WIO reference (1-3/m2)", caveat: "Methodology equivalence with reference studies unconfirmed"},
  {component: "Coral health (bleaching)", confidence: "MEDIUM", basis: "15 site-periods; colony-level assessment", caveat: "Post-bleaching snapshot; no pre-bleaching baseline"},
  {component: "Mangrove condition (composite)", confidence: "MEDIUM", basis: "32 plots, 22 sites; Kenya literature references", caveat: "13 sites with fewer than 2 plots (low sample size flag)"},
  {component: "Mangrove extent (ha)", confidence: "HIGH", basis: "GMW v4 satellite + project classification; WDPA overlay", caveat: "Accuracy of 2025 classification not independently validated"},
  {component: "Seagrass cover (%)", confidence: "MEDIUM", basis: "3,040 quadrats; 9 areas; nested plot design", caveat: "Single time point (2024); no change detection possible"},
  {component: "Seagrass shoot density / height", confidence: "LOW", basis: "Health survey data available", caveat: "No published WIO reference levels; all baselines provisional"},
  {component: "Fisheries physical supply (mt)", confidence: "MEDIUM", basis: "5-year KeFS time series; FishBase guild attribution", caveat: "County aggregate only; reef fraction provisional (30-38%)"},
  {component: "Fisheries resource rent (USD)", confidence: "LOW-MEDIUM", basis: "Resource rent method; GDP deflator series", caveat: "Cost ratio from literature (30-45%); no local fisher cost survey"}
];
```

```js
Inputs.table(confidence, {
  columns: ["component", "confidence", "basis", "caveat"],
  header: {
    component: "Account Component",
    confidence: "Confidence",
    basis: "Evidence Basis",
    caveat: "Key Caveat"
  },
  width: {component: 200, basis: 280, caveat: 260}
})
```

### Confidence summary

```js
const confCounts = d3.rollups(confidence, v => v.length, d => d.confidence)
  .map(([level, count]) => ({level, count}))
  .sort((a, b) => {
    const order = ["HIGH", "MEDIUM", "LOW-MEDIUM", "LOW"];
    return order.indexOf(a.level) - order.indexOf(b.level);
  });
```

```js
Plot.plot({
  title: "Distribution of confidence ratings across account components",
  width: 500,
  height: 200,
  marginLeft: 140,
  x: {label: "Number of components", grid: true},
  y: {label: null, domain: ["HIGH", "MEDIUM", "LOW-MEDIUM", "LOW"]},
  marks: [
    Plot.barX(confCounts, {
      x: "count",
      y: "level",
      fill: d => d.level === "HIGH" ? "#2a9d8f" : d.level === "MEDIUM" ? "#264653" : d.level === "LOW-MEDIUM" ? "#e9c46a" : "#e76f51",
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

The majority of components carry MEDIUM confidence - sufficient for baseline accounting and policy engagement, but requiring targeted strengthening before formal adoption into national statistics. The two LOW-confidence components (seagrass shoot density references and fisheries cost structure) have clear remediation pathways: WIO literature review and fisher cost survey respectively.

---

## 4. Temporal Coverage and Time Series Potential

```js
const temporal = [
  {dataset: "Fisheries landings (KeFS)", start: 2020, end: 2024, points: 5, interval: "Annual", series: "Strong"},
  {dataset: "Coral reef (fish + benthic)", start: 2024, end: 2025, points: 2, interval: "8 months", series: "Emerging"},
  {dataset: "Seagrass (cover + health)", start: 2024, end: 2024, points: 1, interval: "Single snapshot", series: "Baseline only"},
  {dataset: "Mangrove (field condition)", start: 2025, end: 2025, points: 1, interval: "Single snapshot", series: "Baseline only"},
  {dataset: "Mangrove (satellite extent)", start: 2020, end: 2025, points: 2, interval: "5 years", series: "Change detected"}
];
```

```js
Plot.plot({
  title: "Temporal coverage by dataset",
  subtitle: "Horizontal span indicates data availability; dot size = number of time points",
  width: 700,
  height: 250,
  marginLeft: 240,
  x: {label: "Year", domain: [2019.5, 2025.5], grid: true, tickFormat: "d"},
  y: {label: null},
  marks: [
    Plot.link(temporal, {
      x1: "start",
      x2: "end",
      y1: "dataset",
      y2: "dataset",
      stroke: "#264653",
      strokeWidth: 3
    }),
    Plot.dot(temporal, {
      x: d => (d.start + d.end) / 2,
      y: "dataset",
      r: d => Math.sqrt(d.points) * 6,
      fill: d => d.series === "Strong" ? "#2a9d8f" : d.series === "Emerging" ? "#264653" : d.series === "Change detected" ? "#e9c46a" : "#e76f51",
      tip: true,
      title: d => `${d.dataset}\n${d.points} time point(s)\n${d.interval}`
    })
  ]
})
```

Fisheries data provides the strongest temporal foundation (5 annual points). Coral reef surveys at Wesa, Roka, and Uyombo have 2 time points (Nov 2024 + Jul 2025) - sufficient for opening-vs-closing comparison but not trend analysis. Seagrass and mangrove condition are single-snapshot baselines; repeat surveys are recommended in 2026-2027 to enable change detection aligned with the SEEA EA accounting period.

---

## 5. Policy and Finance Implications

### Governance priorities

<div class="grid grid-cols-3">

<div class="card">

### 0-6 months (quick wins)

- Publish reef condition baseline to inform Watamu Marine Park and Malindi MPA management plans
- Flag coral recruitment crisis to Kenya Wildlife Service as a monitoring priority
- Share mangrove extent loss data (341 ha) with County Department of Environment

</div>

<div class="card">

### 1-2 years (institutional embedding)

- Integrate accounts into Kenya's national ocean accounting framework (State Department of Blue Economy)
- Establish Ngomeni as an integrated seascape monitoring station
- Commission repeat seagrass survey (2026) and mangrove resurvey (2027)

</div>

<div class="card">

### 2-5 years (systemic)

- Adopt SEEA EA condition accounts for Kilifi County development planning and environmental impact assessment
- Develop seagrass and coral reef extent accounts from satellite classification
- Extend fisheries accounts to Tier 2 (local fisher cost survey)

</div>

</div>

### Blue finance pathways

```js
const finance = [
  {pathway: "Mangrove blue carbon (VCS VM0033)", asset: "5,742 ha mangrove", estimate: "11-12 M tCO2e stock", status: "Requires allometric biomass data (not in current field dataset)", readiness: "Pre-feasibility"},
  {pathway: "Reef fisheries resource rent", asset: "Reef-associated catch", estimate: "USD 2.06-5.66 M/yr", status: "Provisional; pending Dr Thoya attribution validation", readiness: "Tier 1 complete"},
  {pathway: "MPA effectiveness premium", asset: "Watamu + Mida Creek", estimate: "25% condition uplift (reef); 23% (mangrove)", status: "Quantified; supports results-based finance", readiness: "Evidence ready"},
  {pathway: "Seagrass carbon and nursery", asset: "9 survey areas", estimate: "Not yet valued", status: "Requires extent mapping + carbon stock data", readiness: "Data gap"}
];
```

```js
Inputs.table(finance, {
  columns: ["pathway", "asset", "estimate", "readiness", "status"],
  header: {
    pathway: "Finance Pathway",
    asset: "Ecosystem Asset",
    estimate: "Estimated Value",
    readiness: "Readiness",
    status: "Status / Next Step"
  },
  width: {pathway: 200, status: 260}
})
```

---

## 6. Priority Data Gaps

The following data gaps, if addressed, would materially improve account confidence and unlock additional finance pathways:

```js
const gaps = [
  {gap: "Coral reef extent (ha)", impact: "Cannot calculate total reef asset value or per-ha condition", action: "Sentinel-2 benthic habitat classification", timeline: "Q2-Q3 2026"},
  {gap: "Seagrass extent (ha)", impact: "Cannot value seagrass carbon stock or nursery service", action: "Sentinel-2 seagrass mapping", timeline: "Q2-Q3 2026"},
  {gap: "Fisher cost survey", impact: "Resource rent uncertainty range remains wide (30-45%)", action: "Landing site survey at Ngomeni, Kilifi Creek", timeline: "Q2 2026"},
  {gap: "Seagrass WIO reference levels", impact: "Shoot density and height CIs carry LOW confidence", action: "WIO literature review + expert panel", timeline: "Q3 2026"},
  {gap: "Mangrove allometric parameters", impact: "Cannot estimate biomass or carbon stock from field data", action: "Add allometric measurements to next field campaign", timeline: "2027 resurvey"},
  {gap: "Repeat seagrass survey", impact: "No change detection possible (single 2024 baseline)", action: "Resurvey at same 9 areas", timeline: "Q4 2026"},
  {gap: "Coral recruitment methodology check", impact: "Recruitment CI interpretation depends on method equivalence", action: "Confirm sampling matches Hughes 2010 WIO protocol", timeline: "Q2 2026"}
];
```

```js
Inputs.table(gaps, {
  columns: ["gap", "impact", "action", "timeline"],
  header: {
    gap: "Data Gap",
    impact: "Account Impact",
    action: "Recommended Action",
    timeline: "Target"
  },
  width: {gap: 200, impact: 260, action: 240}
})
```

---

## 7. Cross-Ecosystem Condition Overview

```js
const crossEco = [
  {ecosystem: "Coral reef (M1.3)", headline_ci: "0.63-0.79", direction: "Recovering", signal: "Post-bleaching recovery underway; recruitment critically low", pa_effect: "+25%"},
  {ecosystem: "Mangrove (MFT1.2)", headline_ci: "0.27-0.43", direction: "Regenerating", signal: "High density + low DBH = post-disturbance regrowth; extent declining", pa_effect: "+23%"},
  {ecosystem: "Seagrass (M1.1)", headline_ci: "0.69-0.94", direction: "Good (provisional)", signal: "High cover and diversity at most sites; reference levels LOW confidence", pa_effect: "Not yet comparable"}
];
```

```js
Inputs.table(crossEco, {
  columns: ["ecosystem", "headline_ci", "direction", "signal", "pa_effect"],
  header: {
    ecosystem: "Ecosystem",
    headline_ci: "CI Range",
    direction: "Trajectory",
    signal: "Key Signal",
    pa_effect: "PA Effect"
  },
  width: {signal: 300}
})
```

The three ecosystems tell complementary stories. Coral reefs show active recovery from the 2024 bleaching event but face a structural bottleneck in recruitment. Mangroves are regenerating after historical disturbance but continue to lose extent. Seagrass meadows appear to be in the best condition of the three, but this finding carries lower confidence due to the absence of WIO-specific reference levels.

Together, these accounts provide the empirical foundation for integrated coastal zone management in Kilifi County - connecting reef health to fisheries productivity, mangrove loss to coastal protection, and seagrass condition to nursery function.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
