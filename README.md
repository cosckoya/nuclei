# Nuclei Templates

Custom Nuclei security scanning templates for the cosckoya ecosystem.

## Structure

```text
templates/          # Nuclei templates (YAML)
workflows/          # Nuclei workflows (YAML)
.github/workflows/  # CI/CD scanning workflows
nuclei-config.yaml  # Nuclei runner configuration
```

## Usage

### Install Nuclei

```bash
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
```

### Run a single template

```bash
nuclei -t templates/http/exposed-panels/ -target https://example.com
```

### Run all templates

```bash
nuclei -t templates/ -target https://example.com
```

### Run with config

```bash
nuclei -c nuclei-config.yaml -target https://example.com
```

## Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/awesome-template`)
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

MIT