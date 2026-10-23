# First Scan — Tutorial

This tutorial walks you through your first Nuclei scan using the templates in this repository. No prior Nuclei experience is required.

## Prerequisites

- Go installed (for installing Nuclei)
- A target URL or host you have permission to scan

> ⚠️ Only scan targets you own or have explicit written permission to test.

## Step 1 — Install Nuclei

```bash
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
```

Verify the installation:

```bash
nuclei -version
```

## Step 2 — Clone this repository

```bash
git clone https://github.com/cosckoya/nuclei.git
cd nuclei
```

## Step 3 — Run your first template

Scan a target with the Grafana exposed panel template:

```bash
nuclei -t templates/http/exposed-panels/grafana-exposed.yaml -target https://example.com
```

Expected output includes the template ID, severity, and matched endpoint.

## Step 4 — Run all templates

Scan a target with every template in the repository:

```bash
nuclei -t templates/ -target https://example.com
```

## Step 5 — Run with project configuration

Use the included `nuclei-config.yaml` for consistent settings:

```bash
nuclei -c nuclei-config.yaml -target https://example.com
```

## Step 6 — Interpret results

Nuclei output shows:

| Field | Meaning |
|-------|---------|
| `[medium]` | Severity level |
| `cosckoya-grafana-exposed-panel` | Template ID |
| `https://example.com/login` | Matched endpoint |

Results can be saved to JSONL:

```bash
nuclei -t templates/ -target https://example.com -jsonl -o results.jsonl
```

## Next Steps

- Read [docs/how-to/add-template.md](how-to/add-template.md) to contribute a new template.
- Read [docs/gitflow.md](../gitflow.md) to understand the contribution workflow.
- Review [CONTRIBUTING.md](../../CONTRIBUTING.md) for template authoring standards.
