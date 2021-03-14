/*
 *  This file is part of the DITA DITA-OT Prism-JS project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

var outputclass = attributes.get("outputclass");
var codeDITA = attributes.get("text");

// Load the Prism.js library at runtime.
eval(
  "" +
    org.apache.tools.ant.util.FileUtils.readFully(
      new java.io.FileReader(project.getProperty("prismjs.temp.file"))
    )
);

// Get the grammar regex used to apply highlighting.
var lang = /\blang(?:uage)?-([\w-]+)\b/i;
var language = (outputclass.match(lang) || [null, ""])[1].toLowerCase();
var grammar = Prism.languages[language];

// If no grammar has been found, try again without the language- prefix.
if (!grammar) {
  var lang2 = /\b([\w-]+)\b/i;
  var language2 = (outputclass.match(lang2) || [null, ""])[1].toLowerCase();
  grammar = Prism.languages[language2];
}

function getHighlight(xml) {
  // Run the prism highlighter then replace spans with ph elements
  var text = xml.replace(/&amp;/g, "&")
        .replace(/&lt;/g, "<")
        .replace(/&gt;/g, ">")

  var highlight = grammar
    ? Prism.highlight(text, grammar, language)
    : text;
  return highlight
    .replace(/<span class=/g, '<ph class="- topic/ph " outputclass=')
    .replace(/<\/span>/g, "</ph>")
    .replace(/&amp;gt;/g, '&gt;')
    .replace(/&amp;lt;/g, '&lt;')
}

if (codeDITA.indexOf("<")) {
  var highlightedFragment = "";
  var textStart = 0;
  var textEnd = codeDITA.indexOf("<", textStart);
  while (textStart < codeDITA.length) {
    highlightedFragment +=getHighlight(
      codeDITA.substring(textStart, textEnd)

    )
    textStart = codeDITA.indexOf(">", textEnd)+1;
    if (codeDITA.substring(textEnd, textStart).indexOf("<xref") !=-1){
       textStart =  codeDITA.indexOf("</xref>", textEnd)+7;
    }
    highlightedFragment += codeDITA.substring(textEnd, textStart);
    textEnd = codeDITA.indexOf("<", textStart);
    if(textEnd == -1){
      highlightedFragment += getHighlight(
        codeDITA.substring(textStart, codeDITA.length)
      )
      break;
    }
  }
  project.setProperty(attributes.get("highlighted"), highlightedFragment);
} else {
  project.setProperty(attributes.get("highlighted"), getHighlight(codeDITA));
}

