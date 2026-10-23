# Scanning Guide — How-to

This guide explains how to run Nuclei scans using the templates and workflows in this repository.

## Prerequisites

- Nuclei CLI installed (Go ≥ 1.27.3)
- A target you own or have permission to scan

```bash
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
```

## Basic Scan Patterns

### Scan all templates against a single target

```bash
nuclei -c nuclei-config.yaml -t templates/ -target https://example.com
```

### Scan with workflows

```bash
nuclei -c nuclei-config.yaml -t templates/ -w workflows/ -target https://example.com
```

### Scan a specific template

```bash
nuclei -t templates/cves/2024/CVE-2024-45046.yaml -target https://example.com
```

### Scan multiple targets from a file

```bash
nuclei -c nuclei-config.yaml -t templates/ -list examples/targets.txt
```

### Scan by severity

```bash
nuclei -c nuclei-config.yaml -t templates/ -severity critical,high -target https://example.com
```

### Scan by tag

```bash
nuclei -c nuclei-config.yaml -t templates/ -tags wordpress -target https://example.com
```

### Scan using the Makefile

```bash
make scan TARGET=https://example.com
make scan-severity SEVERITY=critical TARGET=https://example.com
make scan-tags TAGS=cve TARGET=https://example.com
```

### Scan using Docker

```bash
make docker-build
make docker-scan TARGET=https://example.com
```

### Scan using the wrapper script

```bash
chmod +x scripts/nuclei-scan.sh
./scripts/nuclei-scan.sh -s critical -o results.jsonl https://example.com
./scripts/nuclei-scan.sh -v -u https://example.com
./scripts/nuclei-scan.sh -d https://example.com
```

## Output Formats

| Format | Flag | Command Example |
|--------|------|-----------------|
| JSONL | `-jsonl -o results.jsonl` | Machine-readable, one finding per line |
| SARIF | `-sarif-export results.sarif` | GitHub Security code scanning |
| Markdown | `-markdown-export report/` | Human-readable reports |

## CI/CD Scanning

The repository includes a GitHub Actions workflow (`.github/workflows/nuclei-scan.yml`) that:

1. Validates all templates and workflows
2. Runs a scheduled daily scan
3. Uploads results as artifacts
4. Uploads SARIF to GitHub Security

## Related Documents

- [docs/gitflow.md](../gitflow.md) — Branching and PR workflow
- [docs/reference/template-authoring.md](../reference/template-authoring.md) — Writing templates
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — Contribution process
