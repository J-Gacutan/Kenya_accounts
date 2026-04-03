import {readFileSync} from "fs";
process.stdout.write(readFileSync("src/data/inputs/KEN_benthic_cover_site.csv", "utf-8"));
