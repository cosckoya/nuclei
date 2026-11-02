name: "Release Request"
description: "Request a new release of the Nuclei templates project"
title: "[Release] "
labels: ["release", "triage"]
body:
  - type: markdown
    attributes:
      value: |
        # Release Request

        Request a new versioned release of the cosckoya/nuclei templates project.

  - type: dropdown
    id: release-type
    attributes:
      label: Release Type
      description: What type of release is needed?
      options:
        - patch (bug fixes, minor corrections)
        - minor (new templates, workflows, backward-compatible features)
        - major (breaking changes to template structure or config)
      default: patch
    validations:
      required: true

  - type: textarea
    id: changes
    attributes:
      label: Changes Included
      description: List the changes, fixes, or new templates to be included in this release
      placeholder: - Fix: CVE-2024-XXXX template false positive\n- Add: New AWS S3 template\n- Update: README documentation
    validations:
      required: true

  - type: textarea
    id: breaking-changes
    attributes:
      label: Breaking Changes (if any)
      description: Describe any breaking changes that users should be aware of
      placeholder: None
    validations:
      required: false

  - type: checkboxes
    id: changelog-updated
    attributes:
      label: Changelog Status
      options:
        - label: CHANGELOG.md has been updated with the changes
          required: true
