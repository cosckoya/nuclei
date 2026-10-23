# 🎯 Nuclei Templates

Custom Nuclei security scanning templates for the cosckoya ecosystem.

[![Nuclei](https://img.shields.io/badge/Nuclei-templates-blue?logo=go)](https://github.com/projectdiscovery/nuclei)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Go >= 1.27](https://img.shields.io/badge/Go-%3E%3D1.27-blue?logo=go)](https://go.dev/)

---

## What is this?

A curated collection of [Nuclei](https://github.com/projectdiscovery/nuclei) templates and workflows for scanning misconfigurations, exposed panels, CVEs, and cloud exposures.

Think of it as a locksmith's toolkit — each template is a precision pick for a specific lock. From CVE detection to exposed panels and cloud misconfigurations, every template follows the [cosckoya naming convention](#template-conventions).

---

## 🚀 Quick Start

### 1. Install Nuclei (Go ≥ 1.27.3)

```bash
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
```

### 2. Clone this repo

```bash
git clone https://github.com/cosckoya/nuclei.git
cd nuclei
```

### 3. Run your first scan

```bash
# Scan with all templates in this repo
nuclei -c nuclei-config.yaml -t templates/ -target https://example.com

# Scan with templates + workflows
nuclei -c nuclei-config.yaml -t templates/ -w workflows/ -target https://example.com

# Scan a single template
nuclei -t templates/cves/2024/CVE-2024-45046.yaml -target https://example.com

# Scan by severity
nuclei -c nuclei-config.yaml -t templates/ -severity critical,high -target https://example.com

# Scan by tag
nuclei -c nuclei-config.yaml -t templates/ -tags wordpress -target https://example.com
```

### 4. Use AI-powered template generation (Nuclei v3)

```bash
nuclei -auth  # Configure your ProjectDiscovery API key
nuclei -list targets.txt -ai "Find exposed admin panels"
nuclei -list targets.txt -ai "Detect stack traces in error responses"
```

---

## 📦 What's Inside

| Directory | Contents |
|-----------|----------|
| `templates/cves/` | CVE vulnerability templates (2024, 2025, ...) |
| `templates/exposures/` | Exposed panels and services |
| `templates/misconfiguration/` | Cloud and web misconfigurations |
| `templates/technologies/` | CMS and service detection |
| `workflows/` | Conditional and chained scan workflows |
| `docs/` | Diátaxis documentation suite |
| `.github/workflows/` | CI/CD scanning pipeline |

### Example template

```yaml
id: cosckoya-cve-2024-45046
info:
  name: Apache OFBiz Path Traversal (CVE-2024-45046)
  author: cosckoya
  severity: critical
  description: Path traversal leading to RCE in Apache OFBiz
  tags: cve,cve2024,ofbiz,rce,apache
http:
  - method: GET
    path:
      - "{{BaseURL}}/framework/minimal/generators/export.jsp?filename=../../../../../../etc/passwd"
    matchers:
      - type: word
        words: ["root:x:"]
        part: body
```

---

## 📚 Documentation

| You want to... | Go to... |
|----------------|----------|
| Run your first scan | [docs/tutorials/first-scan.md](docs/tutorials/first-scan.md) |
| Add a new template | [docs/how-to/add-template.md](docs/how-to/add-template.md) |
| Understand the layout | [docs/reference/structure.md](docs/reference/structure.md) |
| Write a template (YAML schema) | [docs/reference/template-authoring.md](docs/reference/template-authoring.md) |
| Learn the design rationale | [docs/explanation/design-decisions.md](docs/explanation/design-decisions.md) |
| Understand branching & PRs | [docs/gitflow.md](docs/gitflow.md) |

---

## ⚡ Modern Nuclei v3 Features (October 2026)

This project supports the latest Nuclei engine capabilities:

| Feature | Flag | Use Case |
|---------|------|----------|
| **AI template generation** | `-ai` | Generate templates from natural language |
| **Template profiles** | `-tp` | Reusable scan configurations |
| **Conditional workflows** | `-w` | Chain templates based on detection |
| **Template signing** | `-sign` | Cryptographically sign templates |
| **Self-contained templates** | `-esc` | Load encrypted templates |
| **Code templates** | `-code` | Execute Go-based detection logic |
| **Headless templates** | `-headless` | Browser-based scanning |
| **DAST/Fuzzing** | `-dast` | Dynamic application security testing |
| **Uncover integration** | `-uc` | Scan hosts from Shodan/Censys/etc. |
| **SARIF export** | `-se` | GitHub Security code scanning format |
| **Reporting module** | `-rc` | Auto-create GitHub/Jira tickets |

---

## 🤝 Contributing

New templates are always welcome. The 30-second version:

1. **Fork** the repo
2. **Branch**: `git checkout -b feature/your-template-name` (from `develop`)
3. **Add** your template under `templates/<protocol>/<category>/`
4. **Validate**: `nuclei -validate -t templates/your-template.yaml`
5. **Commit** with Conventional Commits:
   ```bash
   git commit -m "feat: add <template-name> template" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
   ```
6. **Push** and open a PR targeting `develop`

Full details: [CONTRIBUTING.md](CONTRIBUTING.md)

### Template conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Template ID | `cosckoya-<kebab-case>` | `cosckoya-cve-2024-45046` |
| File name | `<kebab-case>.yaml` | `CVE-2024-45046.yaml` |
| Directory | `<protocol>/<category>/` | `templates/cves/2024/` |
| Author | `cosckoya` | — |
| Severity | `info` \| `low` \| `medium` \| `high` \| `critical` | — |

---

## 🔒 Security

Found an issue in a template? Don't open a public issue.  
Read the disclosure process: [SECURITY.md](SECURITY.md)

---

## 📄 License

[MIT](LICENSE) — use it, modify it, share it.

---

## 🛠️ Project Tooling

| Tool | Purpose |
|------|---------|
| [Makefile](Makefile) | Scan, validate, lint, docker targets |
| [Dockerfile](Dockerfile) | Containerized Nuclei scanning |
| [.sops.yaml](.sops.yaml) | Encrypted secrets management |
| [.nuclei-ignore](.nuclei-ignore) | Default template exclusions |
| [CLAUDE.md](CLAUDE.md) | AI agent context for this repo |

---

**Maintained by:** [cosckoya](https://github.com/cosckoya)  
**Co-author on every commit:** Roy Batty <roy.batty@cosckoya.bot>
