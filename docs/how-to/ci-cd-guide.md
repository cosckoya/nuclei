# CI/CD Pipeline Guide — How-to

This guide explains how to set up and use the CI/CD pipeline for Nuclei scanning.

## Pipeline Overview

The repository includes two GitHub Actions workflows:

| Workflow | File | Purpose |
|----------|------|---------|
| Nuclei Scan | `.github/workflows/nuclei-scan.yml` | Daily scanning + PR validation |
| Template Validation | `.github/workflows/validate.yml` | Template validation on push/PR |

## Scan Workflow Details

### Triggers

- **Schedule:** Daily at 03:00 UTC
- **Push:** On changes to `templates/`, `workflows/`, or `nuclei-config.yaml` in `main`/`develop`
- **Pull Request:** Same paths for `main`/`develop`
- **Manual:** `workflow_dispatch` with target and severity inputs

### Jobs

1. **validate** — Validates all templates and workflows with `nuclei -validate`
2. **scan** — Runs the full scan with templates, workflows, and SARIF export

### Outputs

| Artifact | Description | Retention |
|----------|-------------|-----------|
| `nuclei-results` | JSONL scan results | 7 days |
| SARIF | GitHub Security code scanning | Integrated |

## Manual Scan

Trigger a manual scan from the GitHub Actions tab:

1. Go to **Actions** → **Nuclei Scan**
2. Click **Run workflow**
3. Enter target URL and minimum severity
4. Click **Run workflow**

## Dependabot

The repository includes Dependabot configuration (`.github/dependabot.yml`) for:

- GitHub Actions dependencies (weekly)
- Go module dependencies (weekly)

Dependabot PRs are created automatically and should be reviewed before merging.

## Related Documents

- [docs/gitflow.md](../gitflow.md) — Branching model
- [.github/dependabot.yml](../../.github/dependabot.yml) — Dependabot config
