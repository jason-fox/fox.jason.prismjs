/*
 *  This file is part of the DITA DITA-OT Prism-JS project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

var outputclass = attributes.get("outputclass");
var text = attributes.get("text");
var name = attributes.get("name");
var id = attributes.get("id");
var clazz = attributes.get("class");
var count = attributes.get("count");
var xml = attributes.get("xml");

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

function getHighlight(text) {
  // Run the prism highlighter then replace spans with ph elements
  var highlight = grammar
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
  return "<" + name + ' class="' + clazz + '" outputclass="' + outputclass + '">' + highlight + "</" + name + ">";
}

if (count > 0) {
  var start = xml.indexOf(">", xml.indexOf('prismId="'+ id +'"')) + 1;
  var end = xml.indexOf("</"+ name, start);
  var fragment = xml.substring(start, end);
  var highlightedFragment = "";
  var textStart = 0;
  var textEnd = fragment.indexOf("<", textStart);
  while (textStart < fragment.length()) {
    highlightedFragment +=getHighlight(fragment.substring(textStart, textEnd))
    textStart = fragment.indexOf(">", textEnd)+1;
    if (fragment.substring(textEnd, textStart).indexOf("<xref") !=-1){
       textStart =  fragment.indexOf("</xref>", textEnd)+7;
    }
    highlightedFragment += fragment.substring(textEnd, textStart);
    textEnd = fragment.indexOf("<", textStart);
    if(textEnd == -1){
      highlightedFragment += getHighlight(fragment.substring(textStart, fragment.length()))
      break;
    }
  }
  project.setProperty(attributes.get("highlighted"), getXML(highlightedFragment));
} else {
  project.setProperty(attributes.get("highlighted"), getXML(getHighlight(text)));
}
