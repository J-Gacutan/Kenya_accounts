import MarkdownItFootnote from "markdown-it-footnote";
import MarkdownItKatex from "markdown-it-katex";

export default {
  title: "Madagascar Coral Reef Condition Accounts",

  markdownIt: (md) => md.use(MarkdownItFootnote).use(MarkdownItKatex),

  pages: [
    {name: "Overview", path: "/"},
    {
      name: "Analysis",
      pages: [
        {name: "Condition Analysis", path: "/condition-analysis"},
        {name: "Trophic Composition", path: "/trophic-composition"},
        {name: "Site Comparison", path: "/site-comparison"},
      ]
    },
    {
      name: "Reference",
      pages: [
        {name: "Data Tables", path: "/data-tables"},
        {name: "Methods", path: "/methods"},
      ]
    }
  ],

  head: `<link rel="icon" href="observable.png" type="image/png" sizes="32x32">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css" integrity="sha384-uj2P2BRlhRHt0cojKSRVqpbGN6F39TGsI+AX8CuaUtL6v6ldH8TZvVoNVVV6b3W4" crossorigin="anonymous">`,

  root: "src",

  footer: `Madagascar Coral Reef Condition Accounts -- UN SEEA EA Framework. Built with Observable Framework.`,
};
