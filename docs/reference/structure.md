# Repository Structure — Reference

This document describes the complete directory structure of the `cosckoya/nuclei` repository.

## Top-Level Layout

```text
nuclei/
├── .agentic/                 # OpenCode agent configuration
│   ├── AGENTS.md             # Agent delegation map
│   ├── rules/stacks/         # Stack-specific rules (3)
│   └── skills/               # Skill modules (3)
├── .devcontainer/            # VS Code Codespaces configuration
│   ├── devcontainer.json
│   └── docker-compose.yml
├── .github/
│   ├── ISSUE_TEMPLATE/       # bug_report.md, template_request.md
│   ├── workflows/
│   │   ├── dependabot.yml    # Auto dependency updates
│   │   ├── nuclei-scan.yml   # CI/CD scanning pipeline
│   │   └── validate.yml      # Template validation
│   └── codeql-config.yml     # CodeQL configuration
├── .gitignore                # Git ignore rules
├── .nuclei-ignore            # Nuclei default template exclusions
├── .pre-commit-config.yaml   # Pre-commit hooks
├── .sops.yaml                # SOPS encrypted secrets
├── CLAUDE.md                 # Claude Code / AI agent context
├── CODEOWNERS                # Team ownership
├── CONTRIBUTING.md           # Contribution process
├── Dockerfile                # Containerized Nuclei image
├── LICENSE                   # MIT license
├── Makefile                  # Automation targets
├── README.md                 # Project landing page
├── SECURITY.md               # Security policy
├── SCRIPTS/                  # Automation scripts
│   └── nuclei-scan.sh        # Scan wrapper script
├── examples/                 # Example files
│   ├── targets.txt
│   ├── nuclei-config.yaml.example
│   └── custom-workflow.yaml.example
├── nuclei-config.yaml        # Nuclei runner configuration
├── templates/                # Nuclei templates (YAML)
│   ├── cves/
│   │   ├── 2024/
│   │   └── 2025/
│   ├── exposures/
│   │   ├── panels/
│   │   └── files/
│   ├── misconfiguration/
│   │   ├── cloud/
│   │   └── web/
│   ├── technologies/
│   │   ├── webservers/
│   │   ├── cms/
│   │   ├── monitoring/
│   │   └── databases/
│   └── vulnerabilities/
│       ├── auth/
│       ├── injection/
│       └── xss/
├── workflows/                # Nuclei workflows (YAML)
│   ├── full-scan.yaml
│   ├── critical-cves.yaml
│   ├── exposure-scan.yaml
│   ├── wordpress-scan.yaml
│   └── jira-scan.yaml
└── docs/                     # Diátaxis documentation
    ├── gitflow.md
    ├── tutorials/
    ├── how-to/
    ├── reference/
    └── explanation/
```

## Template Directory Categories

| Category | Description |
|----------|-------------|
| `cves/` | Known CVE vulnerability templates by year |
| `exposures/panels/` | Exposed admin panels and dashboards |
| `exposures/files/` | Exposed configuration and sensitive files |
| `misconfiguration/cloud/` | Cloud misconfigurations (AWS, Azure, GCP) |
| `misconfiguration/web/` | Web misconfigurations (open redirect, etc.) |
| `technologies/webservers/` | Web server detection |
| `technologies/cms/` | CMS detection (WordPress, etc.) |
| `technologies/monitoring/` | Monitoring tools (Grafana, etc.) |
| `technologies/databases/` | Database detection (MySQL, PostgreSQL, Redis) |
| `vulnerabilities/auth/` | Authentication vulnerabilities |
| `vulnerabilities/injection/` | Injection vulnerabilities (SQLi, etc.) |
| `vulnerabilities/xss/` | Cross-site scripting vulnerabilities |

## Related Documents

- [docs/reference/template-authoring.md](template-authoring.md) — YAML schema
- [docs/gitflow.md](../gitflow.md) — Contribution workflow
