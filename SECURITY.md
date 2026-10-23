# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| `main`  | ✅ Yes    |
| `develop` | ✅ Yes  |

## Reporting a Vulnerability

If you discover a security issue in a Nuclei template or in this repository's configuration, please report it responsibly.

### How to Report

1. **Do not** open a public GitHub issue for security vulnerabilities.
2. Email the maintainer at `cosckoya@proton.me` with:
   - A clear description of the vulnerability
   - Steps to reproduce
   - The affected template(s) or file(s)
   - Suggested remediation (if any)
3. Allow up to **7 business days** for an initial response.

## Disclosure Timeline

| Stage | Target |
|-------|--------|
| Initial acknowledgment | 7 business days |
| Status update | Every 14 days |
| Public disclosure | After fix is released or 90 days, whichever comes first |

## Scope

In scope:
- Nuclei templates in `templates/`
- Nuclei workflows in `workflows/`
- `nuclei-config.yaml` settings

Out of scope:
- Third-party Nuclei templates not in this repository
- Issues in the Nuclei engine itself (report to [projectdiscovery/nuclei](https://github.com/projectdiscovery/nuclei))

## Recognition

Security reporters will be acknowledged in the release notes and `CHANGELOG.md` unless they request anonymity.

## Policy

This policy follows responsible disclosure principles. We do not offer bounties at this time.
