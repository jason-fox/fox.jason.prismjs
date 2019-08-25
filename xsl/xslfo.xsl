<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:import href="../cfg/fo/attrs/prismjs-attr.xsl"/>

    <xsl:template name="processPrismAttrSetReflection">
        <xsl:param name="attrSet"/>
        <xsl:param name="path"/>
        <xsl:apply-templates select="document($path)//xsl:attribute-set[@name = $attrSet]"/>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass, 'token')]">
        <fo:inline xsl:use-attribute-sets="__codeph__language__">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="processPrismAttrSetReflection">
                <xsl:with-param name="attrSet" select="replace(@outputclass,'token ','__token__')"/>
                <xsl:with-param name="path" select="'../cfg/fo/attrs/prismjs-attr.xsl'"/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="*[contains(@class,' pr-d/codeph ') and starts-with(@outputclass, 'language-')]">
        <fo:inline xsl:use-attribute-sets="__codeph__language__">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>


    <xsl:template match="*[contains(@class,' pr-d/codeblock ') and starts-with(@outputclass, 'language-')]">
        <xsl:call-template name="generateAttrLabel"/>
        <fo:block xsl:use-attribute-sets="__codeblock__language__">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="setFrame"/>
            <xsl:call-template name="setScale"/>
            <xsl:call-template name="setExpanse"/>
            <xsl:variable name="codeblock.line-number" as="xs:boolean">
              <xsl:apply-templates select="." mode="codeblock.generate-line-number"/>
            </xsl:variable>
            <xsl:variable name="codeblock.show-whitespace" as="xs:boolean">
              <xsl:apply-templates select="." mode="codeblock.show-whitespace"/>
            </xsl:variable>
            <xsl:variable name="codeblock.whitespace-character.space" as="item()">
              <xsl:apply-templates select="." mode="codeblock.whitespace-character.space"/>
            </xsl:variable>
            <xsl:variable name="codeblock.whitespace-character.tab" as="item()">
              <xsl:apply-templates select="." mode="codeblock.whitespace-character.tab"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$codeblock.wrap or $codeblock.line-number or $codeblock.show-whitespace">
                <xsl:variable name="content" as="node()*">
                  <xsl:apply-templates/>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$codeblock.line-number">
                    <xsl:variable name="buf" as="document-node()">
                      <xsl:document>
                        <xsl:processing-instruction name="line-number"/>
                        <xsl:apply-templates select="$content" mode="codeblock.line-number"/>
                      </xsl:document>
                    </xsl:variable>
                    <xsl:variable name="line-count" select="count($buf/descendant::processing-instruction('line-number'))"/>
                    <xsl:apply-templates select="$buf" mode="codeblock">
                      <xsl:with-param name="line-count" select="$line-count" tunnel="yes"/>
                      <xsl:with-param name="codeblock.show-whitespace" select="$codeblock.show-whitespace" tunnel="yes"/>
                      <xsl:with-param name="codeblock.whitespace-character.space" select="$codeblock.whitespace-character.space" tunnel="yes"/>
                      <xsl:with-param name="codeblock.whitespace-character.tab" select="$codeblock.whitespace-character.tab" tunnel="yes"/>
                    </xsl:apply-templates>    
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="$content" mode="codeblock">
                      <xsl:with-param name="codeblock.show-whitespace" select="$codeblock.show-whitespace" tunnel="yes"/>
                      <xsl:with-param name="codeblock.whitespace-character.space" select="$codeblock.whitespace-character.space" tunnel="yes"/>
                      <xsl:with-param name="codeblock.whitespace-character.tab" select="$codeblock.whitespace-character.tab" tunnel="yes"/>
                    </xsl:apply-templates>
                  </xsl:otherwise>
                </xsl:choose>                
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates/>
              </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>

 

</xsl:stylesheet>