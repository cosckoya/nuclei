# Add a New Template — How-to

This guide explains how to author and contribute a new Nuclei template to this repository.

## Before You Start

- Read [CONTRIBUTING.md](../../CONTRIBUTING.md) for the contribution process.
- Read [docs/gitflow.md](../gitflow.md) for the branching model.
- Use the [template authoring reference](../../docs/reference/template-authoring.md) for the YAML schema.

## Steps

### 1. Create a feature branch

Branch from `develop`:

```bash
git checkout develop
git pull origin develop
git checkout -b feature/<template-name>
```

### 2. Create the template file

Place the template under `templates/<protocol>/<category>/`:

```text
templates/
  http/
    exposed-panels/
    misconfiguration/
    vulnerabilities/
  dns/
  ssl/
  network/
```

File naming: `cosckoya-<kebab-case-description>.yaml`

Example: `templates/http/exposed-panels/cosckoya-grafana-exposed-panel.yaml`

### 3. Author the template

Follow the schema in [template-authoring.md](../../docs/reference/template-authoring.md). Required `info` fields:

- `id` — unique, prefixed with `cosckoya-`
- `name` — human-readable title
- `author` — `cosckoya`
- `severity` — `info`, `low`, `medium`, `high`, or `critical`
- `description` — what the template detects
- `reference` — links to relevant documentation
- `tags` — relevant keywords

### 4. Test locally

```bash
nuclei -t templates/http/exposed-panels/your-template.yaml -target https://example.com
```

### 5. Commit

Use Conventional Commits and include the mandatory co-author trailer:

```bash
git add templates/http/exposed-panels/your-template.yaml
git commit -m "feat: add <template-name> template

- Detects <what it detects>
- Severity: <level>" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
```

### 6. Open a Pull Request

Push your branch and open a PR targeting `develop`:

```bash
git push -u origin feature/<template-name>
```

Ensure:
- PR title follows Conventional Commits
- Description explains the template and target
- All review conversations are resolved

## Template Naming Convention

| Element | Convention | Example |
|---------|-----------|---------|
| ID prefix | `cosckoya-` | `cosckoya-grafana-exposed-panel` |
| File name | kebab-case + `.yaml` | `grafana-exposed-panel.yaml` |
| Directory | `<protocol>/<category>/` | `http/exposed-panels/` |
| Author | `cosckoya` | — |

## Related Documents

- [docs/reference/template-authoring.md](../../docs/reference/template-authoring.md) — full YAML schema
- [docs/gitflow.md](../gitflow.md) — branching and PR workflow
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — contribution process
