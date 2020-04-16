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
const name = myArgs[3];
const xtrc = myArgs[4];
const xtrf = myArgs[5];
const clazz = myArgs[6];
const count =  myArgs[7];
const xmlFile =  myArgs[8];


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
    : text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
  return highlight
    .replace(/<span class=/g, '<ph class="- topic/ph " outputclass=')
    .replace(/<\/span>/g, "</ph>")
    .replace(/&amp;<\/ph>gt<ph class="- topic\/ph " outputclass="token punctuation">;/g, '&gt;')
    .replace(/&amp;<\/ph>lt<ph class="- topic\/ph " outputclass="token punctuation">;/g, '&lt;');
}

function getXML(highlight) {
  return "<" + name + ' class="' + clazz + '" outputclass="' + outputclass + 
  '" xtrc="' + xtrc + '" xtrf="' + xtrf + '">' + highlight + "</" + name + ">";
}

if (count > 0) {
  const xml = fs.readFileSync(xmlFile, 'utf8');
  const start = xml.indexOf(">", xml.indexOf('xtrc="'+ xtrc +'"')) + 1;
  const end = xml.indexOf("</"+ name, start);
  let fragment = xml.substring(start, end);
  let highlightedFragment = "";
  let textStart = 0;
  let textEnd = fragment.indexOf("<", textStart);
  while (textStart < fragment.length) {
    highlightedFragment +=getHighlight(fragment.substring(textStart, textEnd))
    textStart = fragment.indexOf(">", textEnd)+1;
    if (fragment.substring(textEnd, textStart).indexOf("<xref") !=-1){
       textStart =  fragment.indexOf("</xref>", textEnd)+7;
    }
    highlightedFragment += fragment.substring(textEnd, textStart);
    textEnd = fragment.indexOf("<", textStart);
    if(textEnd == -1){
      highlightedFragment += getHighlight(fragment.substring(textStart, fragment.length))
      break;
    }
  }
  fs.writeFileSync(textFile, getXML(highlightedFragment));
} else {
  const text = fs.readFileSync(textFile, 'utf8');
  fs.writeFileSync(textFile, getXML(getHighlight(text)));
}
