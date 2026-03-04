# Dataset Metadata

## Section A: Dataset Overview

### Dataset Title
Benthic and Coastal Habitat Map of South-West Madagascar derived from Sentinel-2 and In situ Photoquadrats (2025-2026)

### Data Source Type
Remote sensing + In situ field survey + Image classification (OBIA, k-NN)

### Dataset Summary
This dataset contains classified benthic and coastal habitat maps of South-West Madagascar derived from Sentinel-2 imagery (10 m spatial resolution) and georeferenced underwater photoquadrats. Benthic cover was quantified using CPCe (49 stratified points per quadrat). Sentinel-2 Level-1C imagery was atmospherically corrected to Level-2A using Sen2Cor, followed by water column correction using the Lyzenga depth-invariant index method. Object-Based Image Analysis (OBIA) and k-Nearest Neighbour (k-NN) classification were applied to generate thematic habitat maps. Accuracy assessment was conducted using confusion matrix metrics (OA, PA, UA).

### Data Structure / Primary Data Format
Raster (GeoTIFF), Vector (Shapefile / GeoPackage) and Tabular (CSV / Excel)

### Geographic Coverage & Boundaries
South-West Madagascar coastal and marine zone (Morombe to Ambohibola), including barrier reef, fringing reef, patch reefs and adjacent coastal ecosystems (mangroves, beaches, rocky areas). Approximate depth range for in situ data: 0–20 m.

### Spatial Geometry or Coordinates
Yes

## Key Variables and Indicators

| Variable Name | Units | Brief Description | Notes |
|---|---|---|---|
| Benthic_class | Categorical | Dominant benthic habitat class | Coral, Rubble, Sand, Seagrass, Rock |
| Coral_cover | % | Percent coral cover per quadrat | Derived from 49 CPCe points |
| NDVI | Index | Normalized Difference Vegetation Index | Sentinel-2 derived |

## Section B: Collection Methodology

### Methodology Description
Collection of approximately 250 georeferenced underwater photoquadrats per transect along reef systems of South-West Madagascar. GPS positions were recorded every second using a surface-floating waterproof GPS device synchronized with underwater image acquisition. Images were captured every 3 to 5 meters along 500 m transects (average duration 30 minutes). GPS-image synchronization was automated using Python scripts integrating timestamps and embedding coordinates into EXIF metadata. Benthic cover was quantified using Coral Point Count with Excel extension (CPCe), applying 49 stratified random points per image using predefined "CPCe benthic codes 41 Madagascar". Sentinel-2 imagery (10 m resolution) was atmospherically corrected (Sen2Cor) and water column corrected (Lyzenga 1981). Object-Based Image Analysis (OBIA) and k-Nearest Neighbour classifier were applied in eCognition Developer 10.3. All GIS operations were conducted in QGIS 3.34.

## Section C: Temporal Information

### Collection Start Date
2025-11-11

### Collection End Date
2026-02-20

### Reference Period / Coverage Notes
Field surveys and satellite imagery acquired between 2025 and 2026. Sentinel-2 images selected during low spring tides with minimal cloud cover

### Expected Update Frequency
Irregular / Project-based

### Last Update Date
2026-02-20

### Next Expected Update Date
To be determined

## Section D: Spatial Characteristics

### Geometry Type
Mixed (Point + Polygon + Raster)

### Coordinate Reference System (CRS)
EPSG:4326 (WGS 84)

### Spatial Resolution / Scale
Sentinel-2 raster: 10 m, In situ quadrats: approx. 1 m², Transect length: ~500 m

### Positional Accuracy Notes
GPS accuracy estimated ±3–5 m. Underwater positioning derived from synchronized surface GPS tracking. Potential horizontal offset due to drift and current.

### Spatial Extent Notes
South-West Madagascar coastal zone, including reef barrier system and adjacent coastal ecosystems (0–20 m depth range).

## Section E: Quality & Assurance

### Known Limitations or Issues
1. **GPS positional uncertainty**: GPS positioning was obtained using a surface-floating device synchronized with underwater image acquisition. Although minor horizontal displacement may occur due to surface drift and current, the positional accuracy (estimated ±3–5 m) remains well within acceptable limits relative to the 10 m spatial resolution of Sentinel-2 imagery.

2. **Scale difference between field data and satellite imagery**: In situ photoquadrats represent approximately 1 m² sampling units, whereas Sentinel-2 pixels correspond to 10 m resolution. CPCe-derived benthic classes were aggregated into ecologically meaningful dominant categories before overlay and classification.

3. **Spectral similarity among certain benthic classes**: Some substrates (e.g., coral and rubble; sand and sparse seagrass) may exhibit overlapping spectral signatures. This was addressed using Object-Based Image Analysis (OBIA), which integrates spectral, textural, and spatial features.

4. **Water column variability**: Optical attenuation due to water depth and clarity was corrected using the Lyzenga depth-invariant index approach.

5. **Sampling depth range**: Field data collection was limited to depths shallower than 20 m, corresponding to the optically effective depth range of Sentinel-2 in clear tropical waters.

### Validation or QA Methods Applied
- Confusion matrix (OA, PA, UA)
- Independent validation samples
- Cross-verification with in situ CPCe data
- Visual inspection of classified objects

### Data Completeness and Coverage Notes
Field sampling limited to accessible reef areas and depths <20 m. Some offshore or high-current areas not surveyed.

### Quality Indicators

| Indicator | Status | Notes |
|---|---|---|
| Data has been validated | Yes | |
| Fitness for purpose | High | Fit for intended use |
| Complies with relevant standards | Yes | Remote sensing and habitat mapping protocols |
| Known issues flagged | Yes | Details in Known Limitations section |

## Section F: Access & Contacts

### Primary File Format
GeoTIFF + Shapefile + CSV

### Character Encoding / Language
UTF-8 / English

### Access Restrictions or Confidentiality Notes
Research use; contact author for redistribution. Sensitive ecological habitat information

### Preferred Citation or Usage Statement
Mitondrasoa, Y.A. (2026). Benthic and Coastal Habitat Map of South-West Madagascar (2025-2026). Unpublished dataset.

### Submitter Name
Yves Amoros Mitondrasoa

### Submitter Organisation
University of Toliara / Institut Halieutique et des Sciences Marines
