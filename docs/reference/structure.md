# Repository Structure — Reference

This document describes the directory structure and conventions used in the `cosckoya/nuclei` repository.

## Top-Level Layout

```text
nuclei/
├── .github/
│   └── workflows/
│       └── nuclei-scan.yml          # CI/CD scanning workflow
├── .gitignore                       # Ignored files (Nuclei output, OS, IDE)
├── nuclei-config.yaml               # Nuclei runner configuration
├── README.md                        # Project landing page
├── LICENSE                          # MIT license text
├── CONTRIBUTING.md                  # Contribution process
├── SECURITY.md                      # Security policy
├── CHANGELOG.md                     # Version history
├── docs/
│   ├── gitflow.md                   # Branching model and PR workflow
│   ├── tutorials/
│   │   └── first-scan.md            # Getting started tutorial
│   ├── how-to/
│   │   └── add-template.md          # How to contribute a template
│   ├── reference/
│   │   ├── structure.md             # This file
│   │   └── template-authoring.md    # YAML schema and naming
│   └── explanation/
│       └── design-decisions.md      # Design rationale
├── templates/                       # Nuclei templates (YAML)
│   └── http/
│       └── exposed-panels/
│           └── grafana-exposed.yaml
└── workflows/                       # Nuclei workflows (YAML)
    └── example.workflow.yaml
```

## `templates/` Directory

Organized by protocol, then category:

```text
templates/
  http/
    exposed-panels/      # Exposed admin panels, dashboards
    misconfiguration/    # HTTP misconfigurations
    vulnerabilities/     # Known CVEs and exposures
  dns/                   # DNS-related templates
  ssl/                   # SSL/TLS templates
  network/               # Network-level templates
```

Template files are named `cosckoya-<kebab-case>.yaml`.

## `workflows/` Directory

Contains Nuclei workflow YAML files that chain multiple templates together.

## `nuclei-config.yaml`

Runner configuration consumed by `nuclei -c nuclei-config.yaml`. Defines:

- Template and workflow paths
- Allowed severity levels
- Output format (JSONL)
- Rate limiting, timeouts, retries

## `.github/workflows/nuclei-scan.yml`

GitHub Actions workflow that runs templates on a schedule and via manual dispatch, uploading results as an artifact.

## Related Documents

- [docs/reference/template-authoring.md](template-authoring.md) — writing templates
- [docs/gitflow.md](../gitflow.md) — contribution workflow
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — contributing to the project
