/*
 *  This file is part of the DITA DITA-OT Prism-JS project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

var outputclass = attributes.get("outputclass");
var text = attributes.get("text");

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

if (text.indexOf("<")) {
  var highlightedFragment = "";
  var textStart = 0;
  var textEnd = text.indexOf("<", textStart);
  while (textStart < text.length) {
    highlightedFragment +=getHighlight(
      text.substring(textStart, textEnd)

    )
    textStart = text.indexOf(">", textEnd)+1;
    if (text.substring(textEnd, textStart).indexOf("<xref") !=-1){
       textStart =  text.indexOf("</xref>", textEnd)+7;
    }
    highlightedFragment += text.substring(textEnd, textStart);
    textEnd = text.indexOf("<", textStart);
    if(textEnd == -1){
      highlightedFragment += getHighlight(
        text.substring(textStart, text.length)
      )
      break;
    }
  }
  project.setProperty(attributes.get("highlighted"), highlightedFragment);
} else {
  project.setProperty(attributes.get("highlighted"), getHighlight(text));
}

