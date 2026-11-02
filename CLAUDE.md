# CLAUDE.md - Claude Code configuration for cosckoya/nuclei
# This file provides context for AI agents working on this repository

# Project Overview
This is a modern Nuclei security templates repository maintained by cosckoya.
It contains custom Nuclei templates, workflows, and configuration for vulnerability scanning.

# Key Directories
- `templates/` - Nuclei YAML templates organized by protocol/category
- `workflows/` - Nuclei workflow YAML files for conditional template execution
- `docs/` - Diátaxis documentation (tutorials, how-to, reference, explanation)
- `.github/workflows/` - CI/CD scanning workflows

# Template Conventions
- Template ID prefix: `cosckoya-`
- File naming: `<kebab-case>.yaml`
- Directory: `<protocol>/<category>/`
- Required info fields: id, name, author, severity, description, tags
- Author: `cosckoya`
- Severity levels: info, low, medium, high, critical

# Common Commands
- Validate templates: `nuclei -validate -t templates/`
- Run scan: `nuclei -c nuclei-config.yaml -t templates/ -target <target>`
- Run workflow: `nuclei -c nuclei-config.yaml -w workflows/ -target <target>`
- Make targets: `make help`

# Git Flow
- `main` - stable, protected (squash merge from develop only)
- `develop` - integration branch, protected
- `feature/*` - feature branches from develop
- PR required for all merges to develop and main
- Every commit must include: `Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>`

# Modern Nuclei v3 Features (October 2026)
- AI-powered template generation: `nuclei -ai "<prompt>"`
- Template profiles: `nuclei -tp <profile>`
- Workflows with conditional execution
- Template signing: `nuclei -sign`
- Self-contained templates: `-esc`
- Code templates: `-code`
- Headless templates: `-headless`
- DAST/Fuzzing: `-dast`
- Uncover integration: `-uc`
- SARIF export: `-se`
- Reporting module: `-rc`

# Agents (OpenCode Home Directory)
- shadow-architect - Meta-orchestrator, standards enforcer
- rankle - Purple Team strategic lead
- puck - Defensive security
- shadow - Offensive security
- daedalus - Terraform & DevSecOps
- atticus - Documentation architect
