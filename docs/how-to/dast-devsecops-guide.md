# DevSecOps Pipeline Guide for Nuclei DAST

This guide explains how to integrate Nuclei into your DevSecOps pipeline
as a daily DAST (Dynamic Application Security Testing) tool.

## Pipeline Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    DevSecOps Pipeline                           │
├─────────────────────────────────────────────────────────────────┤
│  1. Validate   →  nuclei -validate -t templates/ -w workflows/ │
│  2. Lint       →  yamllint templates/ workflows/               │
│  3. Scan Quick →  nuclei -tags cve,exposure -severity critical │
│  4. Scan Full  →  nuclei -t templates/ -w workflows/           │
│  5. Scan DAST  →  nuclei -dast -fa medium                      │
│  6. Report     →  SARIF upload + alerts                        │
└─────────────────────────────────────────────────────────────────┘
```

## GitHub Actions Pipeline

The repository includes three CI/CD workflows:

| Workflow | File | Trigger | Purpose |
|----------|------|---------|---------|
| DAST Security Scan | `.github/workflows/dast-pipeline.yml` | Push, PR, Schedule, Manual | Full DAST scanning with SARIF |
| Template Validation | `.github/workflows/validate.yml` | Push, PR | Template validation and linting |
| Template Sync | `.github/workflows/sync-templates.yml` | Weekly, Manual | Sync from projectdiscovery/nuclei-templates |
| Secret Scanning | `.github/workflows/secret-scan.yml` | Push, PR, Schedule | Secret detection with TruffleHog + Gitleaks |

## Pipeline Configuration

### DAST Pipeline Inputs

| Input | Description | Options | Default |
|-------|-------------|---------|---------|
| `target` | Target URL/host | string | https://staging.example.com |
| `scan_type` | Scan type | quick, full, dast | quick |
| `severity` | Minimum severity | critical, high, medium, low, info | high |

### Severity Failure Thresholds

| Severity | Action |
|----------|--------|
| Critical | Block PR / Fail pipeline |
| High | Block PR / Fail pipeline |
| Medium | Warn, require review |
| Low | Log only |
| Info | Log only |

## Template Signing

To ensure template integrity, enable template signing:

```bash
# Generate signing key pair
openssl genpkey -algorithm RSA -out nuclei-signing-key.pem
openssl rsa -pubout -in nuclei-signing-key.pem -out nuclei-signing-key.pub

# Configure signing
export NUCLEI_SIGNATURE_PRIVATE_KEY="$(cat nuclei-signing-key.pem)"
export NUCLEI_SIGNATURE_PUBLIC_KEY="$(cat nuclei-signing-key.pub)"

# Sign all templates
nuclei -sign -t templates/

# Run only signed templates (blocks unsigned)
nuclei -dut -t templates/
```

## Secret Scanning

Two secret scanners are configured:

1. **TruffleHog** - Deep secret scanning across git history
2. **Gitleaks** - Fast secret scanning with custom rules

Configuration:
- `.gitleaks.toml` - Gitleaks rules with allowlist for test keys
- `.github/workflows/secret-scan.yml` - CI/CD secret scanning workflow

## Monitoring and Alerting

Configure alerts in `monitoring-config.yaml`:

```yaml
alerts:
  critical_findings:
    enabled: true
    threshold: 0  # Any critical finding triggers alert
    channels:
      - slack
      - github-issues
      - email
```

## OpenAPI / API Scanning

Scan REST APIs using OpenAPI specifications:

```bash
nuclei -l openapi.yaml -im openapi -target https://api.example.com
nuclei -l openapi.yaml -im openapi -vars "X-API-Key=$KEY" -target https://api.example.com
nuclei -l openapi.yaml -im openapi -ro -target https://api.example.com
```

## Local Development

```bash
# Validate templates
make validate

# Run quick scan
make scan TARGET=https://example.com

# Run full scan with workflows
make scan-all TARGET=https://example.com

# Run DAST fuzzing
make scan-dast TARGET=https://example.com

# Docker scan
make docker-scan TARGET=https://example.com
```

## Related Documents

- [docs/gitflow.md](../gitflow.md) — Branching model
- [docs/how-to/scanning-guide.md](scanning-guide.md) — Scanning patterns
- [docs/how-to/api-scanning-guide.md](api-scanning-guide.md) — API scanning
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — Contribution process
- [SECURITY.md](../../SECURITY.md) — Security policy
