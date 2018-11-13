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
        <fo:inline xsl:use-attribute-sets="ph">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="processPrismAttrSetReflection">
                <xsl:with-param name="attrSet" select="replace(@outputclass,'token ','__token__')"/>
                <xsl:with-param name="path" select="'../cfg/fo/attrs/prismjs-attr.xsl'"/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

</xsl:stylesheet>