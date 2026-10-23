# Nuclei Templates

Custom Nuclei security scanning templates for the cosckoya ecosystem.

## Purpose

This repository hosts community-maintained [Nuclei](https://github.com/projectdiscovery/nuclei) templates and workflows used to scan targets for misconfigurations, exposed panels, and common vulnerabilities.

## Quick Start

```bash
# Install Nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Run all templates against a target
nuclei -t templates/ -target https://example.com

# Run with project configuration
nuclei -c nuclei-config.yaml -target https://example.com
```

## Documentation

| Audience | Document | Description |
|----------|----------|-------------|
| New users | [docs/tutorials/first-scan.md](docs/tutorials/first-scan.md) | Step-by-step getting started |
| Daily usage | [docs/how-to/add-template.md](docs/how-to/add-template.md) | How to add a new Nuclei template |
| Repository layout | [docs/reference/structure.md](docs/reference/structure.md) | Directory structure and conventions |
| Template authoring | [docs/reference/template-authoring.md](docs/reference/template-authoring.md) | YAML schema, matchers, extractors, naming |
| Design rationale | [docs/explanation/design-decisions.md](docs/explanation/design-decisions.md) | Why the project is organized this way |
| Git workflow | [docs/gitflow.md](docs/gitflow.md) | Branching, PRs, releases, and tags |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution process, template authoring standards, and the Git flow used in this repository.

## Security

See [SECURITY.md](SECURITY.md) for the security policy and vulnerability disclosure process.

## License

[MIT](LICENSE)

## Project

- **Repository:** https://github.com/cosckoya/nuclei
- **Author:** cosckoya
- **Co-author:** Roy Batty <roy.batty@cosckoya.bot>
