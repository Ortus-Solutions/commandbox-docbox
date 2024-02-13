# DocBox Commands

DocBox Commands is a custom command you can install into CommandBox to generate API (reference) documentation from the commandline. For the main DocBox project, see [DocBox on GitHub][1] or the [DocBox usage documentation][2].

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
Multiple mappings may be specified, where the key is the mapping and the value is the source directory. For example, the following generates documentation for two different versions of a model:
```bash
docbox generate mappings:v1.models=/path/to/modules_app/v1/models mappings:v2.models=/path/to/modules_app/v2/models strategy-outputDir=/output/path strategy-projectTitle="My Docs"
```

Arguments:

- `strategy` - The strategy class to use to generate the docs.
- `source` - The directory containing the CFML source.
- `mapping` - The base mapping for the source folder.
- `excludes` - A regex that will be applied to the input source to exclude from the docs.
- `mappings:*` - One or more dynamic parameters defining source and mapping. This argument will override `source` and `mapping` if provided.


----

# CREDITS & CONTRIBUTIONS

I THANK GOD FOR HIS WISDOM FOR THIS PROJECT

## THE DAILY BREAD

"I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12

[1]: https://docbox.ortusbooks.com/
[2]: https://github.com/Ortus-Solutions/DocBox
