# DocBox Commands

DocBox Commands is a custom command you can install into CommandBox to generate API docs from the commandline.  Documentation for DocBox can be found on the [GitHub Wiki][1] and in this Readme. The main Git repository and downloads can be found on [GitHub][2].  There is also a help forum located at https://groups.google.com/a/ortussolutions.com/forum/#!forum/docbox

## LICENSE

Apache License, Version 2.0.

## SYSTEM REQUIREMENTS

- CommandBox 2.5+

## Installation

Install the commands via CommandBox like so:

```bash
box install commandbox-docbox
```

## Usage

Creates documentation for CFCs JavaDoc style via DocBox

You can pass the strategy options by prefixing them with `strategy-`. So if a strategy takes in a property of `outputDir` you will pass it as `strategy-outputdir=`

Examples:

```bash
docbox generate source=/path/to/coldbox mapping=coldbox excludes=tests strategy-outputDir=/output/path strategy-projectTitle="My Docs"
```

Multiple source mappings may be specified.

```bash
docbox generate source="[{'dir':'../src/modules_app/v1/models', 'mapping':'v1.models'}, {'dir':'../src/modules_app/v2/models', 'mapping':'v2.models'}]" strategy-outputDir=docbox strategy-projectTitle="My API"
```

Arguments:
* strategy - The strategy class to use to generate the docs.
* source - Either, the string directory source, OR a JSON array of structs containing 'dir' and 'mapping' key
* mapping - The base mapping for the folder. Only required if the source is a string
* excludes - A regex that will be applied to the input source to exclude from the docs

----

## CREDITS & CONTRIBUTIONS

I THANK GOD FOR HIS WISDOM FOR THIS PROJECT

### THE DAILY BREAD

"I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12

[1]: https://github.com/Ortus-Solutions/DocBox/wiki
[2]: https://github.com/Ortus-Solutions/DocBox