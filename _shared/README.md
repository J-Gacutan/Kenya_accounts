# Shared Resources — AFRICA Ecosystem Accounting Project

This folder contains resources shared across all country pilots (Madagascar, Mozambique, and future pilots).

---

## Contents

### 1. **`templates/`** — Publication & Brief Templates
Generic templates for communicating ecosystem accounts to peer-reviewed audiences and policy makers.

| File | Purpose | Use for |
|------|---------|---------|
| `POLICY_BRIEF_TEMPLATE.md` | Policy brief skeleton + guidance | Writing 2–4 page policy briefs for national/regional stakeholders |
| `WDPA_WDOECM_Manual_1_6.pdf` | Protected area reference manual | Spatial data standards for WDPA, WDOECM, and PA extent accounting |

**For each new pilot:** Copy the templates to your country folder (`CountryName/docs/`), adapt the skeleton sections with your ecosystem type and national policy context, and populate the worked examples with your data.

---

### 2. **`literature/`** — Regional SEEA EA Case Studies
Shared academic reference papers from neighboring regions (Uganda, Rwanda, South Africa) documenting SEEA EA implementation.

**Files:**
- `12_2020Ecosystem_Accounts_for_Uganda_Report_NEW_new.pdf` + `.txt` — Uganda water resource accounts (UNEP/WAVES partnership)
- `OE_article_86392.pdf` + `.txt` — Open Ecology journal article: Ecosystem accounts in KwaZulu-Natal, South Africa
- `People and Nature - 2019 - Bagstad...Rwanda.pdf` + `.txt` — Rwanda biodiversity & ecosystem service valuation

**Use for:** Understanding SEEA EA implementation approaches in similar African contexts; methodological precedents for condition/extent/service indicator selection.

**See also:** `Madagascar/docs/ACADEMIC_RAG_*.md` — Academic evidence linking system (18+ sources extracted from publications across WIO region).

---

### 3. **`rag_schemas/`** — Generic RAG Schema Templates
Generic JSON schemas and controlled vocabularies for building Retrieval-Augmented Generation systems for policy linking and academic evidence management.

| File | Purpose |
|------|---------|
| `template_seea_publication_GENERIC.md` | 7-section skeleton for peer-reviewed SEEA EA publications; customize for your ecosystem |
| `policy_rag_schema_GENERIC.md` | JSON schema for structuring national policies + international commitments for semantic search; includes example field definitions and controlled vocabularies |

**For each new pilot:**
1. Copy `policy_rag_schema_GENERIC.md` to `CountryName/docs/policy_rag_schema.md`
2. Replace `"country": "string"` with your target country
3. Update ministry names, example policy instruments, and ecosystem classifications
4. If building an academic RAG: use `Madagascar/docs/academic_rag_schema.md` as a template

---

## How to Adapt for a New Pilot Country

### Step 1: Set Up Country Folder
```bash
mkdir -p CountryName/{01_inputs/{raw_data,metadata},02_analysis,03_outputs,docs/{skills}}
```

### Step 2: Copy Shared Templates
```bash
cp _shared/templates/POLICY_BRIEF_TEMPLATE.md CountryName/docs/
cp _shared/templates/WDPA_WDOECM_Manual_1_6.pdf CountryName/docs/
cp _shared/rag_schemas/template_seea_publication_GENERIC.md CountryName/docs/template_seea_publication.md
cp _shared/rag_schemas/policy_rag_schema_GENERIC.md CountryName/docs/policy_rag_schema.md
```

### Step 3: Adapt the Templates
- **POLICY_BRIEF_TEMPLATE.md:** Customize Section 2 (Ecosystem & Policy Context) with your country's ecosystem types, ministries, and policy drivers
- **template_seea_publication.md:** Update all generic placeholders (e.g., "ecosystem type", "reference level") with your specific ecosystem, data sources, and study design
- **policy_rag_schema.md:** Replace country name, ministry names, and add 3–5 example national policy records

### Step 4: Create Country-Specific Analysis
- Write the analysis script (R, Python, or equivalent) in `02_analysis/`
- Document methodology in `docs/skills/skill_[account_type]_[country_ecosystem].md`
- Output results to `03_outputs/`

### Step 5: Link to Regional Precedents
- Review `_shared/literature/` papers for similar ecosystem types or valuation approaches
- Reference case studies in your methodology documentation
- Link your policy_rag_schema to international commitments documented in `_shared/rag_schemas/policy_rag_schema_GENERIC.md`

---

## Managing Shared Resources

### Adding New Shared Templates
- If a template is used by **≥2 pilots**, move it to `_shared/templates/` with clear usage guidance
- Leave country-specific worked examples in the country folder

### Updating Shared References (Literature)
- Add new regional SEEA EA case studies to `_shared/literature/` with a brief README entry
- Keep original PDFs + TXT versions for searchability

### Versioning RAG Schemas
- Generic schemas live in `_shared/rag_schemas/`
- Country-specific records and examples live in `CountryName/docs/policy_rag_schema.md` and `academic_rag_schema.md`
- When updating the generic schema (e.g., adding new policy type), propagate changes to all country implementations

---

## FAQ

**Q: Should I copy or link shared files?**
A: Copy. Each country pilot should have its own adapted versions in the country folder. Shared resources in `_shared/` are for reference and templates only.

**Q: How do I know which files are shared vs. country-specific?**
A: If a file appears in **≥2 country folders**, it either (a) should be moved to `_shared/` with a generic version, or (b) is country-adapted and should stay in the country folder. Check the plan (`CLAUDE.md` → Repository Structure) for clarity.

**Q: Can I modify a shared template for my pilot?**
A: Yes. Copy the template to your country folder and adapt it. If the adaptation is useful for other pilots, discuss with the team about creating a new shared variant.

**Q: Where do I document pilot-specific methodology?**
A: In `CountryName/docs/skills/skill_[account_type]_[ecosystem]_[country].md`. These are never shared — they embed country-specific data.

---

## See Also
- [Madagascar/docs/](../Madagascar/docs/) — Full implementation example (condition + extent + services)
- [Mozambique/docs/](../Mozambique/docs/) — Early-stage extent accounting example
- [CLAUDE.md](../CLAUDE.md) — Project-level conventions and structure
