name: "Template Request"
description: "Request a new Nuclei template for a specific vulnerability or exposure"
title: "[Template Request] "
labels: ["enhancement", "template-request", "triage"]
body:
  - type: markdown
    attributes:
      value: |
        # New Template Request

        Request a new Nuclei template to be added to this repository.

  - type: input
    id: vulnerability-name
    attributes:
      label: Vulnerability / Exposure Name
      description: Name of the vulnerability, CVE ID, or exposure type
      placeholder: e.g., CVE-2024-XXXXX or Exposed Admin Panel
    validations:
      required: true

  - type: input
    id: reference-url
    attributes:
      label: Reference URL
      description: Link to advisory, writeup, or documentation
      placeholder: https://example.com/advisory
    validations:
      required: false

  - type: dropdown
    id: severity
    attributes:
      label: Expected Severity
      options:
        - critical
        - high
        - medium
        - low
        - info
      default: medium
    validations:
      required: true

  - type: dropdown
    id: protocol
    attributes:
      label: Protocol
      options:
        - http
        - dns
        - ssl
        - tcp
        - network
        - javascript
        - code
      default: http
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Describe what the template should detect and how
    validations:
      required: true

  - type: checkboxes
    id: contribution
    attributes:
      label: Contribution
      options:
        - label: I am willing to contribute this template myself
          required: false
