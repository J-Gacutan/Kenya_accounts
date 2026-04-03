# Fisheries Provisioning

## Reef-Associated Fisheries Supply and Use Account, 2020-2024

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const physData = await FileAttachment("data/fisheries-physical.csv").csv({typed: true});
const monData = await FileAttachment("data/fisheries-monetary.csv").csv({typed: true});
```

This account quantifies the ecosystem service of wild fish provisioning attributable to coral reef ecosystems in Kilifi County. The physical supply account records reef-associated catch in metric tonnes; the monetary account values this catch using the resource rent method[^1].

All values are **provisional**, pending validation of the reef attribution fraction by Dr Pascal Thoya (Kenya Fisheries Service).

---

## Physical Supply Account

```js
Plot.plot({
  title: "Reef-associated fish catch, 2020-2024 (metric tonnes)",
  subtitle: "Central estimate with uncertainty bounds; attribution fraction = 30-38% of county catch",
  width: 800,
  height: 400,
  x: {label: "Year", tickFormat: "d"},
  y: {label: "Reef catch (mt)", grid: true},
  marks: [
    Plot.areaY(physData, {
      x: "year",
      y1: "reef_catch_lower_mt",
      y2: "reef_catch_upper_mt",
      fill: "#2a9d8f",
      fillOpacity: 0.2
    }),
    Plot.lineY(physData, {
      x: "year",
      y: "reef_catch_adjusted_mt",
      stroke: "#2a9d8f",
      strokeWidth: 2.5
    }),
    Plot.dot(physData, {
      x: "year",
      y: "reef_catch_adjusted_mt",
      fill: "#2a9d8f",
      r: 5,
      tip: true,
      title: d => `${d.year}\nReef catch: ${d.reef_catch_adjusted_mt.toLocaleString("en-US", {maximumFractionDigits: 0})} mt\nFraction: ${d.reef_fraction_pct.toFixed(1)}%\nTotal county: ${d.total_county_catch_mt.toLocaleString()} mt`
    }),
    Plot.ruleY([0])
  ]
})
```

<div class="grid grid-cols-3">
<div class="card">
<h3>2024 Reef Catch</h3>
<p class="big">${physData[physData.length - 1].reef_catch_adjusted_mt.toLocaleString("en-US", {maximumFractionDigits: 0})} mt</p>
</div>
<div class="card">
<h3>5-Year Mean</h3>
<p class="big">${d3.mean(physData, d => d.reef_catch_adjusted_mt).toLocaleString("en-US", {maximumFractionDigits: 0})} mt/yr</p>
</div>
<div class="card">
<h3>Reef Fraction (2024)</h3>
<p class="big">${physData[physData.length - 1].reef_fraction_pct.toFixed(1)}%</p>
</div>
</div>

---

## Physical Supply Table

```js
Inputs.table(physData.map(d => ({
  Year: d.year,
  "County catch (mt)": d.total_county_catch_mt.toLocaleString(),
  "Reef catch (mt)": d.reef_catch_adjusted_mt.toLocaleString("en-US", {maximumFractionDigits: 0}),
  "Reef fraction (%)": d.reef_fraction_pct.toFixed(1),
  "Lower bound (mt)": d.reef_catch_lower_mt.toLocaleString("en-US", {maximumFractionDigits: 0}),
  "Upper bound (mt)": d.reef_catch_upper_mt.toLocaleString("en-US", {maximumFractionDigits: 0}),
  Status: d.attribution_status
})), {
  columns: ["Year", "County catch (mt)", "Reef catch (mt)", "Reef fraction (%)", "Lower bound (mt)", "Upper bound (mt)", "Status"],
  width: {Status: 200}
})
```

---

## Monetary Supply Account

The monetary account values reef-associated catch using the **resource rent method** - the return to the natural capital input after deducting produced capital and labour costs. Values are in real 2024 USD, deflated from nominal KES using GDP deflators.

```js
const monDataM = monData.map(d => ({
  ...d,
  rent_lower_m: d.resource_rent_lower_usd / 1e6,
  rent_central_m: d.resource_rent_central_usd / 1e6,
  rent_upper_m: d.resource_rent_upper_usd / 1e6,
  revenue_m: d.reef_revenue_real_2024_usd / 1e6
}));
```

```js
Plot.plot({
  title: "Reef fisheries resource rent, 2020-2024",
  subtitle: "Central estimate with sensitivity bounds (lower = 30% rent share, upper = 45%)",
  width: 800,
  height: 400,
  marginLeft: 60,
  x: {label: "Year", tickFormat: "d"},
  y: {label: "Resource rent (USD millions)", grid: true},
  marks: [
    Plot.areaY(monDataM, {
      x: "year",
      y1: "rent_lower_m",
      y2: "rent_upper_m",
      fill: "#264653",
      fillOpacity: 0.2
    }),
    Plot.lineY(monDataM, {
      x: "year",
      y: "rent_central_m",
      stroke: "#264653",
      strokeWidth: 2.5
    }),
    Plot.dot(monDataM, {
      x: "year",
      y: "rent_central_m",
      fill: "#264653",
      r: 5,
      tip: true,
      title: d => `${d.year}\nResource rent: USD ${d.rent_central_m.toFixed(2)}M\nRevenue: USD ${d.revenue_m.toFixed(2)}M`
    }),
    Plot.ruleY([0])
  ]
})
```

<div class="grid grid-cols-3">
<div class="card">
<h3>2024 Resource Rent</h3>
<p class="big-sm">USD ${(monData[monData.length - 1].resource_rent_central_usd / 1e6).toFixed(2)}M</p>
</div>
<div class="card">
<h3>2024 Gross Revenue</h3>
<p class="big-sm">USD ${(monData[monData.length - 1].reef_revenue_real_2024_usd / 1e6).toFixed(2)}M</p>
</div>
<div class="card">
<h3>5-Year Mean Rent</h3>
<p class="big-sm">USD ${(d3.mean(monData, d => d.resource_rent_central_usd) / 1e6).toFixed(2)}M/yr</p>
</div>
</div>

---

## Monetary Supply Table

```js
Inputs.table(monData.map(d => ({
  Year: d.year,
  "Revenue (USD M)": (+d.reef_revenue_real_2024_usd / 1e6).toFixed(2),
  "Rent lower (USD M)": (+d.resource_rent_lower_usd / 1e6).toFixed(2),
  "Rent central (USD M)": (+d.resource_rent_central_usd / 1e6).toFixed(2),
  "Rent upper (USD M)": (+d.resource_rent_upper_usd / 1e6).toFixed(2),
  Notes: d.notes
})), {
  columns: ["Year", "Revenue (USD M)", "Rent lower (USD M)", "Rent central (USD M)", "Rent upper (USD M)", "Notes"],
  width: {Notes: 200}
})
```

---

## Methodology Notes

- **Attribution fraction:** Reef-associated catch is estimated as the proportion of total Kilifi County marine catch attributable to reef ecosystems, based on species composition analysis of landing site records
- **Adjustment factor:** Raw attribution is scaled by 1.3x to account for unreported catch (FAO/IHH methodology)
- **Deflation:** Nominal KES revenues deflated to 2024 real values using Kenya GDP deflator series; converted to USD at 2024 average rate (1 USD = 134.85 KES)
- **Resource rent:** Calculated as 30% (lower), 38% (central), and 45% (upper) of gross revenue, following SEEA EA guidance for artisanal fisheries where factor-share data are unavailable

---

## Interpretation and Next Steps

The reef-associated fisheries account demonstrates that Kilifi County's coral reef ecosystems generate a measurable and significant economic return. Even under the most conservative assumptions (30% reef attribution, 30% rent share), the annual resource rent exceeds USD 2 million - a figure that provides an empirical basis for reef conservation investment decisions.

Two actions would materially improve account confidence: (1) validation of the reef attribution fraction by Dr Pascal Thoya, which would narrow the physical supply uncertainty bounds; and (2) a local fisher cost survey at Ngomeni and Kilifi Creek landing sites, which would replace the literature-derived cost ratio (30-45%) with an empirically grounded estimate. Both are targeted for Q2 2026.

The 172% increase in total county catch between 2020 and 2024 warrants careful interpretation. It may reflect genuine stock recovery, improved reporting coverage by KeFS, or shifts in fishing effort - the current data cannot distinguish between these drivers. The condition account (fish biomass at most sites below the 500 kg/ha sustainability threshold) suggests caution in attributing the catch increase to improved reef health.

[^1]: United Nations (2021). SEEA EA, Chapter 10: Monetary valuation of ecosystem services. Resource rent = gross output - intermediate consumption - compensation of employees - user cost of produced assets.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.big-sm {
  font-size: 1.4rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
