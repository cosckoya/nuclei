# Nuclei Workflows Skill

Provides guidance on authoring and managing Nuclei workflow YAML files for conditional and chained template execution.

## When to use

Use this skill when creating, editing, or reviewing Nuclei workflow `.yaml` files in `workflows/`.

## Workflow types

| Type | Description |
|------|-------------|
| Generic | Run one or more templates/directories unconditionally |
| Conditional | Run subtemplates only when a base template matches |
| Matcher-based | Run subtemplates when a specific matcher name is found |
| Multi-level | Chain nested subtemplates for deep detection chains |

## Generic workflow example

```yaml
workflows:
  - template: http/exposures/configs/git-config.yaml
  - template: http/exposures/configs/exposed-svn.yaml
  - tags: xss,ssrf,cve,lfi
```

## Conditional workflow example

```yaml
workflows:
  - template: technologies/cms/wordpress-detect.yaml
    subtemplates:
      - tags: wordpress
      - template: exposures/panels/
```

## Matcher-based conditional

```yaml
workflows:
  - template: technologies/atlassian/jira-detect.yaml
    matchers:
      - name: jira-detected
        subtemplates:
          - tags: jira
          - template: cves/2024/
```

## Shared execution context

Extractors with `name` in one template can be referenced by name in subsequent subtemplates:

```yaml
# Template 1 extracts a value
extractors:
  - type: regex
    part: body
    name: session-token
    regex:
      - 'token=([^&]+)'

# Template 2 uses {{session-token}}
```

## Validation

```bash
nuclei -validate -w workflows/your-workflow.yaml
nuclei -validate -w workflows/
```

## Commit convention

```bash
git commit -m "feat: add <workflow-name> workflow" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
```

## See also

- [docs/reference/template-authoring.md](../../docs/reference/template-authoring.md)
- [CONTRIBUTING.md](../../CONTRIBUTING.md)
