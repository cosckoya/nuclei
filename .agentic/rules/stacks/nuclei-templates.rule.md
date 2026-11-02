# Nuclei Templates Stack Rule

Standards for Nuclei YAML template files in the cosckoya/nuclei project.

## Required fields

Every template MUST include these `info` fields:

| Field | Requirement | Example |
|-------|-------------|---------|
| `id` | Required, prefix `cosckoya-` | `cosckoya-cve-2024-45046` |
| `name` | Required | `Apache OFBiz Path Traversal` |
| `author` | Required | `cosckoya` |
| `severity` | Required | `critical` |
| `description` | Required | `Path traversal in OFBiz` |
| `reference` | Recommended | URL list |
| `tags` | Recommended | `cve,cve2024,ofbiz` |

## Metadata

Optional `metadata` block for integrations:

```yaml
metadata:
  max-request: 1
  verified: true
  shodan-query: 'vuln:CVE-2024-45046'
```

## Directory structure

```
templates/<protocol>/<category>/<kebab-case>.yaml
```

Protocols: `http`, `dns`, `ssl`, `tcp`, `network`, `javascript`, `code`
Categories: `cves`, `exposures`, `misconfiguration`, `technologies`, `vulnerabilities`

## Matchers

- Use `matchers-condition: and` or `or`
- Matcher types: `word`, `status`, `regex`, `dsl`
- Always include a `status` matcher when appropriate

## Extractors

- Use `name` on extractors for workflow sharing
- Always specify `group` for regex extractors

## Validation

Run before committing:
```bash
nuclei -validate -t templates/your-template.yaml
```

## Commit message

```
feat: add <template-name> template
```

## Prohibited

- No spaces in template ID
- No hardcoded secrets in templates (use `.sops.yaml`)
- No `info` severity `unknown` without justification
- No templates without at least one matcher
