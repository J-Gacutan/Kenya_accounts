"""
WDPA/WDOECM RAG System for Protected Areas Retrieval

Production RAG implementation for querying the WDPA/WDOECM Manual v1.6
and protected areas database schema. Designed for SEEA EA ecosystem accounting.

Spatial Unit: Protected areas (polygon/point geometry + attribute table)
Focus: Madagascar coral reef (M1.3) ecosystem extent & condition accounts
"""

import json
from dataclasses import dataclass
from typing import List, Dict, Optional, Tuple
from enum import Enum


# ============================================================================
# CORE ENTITY DEFINITIONS
# ============================================================================

class PADefinitionStatus(Enum):
    """PA_DEF field: compliance with IUCN/CBD definition"""
    PROTECTED_AREA = "1"  # Meets IUCN or CBD definition
    OECM = "0"  # Other Effective area-based Conservation Measure


class ManagementCategory(Enum):
    """IUCN Management Categories (7 types, non-hierarchical)"""
    IA = "Ia"  # Strict Nature Reserve
    IB = "Ib"  # Wilderness Area
    II = "II"  # National Park
    III = "III"  # Natural Monument
    IV = "IV"  # Habitat/Species Management
    V = "V"  # Protected Landscape/Seascape
    VI = "VI"  # Managed Resource Protected Area
    NOT_ASSIGNED = "Not Assigned"
    NOT_APPLICABLE = "Not Applicable"


class GovernanceType(Enum):
    """IUCN Governance Types (4 types, independent of management category)"""
    GOVERNMENT = "A"  # Federal/national or sub-national ministry
    SHARED = "B"  # Multiple parties (e.g., government + Indigenous)
    PRIVATE = "C"  # Individual or for-profit organization
    INDIGENOUS_LOCAL = "D"  # Indigenous peoples or local communities


class VerificationStatus(Enum):
    """VERIF field: data verification level"""
    STATE_VERIFIED = "State Verified"  # National government confirmed
    EXPERT_VERIFIED = "Expert Verified"  # Independent expert validated
    NOT_REPORTED = "Not Reported"  # Unverified data


class MarineComposition(Enum):
    """MARINE field: terrestrial vs. marine ecosystem type"""
    TERRESTRIAL = "0"  # Predominantly or entirely terrestrial
    COASTAL_MARINE = "1"  # Coastal: marine and terrestrial
    PREDOMINANTLY_MARINE = "2"  # Predominantly or entirely marine


class DesignationStatus(Enum):
    """STATUS field: PA establishment status"""
    PROPOSED = "Proposed"
    INSCRIBED = "Inscribed"
    ADOPTED = "Adopted"
    DESIGNATED = "Designated"
    ESTABLISHED = "Established"


# ============================================================================
# WDPA ATTRIBUTE SCHEMA
# ============================================================================

@dataclass
class WDPAMinimumAttribute:
    """Mandatory attributes required for WDPA/OECM database inclusion"""

    WDPA_ID: float  # Unique PA identifier (never reused)
    WDPA_PID: str  # Unique parcel ID for zones in multi-part PA (max 52 chars)
    PA_DEF: str  # "1" (PA) or "0" (OECM) — compliance with IUCN/CBD
    NAME: str  # PA name (local language, max 254 chars)
    ORIG_NAME: str  # PA name in original language (max 254 chars)
    DESIG: str  # Designation name (max 254 chars)
    DESIG_TYPE: str  # "National", "Regional", "International", "Not Applicable"
    REP_M_AREA: float  # Reported marine area (km²)
    GIS_M_AREA: float  # GIS-calculated marine area (km²)
    REP_AREA: float  # Reported total area (km²)
    GIS_AREA: float  # GIS-calculated total area (km²)
    STATUS: str  # Proposed/Inscribed/Adopted/Designated/Established
    STATUS_YR: int  # Year of designation/establishment (4-digit)
    VERIF: str  # "State Verified", "Expert Verified", "Not Reported"
    METADATAID: int  # Link to source table (metadata provenance)


@dataclass
class WDPACompleteAttribute:
    """Complete/recommended attributes for thorough PA analysis"""

    IUCN_CAT: str  # Ia, Ib, II, III, IV, V, VI, Not Applicable, Not Assigned
    MARINE: str  # 0 (terrestrial), 1 (coastal), 2 (predominantly marine)
    INT_CRIT: str  # International criteria (Ramsar, UNESCO, World Heritage, etc.)
    NO_TAKE: str  # "All", "Part", "None", "Not Reported", "Not Applicable"
    NO_TK_AREA: float  # No-take zone area (km²)
    GOV_TYPE: str  # A (Government), B (Shared), C (Private), D (Indigenous/Local)
    OWN_TYPE: str  # State, Communal, Individual, For-profit, Non-profit, Joint
    MANG_AUTH: str  # Managing authority name (max 254 chars)
    MANG_PLAN: str  # URL or reference to management plan (max 254 chars)
    CONS_OBJ: str  # "Primary", "Secondary", "Ancillary"
    SUB_LOC: str  # Sub-national location code (ISO 3166-2, max 100 chars)
    PARENT_ISO3: str  # Parent country ISO code (3 chars, max 20)
    ISO3: str  # Country ISO code (3 chars, max 20)
    RESTRICT: str  # "Not publicly available" (UNEP-WCMC use only)
    SUPP_INFO: str  # Supporting info on OECM (max 254 chars, OECM only)


# ============================================================================
# SPATIAL DATA SCHEMA
# ============================================================================

@dataclass
class GeometryMetadata:
    """Spatial data coordinate system and representation"""
    coordinate_system: str = "WGS84"  # World Geodetic Survey 1984
    geometry_type: str  # "Polygon" or "Point"
    is_multipart: bool = False  # Multi-part polygon (multiple zones, same WDPA_ID)

    class Config:
        description = """
        WGS84 (EPSG:4326) is mandatory coordinate system.
        Polygon: single-part or multi-part (multi-part zones share WDPA_ID, have unique WDPA_PID)
        Point: single point or multi-point (for boundary-unavailable or multi-zone areas)
        """


@dataclass
class SourceMetadata:
    """Data provenance and verification information"""
    data_provider: str  # Organization submitting data
    year_latest_update: int  # Currency indicator
    spatial_data_source: str  # Source of boundary or point location
    attribute_data_source: str  # Source of attribute information
    verification_method: str  # "State Verified", "Expert Verified", "Not Reported"
    contact_person: Optional[str] = None  # Contact for verification
    iso_standard_conformance: str = "ISO geographic information standards"  # Required


# ============================================================================
# RAG QUERY INTERFACE
# ============================================================================

@dataclass
class RAGQuery:
    """Query structure for RAG retrieval against WDPA schema"""
    query_type: str  # "spatial", "attribute", "temporal", "governance", "integration"
    query_text: str  # Natural language query or structured filter
    filters: Optional[Dict[str, any]] = None  # Key-value filters
    limit: int = 50  # Max results to return


@dataclass
class RAGResult:
    """Retrieved PA record matching RAG query"""
    wdpa_id: float
    name: str
    iso3: str
    designation: str
    governance: str
    iucn_category: Optional[str]
    area_km2: float
    marine_area_km2: float
    verification_status: str
    match_score: float  # 0.0-1.0 confidence score
    relevant_fields: Dict[str, any]  # Fields matching query


# ============================================================================
# KNOWLEDGE BASE STRUCTURE (VALIDATED SCHEMA)
# ============================================================================

WDPA_KNOWLEDGE_BASE = {

    "document": {
        "title": "User Manual for the World Database on Protected Areas and OECM",
        "version": "1.6",
        "published": 2019,
        "organization": "UNEP-WCMC",
        "url": "http://wcmc.io/WDPA_Manual",
        "validation_date": "2026-03-15"
    },

    "core_definitions": {
        "protected_area": {
            "iucn": "A clearly defined geographical space, recognised, dedicated and managed, through legal or other effective means, to achieve the long term conservation of nature with associated ecosystem services and cultural values. (Dudley 2008)",
            "cbd": "A geographically defined area which is designated or regulated and managed to achieve specific conservation objectives (CBD Article 2).",
            "pa_def_field": "1 = meets definition, 0 = does not meet definition (see OECM)"
        },
        "oecm": {
            "definition": "A geographically defined area other than a Protected Area, which is governed and managed in ways that achieve positive and sustained long-term outcomes for the in situ conservation of biodiversity, with associated ecosystem functions and services.",
            "key_distinction": "Conservation may be secondary objective; positive biodiversity outcomes regardless of original management intent.",
            "pa_def_field": "0 = OECM, 1 = Protected Area",
            "database": "Stored in separate OECM database; fully interoperable with WDPA"
        }
    },

    "spatial_standards": {
        "coordinate_system": "WGS84 (World Geodetic Survey 1984, EPSG:4326)",
        "geometry_types": {
            "polygon": {
                "description": "Primary representation (91% of records as of May 2019)",
                "variants": ["Single-part", "Multi-part (zones with same WDPA_ID, unique WDPA_PID)"],
                "use_case": "Recommended when boundary data available"
            },
            "point": {
                "description": "Fallback representation (9% of records as of May 2019)",
                "variants": ["Single point (centremost point)", "Multi-point (central locations of separated zones)"],
                "use_case": "When boundary data unavailable; represents centremost point, not necessarily centroid"
            }
        },
        "submission_requirement": "Geographic location required (preferably spatial boundary)"
    },

    "attribute_standards": {
        "minimum_attributes": {
            "mandatory": True,
            "fields": [
                {"name": "WDPA_ID", "type": "Double", "description": "Unique PA identifier (never reused, globally unique)"},
                {"name": "WDPA_PID", "type": "String(52)", "description": "Unique parcel ID for zones in multi-part PA"},
                {"name": "PA_DEF", "type": "String(20)", "allowed_values": ["1", "0"], "description": "Meets IUCN/CBD definition"},
                {"name": "NAME", "type": "String(254)", "description": "PA name (local language)"},
                {"name": "ORIG_NAME", "type": "String(254)", "description": "PA name in original language"},
                {"name": "DESIG", "type": "String(254)", "description": "Designation name"},
                {"name": "DESIG_TYPE", "type": "String(20)", "allowed_values": ["National", "Regional", "International", "Not Applicable"]},
                {"name": "REP_M_AREA", "type": "Double", "units": "km²", "description": "Reported marine area"},
                {"name": "GIS_M_AREA", "type": "Double", "units": "km²", "description": "GIS-calculated marine area"},
                {"name": "REP_AREA", "type": "Double", "units": "km²", "description": "Reported total area"},
                {"name": "GIS_AREA", "type": "Double", "units": "km²", "description": "GIS-calculated total area"},
                {"name": "STATUS", "type": "String(100)", "allowed_values": ["Proposed", "Inscribed", "Adopted", "Designated", "Established"]},
                {"name": "STATUS_YR", "type": "Long Integer", "description": "Year of designation"},
                {"name": "VERIF", "type": "String(20)", "allowed_values": ["State Verified", "Expert Verified", "Not Reported"]},
                {"name": "METADATAID", "type": "Long Integer", "description": "Link to source table"}
            ]
        },
        "complete_attributes": {
            "mandatory": False,
            "recommended": True,
            "fields": [
                {"name": "IUCN_CAT", "type": "String(20)", "allowed_values": ["Ia", "Ib", "II", "III", "IV", "V", "VI", "Not Applicable", "Not Assigned", "Not Reported"]},
                {"name": "MARINE", "type": "String(20)", "allowed_values": ["0", "1", "2"], "description": "0=terrestrial, 1=coastal, 2=marine"},
                {"name": "INT_CRIT", "type": "String(100)", "examples": ["Ramsar Site", "UNESCO-MAB Biosphere", "World Heritage Site", "Wetland of International Importance"]},
                {"name": "NO_TAKE", "type": "String(50)", "allowed_values": ["All", "Part", "None", "Not Reported", "Not Applicable"]},
                {"name": "NO_TK_AREA", "type": "Double", "units": "km²"},
                {"name": "GOV_TYPE", "type": "String(254)", "allowed_values": ["Federal/national", "Sub-national", "Collaborative", "Private", "Indigenous/Local"]},
                {"name": "OWN_TYPE", "type": "String(254)", "allowed_values": ["State", "Communal", "Individual", "For-profit", "Non-profit", "Joint"]},
                {"name": "MANG_AUTH", "type": "String(254)", "description": "Managing authority"},
                {"name": "MANG_PLAN", "type": "String(254)", "description": "URL or reference to management plan"},
                {"name": "CONS_OBJ", "type": "String(100)", "allowed_values": ["Primary", "Secondary", "Ancillary"]},
                {"name": "SUB_LOC", "type": "String(100)", "description": "ISO 3166-2 sub-national code"},
                {"name": "PARENT_ISO3", "type": "String(20)", "description": "Parent country ISO code"},
                {"name": "ISO3", "type": "String(20)", "description": "Country ISO code"}
            ]
        }
    },

    "iucn_standards": {
        "management_categories": {
            "note": "Non-hierarchical; cannot rank by conservation value or management effectiveness",
            "categories": [
                {"code": "Ia", "name": "Strict Nature Reserve", "description": "Strict protection; research only"},
                {"code": "Ib", "name": "Wilderness Area", "description": "Protected for wilderness character; minimal use"},
                {"code": "II", "name": "National Park", "description": "Large area; ecosystem protection; recreation/education"},
                {"code": "III", "name": "Natural Monument", "description": "Protect specific feature (geological, cultural)"},
                {"code": "IV", "name": "Habitat/Species Management", "description": "Active management for species/habitat conservation"},
                {"code": "V", "name": "Protected Landscape/Seascape", "description": "Large area; sustainable use integrated with conservation"},
                {"code": "VI", "name": "Managed Resource Protected Area", "description": "Sustainable use as conservation tool"}
            ],
            "coverage_note": "66% of WDPA records had category assignment as of May 2019; absence of category does NOT indicate poor management or lack of importance"
        },
        "governance_types": {
            "note": "Independent of management category; both dimensions coexist",
            "types": [
                {"code": "A", "name": "Government", "description": "Federal/national or sub-national ministry"},
                {"code": "B", "name": "Shared", "description": "Multiple parties (government + Indigenous, etc.)"},
                {"code": "C", "name": "Private", "description": "Individual or for-profit organization"},
                {"code": "D", "name": "Indigenous/Local", "description": "Indigenous peoples or local communities"}
            ],
            "coverage_note": "88% of WDPA records had governance type as of May 2019"
        }
    },

    "data_quality": {
        "verification_levels": {
            "State Verified": "National government confirmed data accuracy",
            "Expert Verified": "Independent expert reviewed and validated; preferred for indigenous/community/private-managed areas",
            "Not Reported": "Unverified data (data already in WDPA before 'Verification' field added)"
        },
        "verification_cycle": "Minimum every 5 years; UNEP-WCMC reserves right to remove data after 5 years of no contact",
        "quality_checks": {
            "spatial_validation": [
                "Coordinate system validation (WGS84 conversion if needed)",
                "Geometry topology checks (self-intersection, boundary closure)",
                "Spatial reference validation (datum, projection)",
                "Multi-part polygon integrity (shared WDPA_ID, unique WDPA_PID)"
            ],
            "attribute_validation": [
                "Required field completion (minimum attributes presence)",
                "Allowed value conformance (controlled vocabularies: STATUS, IUCN_CAT, MARINE, etc.)",
                "Data type validation (numeric vs. text fields)",
                "Field length conformance (e.g., WDPA_PID max 52 chars)",
                "Cross-field validation (e.g., NO_TAKE consistency with MARINE field)"
            ],
            "consistency_checks": [
                "Duplicate detection (within new submission and against existing WDPA)",
                "Temporal consistency (STATUS_YR reasonable for country context)",
                "Boundary-attribute consistency (polygon area vs. reported area tolerance)"
            ],
            "expert_review": "WCPA (World Commission on Protected Areas) stakeholder engagement and peer review"
        },
        "data_contributor_agreement": {
            "requirement": "Must be signed before data submission accepted",
            "versions": [
                {
                    "type": "Government data-providers",
                    "template_access": "Available through Protected Planet website and WDPA manual Appendix 2"
                },
                {
                    "type": "Non-government data-providers",
                    "template_access": "Available through Protected Planet website and WDPA manual Appendix 2"
                }
            ],
            "languages": ["English", "French", "Spanish"],
            "purpose": "Written record of IP agreement; terms for use and redistribution under WDPA Terms of Use",
            "contact": "protectedareas@unep-wcmc.org"
        },
        "take_down_policy": {
            "basis": "UNEP-WCMC operates take-down policy for intellectual property, copyright, confidentiality, data protection violations",
            "grounds_for_removal": [
                "Copyright breach",
                "Patent violation",
                "Intellectual property violation",
                "Trademark violation",
                "Confidentiality breach",
                "Data protection violation",
                "Obscenity",
                "Terrorism content",
                "Defamation or libel"
            ],
            "process": {
                "initial_action": "Relevant portion of dataset removed immediately pending investigation",
                "investigation": "UNEP-WCMC seeks advice to resolve complaint",
                "decision": "Complaint validation determines permanent withdrawal or re-availability",
                "timeline": "May take significant time if expert advice required"
            },
            "contact": "Email: protectedareas@unep-wcmc.org (Subject: Take-down notice)"
        },
        "indigenous_community_governance": {
            "framework": "Free, Prior, and Informed Consent (FPIC) - UN Declaration on Rights of Indigenous Peoples",
            "iucn_resolutions": [
                "WCC-2016-Res-036: Supporting conservation by indigenous peoples and local communities",
                "WCC-2016-Res-030: Free prior and informed consent for protected areas affecting indigenous lands"
            ],
            "fpic_requirements": {
                "free": "No coercion, undue influence, or conditional benefits",
                "prior": "Consultation and agreement before establishment/designation",
                "informed": "Full understanding of consequences and decision processes respected",
                "consent": "Expression through indigenous peoples' own decision-making processes"
            },
            "cbd_framework": "Kunming-Montreal Global Biodiversity Framework Target 3: Recognize indigenous and traditional territories; respect rights and contributions",
            "wdpa_implementation": "Data providers with indigenous/community governance encouraged to obtain consent; UNEP-WCMC offers guidance for documentation"
        },
        "known_limitations": [
            "Geographic bias: developed nations over-represented",
            "Temporal lag: updates may lag 1–2 years behind PA establishment",
            "Completeness: not all national PAs globally included",
            "Metadata: source information completeness varies by provider",
            "Data variability: expected differences due to provider capacity and resources"
        ]
    },

    "seea_ea_integration": {
        "ecosystem_extent": {
            "use_case": "Define ecosystem extent within protected vs. unprotected areas",
            "example_query": "Intersect PA polygons with reef extent map; stratify by designation, governance"
        },
        "condition_accounts": {
            "use_case": "Assess biotic condition within vs. outside PAs",
            "example_query": "Fish UVC sites → spatial join with PA polygons; calculate condition metrics by PA type"
        },
        "service_accounts": {
            "use_case": "Link ecosystem services to PA management effectiveness",
            "metrics": [
                "Fisheries Nursery: juvenile fish biomass × PA zone type",
                "Fish Provisioning: landing site catch composition × distance to PA (spillover)",
                "Recreation: fish richness/biomass as tourist attractiveness proxy",
                "Coastal Protection: reef structural health × PA status"
            ]
        }
    }
}


# ============================================================================
# RAG QUERY ENGINE
# ============================================================================

class WDPARAGEngine:
    """Query engine for WDPA/OECM schema and manual retrieval"""

    def __init__(self):
        self.kb = WDPA_KNOWLEDGE_BASE

    def query_attribute_field(self, field_name: str) -> Dict:
        """Retrieve attribute field definition"""
        for attr in self.kb["attribute_standards"]["minimum_attributes"]["fields"]:
            if attr["name"] == field_name:
                return {"source": "minimum", "definition": attr}
        for attr in self.kb["attribute_standards"]["complete_attributes"]["fields"]:
            if attr["name"] == field_name:
                return {"source": "complete", "definition": attr}
        return {"error": f"Field '{field_name}' not found"}

    def query_allowed_values(self, field_name: str) -> List[str]:
        """Get allowed values for a field"""
        all_fields = (
            self.kb["attribute_standards"]["minimum_attributes"]["fields"] +
            self.kb["attribute_standards"]["complete_attributes"]["fields"]
        )
        for field in all_fields:
            if field["name"] == field_name and "allowed_values" in field:
                return field["allowed_values"]
        return []

    def query_iucn_category(self, category_code: str) -> Dict:
        """Retrieve IUCN management category definition"""
        for cat in self.kb["iucn_standards"]["management_categories"]["categories"]:
            if cat["code"] == category_code:
                return cat
        return {"error": f"Category '{category_code}' not found"}

    def query_governance_type(self, governance_code: str) -> Dict:
        """Retrieve governance type definition"""
        for gov in self.kb["iucn_standards"]["governance_types"]["types"]:
            if gov["code"] == governance_code:
                return gov
        return {"error": f"Governance type '{governance_code}' not found"}

    def query_verification_status(self, status: str) -> str:
        """Retrieve verification status meaning"""
        return self.kb["data_quality"]["verification_levels"].get(status, "Unknown")

    def query_entity_definition(self, entity_type: str) -> Dict:
        """Retrieve core entity definitions"""
        return self.kb["core_definitions"].get(entity_type, {})

    def query_spatial_standards(self) -> Dict:
        """Retrieve spatial data standards (WGS84, geometry types)"""
        return self.kb["spatial_standards"]

    def query_seea_integration(self, account_type: str) -> Dict:
        """Query SEEA EA integration guidance"""
        return self.kb["seea_ea_integration"].get(account_type, {})


# ============================================================================
# EXAMPLE USAGE
# ============================================================================

if __name__ == "__main__":
    rag = WDPARAGEngine()

    print("=" * 70)
    print("WDPA/WDOECM RAG SYSTEM — Example Queries")
    print("=" * 70)

    # Example 1: Field definition
    print("\n1. Query: IUCN_CAT field definition")
    result = rag.query_attribute_field("IUCN_CAT")
    print(json.dumps(result, indent=2))

    # Example 2: Allowed values
    print("\n2. Query: Allowed values for MARINE field")
    result = rag.query_allowed_values("MARINE")
    print(f"Allowed values: {result}")

    # Example 3: IUCN category
    print("\n3. Query: IUCN Category II (National Park)")
    result = rag.query_iucn_category("II")
    print(json.dumps(result, indent=2))

    # Example 4: Governance type
    print("\n4. Query: Governance Type A (Government)")
    result = rag.query_governance_type("A")
    print(json.dumps(result, indent=2))

    # Example 5: Entity definition
    print("\n5. Query: Protected Area definition (IUCN vs CBD)")
    result = rag.query_entity_definition("protected_area")
    print(json.dumps(result, indent=2))

    # Example 6: Spatial standards
    print("\n6. Query: Spatial data standards (coordinate system, geometry)")
    result = rag.query_spatial_standards()
    print(json.dumps(result, indent=2, default=str))

    # Example 7: SEEA EA integration
    print("\n7. Query: SEEA EA integration for condition accounts")
    result = rag.query_seea_integration("condition_accounts")
    print(json.dumps(result, indent=2))
