# RAG Schema: WDPA/WDOECM Manual 1.6
**Document:** User Manual for the World Database on Protected Areas and other effective area-based conservation measures: 1.6
**Published:** 2019, UNEP-WCMC
**Purpose:** Schema for retrieval-augmented generation (RAG) queries over WDPA/OECM protected areas documentation
**Spatial Unit:** Protected areas as common basic spatial unit (polygon or point geometry + attribute table)

---

## 1. Document Structure & Sections

| Section | Pages | Primary Topics | Key Concepts |
|---------|-------|-----------------|--------------|
| **Manual at a Glance** | 5–6 | Overview, Protected Planet Initiative, shortcuts | WDPA ID, database structure, use cases |
| **1. What is WDPA?** | 7–11 | History, sites included, IUCN standards, data structure | IUCN definition, management categories, governance types, spatial data (polygons/points) |
| **2. What is OECM database?** | 12 | Background, OECM definition, difference from PA, database linkage | OECM definition (CBD Aichi Target 11), PA_DEF field, interoperability |
| **3. Protected Planet Data Standards** | 13–19 | Spatial data, attribute data, source information, contributor agreements | Coordinate system (WGS84), minimum/complete attributes, metadata, ISO standards |
| **4. How are WDPA/OECM compiled?** | 20–27 | Data providers, verification, quality checks, assessment | Data provider types, QA/QC process, verification workflow, integration |
| **5. Using WDPA/OECM database** | 29–41 | Access, citation, terms of use, analysis, attribute tables, limitations | Download, data interpretation, known issues, use cases, conditions of use |
| **Appendices** | 44–75 | Field descriptions, data contributor agreements, quality checks, take-down policy, metadata, policy references | Complete field reference, governance agreements, check procedures, metadata, legal links |

---

## 2. Core Entities & Definitions

### 2.1 Protected Area (PA)
**Definition (IUCN):**
"A clearly defined geographical space, recognised, dedicated and managed, through legal or other effective means, to achieve the long term conservation of nature with associated ecosystem services and cultural values."

**Key Properties:**
- Unique identifier: `WDPA_ID` (globally unique, never reused)
- Spatial representation: Polygon (single or multi-part) OR Point
- Temporal: `STATUS_YR` (year of establishment)
- Status: Proposed, Inscribed, Adopted, Designated, Established

**Definition Compliance:**
- `PA_DEF`: 1 (meets IUCN/CBD definition) | 0 (does not meet definition)
- Note: Records should meet IUCN/CBD definitions; some may not; UNEP-WCMC does not enforce universal compliance

---

### 2.2 Other Effective Area-based Conservation Measure (OECM)
**Definition (CBD):**
"A geographically defined area other than a Protected Area, which is governed and managed in ways that achieve positive and sustained long-term outcomes for the in situ conservation of biodiversity, with associated ecosystem functions and services and where applicable, cultural, spiritual, socio-economic, and other locally relevant values."

**Key Differences from PA:**
- Conservation may be **secondary objective** (vs. primary in PA)
- Encompasses areas where **positive biodiversity outcomes occur regardless of original management intent**
- Stored in **separate OECM database** (parallel structure to WDPA)
- Linked via `WDPA_ID` + `PA_DEF` field:
  - `PA_DEF = '1'` → Protected Area (WDPA)
  - `PA_DEF = '0'` → Other Effective Measure (OECM)

**Note:** Both databases are **fully interoperable**; can be queried separately or combined

---

### 2.3 Spatial Unit Types

#### Polygon Data
- **Single-part polygon:** One contiguous boundary with single `WDPA_ID`
- **Multi-part polygon:** Multiple non-contiguous zones, all sharing same `WDPA_ID`, but each zone has unique `WDPA_PID` (parcel ID)
- **Coordinate system:** WGS84 (World Geodetic Survey 1984)
- **Coverage (as of May 2019):** 242,784 protected areas; 91% polygons, 9% points

#### Point Data
- **Single point:** Latitude/longitude centroid (when boundary unavailable)
- **Multi-point:** Multiple points representing central locations of separated zones
- **Assumption:** Points represent **central point of the site** (not necessarily centroid)
- **Use case:** When polygon boundary data unavailable from data provider

---

## 3. Attribute Data Schema

### 3.1 Minimum Attributes (Mandatory)
Data submission **requires** these fields:

| Field | Type | Description | Example Values |
|-------|------|-------------|-----------------|
| `WDPA_ID` | Double | Unique PA/OECM identifier (assigned by UNEP-WCMC) | 123456 |
| `WDPA_PID` | String (52) | Unique parcel ID for zones in multi-part PA | Zone_A_123456 |
| `PA_DEF` | String (20) | Meets IUCN/CBD definition? | "1" (PA), "0" (OECM) |
| `NAME` | String (254) | PA name (local language as provided) | "Andohahela National Park" |
| `ORIG_NAME` | String (254) | PA name in original language | (if different from NAME) |
| `DESIG` | String (254) | Designation name | "National Park", "Marine Reserve" |
| `DESIG_TYPE` | String (20) | Designation category | "National", "Regional", "International" |
| `REP_M_AREA` | Double | Marine area (km²) | 12500.5 |
| `GIS_M_AREA` | Double | GIS-calculated marine area (km²) | 12480.3 |
| `REP_AREA` | Double | Total reported area (km²) | 15000.0 |
| `GIS_AREA` | Double | GIS-calculated total area (km²) | 14950.2 |
| `STATUS` | String (100) | Management status | "Proposed", "Inscribed", "Designated", "Established" |
| `STATUS_YR` | Long Integer | Year of designation/establishment | 2005 |
| `VERIF` | String (20) | Verification status | "State Verified", "Expert Verified", "Not Reported" |
| `METADATAID` | Long Integer | Link to source table | 12345 |

---

### 3.2 Complete Attributes (Recommended)
High-priority fields for **thorough analysis**:

| Field | Type | Description | Notes |
|-------|------|-------------|-------|
| `IUCN_CAT` | String (20) | IUCN Management Category | Ia, Ib, II, III, IV, V, VI, Not Applicable, Not Assigned, Not Reported |
| `MARINE` | String (20) | Marine vs. terrestrial composition | 0 (terrestrial), 1 (coastal/marine), 2 (predominantly/entirely marine) |
| `INT_CRIT` | String (100) | International criteria (World Heritage, Ramsar, UNESCO) | "World Heritage Site", "Ramsar Site", etc. |
| `NO_TAKE` | String (50) | No-take zone area (km²) | "All", "Part", "None", "Not Reported", "Not Applicable" |
| `NO_TK_AREA` | Double | No-take area in km² | 500.0 |
| `GOV_TYPE` | String (254) | Governance type | "Federal or national ministry", "Sub-national ministry", "Collaborative", "Private", "Indigenous peoples/Local communities" |
| `OWN_TYPE` | String (254) | Ownership type | "State", "Communal", "Individual landowners", "For-profit", "Non-profit", "Joint ownership" |
| `MANG_AUTH` | String (254) | Managing authority | "National park service", "Wildlife agency", "Private company", etc. |
| `MANG_PLAN` | String (254) | Link/reference to management plan | URL or document reference |
| `CONS_OBJ` | String (100) | Conservation objective | "Primary", "Secondary", "Ancillary" |
| `SUPP_INFO` | String (254) | Supporting info on OECM | For OECM records: explains how OECM definition is met |
| `SUB_LOC` | String (100) | Sub-national location code (ISO 3166-2) | "MG-AS" (Androy, Madagascar) |
| `PARENT_ISO3` | String (20) | Parent country ISO code | "MDG" (Madagascar) |
| `ISO3` | String (20) | Country ISO code | "MDG" |

---

### 3.3 Metadata & Source Information
**Source Table** (linked to attributes via `METADATAID`):

| Field | Purpose |
|-------|---------|
| Data provider | Organization submitting the data |
| Year of latest update | Currency indicator |
| Spatial data source | Source of boundary/point data |
| Attribute data source | Source of attribute info |
| Verification method | How data were verified (state, expert, unverified) |
| Contact person | Verifier responsible for QA/QC |

**Requirement:** *All submissions must include source information; data without source metadata will be rejected.*

---

## 4. IUCN Standards & Classifications

### 4.1 IUCN Management Categories
(Voluntary; 66% of WDPA records had category as of May 2019)

| Category | Code | Description |
|----------|------|-------------|
| **Strict Nature Reserve** | Ia | Strict protection; research only |
| **Wilderness Area** | Ib | Protected for wilderness character; minimal use |
| **National Park** | II | Large area; ecosystem protection; recreation/education |
| **Natural Monument** | III | Protect specific feature (geological, cultural) |
| **Habitat/Species Management** | IV | Active management for species/habitat conservation |
| **Protected Landscape/Seascape** | V | Large area; sustainable use integrated with conservation |
| **Managed Resource Protected Area** | VI | Sustainable use of natural resources as conservation tool |
| **Not Applicable** | N/A | Category not assigned or not applicable |

**Important:** Categories are **NOT hierarchical**; cannot be used to make assumptions about biodiversity value, management effectiveness, or conservation performance.

---

### 4.2 IUCN Governance Types
(88% of WDPA records had governance type as of May 2019)

| Type | Code | Authority/Responsibility |
|------|------|--------------------------|
| **A. Government** | A | Federal/national or sub-national government ministry |
| **B. Shared** | B | Multiple parties (e.g., government + Indigenous communities) |
| **C. Private** | C | Individual or for-profit organization |
| **D. Indigenous/Local** | D | Indigenous peoples or local communities |

**Governance** ≠ **Management Category** (independent dimensions)

---

## 5. Data Quality & Verification

### 5.1 Verification Status (`VERIF` field)
- **State Verified:** National government confirmed the data
- **Expert Verified:** Independent expert reviewed and validated
- **Not Reported:** Unverified data (quality variable; may be removed before public release)

### 5.2 Known Data Issues & Limitations
**Transect area assumption:** Field validates against **100 m² transect** (20×5 m) assumption from Madagascar fish/invertebrate condition accounts; some PAs may use larger transects (20×20 m = 400 m²) — impacts scaling to per-hectare metrics.

**Fish biomass reference level:** 500 kg/ha (MacNeil et al. 2015) may underestimate for total reef fish in less-impacted reefs.

**COTS scaling sensitivity:** Very low densities in small transects scaled per-hectare can be misleading.

**Sea urchin reference level:** No global standard; currently descriptive in condition accounts.

**WDPA completeness:**
- Not all national protected areas are included globally
- Country coverage is uneven (developed nations better represented)
- Some historically-listed PAs may be outdated or incorrect

---

## 6. Common Query Patterns & Use Cases

### 6.1 Spatial Queries
**Q: What protected areas overlap with Madagascar coastal reefs?**
- Intersect polygon features with reef extent map (Sentinel-2)
- Filter: `MARINE` ≥ 1 (coastal or marine)
- Output: PA boundaries, `WDPA_ID`, name, designation, area

**Q: Find all marine PAs within 50 km of landing sites**
- Buffer landing site points
- Spatial join with polygon/point features
- Filter: `MARINE` = 2 (predominantly marine)

**Q: Classify PA coverage by ecosystem type**
- Classify multi-part polygons by zone (`WDPA_PID`)
- Cross-reference with habitat/ecosystem layer
- Aggregate by `WDPA_ID`

### 6.2 Attribute Queries
**Q: What conservation objectives are present in Madagascar?**
- Filter: `ISO3` = 'MDG'
- Group by: `CONS_OBJ` (Primary/Secondary/Ancillary)
- Output: Count, area, PA names

**Q: Which PAs have no-take zones, and how large are they?**
- Filter: `NO_TAKE` = 'Part'
- Select: `NO_TK_AREA`, `GIS_AREA`
- Calculate: Percentage no-take

**Q: Find indigenous-managed PAs**
- Filter: `GOV_TYPE` contains "Indigenous"
- Select: `OWN_TYPE`, `MANG_AUTH`, `NAME`

### 6.3 Temporal Queries
**Q: When were Madagascar PAs designated?**
- Filter: `ISO3` = 'MDG'
- Group by: `STATUS_YR`
- Output: Timeline of designations

**Q: Which PAs are proposed vs. established?**
- Filter: `STATUS` in ["Proposed", "Established"]
- Count by status

### 6.4 Governance & Management Queries
**Q: What governance types manage Madagascar's PAs?**
- Filter: `ISO3` = 'MDG'
- Group by: `GOV_TYPE`, `OWN_TYPE`
- Cross-reference: `IUCN_CAT`

**Q: Which PAs have documented management plans?**
- Filter: `MANG_PLAN` is not null
- Select: `NAME`, `MANG_PLAN` (extract URL or reference)

**Q: Are there community-managed OECMs?**
- Filter: `PA_DEF` = '0' AND `GOV_TYPE` contains "Indigenous/Local"
- Output: OECM names, locations, governance structure

### 6.5 Integration Queries (PA + Condition Accounts)
**Q: What fish/invertebrate condition data exist within protected areas?**
- Spatial join: Fish UVC survey sites (Madagascar/01_inputs) ← Protected area polygons
- Output: Site condition (fish biomass, richness, trophic composition) x PA designation

**Q: Do ecosystem services differ between PA types (IUCN_CAT)?**
- Link: PA geometry + `IUCN_CAT` → Fish biomass/provisioning service data
- Compare: Nursery service value (kg/yr) x IUCN category

---

## 7. Field Mappings & Relationships

### 7.1 Key Identifiers
```
WDPA
├── WDPA_ID (unique protected area identifier, globally assigned)
│   ├── WDPA_PID (zone/parcel IDs for multi-part polygons)
│   └── METADATAID (link to source table)
└── PA_DEF (0 = OECM, 1 = Protected Area)
```

### 7.2 Spatial Representation
```
Geometry
├── Polygon(s) - Primary representation (91% of records)
│   └── Multi-part (multiple zones sharing WDPA_ID)
└── Point(s) - Fallback when boundary unavailable (9% of records)
    └── Multi-point (central locations of separated zones)
```

### 7.3 Classification Hierarchy
```
Management Objective (Primary/Secondary/Ancillary)
├── IUCN Category (Ia, Ib, II, III, IV, V, VI, N/A)
│   └── Specific Designation (National Park, Marine Reserve, etc.)
└── Governance Type (A/B/C/D)
    ├── Ownership Type (State, Communal, Individual, For-profit, etc.)
    └── Managing Authority
```

### 7.4 Data Quality Chain
```
Data Provider (Government/NGO/Individual)
→ Source Information (metadata table)
  └── METADATAID ← linked to each attribute record
  └── Verification Status (VERIF)
  └── Year of last update
→ Data Verification (QA/QC process)
→ Public Release (Protected Planet)
```

---

## 8. Constraints & Caveats

### 8.1 Data Submission Requirements
- **Spatial data:** WGS84 coordinate system; polygon or point required
- **Attributes:** Minimum mandatory fields + source metadata
- **Governance:** IUCN definition compliance (but not enforced uniformly)
- **Agreement:** WDPA Data Contributor Agreement must be signed
- **Source info:** Metadata without source info will be rejected

### 8.2 Interpretation Caveats
- IUCN categories **NOT hierarchical** (cannot rank by conservation value)
- Absence of IUCN category **does NOT indicate poor management** or lack of importance
- `PA_DEF` compliance varies by country (national definitions may differ)
- Point data ≠ point locations (represent centroid only)
- Multi-part polygons may represent **non-contiguous zones** (same PA name, same conservation objective)

### 8.3 Known Gaps & Biases
- **Geographic bias:** Developed nations over-represented
- **Temporal lag:** Updates may lag 1–2 years behind actual PA establishment
- **Completeness:** Not all national PAs globally included
- **Metadata:** Source information completeness varies by data provider

---

## 9. Integration with SEEA EA Framework

### 9.1 Extent Accounts
**Use Case:** Define ecosystem extent within protected vs. unprotected areas

**Query Pattern:**
```sql
SELECT
  pa.WDPA_ID, pa.NAME, pa.IUCN_CAT,
  ST_Area(pa.geometry) as PA_area_km2,
  ST_Intersection(pa.geometry, reef_extent.geometry) as reef_area_within_pa
FROM WDPA_polygons pa
JOIN reef_extent ON ST_Intersects(pa.geometry, reef_extent.geometry)
WHERE pa.ISO3 = 'MDG' AND pa.MARINE >= 1
```

### 9.2 Condition Accounts
**Use Case:** Assess biotic condition within vs. outside PAs

**Data Integration:**
- Fish UVC survey sites (Madagascar/01_inputs) → spatial join with PA polygons
- Calculate condition metrics (fish biomass, richness) stratified by:
  - PA designation (`DESIG`)
  - IUCN category (`IUCN_CAT`)
  - Governance type (`GOV_TYPE`)
  - No-take status (`NO_TAKE`)

### 9.3 Service Accounts
**Use Case:** Link ecosystem services to PA management effectiveness

**Potential Metrics:**
- **Fisheries Nursery Service:** Juvenile fish biomass × PA zone type (protected vs. open access)
- **Fish Provisioning:** Landing site catch composition × distance to PA (spillover effects)
- **Recreation:** Tourist attraction (proxy: fish richness/biomass in PA vs. non-PA reefs)
- **Coastal Protection:** Reef structural health (condition index) × PA status

---

## 10. Appendix: Complete Field Reference

**Refer to:**
- **Appendix 1 (Manual pp. 44–61):** Detailed descriptions of all 29 WDPA + 31 OECM fields
- **Appendix 5 (Manual pp. 70–74):** WDPA/OECM metadata standard (ISO geographic information standards)
- **Appendix 6 (Manual pp. 75+):** Policy references (CBD, IUCN Resolutions, UNEP-WCMC standards)

**Access Full Field Documentation:**
```
WDPA Data Fields (Min/Complete):
  - WDPA_ID, WDPA_PID, PA_DEF, NAME, ORIG_NAME, DESIG, DESIG_TYPE,
  - IUCN_CAT, MARINE, INT_CRIT, REP_M_AREA, GIS_M_AREA, REP_AREA, GIS_AREA,
  - STATUS, STATUS_YR, VERIF, NO_TAKE, NO_TK_AREA,
  - GOV_TYPE, OWN_TYPE, MANG_AUTH, MANG_PLAN, CONS_OBJ,
  - SUB_LOC, PARENT_ISO3, ISO3, METADATAID, RESTRICT, [others per Appendix 1]

OECM Database (31 fields):
  - All WDPA fields + SUPP_INFO (supporting evidence on OECM definition)
```

---

## 11. Document Citation & Access

**Citation:**
```
UNEP-WCMC (2019). User Manual for the World Database on Protected Areas
and world database on other effective area-based conservation measures: 1.6.
UNEP-WCMC: Cambridge, UK. Available at: http://wcmc.io/WDPA_Manual
```

**Access & Download:**
- **Online Database:** https://www.protectedplanet.net
- **GIS Shapefiles:** Polygon and point feature classes (WGS84)
- **Data Format:** File geodatabase (.gdb) or shapefile (.shp)
- **Metadata:** ISO-compliant XML metadata available per dataset

**Contact:**
- Email: protectedareas@unep-wcmc.org
- Query/Technical: http://wcmc.io/WDPA_Manual (Section 5, pp. 29–41)

---

## 12. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-15 | Initial RAG schema for WDPA/OECM Manual v1.6; integrated with Madagascar M1.3 coral reef SEEA EA condition accounts |

