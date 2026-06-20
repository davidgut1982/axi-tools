---
name: axi-tools
description: Use AXI CLI tools for cluster operations, knowledge base, observability, project boards, code search, code intelligence, GitHub, and npm. Use instead of raw curl/ssh/grep when an AXI covers the task.
user-invocable: false
---

# AXI Tools

**AXI** (Agent eXecution Interface) tools are lightweight, single-file CLI utilities that replace traditional MCP servers. They produce **TOON** output (Token-Optimized Object Notation) — dense `key: value` pairs and `table[N]{cols}:` format — yielding **~40% fewer tokens** than raw JSON. An AXI call is typically **10-30× smaller** than equivalent SSH/curl/grep tool calls.

## Why Use AXIs Instead of Raw Commands

| Task | Bad (floods context) | Good (AXI) |
|------|---------------------|-------------|
| Check cluster health | `ssh host pvesh get ...` | `cluster-ops-axi status` |
| Search codebase | `grep -r pattern | head` | `vector-indexer-axi search "pattern"` |
| GitHub issues | `gh issue list --json ...` | `gh-axi issue list` |
| Check npm package | `npm view pkg --json` | `npm-axi view pkg` |
| Find symbol usage | `grep -r functionName` | `codeintel-axi references func --path file.ts` |

## Available AXIs

All tools are installed to `~/.local/bin/` and managed via `axi <command>`.

### 1. cluster-ops-axi — Proxmox Cluster Operations
**Commands:** `status`, `containers`, `disk`, `services`, `journal`
**Env:** `CLUSTER_OPS_AXI_URL`
**Use when:** Checking host status, container health, disk usage, systemd services, or logs on the Proxmox cluster.

### 2. lore-axi — Knowledge Base & Journal
**Commands:** `kb-search`, `kb-get`, `kb-list`, `jrnl-today`, `jrnl-search`, `inv-list`, `search-local`
**Env:** `LORE_MCP_URL`
**Use when:** Searching the knowledge base, journal entries, investigations, or local files. Replaces raw lore MCP calls.

### 3. langfuse-axi — LLM Observability
**Commands:** `traces`, `trace`, `prompts`, `prompt`, `status`, `sessions`
**Env:** `LANGFUSE_AXI_URL`, `LANGFUSE_AXI_PK`, `LANGFUSE_AXI_SK`
**Use when:** Debugging LLM traces, inspecting prompts, or checking Langfuse sessions.

### 4. kanban-axi — Project Boards
**Commands:** `board`, `tasks`, `task`, `create`, `update`, `delete`, `boards`, `status`
**Env:** `KANBAN_AXI_URL`, `KANBAN_AXI_TOKEN`
**Use when:** Managing tasks, checking board state, or updating project tracking.

### 5. vector-indexer-axi — Codebase Search
**Commands:** `search`, `semantic`, `hybrid`, `chunks`, `status`, `reindex`
**Env:** `VECTOR_INDEXER_AXI_URL`
**Use when:** Searching 105K+ files and 694K+ chunks. One call replaces 10+ grep/glob/read chains.

### 6. codeintel-axi — Code Intelligence
**Commands:** `symbols`, `callers`, `callees`, `search`, `references`, `index-repo`, `index-status`
**Env:** `CODEINTEL_AXI_CMD`
**Use when:** Finding symbol definitions, callers/callees, or references via LSP. Replaces grep-based code navigation.

### 7. gh-axi — GitHub Operations
**Commands:** `issue`, `pr`, `run`, `release`, `repo`, `label`
**Env:** (none — delegates to `gh` CLI)
**Use when:** Listing/filing issues, reviewing PRs, checking CI runs, managing releases. Prefer over raw `gh` for token-efficient output.

### 8. npm-axi — npm Registry
**Commands:** `search`, `view`, `versions`, `downloads`
**Env:** (none)
**Use when:** Searching for packages, checking versions, download stats. Prefer over raw `npm view` for TOON output.

## Self-Healing: Check Before Using

**Before** invoking an AXI, check if it is installed:

```shell
# Check if a specific AXI exists
which cluster-ops-axi || axi install cluster-ops-axi

# Or list all installed
axi list
```

**If missing**, prompt the user:

> "The `cluster-ops-axi` tool is not installed. Run `axi install cluster-ops-axi` to install it (~50 KB). Once installed, I can use it to check cluster health in ~200 tokens instead of ~4,000+ from raw SSH."

## Prompt Templates

### Cluster Health Check
```
Use cluster-ops-axi to check the current status of all Proxmox hosts.
Run `cluster-ops-axi status` and report any failures.
```

### Code Search
```
Use vector-indexer-axi to search for all references to [symbol].
Run `vector-indexer-axi search "[symbol]"` and summarize the results.
```

### GitHub Issue Lookup
```
Use gh-axi to list open issues labeled "bug" in this repo.
Run `gh-axi issue list --label bug` and report the top 5.
```

### Knowledge Base Query
```
Use lore-axi to search the knowledge base for [topic].
Run `lore-axi kb-search "[topic]"` and present findings.
```

### Code Intelligence
```
Use codeintel-axi to find all callers of [function] in [file].
Run `codeintel-axi callers [function] --path [file]` and list them.
```

### npm Package Check
```
Use npm-axi to check the latest version and license of [package].
Run `npm-axi view [package]` and report the key details.
```

## Quick Install (One-Liner)

```shell
curl -fsSL https://raw.githubusercontent.com/davidgut1982/axi-tools/main/install.sh | bash
axi install --all
```

## Principles

- **Always prefer AXI over raw tools** when an AXI covers the task — fewer tokens, structured output, same result
- **Check installation first** — a missing AXI is a 2-second fix, not a reason to fall back to curl/grep/ssh
- **Use `status` first** — every AXI has a status/health command; run it before deeper queries
- **Read `help[N]` suggestions** — AXIs emit contextual next-step hints after every command
