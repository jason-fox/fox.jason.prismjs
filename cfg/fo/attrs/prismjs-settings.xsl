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
  <xsl:variable name="prismjs.tag.color">#900050</xsl:variable>
  <xsl:variable name="prismjs.name.color">#609000</xsl:variable>
  <xsl:variable name="prismjs.url.color">#9a6e3a</xsl:variable>
  <xsl:variable name="prismjs.string.color">#0070a0</xsl:variable>
  <xsl:variable name="prismjs.function.color">#dd4a68</xsl:variable>
  <xsl:variable name="prismjs.keyword.color">#e09000</xsl:variable>

  <!-- PrismJS Styling Variables Map for Reflection (Dynamically picking up overrides) -->
  <xsl:variable name="prismjs-settings">
    <entry name="prismjs.text.color"><xsl:value-of select="$prismjs.text.color"/></entry>
    <entry name="prismjs.background.color"><xsl:value-of select="$prismjs.background.color"/></entry>
    <entry name="prismjs.comment.color"><xsl:value-of select="$prismjs.comment.color"/></entry>
    <entry name="prismjs.punctuation.color"><xsl:value-of select="$prismjs.punctuation.color"/></entry>
    <entry name="prismjs.tag.color"><xsl:value-of select="$prismjs.tag.color"/></entry>
    <entry name="prismjs.name.color"><xsl:value-of select="$prismjs.name.color"/></entry>
    <entry name="prismjs.url.color"><xsl:value-of select="$prismjs.url.color"/></entry>
    <entry name="prismjs.string.color"><xsl:value-of select="$prismjs.string.color"/></entry>
    <entry name="prismjs.function.color"><xsl:value-of select="$prismjs.function.color"/></entry>
    <entry name="prismjs.keyword.color"><xsl:value-of select="$prismjs.keyword.color"/></entry>
  </xsl:variable>

</xsl:stylesheet>
