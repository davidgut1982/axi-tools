# AXI Specification v1.0

An **AXI** (Agent eXecution Interface) is a lightweight, single-file CLI tool that replaces a traditional MCP server. It follows the **TOON** output format for maximum token efficiency.

## Core Principles

1. **One tool, one file** — No dependency tree, no `node_modules`, no virtualenv
2. **TOON output** — `key: value` pairs and `table[N]{cols}:` rows; never raw JSON or unstructured text
3. **Executable anywhere** — Drop into `~/.local/bin/`, run immediately
4. **Self-documenting** — `axi-name --help` returns complete usage
5. **Composable** — Each AXI has a companion ambient context plugin for LLM environments

## CLI Contract

### Help

Every AXI must respond to `--help` (or no arguments) with:
```
axi-name <command> [options]

Commands:
  cmd1        Description
  cmd2        Description

Options:
  --flag      Description

Env: ENV_VAR_NAME
```

### Status

Every AXI must respond to `status` (or `health` or equivalent) with:
```
ok: true
version: 1.0.0
<additional fields as appropriate>
```

### Output

TOON format rules:
- `key: value` for scalar output
- `key[N]{col1,col2}:` followed by rows for table output
- `ok: true` or `ok: false` on every response
- `help[N]:` for actionable next-step hints
- `error:` for failures

### Exit Codes

- `0` — success
- `1` — general error
- `2` — usage error (bad args)

## Manifest Schema

Each tool ships with a `manifest.json`:

```json
{
  "name": "tool-name-axi",
  "version": "1.0.0",
  "description": "One-line description",
  "runtime": "node >= 18 | python >= 3.10 | bash >= 5",
  "dependencies": [],
  "env": {
    "TOOL_AXI_URL": "http://default-host:port/path"
  },
  "commands": [
    {"name": "status", "desc": "Health check"},
    {"name": "search", "desc": "Search", "args": ["<query>", "--limit"]}
  ],
  "plugin": "plugin/axi-tool-name.js",
  "skill": "skill/SKILL.md"
}
```

## Plugin Contract

Ambient context plugins follow the opencode plugin interface and register an `AmbientContextPlugin` that:

1. Spawns `axi-name` on session start
2. Captures its home view output
3. Injects it into the system transform hook

## Directory Layout

```
tools/<name>-axi/
├── bin/<name>-axi          # Executable CLI
├── plugin/axi-<name>.js    # opencode ambient context plugin
├── skill/SKILL.md          # (optional) hermes skill
└── manifest.json           # Machine-readable metadata
```
