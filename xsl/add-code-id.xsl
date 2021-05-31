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

  <xsl:param as="xs:string" name="CODE_DEST"/> 

  <!-- IdentityTransform -->
  <xsl:template match="/ | @* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>

   <xsl:template match="codeph|codeblock">
    <xsl:variable name="prismId" select="generate-id()"/>
    <xsl:variable name="prismjsfile" select="string-join(( $CODE_DEST, concat($prismId,'.xml')), '/')"/>
    <xsl:variable name="prismjslang" select="string-join(( $CODE_DEST, concat($prismId,'.txt')), '/')"/>

    <xsl:variable name="outputclass">
      <xsl:choose>
        <xsl:when test="@outputclass">
           <xsl:value-of select="@outputclass"/>
        </xsl:when>
        <xsl:when test="ancestor::body/@outputclass" >
          <xsl:value-of select="ancestor::body/@outputclass"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>language-markup</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="outputclass2">
      <xsl:text>language-</xsl:text>
      <xsl:value-of select="replace(replace($outputclass, 'language-', ''), 'lang-', '')"/>
    </xsl:variable>


    <xsl:element name="{name()}">
      <!-- process attributes -->
      <xsl:for-each select="@*">
        <xsl:if test="name() != 'outputclass'">
          <xsl:attribute name="{name()}">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:if>
      </xsl:for-each>
      <xsl:attribute name="outputclass">
        <xsl:value-of select="$outputclass2"/>
         <xsl:if test="@scale">
            <xsl:text> scale-</xsl:text>
            <xsl:value-of select="@scale"/>
         </xsl:if>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="$outputclass2='language-none'">
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:when test="$outputclass2='language-text'">
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>@@@</xsl:text>
          <xsl:value-of select="$prismId"/>
          <xsl:text>@@@</xsl:text>

           <xsl:result-document method="xml" href="{$prismjsfile}" omit-xml-declaration="true">
             <xsl:apply-templates select="node()" mode="copy"/>
            </xsl:result-document>

            <xsl:result-document method="text" href="{$prismjslang}" omit-xml-declaration="true">
              <xsl:value-of select="$outputclass"/>
            </xsl:result-document>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>

   
   </xsl:template>

  <xsl:template match="/ | @* | node()" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="copy" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
