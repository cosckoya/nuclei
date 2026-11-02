name: "Security Report"
description: "Report a security vulnerability in a Nuclei template or configuration"
title: "[Security] "
labels: ["security", "triage"]
body:
  - type: markdown
    attributes:
      value: |
        # Security Report

        **Do not** open a public issue for security vulnerabilities if they involve sensitive information.
        Email the maintainer at `cosckoya@proton.me` instead.

        For non-sensitive security issues, use this form.

  - type: input
    id: affected-template
    attributes:
      label: Affected Template / File
      description: The template ID or file path affected
      placeholder: cosckoya-cve-2024-45046 or templates/cves/2024/CVE-2024-45046.yaml
    validations:
      required: true

  - type: textarea
    id: vulnerability-description
    attributes:
      label: Vulnerability Description
      description: Describe the security issue and its impact
    validations:
      required: true

  - type: textarea
    id: steps-to-reproduce
    attributes:
      label: Steps to Reproduce
      description: How to reproduce the issue
    validations:
      required: true

  - type: textarea
    id: suggested-fix
    attributes:
      label: Suggested Fix
      description: How to fix the issue (if known)
    validations:
      required: false

  - type: input
    id: nuclei-version
    attributes:
      label: Nuclei Version
      description: Output of `nuclei -version`
      placeholder: v3.x.x
    validations:
      required: false

  - type: checkboxes
    id: disclosure
    attributes:
      label: Disclosure
      options:
        - label: I understand this will be handled according to SECURITY.md disclosure policy
          required: true
