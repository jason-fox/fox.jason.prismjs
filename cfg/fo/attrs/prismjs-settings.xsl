<?xml version="1.0" encoding="UTF-8"?>
<!--
	This file is part of the DITA-OT Prism-JS Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <!-- Default Styling Variables (Allowing Overrides) -->
  <xsl:variable name="prismjs.text.color">black</xsl:variable>
  <xsl:variable name="prismjs.background.color">#f5f2f0</xsl:variable>
  <xsl:variable name="prismjs.comment.color">#909090</xsl:variable>
  <xsl:variable name="prismjs.punctuation.color">slategray</xsl:variable>
  <xsl:variable name="prismjs.namespace.color" select="$prismjs.comment.color"/>
  <xsl:variable name="prismjs.tag.color">#900050</xsl:variable>
  <xsl:variable name="prismjs.string.color">#609000</xsl:variable>
  <xsl:variable name="prismjs.keyword.color">#0070a0</xsl:variable>
  <xsl:variable name="prismjs.type.color">#dd4a68</xsl:variable>
  <xsl:variable name="prismjs.regex.color">#e09000</xsl:variable>
  <xsl:variable name="prismjs.deleted.color">red</xsl:variable>
  <xsl:variable name="prismjs.url.color">#9a6e3a</xsl:variable>

  <!-- PrismJS Styling Variables Map for Reflection (Dynamically picking up overrides) -->
  <xsl:variable name="prismjs-settings">
    <entry name="prismjs.text.color"><xsl:value-of select="$prismjs.text.color"/></entry>
    <entry name="prismjs.background.color"><xsl:value-of select="$prismjs.background.color"/></entry>
    <entry name="prismjs.comment.color"><xsl:value-of select="$prismjs.comment.color"/></entry>
    <entry name="prismjs.punctuation.color"><xsl:value-of select="$prismjs.punctuation.color"/></entry>
    <entry name="prismjs.namespace.color"><xsl:value-of select="$prismjs.namespace.color"/></entry>
    <entry name="prismjs.tag.color"><xsl:value-of select="$prismjs.tag.color"/></entry>
    <entry name="prismjs.string.color"><xsl:value-of select="$prismjs.string.color"/></entry>
    <entry name="prismjs.keyword.color"><xsl:value-of select="$prismjs.keyword.color"/></entry>
    <entry name="prismjs.type.color"><xsl:value-of select="$prismjs.type.color"/></entry>
    <entry name="prismjs.regex.color"><xsl:value-of select="$prismjs.regex.color"/></entry>
    <entry name="prismjs.deleted.color"><xsl:value-of select="$prismjs.deleted.color"/></entry>
    <entry name="prismjs.url.color"><xsl:value-of select="$prismjs.url.color"/></entry>
  </xsl:variable>

</xsl:stylesheet>
