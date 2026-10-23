# Nuclei CI/CD Stack Rule

Standards for Nuclei CI/CD pipeline configuration.

## GitHub Actions

Required steps in scan workflow:

1. Checkout repository (`actions/checkout@v4`)
2. Install Go (`actions/setup-go@v5`, go ≥ 1.27.3)
3. Install Nuclei (`go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest`)
4. Validate templates (`nuclei -validate -t templates/`)
5. Validate workflows (`nuclei -validate -w workflows/`)
6. Run scan with `-jsonl` output
7. Upload results artifact (`actions/upload-artifact@v4`)
8. Optional: SARIF upload to GitHub Security

## Triggers

- `schedule` — daily cron
- `push` to `main`/`develop` on template/workflow/config changes
- `pull_request` to `main`/`develop` on template/workflow/config changes
- `workflow_dispatch` — manual with target/severity inputs

## Output artifacts

| Artifact | Format | Retention |
|----------|--------|-----------|
| `results.jsonl` | JSONL | 7 days |
| `results.sarif` | SARIF | 7 days |

## Rate limits for CI

```yaml
rate-limit: 150
bulk-size: 25
concurrency: 25
timeout: 10
```

## Environment secrets

- `PDCP_API_KEY` — ProjectDiscovery Cloud
- `GITHUB_TOKEN` — auto-provided by GitHub Actions
- `SHODAN_API_KEY` — for uncover integration

## Commit message

```
chore: update CI/CD pipeline
```