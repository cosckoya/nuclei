# Design Decisions — Explanation

This document explains *why* the `cosckoya/nuclei` repository is organized the way it does, and the rationale behind key architectural choices.

## Directory Structure

### Why `templates/` is split by protocol and category

Nuclei templates are protocol-specific (`http`, `dns`, `ssl`, etc.). Splitting by protocol first keeps related templates together and makes it easy to run a subset:

```bash
nuclei -t templates/http/ -target https://example.com
nuclei -t templates/dns/ -target example.com
```

Categories within each protocol (e.g., `cves/`, `exposures/`) further group templates by intent, reducing cognitive load when browsing or authoring.

### Why `workflows/` is separate from `templates/`

Workflows chain multiple templates together and have a different schema than individual templates. Keeping them separate prevents schema confusion.

## Configuration

### Why `nuclei-config.yaml` exists

A shared configuration file ensures consistent scan settings (severity, rate limit, output format) across all users and CI runs.

### Why JSONL output

JSONL is easy to parse programmatically and append-friendly, suitable for CI artifacts and downstream processing.

## Git Workflow

### Why `main` is protected

`main` represents stable, deployable code. Protection rules prevent accidental or malicious direct pushes.

### Why `develop` exists

`develop` is the integration branch where features accumulate before a release, keeping `main` clean and deployable at all times.

## Naming

### Why templates are prefixed with `cosckoya-`

Prevents ID collisions with official Nuclei community templates and makes project templates identifiable.

## Related Documents

- [docs/gitflow.md](../gitflow.md) — Branching model
- [docs/reference/structure.md](structure.md) — Directory layout
- [docs/reference/template-authoring.md](template-authoring.md) — YAML schema
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — Contribution process
