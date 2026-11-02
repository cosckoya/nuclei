# Changelog

All notable changes to the `cosckoya/nuclei` repository are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `.github/ISSUE_TEMPLATE/feature_request.md` — Feature request template
- `.github/ISSUE_TEMPLATE/release_request.md` — Release request template
- `.github/ISSUE_TEMPLATE/security_report.md` — Security report template
- `.github/RELEASE_TEMPLATE.md` — Release notes template
- `.github/workflows/release.yml` — Automated release workflow with tag generation

### Changed
- `.github/PULL_REQUEST_TEMPLATE.md` — Enhanced PR checklist with template details
- `docs/gitflow.md` — Updated with versioning and release process

## [2.0.0] — 2026-11-02

### Added
- Complete DAST pipeline with quick/full/dast scan modes
- 30+ new templates across 10 protocol categories
- 6 conditional and full-scan workflows
- Automated template sync from projectdiscovery/nuclei-templates
- Secret scanning (TruffleHog + Gitleaks) with CI/CD
- Template signing configuration and verification
- Monitoring and alerting (Slack, Email, GitHub Issues)
- OpenAPI/Swagger API security scanning
- SARIF export to GitHub Code Scanning
- DevSecOps pipeline guide and documentation suite
- Auto-merge develop → main workflow
- GitHub Rulesets for main and develop branch protection

### Changed
- Refactored `nuclei-config.yaml` with Nuclei v3 flags
- Refactored `README.md` with DAST pipeline section and scan modes
- All templates YAML-validated

## [1.1.0] — 2026-10-23

### Added
- Modern nuclei-config.yaml with v3 flags (rate-limit, concurrency, project, etc.)
- `.nuclei-ignore` for default template exclusions
- `.sops.yaml` for encrypted secrets management
- `Dockerfile` for containerized scanning
- `docker-compose.yml` for orchestration
- `Makefile` with scan, validate, lint, docker targets
- `CLAUDE.md` for AI agent context
- `CODEOWNERS` for team ownership
- `.agentic/` with agents, skills, and stack rules
- 16 new templates: CVE-2024-45046, CVE-2024-29824, CVE-2024-23692, CVE-2024-3400, CVE-2024-21887, CVE-2025-0001, Jenkins/Grafana panels, S3 public, WordPress/Grafana detection
- 5 workflows including conditional DAST API scan and full scan
- CI/CD workflow with validation, SARIF, GitHub Security upload
- Issue templates: bug_report, template_request
- README refactor with modern Nuclei v3 features (AI, workflows, profiles, SARIF)
- Updated docs references

## [1.0.0] — 2026-10-23

### Added
- Initial repository structure
- `docs/` documentation suite (tutorials, how-to, reference, explanation)
- `docs/gitflow.md` — branching model and PR workflow
- `CONTRIBUTING.md`, `SECURITY.md`, `LICENSE`, `CHANGELOG.md`
- Sample Grafana exposed panel template and workflow
- CI/CD scanning workflow
- Dependabot configuration
