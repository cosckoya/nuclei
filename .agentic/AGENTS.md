# OpenCode Agent Configuration — cosckoya/nuclei

This directory defines the OpenCode agents, skills, and rules for this Nuclei templates project.
Files here are auto-discovered by OpenCode after a restart.

## Agents

| Agent | Role | File |
|-------|------|------|
| `shadow-architect` | Meta-orchestrator, standards enforcer | `agents/shadow-architect.agent.md` |
| `rankle` | Purple Team strategic lead | `agents/rankle.agent.md` |
| `puck` | Defensive security | `agents/puck.agent.md` |
| `shadow` | Offensive security | `agents/shadow.agent.md` |
| `daedalus` | Terraform & DevSecOps | `agents/daedalus.agent.md` |
| `atticus` | Documentation architect | `agents/atticus.agent.md` |

## Skills

| Skill | Purpose | File |
|-------|---------|------|
| `nuclei-templates` | Nuclei template authoring guidance | `skills/nuclei-templates/SKILL.md` |
| `nuclei-workflows` | Nuclei workflow orchestration | `skills/nuclei-workflows/SKILL.md` |
| `nuclei-ci-cd` | Nuclei CI/CD pipeline setup | `skills/nuclei-ci-cd/SKILL.md` |

## Rules

| Rule | Scope | File |
|------|-------|------|
| `communication` | English-only, concise | `rules/universal/communication.rule.md` |
| `code-quality` | DRY/KISS/SOLID | `rules/universal/code-quality.rule.md` |
| `safety` | Non-destructive, research-first | `rules/universal/safety.rule.md` |
| `git-workflow` | Conventional commits, git flow | `rules/universal/git-workflow.rule.md` |
| `nuclei-templates` | Nuclei YAML template standards | `rules/stacks/nuclei-templates.rule.md` |
| `nuclei-workflows` | Nuclei workflow standards | `rules/stacks/nuclei-workflows.rule.md` |
| `nuclei-ci-cd` | Nuclei CI/CD pipeline standards | `rules/stacks/nuclei-ci-cd.rule.md` |

## Delegation Map (Shadow Architect)

| Domain | Delegate To |
|--------|-------------|
| Security audit | `@rankle` → `@puck` + `@shadow` |
| Infrastructure / IaC | `@daedalus` |
| Documentation | `@atticus` |
| Architecture review | `shadow-architect` (you) |
