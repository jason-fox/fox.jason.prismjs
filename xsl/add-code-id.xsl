<?xml version="1.0" encoding="UTF-8" ?>
<!--
  This file is part of the DITA-OT Prism-JS Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
     xmlns:foo="http://www.foo.org/"
    exclude-result-prefixes="xs dita-ot"
    version="2.0">

   

  <!-- IdentityTransform -->
  <xsl:template match="/ | @* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>

   <xsl:template match="codeph|codeblock">
      <xsl:element name="{name()}">
        <xsl:attribute name="prismId">
          <xsl:value-of select="generate-id()"/>
        </xsl:attribute>
      <!-- process attributes -->
      <xsl:for-each select="@*">
        <xsl:attribute name="{name()}">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:for-each>
      <xsl:if test="not(@outputclass)">
        <xsl:attribute name="outputclass">
          <xsl:value-of select="ancestor::body/@outputclass"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="node()" mode="copy"/>
    </xsl:element>
      
   </xsl:template>

  <xsl:template match="/ | @* | node()" mode="copy">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()" mode="copy" />
      </xsl:copy>
   </xsl:template>

</xsl:stylesheet>
