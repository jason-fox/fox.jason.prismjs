/*
 *  This file is part of the DITA DITA-OT Prism-JS project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

const fs = require('fs')
const myArgs = process.argv.slice(2);
// Load the Prism.js library at runtime.
const prismjsTempFile = require(myArgs[0]);

const outputclass = myArgs[1];
const textFile = myArgs[2];

// Get the grammar regex used to apply highlighting.
const lang = /\blang(?:uage)?-([\w-]+)\b/i;
const language = (outputclass.match(lang) || [null, ""])[1].toLowerCase();
let grammar = Prism.languages[language];

// If no grammar has been found, try again without the language- prefix.
if (!grammar) {
  const lang2 = /\b([\w-]+)\b/i;
  const language2 = (outputclass.match(lang2) || [null, ""])[1].toLowerCase();
  grammar = Prism.languages[language2];
}

function getHighlight(text) {
  // Run the prism highlighter then replace spans with ph elements
  const highlight = grammar
    ? Prism.highlight(text, grammar, language)
    : text;
  return highlight
    .replace(/<span class=/g, '<ph class="- topic/ph " outputclass=')
    .replace(/<\/span>/g, "</ph>")
    .replace(/&amp;gt;/g, '&gt;')
    .replace(/&amp;lt;/g, '&lt;')
}

let text = fs.readFileSync(textFile, 'utf8');

text = text
        .replace(/&amp;/g, "&")
        .replace(/&lt;/g, "<")
        .replace(/&gt;/g, ">");

fs.writeFileSync(textFile, getHighlight(text));

