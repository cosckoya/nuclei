# justfile for cosckoya/nuclei project
# Modern Nuclei project automation (October 2026)
# Replaces Makefile with a more readable, modern task runner

set dotenv-load

nuclei := "nuclei"
target := "https://example.com"
templates_dir := "templates"
workflows_dir := "workflows"
config_file := "nuclei-config.yaml"
docker_image := "cosckoya/nuclei"
docker_tag := "latest"

default:
  just --list

install:
  echo "Installing Nuclei CLI..."
  go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

update-templates:
  echo "Updating Nuclei templates..."
  {{nuclei}} -ut

validate:
  echo "Validating templates..."
  {{nuclei}} -validate -t {{templates_dir}}

lint:
  echo "Linting templates..."
  @find {{templates_dir}} -name "*.yaml" -exec sh -c 'echo "Checking {}" && python3 -c "import yaml; yaml.safe_load(open(\"{}"))"' \;

scan:
  echo "Running all templates against {{target}}..."
  {{nuclei}} -c {{config_file}} -t {{templates_dir}} -target {{target}}

scan-single template:
  echo "Running single template {{template}} against {{target}}..."
  {{nuclei}} -c {{config_file}} -t {{template}} -target {{target}}

scan-all:
  echo "Running all templates and workflows against {{target}}..."
  {{nuclei}} -c {{config_file}} -t {{templates_dir}} -w {{workflows_dir}} -target {{target}}

scan-severity severity:
  echo "Running {{severity}} severity templates against {{target}}..."
  {{nuclei}} -c {{config_file}} -t {{templates_dir}} -severity {{severity}} -target {{target}}

scan-tags tags:
  echo "Running {{tags}} tagged templates against {{target}}..."
  {{nuclei}} -c {{config_file}} -t {{templates_dir}} -tags {{tags}} -target {{target}}

scan-workflow workflow:
  echo "Running workflow {{workflow}} against {{target}}..."
  {{nuclei}} -c {{config_file}} -w {{workflows_dir}}/{{workflow}} -target {{target}}

docker-build:
  echo "Building Docker image {{docker_image}}:{{docker_tag}}..."
  docker build -t {{docker_image}}:{{docker_tag}} .

docker-scan:
  echo "Running Docker scan against {{target}}..."
  docker run --rm {{docker_image}}:{{docker_tag}} -c /nuclei/config.yaml -t /nuclei/templates -target {{target}}

fmt:
  echo "Formatting YAML templates..."
  @find {{templates_dir}} {{workflows_dir}} -name "*.yaml" -exec sh -c 'python3 -c "import yaml; data=yaml.safe_load(open(\"{}\")); open(\"{}\",\"w\").write(yaml.dump(data, default_flow_style=False, sort_keys=False))"' \;

test:
  echo "Running tests..."
  just validate
  just lint

clean:
  echo "Cleaning..."
  rm -rf *.jsonl *.json *.md output/ .nuclei/
