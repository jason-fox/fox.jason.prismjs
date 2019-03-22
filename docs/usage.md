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

![](https://jason-fox.github.io/fox.jason.prismjs/prism-pdf.png)

-   to create static HTML with highlighted code snippets run:

```bash
PATH-TO-DITA-OT/bin/dita -f html5 -i document.ditamap  -o out
```

<h4>HTML Result</h4>

![](https://jason-fox.github.io/fox.jason.prismjs/prism-html.png)

## Customizing the output

Prism-JS is easily extended to other languages since it purely relies on regular expressions. A large number of
additional languages are supported - just look at the list on
[https://github.com/PrismJS/prism/tree/master/components](https://github.com/PrismJS/prism/tree/master/components)

<h3>Extending to other languages</h3>

To extend code highlight to other languages, just pick the languages of your choice from the Prism-JS
[download page](https://prismjs.com/download.html#themes=prism&languages=markup+css+clike+javascript) and replace the
existing `resource/prism.js` file

<h3>Altering the static HTML look and feel</h3>

Amend the `resource/style.css` file to alter the look-and-feel of the rendered HTML

<h3>Altering the PDF look and feel</h3>

The `cfg/fo/attrs/prismjs-attr.xsl` provides the colors for the PDF output. The names of the attributes match the CSS
file.
