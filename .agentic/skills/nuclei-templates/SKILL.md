# Nuclei Templates Skill

Provides guidance on authoring, validating, and managing Nuclei YAML templates for the cosckoya/nuclei project.

## When to use

Use this skill when creating, editing, or reviewing Nuclei template `.yaml` files in `templates/`.

## Template conventions

- **ID prefix:** `cosckoya-` (e.g., `cosckoya-cve-2024-45046`)
- **File naming:** `<kebab-case>.yaml`
- **Directory:** `templates/<protocol>/<category>/`
- **Author:** `cosckoya`
- **Required `info` fields:** `id`, `name`, `author`, `severity`, `description`, `tags`
- **Severity levels:** `info`, `low`, `medium`, `high`, `critical`

## Required info block

```yaml
info:
  name: Human-Readable Template Name
  author: cosckoya
  severity: medium
  description: What this template detects.
  reference:
    - https://example.com/advisory
  tags: tag1,tag2
```

## Protocol directories

| Protocol | Directory | Description |
|----------|-----------|-------------|
| `http` | `templates/http/` | HTTP requests/responses |
| `dns` | `templates/dns/` | DNS queries |
| `ssl` | `templates/ssl/` | SSL/TLS certificates |
| `tcp` | `templates/tcp/` | Raw TCP probes |
| `network` | `templates/network/` | Network-level templates |
| `javascript` | `templates/javascript/` | JS-based detection |
| `code` | `templates/code/` | Go-based code templates |

## Validation

```bash
nuclei -validate -t templates/your-template.yaml
nuclei -validate -t templates/
```

## Matchers

Common matcher types: `word`, `status`, `regex`, `dsl`. Use `matchers-condition: and` or `or` to combine.

## Extractors

Use `name` on extractors to share values across workflow templates.

```yaml
extractors:
  - type: regex
    part: body
    name: extracted-value
    regex:
      - 'pattern (.*)'
    group: 1
```

## Commit convention

```bash
git commit -m "feat: add <template-name> template" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
```

## See also

- [docs/reference/template-authoring.md](../../docs/reference/template-authoring.md)
- [CONTRIBUTING.md](../../CONTRIBUTING.md)
