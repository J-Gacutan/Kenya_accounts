# Seagrass Condition

## Kilifi County Seagrass Meadow Assessment

```js
import * as Plot from "npm:@observablehq/plot";
import * as d3 from "npm:d3";
```

```js
const coverData = await FileAttachment("data/seagrass-cover-site.csv").csv({typed: true});
const healthData = await FileAttachment("data/seagrass-health-site.csv").csv({typed: true});
const zoneData = await FileAttachment("data/seagrass-health-zone.csv").csv({typed: true});
```

Seagrass meadows (M1.1) provide critical ecosystem services including carbon sequestration, sediment stabilisation, and nursery habitat for reef-associated fish species. Nine survey areas along the Kilifi coastline were assessed using 3,040 quadrat records collected between May and November 2024.

Seagrass condition is generally good across the study area, with Ngomeni recording the highest species diversity (8 of 10 observed species). However, all condition indices carry LOW to MEDIUM confidence because no published WIO-specific reference levels exist for shoot density or canopy height. The values reported here should be treated as a baseline for future change detection rather than definitive condition assessments.

---

## Total Seagrass Cover by Area

```js
Plot.plot({
  title: "Total seagrass cover by area (%)",
  subtitle: "Dashed line = 50% cover threshold",
  width: 800,
  height: 350,
  marginLeft: 160,
  x: {label: "Total cover (%)", grid: true, domain: [0, 100]},
  y: {label: null},
  marks: [
    Plot.barX(coverData, {
      x: "Total_Cover_pct",
      y: "Area",
      fill: "#2a9d8f",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([50], {stroke: "#e76f51", strokeDasharray: "4,4", strokeWidth: 1.5}),
    Plot.ruleX([0])
  ]
})
```

Malindi Marine Park and Ngomeni show the highest cover (95% and 91% respectively). Marereni and Kuruwitu have the lowest cover (50% and 52%), potentially reflecting higher anthropogenic disturbance.

---

## Species Richness by Area

```js
Plot.plot({
  title: "Seagrass species richness by area",
  subtitle: "Number of species recorded at each site",
  width: 800,
  height: 350,
  marginLeft: 160,
  x: {label: "Species richness", grid: true},
  y: {label: null},
  marks: [
    Plot.barX(coverData, {
      x: "Species_Richness",
      y: "Area",
      fill: "#264653",
      sort: {y: "-x"},
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

Ngomeni leads with 8 species - the highest diversity recorded. Kikambala has the fewest (2 species). Species richness is positively associated with total cover.

---

## Species Composition by Area

```js
const speciesCols = ["Cymodocea_rotundata_pct", "Syringodium_isoetifolium_pct", "Thalassodendron_ciliatum_pct", "Halodule_uninervis_pct", "Halophila_stipulacea_pct", "Thalassia_hemprichii_pct", "Halophila_ovalis_pct", "Cymodocea_serrulata_pct", "Enhalus_acoroides_pct"];
const speciesLabels = ["C. rotundata", "S. isoetifolium", "T. ciliatum", "H. uninervis", "H. stipulacea", "T. hemprichii", "H. ovalis", "C. serrulata", "E. acoroides"];

const speciesLong = coverData.flatMap(d =>
  speciesCols.map((col, i) => ({
    area: d.Area,
    species: speciesLabels[i],
    cover: d[col] || 0
  })).filter(r => r.cover > 0)
);
```

```js
Plot.plot({
  title: "Mean cover by species and area (%)",
  subtitle: "Mean cover where species is present; values are independent per species (not additive to 100%)",
  width: 800,
  height: 500,
  marginLeft: 160,
  x: {label: "Mean cover (%)", domain: [0, 100], grid: true},
  fy: {label: null},
  y: {label: null},
  color: {
    domain: speciesLabels,
    range: ["#2a9d8f", "#264653", "#e9c46a", "#e76f51", "#a8dadc", "#457b9d", "#f4a261", "#6c757d", "#2d6a4f"],
    legend: true
  },
  marks: [
    Plot.barX(speciesLong, {
      x: "cover",
      fy: "area",
      y: "species",
      fill: "species",
      tip: true
    }),
    Plot.ruleX([0])
  ]
})
```

Values represent mean cover per species where that species was recorded - they do not sum to 100% because species overlap within quadrats. *Thalassodendron ciliatum* dominates at most sites (up to 100% at Ngomeni). *Cymodocea rotundata* is the second most common species. Ngomeni is the only area where *Enhalus acoroides* was recorded.

---

## Shoot Density and Canopy Height

```js
const healthClean = healthData.filter(d => d.Area != null && d.Mean_Shoots_m2 > 0);
```

```js
Plot.plot({
  title: "Shoot density vs canopy height by species and area",
  subtitle: "Each point = one species at one area",
  width: 800,
  height: 500,
  x: {label: "Shoot density (shoots/m2)", grid: true},
  y: {label: "Mean canopy height (cm)", grid: true},
  color: {legend: true},
  marks: [
    Plot.dot(healthClean, {
      x: "Mean_Shoots_m2",
      y: "Mean_Canopy_height_cm",
      fill: "Species",
      r: d => Math.sqrt(d.n_quadrats) * 2,
      tip: true,
      title: d => `${d.Area} - ${d.Species}\nShoots: ${d.Mean_Shoots_m2.toFixed(0)}/m2\nHeight: ${d.Mean_Canopy_height_cm.toFixed(1)} cm\nn = ${d.n_quadrats}`
    })
  ]
})
```

---

## Seagrass Health by Zone

```js
const zoneClean = zoneData.filter(d => d.Area != null);
```

```js
Inputs.table(zoneClean.map(d => ({
  Area: d.Area,
  Zone: d.Zone,
  Species: d.Species,
  "Shoots/m2": (+d.Mean_Shoots_m2).toFixed(0),
  "Height (cm)": (+d.Mean_Canopy_height_cm).toFixed(1),
  "Epiphyte": d.Mean_Epiphyte_cover_pct != null ? (+d.Mean_Epiphyte_cover_pct).toFixed(1) : "-",
  Quadrats: d.n_quadrats
})), {
  sort: "Area",
  columns: ["Area", "Zone", "Species", "Shoots/m2", "Height (cm)", "Epiphyte", "Quadrats"]
})
```

---

## Summary Table

```js
Inputs.table(coverData.map(d => ({
  Area: d.Area,
  "Cover (%)": (+d.Total_Cover_pct).toFixed(1),
  "Spp richness": d.Species_Richness,
  "N quadrats": d.n_quadrats_cover
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
