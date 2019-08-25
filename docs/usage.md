<h1>Usage</h1>

To highlight the syntax within codeblocks, add an `outputclass` attribute to any `<codeph>` or `<codeblock>` elements in
your `*.dita` files. Alternatively add an `outputclass` attribute to the `<body>` element, and all `<codeph>` or
`<codeblock>` will inherit from it.

With the default Prism-JS
[library](https://prismjs.com/download.html#themes=prism&languages=markup+css+clike+javascript) the following languages
can be highlighted

-   `outputclass="language-markup"` - HTML, XML etc.
-   `outputclass="language-css"` - Cascading Style Sheet highlighting
-   `outputclass="language-clike"` - C-language family highlighting
-   `outputclass="language-javascript"` - JavaScript highlighting
...etc.

e.g.:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "topic.dtd">
<topic id="examples">
  <title>Examples</title>
  <body  outputclass="language-markup">

  <p>The Prism source, highlighted with Prism:</p>
  <codeblock outputclass="language-javascript">
    <coderef href="../src/prism.js"/>
  </codeblock>

  <p>This page’s CSS code, highlighted with Prism:</p>
  <codeblock outputclass="language-css">
    <coderef href="../src/style.css"/>
  </codeblock>

  <p>This page’s HTML, highlighted with Prism:</p>
  <codeblock outputclass="language-html">
    <coderef href="../src/index.html"/>
  </codeblock>

  <p>This page’s logo (SVG), highlighted with Prism:</p>
  <codeblock outputclass="language-markup">
    <coderef href="../src/logo.svg"/>
  </codeblock>
  </body>
</topic>
```

A test document including HTML, CSS and JavaScript code snippets can be found within the plug-in at:
`PATH_TO_DITA_OT/plugins/fox.jason.prismjs/sample`

## Invocation from the command line

The Plug-in extends the existing PDF and HTML transforms

-   to create a PDF with highlighted code snippets run:

```bash
PATH-TO-DITA-OT/bin/dita -f pdf -i document.ditamap  -o out
```

<h4>PDF Result</h4>

<img src="https://jason-fox.github.io/fox.jason.prismjs/prism-pdf.png" align="center" style="border-style:solid; border-width:1px; border-color:#ddd"/>

-   to create static HTML with highlighted code snippets run:

```bash
PATH-TO-DITA-OT/bin/dita -f html5 -i document.ditamap  -o out
```

<h4>HTML Result</h4>

<img src="https://jason-fox.github.io/fox.jason.prismjs/prism-html.png" align="center" style="border-style:solid; border-width:1px; border-color:#ddd"/>

## Customizing the output

Prism-JS is easily extended to other languages since it purely relies on regular expressions. Additional languages are loaded dynamically during processing. A large number of
additional languages are supported - just look at the list on
[https://github.com/PrismJS/prism/tree/master/components](https://github.com/PrismJS/prism/tree/master/components)

<h3>Altering the static HTML look and feel</h3>

Extend with an additional plug-in which overrides the default `prismjs.css.file` property and amend a copy of the `resource/style.css` file to alter the look-and-feel of the rendered HTML


<h4><code>plugin.xml</code> Configuration</h4>

```xml
<plugin id="com.example.prismjs-theme">
  <feature extension="ant.import" file="theme.xml"/>
  <require plugin="fox.jason.extend.css"/>
  <require plugin="fox.jason.prismjs"/>
  <feature extension="extend.css.process.pre" value="prismjs.override.css"/>
</plugin>
```

<h4>ANT Build file: <code>theme.xml</code></h4>

```xml
<project name="com.example.prismjs-theme">
  <target name="prismjs.override.css">
    <property name="prismjs.css.file" value="${dita.plugin.com.example.prismjs-theme.dir}/resource/style.css"/>
  </target>
</project>
```

A working example can be found in the [Dark Theme CSS DITA-OT plug-in](https://github.com/jason-fox/fox.jason.prismjs.dark-theme)


<h3>Altering the PDF look and feel</h3>

The `cfg/fo/attrs/prismjs-attr.xsl` provides the colors for the PDF output. The names of the attributes match the CSS
file, copy and amend the `prismjs-attr.xsl` file in your own plug-in.

<h4><code>plugin.xml</code> Configuration</h4>

```xml
<plugin id="com.example.prismjs-theme">
  <require plugin="fox.jason.prismjs"/>
  <feature extension="dita.xsl.xslfo" value="xsl/xslfo.xsl" type="file"/>
</plugin>
```

<h4><code>xsl/xslfo.xsl</code> XSL Stylesheet</h4>

Override the `<xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass, 'token')]">` template as shown:

```xml
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:param name="PRISM-THEME" select="'com.example.prismjs-theme'"/>

    <xsl:include href="../cfg/fo/attrs/prismjs-attr.xsl"/>

    <xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass, 'token')]">
      <fo:inline xsl:use-attribute-sets="__codeph__language__">
        <xsl:call-template name="commonattributes"/>
        <xsl:call-template name="processPrismAttrSetReflection">
          <xsl:with-param name="attrSet"
            select="replace(@outputclass,'token ','__token__')"/>
          <xsl:with-param name="path" select="concat('../../', concat($PRISM-THEME, '/cfg/fo/attrs/prismjs-attr.xsl'))"/>
        </xsl:call-template>
        <xsl:apply-templates/>
      </fo:inline>
  </xsl:template>
</xsl:stylesheet>
```

A working example can be found in the [Dark Theme CSS DITA-OT plug-in](https://github.com/jason-fox/fox.jason.prismjs.dark-theme)

