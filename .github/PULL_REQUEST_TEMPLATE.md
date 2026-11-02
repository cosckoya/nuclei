## PR Checklist

- [ ] Branch follows naming convention (`feature/`, `hotfix/`, `release/`)
- [ ] Created from `develop` (or `main` for hotfixes)
- [ ] Commit messages follow Conventional Commits
- [ ] `Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>` trailer on every commit
- [ ] Templates validated locally (`nuclei -validate -t templates/`)
- [ ] Workflows validated locally (`nuclei -validate -w workflows/`)
- [ ] YAML syntax checked (`yamllint` or Python yaml.safe_load)
- [ ] All conversations resolved
- [ ] PR targets correct branch (`develop` or `main`)
- [ ] No direct push to `main` or `develop`

## Description

<!-- What does this PR do? -->

## Type of Change

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] CI/CD pipeline update
- [ ] Release / Version bump

## Template Details (if adding a Nuclei template)

| Field | Value |
|-------|-------|
| Template ID | `cosckoya-<kebab-case>` |
| Protocol | `http` / `dns` / `ssl` / `tcp` / `network` / `javascript` / `code` / `cloud` / `file` |
| Severity | `info` / `low` / `medium` / `high` / `critical` |
| Author | `cosckoya` |

## Related Issues

<!-- Link to related issues (e.g., Closes #123) -->

## Screenshots / Output

<!-- If applicable, add screenshots or Nuclei output to verify the change -->
