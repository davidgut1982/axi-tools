# AXI Tools — Agent eXecution Interface

**AXI** (Agent eXecution Interface) is a toolkit of lightweight, single-file CLI tools that replace traditional MCP servers. Each AXI produces **TOON** output (Token-Optimized Object Notation) — yielding ~40% fewer tokens than raw JSON and 10-30× smaller than equivalent SSH/curl/grep calls.

## Quick Install

```shell
curl -fsSL https://raw.githubusercontent.com/davidgut1982/axi-tools/main/install.sh | bash
axi install --all
```

The one-liner downloads the `axi` CLI manager to `~/.local/bin/axi`. Then `axi install --all` fetches all 8 AXIs.

## Available Tools

| Tool | Version | Description | Env Required |
|------|---------|-------------|--------------|
| **cluster-ops-axi** | 1.0.0 | Proxmox cluster operations (containers, disk, services, journal) | `CLUSTER_OPS_AXI_URL` |
| **lore-axi** | 1.0.0 | Knowledge base, journal, investigations, search | `LORE_MCP_URL` |
| **langfuse-axi** | 1.0.0 | LLM observability (traces, prompts, sessions) | `LANGFUSE_AXI_URL`, `LANGFUSE_AXI_PK`, `LANGFUSE_AXI_SK` |
| **kanban-axi** | 1.0.0 | Project boards and task tracking | `KANBAN_AXI_URL`, `KANBAN_AXI_TOKEN` |
| **vector-indexer-axi** | 1.0.0 | Codebase semantic/lexical search (105K files, 694K chunks) | `VECTOR_INDEXER_AXI_URL` |
| **codeintel-axi** | 1.0.0 | LSP-based code intelligence (symbols, callers, callees, references) | `CODEINTEL_AXI_CMD` |
| **gh-axi** | 1.0.0 | GitHub operations (issues, PRs, workflow runs, releases) | — |
| **npm-axi** | 1.0.0 | npm registry search and package inspection | — |

## Usage

```shell
axi install <name>       # Install a specific tool (e.g., axi install gh-axi)
axi install --all         # Install all 8 tools
axi list                  # Show available vs installed
axi update <name>         # Re-download latest version
axi status                # Health-check installed AXIs
axi help                  # Show help
```

## How It Works

Each AXI is a single executable file with **zero dependencies** (Node.js built-ins only). The `axi` manager downloads them from this repo to:

```
~/.local/bin/<name>-axi                    # Executable CLI
~/.config/opencode/plugins/axi-<name>-axi.js   # Ambient context plugin
~/.config/opencode/skills/<name>-axi/SKILL.md  # Hermes skill (if provided)
```

## Why AXIs?

- **Fewer tokens**: TOON format (`key: value`, `table[N]{cols}:`) uses ~40% fewer tokens than JSON
- **Faster**: Single-file, no dependency tree, no virtualenv — runs immediately
- **Self-documenting**: Every AXI responds to `--help` with complete usage
- **Composable**: Ambient context plugins inject AXI output into LLM session context
- **No MCP overhead**: Direct CLI invocation instead of MCP protocol round-trips

## Specifications

See [AXI-SPEC.md](spec/AXI-SPEC.md) for the full specification, including:
- CLI contract (help, status, output format, exit codes)
- Manifest schema
- Plugin contract
- Directory layout conventions

## Contributing a New AXI

1. Create a directory: `tools/<name>-axi/`
2. Add `bin/<name>-axi` — the executable CLI (Node.js, zero deps)
3. Add `plugin/axi-<name>-axi.js` — ambient context plugin (optional)
4. Add `skill/SKILL.md` — hermes skill document (optional)
5. Add to `registry.json`
6. Submit a PR

The CLI must follow the [AXI spec](spec/AXI-SPEC.md):
- Respond to `--help` with usage
- Respond to `status` with `ok: true/false` and `version`
- Use TOON output format
- Exit 0 on success, 1 on error, 2 on usage error

## License

MIT
