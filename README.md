# Prism-JS for DITA-OT [<img src="https://jason-fox.github.io/fox.jason.prismjs/prismjs.png" align="right" width="300">](https://prismjsdita-ot.rtfd.io/)

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.prismjs.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 3.4](https://img.shields.io/badge/DITA--OT-3.4-blue.svg)](http://www.dita-ot.org/3.4)
[![Build Status](https://travis-ci.org/jason-fox/fox.jason.prismjs.svg?branch=master)](https://travis-ci.org/jason-fox/fox.jason.prismjs)
[![Coverage Status](https://coveralls.io/repos/github/jason-fox/fox.jason.prismjs/badge.svg?branch=master)](https://coveralls.io/github/jason-fox/fox.jason.prismjs?branch=master)
[![Documentation Status](https://readthedocs.org/projects/prismjsdita-ot/badge/?version=latest)](https://prismjsdita-ot.readthedocs.io/en/latest/?badge=latest)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=fox.jason.prismjs&metric=alert_status)](https://sonarcloud.io/dashboard?id=fox.jason.prismjs)

This is a syntax highlighting [DITA-OT Plug-in](https://www.dita-ot.org/plugins) which integrates the flexible [Prism-JS](https://github.com/PrismJS/prism)
highlighting library into the DITA Open Toolkit engine. This enables the generation of documents including code snippets
which are automatically colorized according to language syntax. The plug-in extends both static HTML and PDF transtypes.

> ![](https://jason-fox.github.io/fox.jason.prismjs/highlighted.png)

:arrow_forward: [Video from DITA-OT Day 2019](https://youtu.be/vobY_ha5nd0)

[![](https://jason-fox.github.io/fox.jason.prismjs/javascript-video.png)](https://youtu.be/vobY_ha5nd0)

<details>
<summary><strong>Table of Contents</strong></summary>

-   [Background](#background)
    -   [What is Prism-JS?](#what-is-prism-js)
-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
-   [Usage](#usage)
    -   [Invocation from the command line](#invocation-from-the-command-line)
        -   [Result](#result)
    -   [Customizing the output](#customizing-the-output)
        -   [Extending to other languages](#extending-to-other-languages)
        -   [Altering the static HTML look and feel](#altering-the-static-html-look-and-feel)
        -   [Altering the PDF look and feel](#altering-the-pdf-look-and-feel)
-   [License](#license)

</details>

## Background

### What is Prism-JS?

<a href="http://prismjs.com"><img src="https://pbs.twimg.com/profile_images/2451426554/Screen_Shot_2012-07-31_at_21.57.03__400x400.png" align="right" height="70"></a>


Prism is a lightweight, robust, elegant syntax highlighting library. It's a spin-off project from
[Dabblet](http://dabblet.com/).

-   Highlights embedded languages (e.g. CSS inside HTML, JavaScript inside HTML)
-   Highlights inline code (`<codeph>`) as well, not just code blocks (`<codeblock>`)
-   Highlights nested languages (CSS in HTML, JavaScript in HTML)
-   It doesn’t force you to use any Prism-specific markup

You can learn more on http://prismjs.com/.

Why another syntax highlighter?:
http://lea.verou.me/2012/07/introducing-prism-an-awesome-new-syntax-highlighter/#more-1841

---

## Install

The DITA-OT Prism-JS syntax highlighter has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). It is
recommended that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

The DITA-OT Prism-JS syntax highlighter is a plug-in for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/3.4/topics/installing-client.html).

    1.  Download the `dita-ot-3.4.1.zip` package from the project website at [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.4.1/dita-ot-3.4.1.zip
unzip -q dita-ot-3.4.1.zip
rm dita-ot-3.4.1.zip
```

### Installing the Plug-in

-   Run the plug-in installation commands:

```console
dita --install https://github.com/doctales/org.doctales.xmltask/archive/master.zip
dita --install https://github.com/jason-fox/fox.jason.extend.css/archive/master.zip
dita --install https://github.com/jason-fox/fox.jason.prismjs/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

---

## Usage

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
... etc.

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

### Invocation from the command line

The Plug-in extends the existing PDF and HTML transforms

-   to create a PDF with highlighted code snippets run:

```console
PATH-TO-DITA-OT/bin/dita -f pdf -i document.ditamap  -o out
```

#### Result

![](https://jason-fox.github.io/fox.jason.prismjs/prism-pdf.png)

-   to create static HTML with highlighted code snippets run:

```console
PATH-TO-DITA-OT/bin/dita -f html5 -i document.ditamap  -o out
```

#### Result

![](https://jason-fox.github.io/fox.jason.prismjs/prism-html.png)

### Customizing the output

Prism-JS is easily extended to other languages since it purely relies on regular expressions. Additional languages are loaded dynamically during processing. A large number of
additional languages are supported - just look at the list on https://github.com/PrismJS/prism/tree/master/components


#### Altering the static HTML look and feel

Extend with an additional plug-in which overrides the default `prismjs.css.file` property and amend a copy of the `resource/style.css` file to alter the look-and-feel of the rendered HTML


##### `plugin.xml` Configuration

```xml
<plugin id="com.example.prismjs-theme">
  <feature extension="ant.import" file="theme.xml"/>
  <require plugin="fox.jason.extend.css"/>
  <require plugin="fox.jason.prismjs"/>
  <feature extension="extend.css.process.pre" value="prismjs.override.css"/>
</plugin>
```

##### ANT Build file: `theme.xml`

```xml
<project name="com.example.prismjs-theme">
  <target name="prismjs.override.css">
    <property name="prismjs.css.file" value="${dita.plugin.com.example.prismjs-theme.dir}/resource/style.css"/>
  </target>
</project>
```

A working example can be found in the [Dark Theme CSS DITA-OT plug-in](https://github.com/jason-fox/fox.jason.prismjs.dark-theme)

#### Altering the PDF look and feel

The `cfg/fo/attrs/prismjs-attr.xsl` provides the colors for the PDF output. The names of the attributes match the CSS
file, copy and amend the `prismjs-attr.xsl` file in your own plug-in.

##### `plugin.xml` Configuration

```xml
<plugin id="com.example.prismjs-theme">
  <require plugin="fox.jason.prismjs"/>
  <feature extension="dita.xsl.xslfo" value="xsl/xslfo.xsl" type="file"/>
</plugin>
```

##### `xsl/xslfo.xsl` XSL Stylesheet

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

> ![](https://jason-fox.github.io/fox.jason.prismjs/highlighted-dark.png)

## License

[Apache 2.0](LICENSE) © 2018-2019 Jason Fox

The Program includes the following additional software components which were obtained under license:

-   prism.js - https://github.com/PrismJS/prism/ - **MIT license**
-   xmltask.jar - http://www.oopsconsultancy.com/software/xmltask/ - **Apache 1.1 license** (within `org.doctales.xmltask` plug-in)
