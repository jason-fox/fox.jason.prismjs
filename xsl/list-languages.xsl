<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA-OT Prism-JS Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="3.0"
>

  <xsl:param as="xs:string" name="FILES"/>
  <xsl:param as="xs:string" name="PRISM_DEFAULT" select="''"/>
  <xsl:param as="xs:string" name="PRISM_IGNORE" select="'swagger-'"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="languages" as="xs:string*">
      <xsl:for-each select="tokenize($FILES, ';')[normalize-space()]">
        <xsl:for-each
          select="doc(.)//*[contains(@class, ' pr-d/codeblock ') or contains(@class, ' pr-d/codeph ')]"
        >
          <xsl:variable
            name="outputclass"
            select="(@outputclass, ancestor::*[contains(@class, ' topic/body ')]/@outputclass, $PRISM_DEFAULT)[1]"
          />
          <xsl:variable
            name="tagged"
            select="tokenize($outputclass, '\s+')[matches(., '^lang(uage)?-[\w-]+$', 'i')][1]"
          />
          <xsl:variable
            name="short"
            select="if ($tagged) then lower-case(substring-after($tagged, '-')) else lower-case(normalize-space($outputclass))"
          />
          <xsl:if
            test="matches($short, '^[\w-]+$') and not($short = ('none', 'text')) and not(some $prefix in tokenize($PRISM_IGNORE, '[,\s]+')[. != ''] satisfies starts-with($short, $prefix))"
          >
            <xsl:sequence select="$short"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:variable>
    <languages>
      <xsl:for-each select="distinct-values($languages)">
        <xsl:sort select="."/>
        <language><xsl:value-of select="."/></language>
      </xsl:for-each>
    </languages>
  </xsl:template>

</xsl:stylesheet>
