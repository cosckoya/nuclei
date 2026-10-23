# Template Authoring — Reference

This document defines the YAML schema, required fields, matchers, extractors, and naming conventions for Nuclei templates in this repository.

## Template Schema

A minimal Nuclei template:

```yaml
id: cosckoya-<kebab-case-name>

info:
  name: Human-Readable Template Name
  author: cosckoya
  severity: medium
  description: What this template detects.
  reference:
    - https://example.com/docs/
  tags: tag1,tag2

http:
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
```

## Required `info` Fields

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| `id` | ✅ | Unique identifier, prefixed with `cosckoya-` | `cosckoya-grafana-panel` |
| `name` | ✅ | Human-readable title | `Grafana Exposed Panel` |
| `author` | ✅ | Template author | `cosckoya` |
| `severity` | ✅ | `info`, `low`, `medium`, `high`, `critical` | `medium` |
| `description` | ✅ | What the template detects | `An exposed Grafana instance` |
| `reference` | ❌ | Links to documentation or advisories | URL list |
| `tags` | ❌ | Comma-separated keywords | `grafana,panel,exposed` |

## Naming Convention

| Element | Convention | Example |
|---------|-----------|---------|
| Template ID | `cosckoya-<kebab-case>` | `cosckoya-grafana-exposed-panel` |
| File name | `<kebab-case>.yaml` | `grafana-exposed-panel.yaml` |
| Directory | `<protocol>/<category>/` | `http/exposed-panels/` |

## Common Protocols

| Protocol | Directory | Description |
|----------|-----------|-------------|
| `http` | `templates/http/` | HTTP requests and responses |
| `dns` | `templates/dns/` | DNS queries |
| `ssl` | `templates/ssl/` | SSL/TLS certificates |
| `network` | `templates/network/` | Raw network probes |

## Matchers

Matchers determine if a target is vulnerable. Common types:

- `word` — match a string in body, header, or status line
- `status` — match HTTP status codes
- `regex` — match a regular expression
- `dsl` — match using Nuclei DSL expressions

Use `matchers-condition: and` or `or` to combine multiple matchers.

## Extractors

Extractors pull data from the response for reporting:

```yaml
extractors:
  - type: regex
    part: header
    regex:
      - "(?i)grafana"
```

## Testing Locally

```bash
nuclei -t templates/http/exposed-panels/your-template.yaml -target https://example.com
```

## Related Documents

- [docs/gitflow.md](../gitflow.md) — contribution workflow
- [docs/how-to/add-template.md](../how-to/add-template.md) — adding a template step-by-step
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — contribution process
