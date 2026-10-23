# Changelog

All notable changes to the `cosckoya/nuclei` repository are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- 16 new Nuclei templates across CVEs, exposures, technologies, misconfigurations, and vulnerabilities
- 5 workflow files including conditional and full-scan workflows
- `.devcontainer/` for VS Code Codespaces development
- `.pre-commit-config.yaml` for pre-commit hooks
- `Dockerfile` and `docker-compose.yml` for containerized scanning
- `Makefile` with scan, validate, lint, docker targets
- `scripts/nuclei-scan.sh` wrapper script
- `examples/` directory with targets and config examples
- `.github/workflows/validate.yml` for template validation CI
- `.github/codeql-config.yml` for CodeQL integration
- `.agentic/` with OpenCode agents, skills, and stack rules
- `CLAUDE.md` and `CODEOWNERS`
- `.nuclei-ignore` and `.sops.yaml`

### Changed
- Refactored `nuclei-config.yaml` with Nuclei v3 flags
- Updated `README.md` with modern Nuclei v3 features
- Updated `docs/gitflow.md` with protection rules

## [1.0.0] — 2026-10-23

### Added
- Initial repository structure
- `docs/` documentation suite (tutorials, how-to, reference, explanation)
- `docs/gitflow.md` — branching model and PR workflow
- `CONTRIBUTING.md`, `SECURITY.md`, `LICENSE`, `CHANGELOG.md`
- Sample Grafana exposed panel template and workflow
- CI/CD scanning workflow
- Dependabot configuration
