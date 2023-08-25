<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:template match="*[contains(@class, ' pr-d/codeblock ') and contains(@otherprops, 'line-numbers')]">
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
    <xsl:call-template name="spec-title-nospace"/>


    <pre>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="setscale"/>
      <xsl:call-template name="setidaname"/>
      <code>
      	<span class="line-numbers-rows"></span>
        <xsl:apply-templates mode="line-numbers"/>
      </code>
    </pre>
  
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
  </xsl:template>

  <xsl:template match="*" mode="line-numbers">
  	<xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass, 'token')]" mode="line-numbers">
     <xsl:choose>
      <xsl:when test="@keyref and @href">
        <xsl:apply-templates select="." mode="turning-to-link">
          <xsl:with-param name="type" select="'ph'"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:call-template name="commonattributes"/>
          <xsl:call-template name="setidaname"/> 
          <xsl:apply-templates mode="line-numbers"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
      

   <xsl:template match="text()" mode="line-numbers">
    <xsl:choose>
      <xsl:when test="contains(., '&#10;')">
        <!--xsl:value-of select="."/>
        <span class="line-numbers-rows"></span-->

        <xsl:for-each select="tokenize(.,'&#10;')">
          <xsl:sequence select="."/>
          <xsl:if test="not(position() eq last())">
            <xsl:text>&#10;</xsl:text>
            <span class="line-numbers-rows"></span>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
  	   <xsl:value-of select="."/>
     </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' pr-d/codeblock ') and contains(@otherprops, 'line-numbers')]" mode="get-output-class">
    <xsl:text> line-numbers</xsl:text>
    <xsl:next-match/>
  </xsl:template>
</xsl:stylesheet>