<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!--
	This file is part of the DITA-OT Prism-JS Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:rx="http://www.renderx.com/XSL/Extensions"
  version="2.0"
>

	<xsl:import href="prismjs-settings.xsl"/>

	<!-- prismjs attribute sets -->

	<xsl:attribute-set name="__codeblock__language__" use-attribute-sets="codeblock">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.text.color"/></xsl:attribute>
		<xsl:attribute name="background-color"><xsl:value-of select="$prismjs.background.color"/></xsl:attribute>
		<xsl:attribute name="font-weight"><xsl:value-of select="$prismjs.font-weight"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__codeph__language__" use-attribute-sets="codeph">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.text.color"/></xsl:attribute>
		<!--xsl:attribute name="background-color"><xsl:value-of select="$prismjs.background.color"/></xsl:attribute-->
		<xsl:attribute name="font-weight"><xsl:value-of select="$prismjs.font-weight"/></xsl:attribute>
	</xsl:attribute-set>

	<!-- comments, doctype, cdata, prolog -->
	<xsl:attribute-set name="__token__comment">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.comment.color"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__block-comment" use-attribute-sets="__token__comment">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__prolog" use-attribute-sets="__token__comment">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__doctype" use-attribute-sets="__token__comment">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__cdata" use-attribute-sets="__token__comment">
	</xsl:attribute-set>

	<!-- punctuation -->
	<xsl:attribute-set name="__token__punctuation">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.punctuation.color"/></xsl:attribute>
	</xsl:attribute-set>

	<!-- namespace -->
	<xsl:attribute-set name="__token__namespace">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.namespace.color"/></xsl:attribute>
	</xsl:attribute-set>

	<!-- booleans, constants, numbers, properties, symbols, tags -->
	<xsl:attribute-set name="__token__tag">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.tag.color"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__macro" use-attribute-sets="__token__tag">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__boolean" use-attribute-sets="__token__tag">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__constant" use-attribute-sets="__token__tag">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__number" use-attribute-sets="__token__tag">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__property" use-attribute-sets="__token__tag">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__symbol" use-attribute-sets="__token__tag">
	</xsl:attribute-set>

	<!-- attr-names, builtins, chars, inserted, selectors, strings, variables -->
	<xsl:attribute-set name="__token__string">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.string.color"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__attr-name" use-attribute-sets="__token__string">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__builtin" use-attribute-sets="__token__string">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__char" use-attribute-sets="__token__string">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__inserted" use-attribute-sets="__token__string">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__selector" use-attribute-sets="__token__string">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__variable" use-attribute-sets="__token__string">
	</xsl:attribute-set>

	<!-- atrules, attr-values, keywords -->
	<xsl:attribute-set name="__token__keyword">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.keyword.color"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__atrule" use-attribute-sets="__token__keyword">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__attr-value" use-attribute-sets="__token__keyword">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__directive" use-attribute-sets="__token__keyword">
	</xsl:attribute-set>

	<!-- class names, functions -->
	<xsl:attribute-set name="__token__function">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.type.color"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__class-name" use-attribute-sets="__token__function">
	</xsl:attribute-set>

	<!-- important, regex -->
	<xsl:attribute-set name="__token__regex">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.regex.color"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__important" use-attribute-sets="__token__regex">
	</xsl:attribute-set>

	<!-- deleted -->
	<xsl:attribute-set name="__token__deleted">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.deleted.color"/></xsl:attribute>
	</xsl:attribute-set>

	<!-- operators, entities, urls -->
	<xsl:attribute-set name="__token__operator">
		<xsl:attribute name="color"><xsl:value-of select="$prismjs.url.color"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__entity" use-attribute-sets="__token__operator">
	</xsl:attribute-set>
	<xsl:attribute-set name="__token__url" use-attribute-sets="__token__operator">
	</xsl:attribute-set>

</xsl:stylesheet>
