# Git Flow — cosckoya/nuclei

This document describes the branching model, pull request workflow, release process, and tagging strategy used in this repository.

## Branch Strategy

| Branch | Purpose | Protected | Auto-deleted |
|--------|---------|-----------|--------------|
| `main` | Stable, production-ready code. Deployable at all times. | ✅ Yes | No |
| `develop` | Active integration branch for upcoming changes. | ❌ No | No |
| `feature/*` | New templates, workflows, or tooling. | ❌ No | ✅ Yes (after merge) |
| `release/*` | Release candidate stabilization (version bump, changelog). | ❌ No | ✅ Yes (after merge) |
| `hotfix/*` | Critical fixes applied directly to `main`. | ❌ No | ✅ Yes (after merge) |

## Branch Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/<short-description>` | `feature/grafana-panel-template` |
| Release | `release/v<semver>` | `release/v1.1.0` |
| Hotfix | `hotfix/<short-description>` | `hotfix/fix-template-matcher` |

All branches are lowercase, kebab-case, and prefixed with their type.

## Workflow

### 1. Start work

Always branch from `develop` for features, or from `main` for hotfixes.

```bash
# Sync local branches
git checkout develop
git pull origin develop

# Create a feature branch
git checkout -b feature/grafana-panel-template
```

### 2. Commit

Use [Conventional Commits](https://www.conventionalcommits.org/). Every commit **must** include the `Co-Authored-By` trailer.

```bash
git commit -m "feat: add grafana exposed panel template

- Add templates/http/exposed-panels/grafana-exposed.yaml
- Add matchers for status 200 and body containing Grafana" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
```

Allowed prefixes: `feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `security`.

### 3. Push and open Pull Request

Push the feature branch and open a PR targeting `develop` (or `main` for hotfixes).

```bash
git push -u origin feature/grafana-panel-template
```

**PR requirements:**
- Title follows Conventional Commits (`feat: ...`, `fix: ...`, etc.)
- Description explains the change and links to any related issue
- All conversations resolved before merge
- At least **1 approving review** required on `main`
- Force pushes and branch deletions are disabled on `main`

### 4. Merge

PRs are merged into `develop` via **squash merge** only. After the release is cut, `develop` is merged into `main` and tagged.

```bash
# On develop, after release is stable
git checkout main
git merge --no-ff develop
git push origin main
```

## Release Process

1. Create `release/v<semver>` from `develop`.
2. Update `CHANGELOG.md` with changes since last release.
3. Bump version in relevant files.
4. Open PR targeting `main`.
5. Once approved and merged, create a Git tag:

```bash
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin v1.1.0
```

6. Delete the `release/*` branch.

### Versioning

This project follows [Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`):
- **MAJOR** — breaking changes to template structure or config
- **MINOR** — new templates, workflows, or backward-compatible features
- **PATCH** — bug fixes, doc updates, minor corrections

## Hotfix Process

Critical bugs on `main` are fixed via `hotfix/*` branched from `main`:

```bash
git checkout main
git checkout -b hotfix/fix-matcher-bug
# ... fix ...
git commit -m "fix: correct grafana template matcher" -m "Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>"
git push -u origin hotfix/fix-matcher-bug
```

After merge to `main`, the hotfix is also merged back into `develop`.

## Protection Rules on `main`

- Required approving reviews: **1**
- Dismiss stale reviews: enabled
- Enforce admins: enabled
- Required linear history: enabled
- Force pushes: disabled
- Branch deletions: disabled
- Required conversation resolution: enabled

## Authors

- **cosckoya** — repository owner
- **Roy Batty <roy.batty@cosckoya.bot>** — mandatory co-author on every commit
