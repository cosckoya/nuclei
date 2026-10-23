# Template Authoring — Reference

This document defines the YAML schema, required fields, matchers, extractors, and naming conventions for Nuclei templates in this repository.

## Template Schema

```yaml
id: cosckoya-<kebab-case-name>

info:
  name: Human-Readable Template Name
  author: cosckoya
  severity: medium
  description: What this template detects.
  reference:
    - https://example.com/advisory
  tags: tag1,tag2
  metadata:
    max-request: 1
    verified: true

<protocol>:
  - method: GET
    path:
      - "{{BaseURL}}/endpoint"

    matchers-condition: and
    matchers:
      - type: word
        words:
          - "Keyword"
        part: body
      - type: status
        status:
          - 200

    extractors:
      - type: regex
        part: body
        name: extracted-value
        regex:
          - "pattern (.*)"
        group: 1
```

## Required `info` Fields

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| `id` | ✅ | Unique ID, prefixed with `cosckoya-` | `cosckoya-cve-2024-45046` |
| `name` | ✅ | Human-readable title | `Apache OFBiz Path Traversal` |
| `author` | ✅ | Template author | `cosckoya` |
| `severity` | ✅ | `info`, `low`, `medium`, `high`, `critical` | `critical` |
| `description` | ✅ | What the template detects | `Path traversal in OFBiz` |
| `reference` | ❌ | Links to advisories | URL list |
| `tags` | ❌ | Comma-separated keywords | `cve,cve2024,ofbiz` |
| `metadata` | ❌ | Additional metadata | `max-request`, `verified` |

## Naming Convention

| Element | Convention | Example |
|---------|-----------|---------|
| Template ID | `cosckoya-<kebab-case>` | `cosckoya-cve-2024-45046` |
| File name | `<kebab-case>.yaml` | `CVE-2024-45046.yaml` |
| Directory | `<protocol>/<category>/` | `templates/cves/2024/` |
| Author | `cosckoya` | — |

## Protocol Directories

| Protocol | Directory | Use Case |
|----------|-----------|----------|
| `http` | `templates/http/` | HTTP requests/responses |
| `dns` | `templates/dns/` | DNS queries |
| `ssl` | `templates/ssl/` | SSL/TLS certificates |
| `tcp` | `templates/tcp/` | Raw TCP probes |
| `network` | `templates/network/` | Network-level templates |
| `javascript` | `templates/javascript/` | JavaScript-based detection |
| `code` | `templates/code/` | Go-based code templates |

## Matchers

Common matcher types:

- `word` — Match a string in body, header, or status line
- `status` — Match HTTP status codes
- `regex` — Match a regular expression
- `dsl` — Match using Nuclei DSL expressions

Use `matchers-condition: and` or `or` to combine multiple matchers.

## Extractors

Use `name` on extractors to share values across workflow templates:

```yaml
extractors:
  - type: regex
    part: body
    name: session-token
    regex:
      - 'token=([^&]+)'
    group: 1
```

Referenced in subsequent templates as `{{session-token}}`.

## Validation

```bash
nuclei -validate -t templates/your-template.yaml
nuclei -validate -t templates/
```

## Commit Convention

```bash
git commit -m "feat: add <template-name> template" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
```

## Related Documents

- [docs/gitflow.md](../gitflow.md) — Contribution workflow
- [docs/how-to/add-template.md](../how-to/add-template.md) — Adding templates step-by-step
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — Contribution process
