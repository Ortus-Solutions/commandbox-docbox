# 📦 CommandBox DocBox Commands

[![Build Status](https://github.com/Ortus-Solutions/commandbox-docbox/actions/workflows/ci.yml/badge.svg)](https://github.com/Ortus-Solutions/commandbox-docbox/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A CommandBox module for generating API documentation from CFML/BoxLang codebases using [DocBox](https://docbox.ortusbooks.com). Generate beautiful JavaDoc-style reference documentation directly from the command line!

## 🚀 Features

- ✅ Generate API documentation from CFML/BoxLang source code
- ✅ Support for multiple source directories and mappings
- ✅ Multiple output strategies (HTML, JSON, XMI)
- ✅ Customizable project titles and output locations
- ✅ Regex-based exclusion patterns
- ✅ JSON array format for complex mapping scenarios

## 📋 System Requirements

- CommandBox 2.5+

## 📥 Installation

Install the commands via CommandBox:

```bash
box install commandbox-docbox
```

## 💡 Usage

### Basic Usage

Generate documentation with a single source directory:

```bash
docbox generate source=/path/to/coldbox \
	mapping=coldbox \
	excludes=tests \
	strategy-outputDir=/output/path \
	strategy-projectTitle="My Docs"
```

### Multiple Mappings (Dynamic Parameters)

Generate documentation for multiple source directories using dynamic parameters:

```bash
docbox generate mappings:v1.models=/path/to/modules_app/v1/models \
	mappings:v2.models=/path/to/modules_app/v2/models \
	strategy-outputDir=/output/path \
	strategy-projectTitle="My API v1 & v2"
```

### Multiple Mappings (JSON Array)

For complex scenarios, use JSON array format:

```bash
docbox generate \
	source="[{'dir':'../src/modules_app/v1/models', 'mapping':'v1.models'}, {'dir':'../src/modules_app/v2/models', 'mapping':'v2.models'}]" \
	strategy-outputDir=docs \
	strategy-projectTitle="My API"
```

## ⚙️ Command Arguments

| Argument | Description |
|----------|-------------|
| `strategy` | The strategy class to use for generating docs. Default: `docbox.strategy.api.HTMLAPIStrategy` |
| `source` | The directory containing the CFML/BoxLang source code |
| `mapping` | The base mapping for the source folder |
| `excludes` | A regex pattern to exclude files/folders from documentation |
| `mappings:*` | Dynamic parameters defining source and mapping pairs (overrides `source` and `mapping`) |
| `strategy-*` | Any strategy-specific options (e.g., `strategy-outputDir`, `strategy-projectTitle`) |

### Available Strategies

- `docbox.strategy.api.HTMLAPIStrategy` - Generate HTML API documentation (default)
- `docbox.strategy.json.JSONAPIStrategy` - Generate JSON API documentation
- `docbox.strategy.uml2tools.XMIStrategy` - Generate XMI for UML tools

## 🛠️ Development

### Build Scripts

```bash
# Format code
box run-script format

# Watch and auto-format on changes
box run-script format:watch

# Check formatting without changes
box run-script format:check

# Generate API docs
box run-script build:docs

# Full build (source + docs + checksums)
box run-script build:module
```

## 📖 Resources

- 📚 [DocBox Documentation](https://docbox.ortusbooks.com/)
- 🐙 [GitHub Repository](https://github.com/Ortus-Solutions/commandbox-docbox)
- 🐛 [Report Issues](https://github.com/Ortus-Solutions/commandbox-docbox/issues)
- 💬 [Ortus Community Discourse](https://community.ortussolutions.com)

## 📄 License

Apache License, Version 2.0 - See [LICENSE](http://www.apache.org/licenses/LICENSE-2.0)

---

## 🙏 Credits & Contributions

### Contributors

- Brad Wood ([@bdw429s](https://github.com/bdw429s))
- Luis Majano ([@lmajano](https://github.com/lmajano))

### Support Ortus Solutions

This project is maintained by [Ortus Solutions](https://www.ortussolutions.com). Support our open source work!

- 💖 [Become a Patreon](https://www.patreon.com/ortussolutions)
- 💵 [One-time donation via PayPal](https://www.paypal.com/paypalme/ortussolutions)

---

### THE DAILY BREAD

"I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" - John 14:6

---

Built with ❤️ by [Ortus Solutions](https://www.ortussolutions.com)
