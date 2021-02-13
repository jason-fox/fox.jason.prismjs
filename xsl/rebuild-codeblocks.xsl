<?xml version="1.0" encoding="UTF-8" ?>
<!--
  This file is part of the DITA-OT Translate Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:prismjs="https://prismjs.com/"
    exclude-result-prefixes="xs dita-ot"
    version="2.0">

  <xsl:param name="text-encoding" as="xs:string" select="'UTF-8'"/>
  <xsl:param as="xs:string" name="CODE_DEST"/>
  <xsl:param as="xs:string" name="DITAFILE"/>

  <!-- IdentityTransform -->
  <xsl:template match="/ | @* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[@prismjs]">
  	<xsl:variable name="prismjsfile" select="@prismjs"/>
    <xsl:message>
      <xsl:value-of select="$prismjsfile"/>
    </xsl:message>

  	<xsl:variable name="text" select="unparsed-text($prismjsfile, $text-encoding)"/>
  	<xsl:element name="{name()}">
  		<xsl:for-each select="@*">
  			<xsl:attribute name="{name()}">
  				<xsl:value-of select="."/>
  			</xsl:attribute>
  		</xsl:for-each>
      <xsl:value-of select="$text" disable-output-escaping="no"/>
    </xsl:element>  
  </xsl:template>


</xsl:stylesheet>
