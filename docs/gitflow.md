# Git Flow — cosckoya/nuclei

This document describes the branching model, pull request workflow, release process, and tagging strategy used in this repository.

## Branch Strategy

| Branch | Purpose | Protected | Auto-deleted |
|--------|---------|-----------|--------------|
| `main` | Stable, production-ready code. Deployable at all times. | ✅ Yes | No |
| `develop` | Active integration branch for upcoming changes. | ✅ Yes | No |
| `feature/*` | New templates, workflows, or tooling. | ❌ No | ✅ Yes (after merge) |
| `release/*` | Release candidate stabilization (version bump, changelog). | ❌ No | ✅ Yes (after merge) |
| `hotfix/*` | Critical fixes applied directly to `main`. | ❌ No | ✅ Yes (after merge) |

## Protection Rules

Both `main` and `develop` are protected with:

- Required PR reviews: 1
- Force pushes: Disabled
- Branch deletions: Disabled
- Required linear history: Enabled
- Admins enforced: Yes
- Required conversation resolution: Yes

## Branch Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/<short-description>` | `feature/cve-2024-45046-template` |
| Release | `release/v<semver>` | `release/v1.1.0` |
| Hotfix | `hotfix/<short-description>` | `hotfix/fix-template-matcher` |

All branches are lowercase, kebab-case, and prefixed with their type.

## Workflow

### 1. Start work

Always branch from `develop` for features, or from `main` for hotfixes:

```bash
git checkout develop
git pull origin develop
git checkout -b feature/cve-2024-45046-template
```

### 2. Commit

Use [Conventional Commits](https://www.conventionalcommits.org/). Every commit **must** include the `Co-Authored-By` trailer:

```bash
git commit -m "feat: add CVE-2024-45046 template" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
```

Allowed prefixes: `feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `security`.

### 3. Push and open Pull Request

```bash
git push -u origin feature/cve-2024-45046-template
```

Open a PR targeting `develop` (or `main` for hotfixes).

### 4. Merge

PRs are merged into `develop` via **squash merge** only. After release, `develop` is merged into `main` via squash merge and tagged.

## Release Process

1. Create `release/v<semver>` from `develop`
2. Update `CHANGELOG.md`
3. Bump version
4. Open PR targeting `main`
5. After approval, merge and tag:

```bash
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin v1.1.0
```

## Versioning

[Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`):
- **MAJOR** — Breaking changes to template structure or config
- **MINOR** — New templates, workflows, or backward-compatible features
- **PATCH** — Bug fixes, doc updates, minor corrections

## Related Documents

- [CONTRIBUTING.md](../../CONTRIBUTING.md) — Contribution process
- [docs/reference/structure.md](../reference/structure.md) — Directory layout
