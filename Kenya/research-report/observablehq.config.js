import MarkdownItFootnote from "markdown-it-footnote";
import MarkdownItKatex from "markdown-it-katex";

export default {
  title: "Kenya Coastal Ecosystem Accounts",

  markdownIt: (md) => md.use(MarkdownItFootnote).use(MarkdownItKatex),

  pages: [
    {name: "Overview", path: "/"},
    {
      name: "Extent Accounts",
      pages: [
        {name: "Mangrove Extent & Condition", path: "/mangrove"},
      ]
    },
    {
      name: "Condition Accounts",
      pages: [
        {name: "Coral Reef Condition", path: "/coral-reef"},
        {name: "Seagrass Condition", path: "/seagrass"},
      ]
    },
    {
      name: "Services & Integration",
      pages: [
        {name: "Fisheries Provisioning", path: "/fisheries"},
        {name: "Cross-Ecosystem Synthesis", path: "/synthesis"},
        {name: "SEEA EA Accounts", path: "/seea-accounts"},
      ]
    },
    {
      name: "Reference",
      pages: [
        {name: "Data Tables", path: "/data-tables"},
        {name: "Methods", path: "/methods"},
        {name: "About", path: "/about"},
      ]
    }
  ],

  head: `<link rel="icon" href="observable.png" type="image/png" sizes="32x32">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css" integrity="sha384-uj2P2BRlhRHt0cojKSRVqpbGN6F39TGsI+AX8CuaUtL6v6ldH8TZvVoNVVV6b3W4" crossorigin="anonymous">`,

  root: "src",

  footer: `Kenya Coastal Ecosystem Accounts - UN SEEA EA Framework. Built with Observable Framework.`,
};
