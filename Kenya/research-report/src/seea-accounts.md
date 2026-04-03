# SEEA EA Accounts

## Integrated Ecosystem Accounts

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const condFinal = await FileAttachment("data/seea-condition-final.csv").csv({typed: true});
const extFinal = await FileAttachment("data/seea-extent-final.csv").csv({typed: true});
const condSummary = await FileAttachment("data/seea-condition-summary.csv").csv({typed: true});
```

The UN SEEA EA framework organises ecosystem data into standardised accounting tables that track extent, condition, and ecosystem services[^1]. This page presents the integrated accounts spanning all three coastal ecosystem types.

---

## Extent Account

The extent account records opening and closing area for each ecosystem type over the accounting period.

```js
Inputs.table(extFinal, {
  columns: ["Entry", "Units", "Mangrove", "Seagrass", "Coral_Reef", "Totals"],
  header: {
    Coral_Reef: "Coral Reef"
  },
  width: {Entry: 180}
})
```

Mangrove is the only ecosystem type with a complete extent account (2020-2025). Seagrass and coral reef extent accounts require satellite-derived benthic habitat classification, which is in progress.

---

## Condition Account

The condition account reports condition indices (0-1) for key biophysical indicators across all three ecosystem types.

```js
Inputs.table(condFinal, {
  columns: ["Entry", "Units", "Coral_Reef", "Mangrove", "Seagrass"],
  header: {
    Coral_Reef: "Coral Reef"
  },
  width: {Entry: 300}
})
```

---

## Condition Account Visualisation - Coral Reef

```js
const coralRows = condFinal.filter(d => d.Coral_Reef !== "--" && d.Coral_Reef !== "-" && !d.Entry.includes("Change") && d.Entry.includes("Coral_Reef") === false);
const coralVis = coralRows.filter(d => {
  const v = parseFloat(d.Coral_Reef);
  return !isNaN(v);
}).map(d => ({
  indicator: d.Entry,
  value: parseFloat(d.Coral_Reef)
}));
```

```js
Plot.plot({
  title: "Coral reef condition indices",
  subtitle: "Opening (Nov 2024) and closing (Jul 2025) values; higher = better",
  width: 800,
  height: 500,
  marginLeft: 300,
  x: {label: "Condition Index (0-1)", domain: [0, 1], grid: true},
  y: {label: null},
  marks: [
    Plot.barX(coralVis, {
      x: "value",
      y: "indicator",
      fill: d => d.indicator.includes("Opening") ? "#264653" : d.indicator.includes("Closing") ? "#2a9d8f" : "#e9c46a",
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

---

## Condition Summary - Accounting-Area Aggregates

The summary table reports mean condition indices across all survey sites for each indicator, with confidence levels and standard errors.

```js
Inputs.table(condSummary.map(d => ({
  Period: d.survey_period,
  Indicator: d.condition_indicator,
  Unit: d.unit,
  "Mean value": typeof d.mean_value === "number" ? d.mean_value.toFixed(3) : d.mean_value,
  SE: typeof d.se_value === "number" ? d.se_value.toFixed(3) : d.se_value,
  "Mean CI": typeof d.mean_ci === "number" ? d.mean_ci.toFixed(3) : d.mean_ci,
  "N sites": d.n_sites,
  Confidence: d.confidence
})), {
  columns: ["Period", "Indicator", "Unit", "Mean value", "SE", "Mean CI", "N sites", "Confidence"],
  width: {Indicator: 200, "Reference level": 200}
})
```

---

## Condition Summary Visualisation

```js
const summVis = condSummary.map(d => ({
  label: `${d.condition_indicator} (${d.survey_period})`,
  ci: typeof d.mean_ci === "number" ? d.mean_ci : parseFloat(d.mean_ci),
  period: d.survey_period,
  indicator: d.condition_indicator
})).filter(d => !isNaN(d.ci));
```

```js
Plot.plot({
  title: "SEEA EA condition indices by indicator and survey period",
  subtitle: "Higher = better condition (1.0 = reference level met)",
  width: 800,
  height: 500,
  marginLeft: 280,
  x: {label: "Mean Condition Index", domain: [0, 1], grid: true},
  y: {label: null},
  color: {
    domain: ["Nov_2024", "Jul_2025"],
    range: ["#264653", "#2a9d8f"],
    legend: true
  },
  marks: [
    Plot.barX(summVis, {
      x: "ci",
      y: "label",
      fill: "period",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

Key findings:
- **Bleaching** and **disease** indices are at or near 1.0 (excellent) in July 2025, reflecting post-bleaching recovery
- **Coral recruitment** is critically low (CI = 0.054) - the single most concerning metric
- **Live coral cover** declined from CI = 0.905 (Nov 2024) to 0.73 (Jul 2025), consistent with post-bleaching die-off

[^1]: United Nations (2021). System of Environmental-Economic Accounting - Ecosystem Accounting (SEEA EA). United Nations, New York.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
