# Nuclei Workflows Stack Rule

Standards for Nuclei workflow YAML files in the cosckoya/nuclei project.

## Workflow types

| Type | When to use |
|------|-------------|
| Generic | Run multiple templates unconditionally |
| Conditional | Run subtemplates only when base matches |
| Matcher-based | Run subtemplates when specific matcher fires |
| Multi-level | Chain nested subtemplates |

## Required structure

```yaml
workflows:
  - template: <path-to-template>
    subtemplates:
      - tags: <tag-list>
      - template: <path-to-subtemplate>
```

## Matcher-based conditional

```yaml
workflows:
  - template: <base-template>
    matchers:
      - name: <matcher-name>
        subtemplates:
          - template: <subtemplate>
```

## Shared context

Use named extractors to share values between templates in a workflow:

```yaml
extractors:
  - type: regex
    part: body
    name: shared-value
    regex:
      - 'pattern'
    group: 1
```

## Validation

Run before committing:
```bash
nuclei -validate -w workflows/your-workflow.yaml
```

## Commit message

```
feat: add <workflow-name> workflow
```

## Prohibited

- Empty workflow definitions
- Circular subtemplate references
- Workflows without at least one template reference
