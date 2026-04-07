<?xml version="1.0" encoding="UTF-8"?>
<!--
	This file is part of the DITA-OT Prism-JS Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <!-- Default Styling Variables (Allowing Overrides) -->
  <xsl:variable name="prismjs.maintext.color">black</xsl:variable>
  <xsl:variable name="prismjs.background.color">#f5f2f0</xsl:variable>
  <xsl:variable name="prismjs.token.comment.color">slategray</xsl:variable>
  <xsl:variable name="prismjs.token.punctuation.color">#909090</xsl:variable>
  <xsl:variable name="prismjs.token.property.color">#900050</xsl:variable>
  <xsl:variable name="prismjs.token.selector.color">#609000</xsl:variable>
  <xsl:variable name="prismjs.token.operator.color">#9a6e3a</xsl:variable>
  <xsl:variable name="prismjs.token.atrule.color">#0070a0</xsl:variable>
  <xsl:variable name="prismjs.token.function.color">#dd4a68</xsl:variable>
  <xsl:variable name="prismjs.token.regex.color">#e09000</xsl:variable>

  <!-- PrismJS Styling Variables Map for Reflection (Dynamically picking up overrides) -->
  <xsl:variable name="prismjs-settings">
    <entry name="prismjs.maintext.color"><xsl:value-of select="$prismjs.maintext.color"/></entry>
    <entry name="prismjs.background.color"><xsl:value-of select="$prismjs.background.color"/></entry>
    <entry name="prismjs.token.comment.color"><xsl:value-of select="$prismjs.token.comment.color"/></entry>
    <entry name="prismjs.token.punctuation.color"><xsl:value-of select="$prismjs.token.punctuation.color"/></entry>
    <entry name="prismjs.token.property.color"><xsl:value-of select="$prismjs.token.property.color"/></entry>
    <entry name="prismjs.token.selector.color"><xsl:value-of select="$prismjs.token.selector.color"/></entry>
    <entry name="prismjs.token.operator.color"><xsl:value-of select="$prismjs.token.operator.color"/></entry>
    <entry name="prismjs.token.atrule.color"><xsl:value-of select="$prismjs.token.atrule.color"/></entry>
    <entry name="prismjs.token.function.color"><xsl:value-of select="$prismjs.token.function.color"/></entry>
    <entry name="prismjs.token.regex.color"><xsl:value-of select="$prismjs.token.regex.color"/></entry>
  </xsl:variable>

</xsl:stylesheet>
