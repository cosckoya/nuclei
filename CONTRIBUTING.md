# Contributing

Thank you for contributing to `cosckoya/nuclei`! This document outlines the contribution process, template authoring standards, and the Git flow used in this repository.

## How to Contribute

1. **Fork** the repository.
2. **Clone** your fork and create a feature branch from `develop`.
3. **Author** your template or change following the standards below.
4. **Test** locally with Nuclei.
5. **Commit** using Conventional Commits and include the mandatory co-author trailer.
6. **Push** your branch and open a Pull Request targeting `develop`.
7. **Address review feedback** until all conversations are resolved.
8. **Merge** via squash merge (maintainer action).

## Template Authoring Standards

### Required fields

Every template must include these `info` fields:

| Field | Requirement | Example |
|-------|-------------|---------|
| `id` | Required, prefix `cosckoya-` | `cosckoya-grafana-panel` |
| `name` | Required | `Grafana Exposed Panel` |
| `author` | Required | `cosckoya` |
| `severity` | Required | `medium` |
| `description` | Required | `An exposed Grafana instance` |
| `reference` | Recommended | URL list |
| `tags` | Recommended | `grafana,panel,exposed` |

### File placement

Place templates under `templates/<protocol>/<category>/`:

```
templates/http/exposed-panels/cosckoya-grafana-panel.yaml
```

### Naming

- Template ID: `cosckoya-<kebab-case>`
- File name: `<kebab-case>.yaml`
- Directory: `<protocol>/<category>/`

Read the full schema in [docs/reference/template-authoring.md](docs/reference/template-authoring.md).

## Git Flow

This repository uses Git flow:

- `main` — stable, protected
- `develop` — integration branch
- `feature/*` — new templates or changes
- `release/*` — release candidates
- `hotfix/*` — critical fixes

Read the full workflow in [docs/gitflow.md](docs/gitflow.md).

## Commit Convention

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <description>

[optional body]
```

Allowed types: `feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `security`.

**Every commit must include:**

```
Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>
```

Example:

```bash
git commit -m "feat: add grafana exposed panel template

- Add templates/http/exposed-panels/grafana-exposed.yaml
- Detects unauthenticated Grafana login page" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
```

## Pull Request Checklist

- [ ] Branch follows naming convention (`feature/`, `fix/`, etc.)
- [ ] Commit messages follow Conventional Commits
- [ ] `Co-Authored-By` trailer present on every commit
- [ ] Template includes all required `info` fields
- [ ] Template tested locally with Nuclei
- [ ] PR description explains the change
- [ ] All review conversations resolved

## Code of Conduct

Be respectful, inclusive, and constructive in all interactions. Follow the [GitHub Community Guidelines](https://docs.github.com/en/communities).

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).

## Maintainers

- **cosckoya** — repository owner
- **Roy Batty <roy.batty@cosckoya.bot>** — co-author on all commits
