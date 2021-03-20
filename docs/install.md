# Install

The DITA-OT Prism-JS syntax highlighter has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). It is
recommended that you upgrade to the latest version.

## Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" width="55" height="55"></a>

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/3.6/topics/installing-client.html).

    1.  Download the `dita-ot-3.6.1.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable. This defines the
        necessary environment variable to run the `dita` command from the command line.

```bash
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.6.1/dita-ot-3.6.1.zip
unzip -q dita-ot-3.6.1.zip
rm dita-ot-3.6.1.zip
```

## Installing the Plug-in

-   Run the plug-in installation command:

```bash
dita install https://github.com/jason-fox/fox.jason.extend.css/archive/master.zip
dita install https://github.com/jason-fox/fox.jason.prismjs/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

## Installing Node.js

<a href="https://nodejs.org/"><img src="https://nodejs.org/static/images/logos/nodejs-new-pantone-black.svg" align="right" width="60" height="60"></a>

Due to the deprecation and removal of the Nashorn Engine in JDK11-14 [JEP 335](https://openjdk.java.net/jeps/335)
any plug-in using JavaScript within `<script>` or `<scriptdef>` ANT tasks will start throwing warnings with Java
11 onwards and above. From Java 15 onwards, these plugins will no longer work.

The DITA-OT Prism-JS syntax highlighter relies heavily the Prism-JS JavaScript library, and therefore has been updated
to run using [Node.js](https://nodejs.org/) where present on a user's machine. Node.js is a JavaScript runtime built on
Chrome's V8 JavaScript engine.

To download a copy follow the instructions on the [Install Page](https://nodejs.org/en/download/).
