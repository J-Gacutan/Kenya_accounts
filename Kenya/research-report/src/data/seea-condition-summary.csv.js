import {readFileSync} from "fs";
process.stdout.write(readFileSync("src/data/inputs/KEN_seea_condition_summary.csv", "utf-8"));
