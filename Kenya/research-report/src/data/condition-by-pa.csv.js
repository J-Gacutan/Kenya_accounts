import {readFileSync} from "fs";
process.stdout.write(readFileSync("src/data/inputs/KEN_condition_by_pa.csv", "utf-8"));
