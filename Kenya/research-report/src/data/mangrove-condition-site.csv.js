import {readFileSync} from "fs";
process.stdout.write(readFileSync("src/data/inputs/KEN_mangrove_condition_by_site.csv", "utf-8"));
