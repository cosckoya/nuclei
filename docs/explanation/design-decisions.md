# Design Decisions — Explanation

This document explains *why* the `cosckoya/nuclei` repository is organized the way it does, and the rationale behind key architectural choices.

## Directory Structure

### Why `templates/` is split by protocol and category

Nuclei templates are protocol-specific (`http`, `dns`, `ssl`, etc.). Splitting by protocol first keeps related templates together and makes it easy to run a subset:

```bash
nuclei -t templates/http/ -target https://example.com
nuclei -t templates/dns/ -target example.com
```

Categories within each protocol (e.g., `exposed-panels/`, `misconfiguration/`) further group templates by intent, reducing cognitive load when browsing or authoring.

### Why `workflows/` is separate from `templates/`

Workflows chain multiple templates together and have a different schema than individual templates. Keeping them in a top-level `workflows/` directory prevents schema confusion and makes it clear which files are standalone templates versus orchestration logic.

## Configuration

### Why `nuclei-config.yaml` exists

A shared configuration file ensures consistent scan settings (severity, rate limit, output format) across all users and CI runs. It prevents drift between local scans and the GitHub Actions workflow.

### Why JSONL output

JSONL (one JSON object per line) is easy to parse programmatically and append-friendly, making it suitable for CI artifacts and downstream processing.

## Git Workflow

### Why `main` is protected

`main` represents stable, deployable code. Protection rules (required reviews, no force pushes, linear history) prevent accidental or malicious direct pushes that could break scans or introduce vulnerable templates.

### Why `develop` exists

`develop` is the integration branch where features accumulate before a release. This keeps `main` clean and deployable at all times, supporting the Git flow described in [docs/gitflow.md](../gitflow.md).

## Naming

### Why templates are prefixed with `cosckoya-`

The prefix prevents ID collisions with official Nuclei community templates and makes it trivial to identify which templates belong to this project.

## Conventions

### Why Conventional Commits

Commit prefixes (`feat`, `fix`, `docs`, etc.) enable automated changelog generation and make the project history scannable.

### Why `Co-Authored-By: Roy Batty` is mandatory

This repository attributes every commit to `Roy Batty <roy.batty@cosckoya.bot>` as a co-author, per project policy.

## Related Documents

- [docs/gitflow.md](../gitflow.md) — branching model
- [docs/reference/structure.md](structure.md) — directory layout
- [docs/reference/template-authoring.md](template-authoring.md) — YAML schema
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — contribution process
