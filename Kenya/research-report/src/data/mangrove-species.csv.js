import {readFileSync} from "fs";
process.stdout.write(readFileSync("src/data/inputs/KEN_mangrove_species_composition.csv", "utf-8"));
