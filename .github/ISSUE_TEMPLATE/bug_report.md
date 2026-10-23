name: "Bug Report"
description: "File a bug report for a Nuclei template or workflow"
title: "[Bug] "
labels: ["bug", "triage"]
body:
  - type: markdown
    attributes:
      value: |
        # Nuclei Bug Report

        Help us improve the cosckoya/nuclei templates by reporting bugs.

  - type: input
    id: template-id
    attributes:
      label: Template ID
      description: The ID of the template with the bug (e.g., cosckoya-cve-2024-45046)
      placeholder: cosckoya-...
    validations:
      required: true

  - type: input
    id: template-path
    attributes:
      label: Template Path
      description: Path to the template file
      placeholder: templates/cves/2024/CVE-2024-45046.yaml
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Description
      description: What is the bug? What expected behavior vs actual behavior?
    validations:
      required: true

  - type: input
    id: nuclei-version
    attributes:
      label: Nuclei Version
      description: Output of `nuclei -version`
      placeholder: v3.x.x
    validations:
      required: true

  - type: checkboxes
    id: validated
    attributes:
      label: Validation
      options:
        - label: I have validated this template locally with `nuclei -validate`
          required: true
