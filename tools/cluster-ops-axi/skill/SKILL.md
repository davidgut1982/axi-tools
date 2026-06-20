---
name: cluster-ops-axi
description: AXI-compliant CLI for Proxmox cluster operations — host status, containers, disk usage, services, journal. Use instead of cluster-ops MCP.
user-invocable: false
---

# cluster-ops-axi

AXI-compliant CLI for your Proxmox cluster. Use this for all infrastructure operations.

## Quick Reference

```shell
cluster-ops-axi                          # Live dashboard (content-first)
cluster-ops-axi dashboard                # Full cluster snapshot
cluster-ops-axi dashboard -g hypervisors # Filter by group
cluster-ops-axi host <name>              # Host drill-down (containers + disks)
cluster-ops-axi service <host> <unit>    # systemd service status
cluster-ops-axi journal <host> <unit>    # Recent logs for a service
```

## Principles

- TOON output (token-optimized, ~40% smaller than JSON)
- Pre-computed aggregates — counts, summaries at a glance
- Contextual next-step suggestions after every command
- Explicit "0 results" on empty state (never ambiguous)
- `--full` for complete output, `--json` for raw data
- `--help` on every subcommand

## Available Groups

- hypervisors, mcp_services, application_services
- media_services, databases, gpu_workloads, latvian_project

## Tips

- Start with `cluster-ops-axi` (no args) for the live overview
- Drill into hosts with `cluster-ops-axi host <alias>`
- Check services when dashboard shows failed_services
- Use `cluster-ops-axi journal <host> <unit>` to debug failures
