<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA-OT Prism-JS Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">

  <xsl:param name="PRISM-CSS" select="'prism.css'"/> 

  <xsl:template match="/|node()|@*" mode="gen-prism-style">
     <xsl:variable name="urltest" as="xs:boolean"> <!-- test for URL -->
        <xsl:call-template name="url-string">
          <xsl:with-param name="urltext" select="concat($CSSPATH, $PRISM-CSS)"/>
        </xsl:call-template>
      </xsl:variable>

     <xsl:choose>
        <xsl:when test="$urltest">
          <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$PRISM-CSS}" />
        </xsl:when>
        <xsl:otherwise>
          <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}{$PRISM-CSS}" />
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

  
</xsl:stylesheet>
