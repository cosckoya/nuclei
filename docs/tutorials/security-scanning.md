# Template Security Scanning — Tutorial

This tutorial walks you through scanning a target for security issues using the templates in this repository.

## Step 1 — Identify Your Target

Determine the target you want to scan. Only scan targets you own or have explicit permission to test.

```bash
TARGET=https://your-target.com
```

## Step 2 — Run Technology Detection First

Start by detecting what technologies are running on the target:

```bash
nuclei -c nuclei-config.yaml \
  -t templates/technologies/ \
  -target "${TARGET}"
```

This helps you understand what vulnerability templates are relevant.

## Step 3 — Run Exposure Checks

Check for exposed panels, files, and configurations:

```bash
nuclei -c nuclei-config.yaml \
  -t templates/exposures/ \
  -target "${TARGET}"
```

## Step 4 — Run CVE Scans

Scan for known CVEs:

```bash
nuclei -c nuclei-config.yaml \
  -t templates/cves/ \
  -severity critical,high \
  -target "${TARGET}"
```

## Step 5 — Run Conditional Workflows

Use conditional workflows for targeted scanning:

```bash
nuclei -c nuclei-config.yaml \
  -w workflows/full-scan.yaml \
  -target "${TARGET}"
```

## Step 6 — Save and Review Results

```bash
nuclei -c nuclei-config.yaml \
  -t templates/ \
  -target "${TARGET}" \
  -jsonl -o output/scan-results.jsonl
```

Review the JSONL output or convert to SARIF for GitHub Security:

```bash
nuclei -c nuclei-config.yaml \
  -t templates/ \
  -target "${TARGET}" \
  -sarif-export output/scan-results.sarif
```

## Step 7 — Remediate Findings

For each finding:
1. Verify the finding is a true positive
2. Assess the severity and impact
3. Apply the appropriate remediation
4. Re-scan to confirm the fix

## Related Documents

- [docs/how-to/scanning-guide.md](scanning-guide.md) — Detailed scanning patterns
- [docs/reference/template-authoring.md](../reference/template-authoring.md) — Writing templates
