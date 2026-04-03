import {readFileSync} from "fs";
import {globSync} from "fs";
const files = globSync("src/data/inputs/KEN_coral_health_site_*.csv");
const header = readFileSync(files[0], "utf-8").split("\n")[0];
const rows = files.flatMap(f => readFileSync(f, "utf-8").split("\n").slice(1)).filter(r => r.trim());
process.stdout.write(header + "\n" + rows.join("\n") + "\n");
