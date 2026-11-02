name: "Feature Request"
description: "Suggest a new Nuclei template, workflow, or feature for the project"
title: "[Feature] "
labels: ["enhancement", "triage"]
body:
  - type: markdown
    attributes:
      value: |
        # Feature Request

        Help us improve the cosckoya/nuclei templates by suggesting new features.

  - type: input
    id: feature-type
    attributes:
      label: Type of Feature
      description: What kind of feature are you requesting?
      options:
        - Nuclei Template
        - Nuclei Workflow
        - CI/CD Pipeline
        - Documentation
        - Tooling
        - Other
      default: "Nuclei Template"
    validations:
      required: true

  - type: input
    id: feature-name
    attributes:
      label: Feature Name
      description: A short, descriptive name for the feature
      placeholder: e.g., AWS Lambda detection template
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Describe the feature and what problem it solves
      placeholder: A clear and concise description of what you want to happen.
    validations:
      required: true

  - type: textarea
    id: use-case
    attributes:
      label: Use Case
      description: Describe the scenario where this feature would be used
      placeholder: When scanning targets X, we need to detect Y...
    validations:
      required: true

  - type: dropdown
    id: severity
    attributes:
      label: Expected Severity (if applicable)
      options:
        - critical
        - high
        - medium
        - low
        - info
        - N/A
      default: N/A
    validations:
      required: false

  - type: dropdown
    id: protocol
    attributes:
      label: Protocol (if template)
      options:
        - http
        - dns
        - ssl
        - tcp
        - network
        - javascript
        - code
        - file
        - cloud
        - N/A
      default: http
    validations:
      required: false

  - type: input
    id: reference-url
    attributes:
      label: Reference URL
      description: Link to advisory, CVE, writeup, or documentation
      placeholder: https://example.com/advisory
    validations:
      required: false

  - type: checkboxes
    id: contribution
    attributes:
      label: Contribution
      options:
        - label: I am willing to contribute this feature myself
          required: false
