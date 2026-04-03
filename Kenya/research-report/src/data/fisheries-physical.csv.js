import {readFileSync} from "fs";
process.stdout.write(readFileSync("src/data/inputs/KEN_fisheries_supply_physical.csv", "utf-8"));
