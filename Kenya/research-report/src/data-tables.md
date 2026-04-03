# Data Tables

## Interactive Data Explorer

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
function copyableTable(data, options = {}) {
  const container = document.createElement("div");
  container.style.position = "relative";

  const btn = document.createElement("button");
  btn.textContent = "📋 Copy table";
  btn.style.cssText = "margin-bottom:8px;padding:4px 12px;cursor:pointer;border:1px solid #ccc;border-radius:4px;background:#f8f8f8;font-size:0.85rem;";
  btn.onclick = () => {
    const cols = options.columns || Object.keys(data[0]);
    const headers = cols.map(c => (options.header && options.header[c]) || c);
    const rows = data.map(row => cols.map(c => row[c] ?? "").join("\t"));
    const tsv = [headers.join("\t"), ...rows].join("\n");
    navigator.clipboard.writeText(tsv).then(() => {
      btn.textContent = "✓ Copied!";
      setTimeout(() => btn.textContent = "📋 Copy table", 2000);
    });
  };

  const table = copyableTable(data, options);
  container.appendChild(btn);
  container.appendChild(table);
  return container;
}
```

```js
const fishData = await FileAttachment("data/fish-condition-site.csv").csv({typed: true});
const benthicData = await FileAttachment("data/benthic-cover-site.csv").csv({typed: true});
const healthData = await FileAttachment("data/coral-health-site.csv").csv({typed: true});
const recruitData = await FileAttachment("data/coral-recruitment-site.csv").csv({typed: true});
const mangroveData = await FileAttachment("data/mangrove-condition-site.csv").csv({typed: true});
const coverData = await FileAttachment("data/seagrass-cover-site.csv").csv({typed: true});
const healthSg = await FileAttachment("data/seagrass-health-site.csv").csv({typed: true});
const condFinal = await FileAttachment("data/seea-condition-final.csv").csv({typed: true});
const extFinal = await FileAttachment("data/seea-extent-final.csv").csv({typed: true});
const condSummary = await FileAttachment("data/seea-condition-summary.csv").csv({typed: true});
const physData = await FileAttachment("data/fisheries-physical.csv").csv({typed: true});
const monData = await FileAttachment("data/fisheries-monetary.csv").csv({typed: true});
```

---

## Dataset Summary

<div class="grid grid-cols-4">
<div class="card">
<h3>Reef Sites</h3>
<p class="big">${new Set(fishData.map(d => d.site)).size}</p>
</div>
<div class="card">
<h3>Mangrove Sites</h3>
<p class="big">${mangroveData.length}</p>
</div>
<div class="card">
<h3>Seagrass Areas</h3>
<p class="big">${coverData.length}</p>
</div>
<div class="card">
<h3>Fisheries Years</h3>
<p class="big">${physData.length}</p>
</div>
</div>

---

## SEEA EA Condition Account (Final)

```js
copyableTable(condFinal, {
  columns: ["Entry", "Units", "Coral_Reef", "Mangrove", "Seagrass"],
  header: {Coral_Reef: "Coral Reef"},
  width: {Entry: 300}
})
```

---

## SEEA EA Extent Account (Final)

```js
copyableTable(extFinal, {
  columns: ["Entry", "Units", "Mangrove", "Seagrass", "Coral_Reef", "Totals"],
  header: {Coral_Reef: "Coral Reef"},
  width: {Entry: 180}
})
```

---

## Condition Summary (Accounting-Area Means)

```js
copyableTable(condSummary, {
  columns: ["survey_period", "condition_indicator", "unit", "mean_value", "se_value", "mean_ci", "n_sites", "confidence"],
  header: {
    survey_period: "Period",
    condition_indicator: "Indicator",
    mean_value: "Mean",
    se_value: "SE",
    mean_ci: "CI",
    n_sites: "N",
    confidence: "Confidence"
  }
})
```

---

## Fish Condition by Site

```js
copyableTable(fishData, {
  columns: ["survey_period", "site", "mean_biomass_kg_ha", "se_biomass_kg_ha", "mean_abundance_ha", "mean_richness", "n_transects"],
  header: {
    survey_period: "Period",
    mean_biomass_kg_ha: "Biomass (kg/ha)",
    se_biomass_kg_ha: "SE",
    mean_abundance_ha: "Abundance (/ha)",
    mean_richness: "Richness",
    n_transects: "Transects"
  },
  sort: "site"
})
```

---

## Benthic Cover by Site

```js
copyableTable(benthicData, {
  columns: ["survey_period", "site", "live_coral_pct", "dead_coral_pct", "macroalgae_pct", "rubble_pct", "bleached_pct", "n_transects", "source"],
  header: {
    survey_period: "Period",
    live_coral_pct: "Live coral (%)",
    dead_coral_pct: "Dead coral (%)",
    macroalgae_pct: "Macroalgae (%)",
    rubble_pct: "Rubble (%)",
    bleached_pct: "Bleached (%)",
    n_transects: "Transects"
  },
  sort: "site"
})
```

---

## Coral Health by Site

```js
const healthClean = healthData.filter(d => d.site != null);
copyableTable(healthClean, {
  columns: ["survey_period", "site", "n_total", "pct_healthy", "pct_pale", "pct_bleached", "pct_diseased", "pct_dead"],
  header: {
    survey_period: "Period",
    n_total: "N colonies",
    pct_healthy: "Healthy (%)",
    pct_pale: "Pale (%)",
    pct_bleached: "Bleached (%)",
    pct_diseased: "Diseased (%)",
    pct_dead: "Dead (%)"
  },
  sort: "site"
})
```

---

## Coral Recruitment by Site

```js
const recruitClean = recruitData.filter(d => d.site != null);
copyableTable(recruitClean, {
  columns: ["survey_period", "site", "mean_recruits_m2", "se_recruits_m2", "n_quadrats"],
  header: {
    survey_period: "Period",
    mean_recruits_m2: "Recruits/m2",
    se_recruits_m2: "SE",
    n_quadrats: "Quadrats"
  },
  sort: "site"
})
```

---

## Mangrove Condition by Site

```js
copyableTable(mangroveData, {
  columns: ["area", "site", "n_plots", "mean_stem_density_ha", "mean_dbh_cm", "mean_height_m", "mean_canopy_cover_pct", "ci_composite", "pa_status"],
  header: {
    mean_stem_density_ha: "Stems/ha",
    mean_dbh_cm: "DBH (cm)",
    mean_height_m: "Height (m)",
    mean_canopy_cover_pct: "Cover (%)",
    ci_composite: "CI composite",
    pa_status: "PA status",
    n_plots: "Plots"
  },
  sort: "area"
})
```

---

## Seagrass Cover by Area

```js
copyableTable(coverData, {
  columns: ["Area", "Total_Cover_pct", "Species_Richness", "n_quadrats_cover"],
  header: {
    Total_Cover_pct: "Total cover (%)",
    Species_Richness: "Spp richness",
    n_quadrats_cover: "Quadrats"
  },
  sort: "Area"
})
```

---

## Seagrass Health (Shoot Density & Canopy Height)

```js
copyableTable(healthSg, {
  columns: ["Area", "Species", "Mean_Shoots_m2", "Mean_Canopy_height_cm", "n_quadrats"],
  header: {
    Mean_Shoots_m2: "Shoots/m2",
    Mean_Canopy_height_cm: "Height (cm)",
    n_quadrats: "Quadrats"
  },
  sort: "Area"
})
```

---

## Fisheries Physical Supply

```js
copyableTable(physData, {
  columns: ["year", "total_county_catch_mt", "reef_catch_adjusted_mt", "reef_fraction_pct", "reef_catch_lower_mt", "reef_catch_upper_mt"],
  header: {
    total_county_catch_mt: "County catch (mt)",
    reef_catch_adjusted_mt: "Reef catch (mt)",
    reef_fraction_pct: "Reef %",
    reef_catch_lower_mt: "Lower (mt)",
    reef_catch_upper_mt: "Upper (mt)"
  }
})
```

---

## Fisheries Monetary Supply

```js
copyableTable(monData, {
  columns: ["year", "reef_revenue_real_2024_usd", "resource_rent_lower_usd", "resource_rent_central_usd", "resource_rent_upper_usd"],
  header: {
    reef_revenue_real_2024_usd: "Revenue (USD)",
    resource_rent_lower_usd: "Rent lower",
    resource_rent_central_usd: "Rent central",
    resource_rent_upper_usd: "Rent upper"
  }
})
```

---

## Export

To export any table as CSV, right-click the table and select "Copy" or use the download buttons provided by Observable's table component.

<style>
.big {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0 0 0;
}
.card h3 { margin-top: 0; }
</style>
