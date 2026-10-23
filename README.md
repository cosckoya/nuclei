# 🎯 Nuclei Templates

Custom Nuclei security scanning templates for the cosckoya ecosystem.

[![Nuclei](https://img.shields.io/badge/Nuclei-templates-blue?logo=go)](https://github.com/projectdiscovery/nuclei)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

---

## What is this?

A curated collection of [Nuclei](https://github.com/projectdiscovery/nuclei) templates and workflows used to scan targets for misconfigurations, exposed panels, and common vulnerabilities.

Think of it as a locksmith's toolkit: each template is a pick designed for a specific lock. Some check for exposed admin panels, others hunt for HTTP misconfigurations or SSL weaknesses.

---

## 🚀 Quick Start

### 1. Install Nuclei

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
# Scan a target with every template in this repo
nuclei -t templates/ -target https://example.com

# Or use the project configuration for consistent settings
nuclei -c nuclei-config.yaml -target https://example.com
```

### 4. Run a single template

```bash
nuclei -t templates/http/exposed-panels/grafana-exposed.yaml -target https://example.com
```

---

## 📦 What's Inside

| Directory | Purpose |
|-----------|---------|
| `templates/` | Nuclei templates (YAML), organized by protocol and category |
| `workflows/` | Nuclei workflows that chain multiple templates together |
| `.github/workflows/` | CI/CD scanning workflow (runs on schedule + manual trigger) |
| `docs/` | Full documentation (tutorials, how-tos, reference, explanation) |
| `nuclei-config.yaml` | Runner configuration for consistent scans |

### Example template

```yaml
id: cosckoya-grafana-exposed-panel
info:
  name: Grafana Exposed Panel
  author: cosckoya
  severity: medium
  description: A Grafana instance is exposed and accessible without authentication.
http:
  - method: GET
    path:
      - "{{BaseURL}}/login"
    matchers:
      - type: word
        words: ["Grafana", "Login"]
        part: body
      - type: status
        status: [200]
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

## 🤝 Contributing

New templates are always welcome. Here's the 30-second version:

1. **Fork** the repo
2. Create a branch: `git checkout -b feature/your-template-name`
3. Add your template under `templates/<protocol>/<category>/`
4. Test it: `nuclei -t templates/... -target <your-target>`
5. Commit with [Conventional Commits](https://www.conventionalcommits.org/):
   ```bash
   git commit -m "feat: add <template-name> template" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
   ```
6. Push and open a Pull Request targeting `develop`

Full details: [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 🔒 Security

Found an issue in a template? Don't open a public issue.  
Read the disclosure process: [SECURITY.md](SECURITY.md)

---

## 📄 License

[MIT](LICENSE) — use it, modify it, share it.

---

**Maintained by:** [cosckoya](https://github.com/cosckoya)  
**Co-author on every commit:** Roy Batty <roy.batty@cosckoya.bot>
