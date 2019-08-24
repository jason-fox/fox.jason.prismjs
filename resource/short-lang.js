/*
 *  This file is part of the DITA DITA-OT Prism-JS project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

var outputclass = attributes.get("outputclass");
var defaultLang = attributes.get("default");
var property = attributes.get("property");


var lang = /\blang(?:uage)?-([\w-]+)\b/i;
var language = (outputclass.match(lang) || [, ""])[1].toLowerCase();

if (language === ""){
	language = outputclass;
}

project.setProperty(property, language === "" ? defaultLang : language);