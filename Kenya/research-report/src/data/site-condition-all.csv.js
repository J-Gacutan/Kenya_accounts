import {readFileSync} from "fs";
process.stdout.write(readFileSync("src/data/inputs/KEN_site_condition_all_indicators.csv", "utf-8"));
