# API Security Scanning Guide — How-to

This guide explains how to perform API security scanning using Nuclei
with OpenAPI/Swagger specifications.

## Prerequisites

- Nuclei CLI v3.2.0 or later
- OpenAPI/Swagger specification file for your API

## Scan API from OpenAPI Specification

```bash
# Basic API scan
nuclei -l openapi.yaml -im openapi -target https://api.example.com

# Scan with authentication
nuclei -l openapi.yaml -im openapi -vars "X-API-Key=$API_KEY" -target https://api.example.com

# Scan only required parameters
nuclei -l openapi.yaml -im openapi -ro -target https://api.example.com

# Skip optional parameters with missing values
nuclei -l openapi.yaml -im openapi -sfv -target https://api.example.com

# Verbose mode to see skipped parameters
nuclei -l openapi.yaml -im openapi -v -target https://api.example.com
```

## API Security Templates

The following templates are designed for API security scanning:

| Template | Protocol | Detection |
|----------|----------|-----------|
| `cosckoya-dast-sql-injection-fuzz` | HTTP | SQL injection in API parameters |
| `cosckoya-dast-xss-fuzz` | HTTP | XSS in API responses |
| `cosckoya-dast-path-traversal-fuzz` | HTTP | Path traversal in file parameters |
| `cosckoya-dast-command-injection-fuzz` | HTTP | Command injection in API calls |
| `cosckoya-dast-ssrf-fuzz` | HTTP | SSRF in webhook/URL parameters |

## Example API Scan Workflow

```bash
# 1. Detect API technologies
nuclei -t templates/technologies/ -target https://api.example.com

# 2. Run DAST fuzzing against API
nuclei -t templates/dast/ -target https://api.example.com -severity critical,high

# 3. Run with OpenAPI spec
nuclei -l openapi.yaml -im openapi -t templates/dast/ -target https://api.example.com

# 4. Full API scan with all fuzzing
nuclei -l openapi.yaml -im openapi -w workflows/dast-api-scan.yaml -target https://api.example.com
```

## CI/CD Integration for API Scanning

Add this step to your `.github/workflows/dast-pipeline.yml`:

```yaml
- name: Run API DAST scan
  run: |
    nuclei \
      -l openapi.yaml \
      -im openapi \
      -t templates/dast/ \
      -target ${{ env.API_TARGET }} \
      -vars "X-API-Key=${{ secrets.API_KEY }}" \
      -jsonl -o api-scan.jsonl
```

## Related Documents

- [docs/gitflow.md](../gitflow.md) — Branching and PR workflow
- [docs/reference/template-authoring.md](../reference/template-authoring.md) — Writing templates
