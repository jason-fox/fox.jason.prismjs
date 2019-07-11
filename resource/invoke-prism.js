/*
 *  This file is part of the DITA DITA-OT Prism-JS project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

var dir = project.getProperty("dita.plugin.fox.jason.prismjs.dir");
var outputclass = attributes.get("outputclass");
var text = attributes.get("text");
var name = attributes.get("name");
var xtrc = attributes.get("xtrc");
var xtrf = attributes.get("xtrf");
var clazz = attributes.get("class");

// Load the Prism.js library at runtime.
eval(
  "" +
    org.apache.tools.ant.util.FileUtils.readFully(
      new java.io.FileReader(dir + "/resource/prism.js")
    )
);

// Get the grammar regex used to apply highlighting.
var lang = /\blang(?:uage)?-([\w-]+)\b/i;
var language = (outputclass.match(lang) || [, ""])[1].toLowerCase();
var grammar = Prism.languages[language];

// If no grammar has been found, try again without the language- prefix.
if (!grammar) {
  var lang2 = /\b([\w-]+)\b/i;
  var language2 = (outputclass.match(lang2) || [, ""])[1].toLowerCase();
  grammar = Prism.languages[language2];
}

// Run the prism highlighter then replace spans with ph elements
var highlight = grammar
  ? Prism.highlight(text, grammar, language)
  : text
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
highlight = highlight
  .replace(/<span class=/g, '<ph class="- topic/ph " outputclass=')
  .replace(/<\/span>/g, "</ph>");
highlight =
  "<" +
  name +
  ' class="' +
  clazz +
  '" outputclass="' +
  outputclass +
  '" xtrc="' +
  xtrc +
  '" xtrf="' +
  xtrf +
  '">' +
  highlight +
  "</" +
  name +
  ">";

project.setProperty(attributes.get("highlighted"), highlight);
