# Nuclei CI/CD Skill

Provides guidance on setting up and maintaining Nuclei CI/CD scanning pipelines.

## When to use

Use this skill when configuring GitHub Actions, GitLab CI, or other CI/CD pipelines for Nuclei scanning.

## GitHub Actions workflow

See `.github/workflows/nuclei-scan.yml` for the reference implementation.

### Key steps

1. Checkout repository
2. Install Go (≥ 1.27.3)
3. Install Nuclei CLI
4. Validate templates and workflows
5. Update community templates (`nuclei -ut`)
6. Run scan with `-jsonl` and/or `-sarif-export`
7. Upload results as artifact
8. Upload SARIF to GitHub Security (code scanning)

### Workflow triggers

- `schedule` — daily cron scan
- `push` to `main`/`develop` on template changes
- `pull_request` to `main`/`develop` on template changes
- `workflow_dispatch` — manual scan with target/severity inputs

## Output formats

| Format | Flag | Use |
|--------|------|-----|
| JSONL | `-jsonl -o results.jsonl` | Machine-readable results |
| SARIF | `-sarif-export results.sarif` | GitHub Security code scanning |
| Markdown | `-markdown-export report/` | Human-readable reports |

## Rate limiting for CI

```yaml
rate-limit: 150
bulk-size: 25
concurrency: 25
timeout: 10
```

## Environment variables

| Variable | Purpose |
|----------|---------|
| `PDCP_API_KEY` | ProjectDiscovery Cloud API key |
| `GITHUB_TOKEN` | GitHub API token for private template repos |
| `SHODAN_API_KEY` | Shodan API key for uncover integration |

## See also

- [docs/gitflow.md](../../docs/gitflow.md)
- [CONTRIBUTING.md](../../CONTRIBUTING.md)
