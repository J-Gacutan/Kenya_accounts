Kenya 02_analysis -- Analysis Scripts
=====================================

R scripts that process raw field data into SEEA EA ecosystem condition
and service accounts for the Kenya pilot (Kilifi County, 2024-2025).

Scripts
-------

coral_reef_fish_condition.R
  Fish biomass and community condition indicators for photic coral
  reefs (M1.3). Processes UVC fish survey data from Nov 2024 and
  Jul 2025. Outputs site-level biomass, richness, trophic metrics
  and SEEA EA condition rows.
  Paired with: coral_reef_coral_invert_condition.R

coral_reef_coral_invert_condition.R
  Coral structural condition (cover, health, size structure,
  recruitment) and invertebrate condition (sea urchin, COTS,
  Tridacna, sea cucumber). Produces the main Kenya SEEA EA
  condition account table, multi-period comparison, and
  condition-by-protected-area breakdown.

seagrass_condition.R
  Seagrass meadow (M1.1) biotic condition: cover, species richness,
  shoot density, and canopy height from 2024 field surveys. Exports
  site-level and zone-level health metrics and a SEEA EA condition
  table. Reference values are PROVISIONAL.

mangrove_condition.R
  Mangrove (MFT1.2) structural condition from plot-based surveys
  (Dec 2025, 2,095 rows, 38 plots, 22 sites). Derives 5 biotic
  condition indicators normalised to 0-1.

fisheries_provisioning.R
  Wild fish provisioning service account using the resource rent
  method. Processes fisheries landing data to produce physical
  supply, monetary supply, and ecosystem attribution tables.
  Tier 1 (literature cost ratios); Tier 2 pending fisher cost survey.

_assemble_final_accounts.R
  Assembles individual script outputs into standardised final
  SEEA EA extent and condition account CSVs.

_archive/
  Superseded scripts retained for reference.
  - coral_reef_condition_combined_v1.R (replaced by separate
    fish and coral/invert scripts)

Running order
-------------
1. coral_reef_fish_condition.R
2. coral_reef_coral_invert_condition.R  (optionally joins fish output)
3. seagrass_condition.R
4. mangrove_condition.R
5. fisheries_provisioning.R
6. _assemble_final_accounts.R

All scripts use the here package to resolve paths from the project
root (AFRICA - accounts/). Outputs are written to Kenya/03_outputs/.
