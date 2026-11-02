# Release Template

This template is used for generating release notes for the cosckoya/nuclei project.

## Release v{{VERSION}}

Released on {{DATE}}

## Summary

{{SUMMARY}}

## New Templates

{{NEW_TEMPLATES}}

## Updated Templates

{{UPDATED_TEMPLATES}}

## New Workflows

{{NEW_WORKFLOWS}}

## Bug Fixes

{{BUG_FIXES}}

## Breaking Changes

{{BREAKING_CHANGES}}

## Documentation

{{DOCUMENTATION}}

## CI/CD Changes

{{CICD_CHANGES}}

## Contributors

{{CONTRIBUTORS}}

## Installation

```bash
# Install Nuclei CLI
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Clone this repository
git clone https://github.com/cosckoya/nuclei.git
cd nuclei

# Checkout the release tag
git checkout v{{VERSION}}
```

## Usage

```bash
# Run all templates
nuclei -c nuclei-config.yaml -t templates/ -target https://example.com

# Run with workflows
nuclei -c nuclei-config.yaml -t templates/ -w workflows/ -target https://example.com

# Run by severity
nuclei -c nuclei-config.yaml -t templates/ -severity critical,high -target https://example.com

# Run DAST fuzzing
nuclei -c nuclei-config.yaml -t templates/dast/ -dast -target https://example.com
```

## Security

For security vulnerabilities, please see [SECURITY.md](SECURITY.md) for disclosure instructions.

## License

[MIT](LICENSE)
