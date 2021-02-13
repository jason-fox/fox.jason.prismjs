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

  <xsl:param as="xs:string" name="CODE_DEST"/>
  <xsl:param as="xs:string" name="DITAFILE"/>

  <!-- IdentityTransform -->
  <xsl:template match="/ | @* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[contains(@class,' pr-d/codeph ') or contains(@class,' pr-d/codeblock ')]">
  	<xsl:variable name="outputclass">
  		<xsl:choose>
  			<xsl:when test="@outputclass">
				<xsl:value-of select="replace(@outputclass, 'language-', '')"/>
			</xsl:when>
			<xsl:when test="ancestor::body/@outputclass">
				<xsl:value-of select="replace(ancestor::body/@outputclass, 'language-', '')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>none</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
  	<xsl:variable name="uid" select="generate-id(.)"/>

  	<xsl:variable name="prismjsfile" select="string-join((
  		$CODE_DEST, 
  		$outputclass,
  		$DITAFILE,
  		concat($uid,'.txt')
  		), '/')"/>


  	<xsl:element name="{name()}">
  		<xsl:attribute name="prismjs">
  			<xsl:value-of select="$prismjsfile"/>
  		</xsl:attribute>
  		<xsl:for-each select="@*">
  			<xsl:attribute name="{name()}">
  				<xsl:value-of select="."/>
  			</xsl:attribute>
  		</xsl:for-each>
  	</xsl:element>  
  	<xsl:result-document method="text" href="{$prismjsfile}" omit-xml-declaration="true">
      <xsl:apply-templates select="node()"/>
    </xsl:result-document>
  </xsl:template>


</xsl:stylesheet>
