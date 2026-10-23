# Makefile for cosckoya/nuclei project
# Modern Nuclei project automation (October 2026)

.PHONY: help install scan scan-single scan-all update-templates validate lint docker-build docker-scan clean test fmt

# Variables
NUCLEI ?= nuclei
TARGET ?= https://example.com
TEMPLATES_DIR ?= templates
WORKFLOWS_DIR ?= workflows
CONFIG_FILE ?= nuclei-config.yaml
DOCKER_IMAGE ?= cosckoya/nuclei
DOCKER_TAG ?= latest

help: ## Show this help message
	@echo "cosckoya/nuclei - Modern Nuclei Security Templates Project"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install Nuclei CLI
	@echo "Installing Nuclei CLI..."
	go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

update-templates: ## Update Nuclei community templates
	@echo "Updating Nuclei templates..."
	$(NUCLEI) -ut

validate: ## Validate all templates in the project
	@echo "Validating templates..."
	$(NUCLEI) -validate -t $(TEMPLATES_DIR)

lint: ## Lint templates (basic YAML syntax check)
	@echo "Linting templates..."
	@find $(TEMPLATES_DIR) -name "*.yaml" -exec sh -c 'echo "Checking {}" && python3 -c "import yaml; yaml.safe_load(open(\"{}"))"' \;

scan: ## Run all templates against a target
	@echo "Running all templates against $(TARGET)..."
	$(NUCLEI) -c $(CONFIG_FILE) -t $(TEMPLATES_DIR) -target $(TARGET)

scan-single: ## Run a single template against a target
	@echo "Running single template against $(TARGET)..."
	$(NUCLEI) -c $(CONFIG_FILE) -t $(TEMPLATE) -target $(TARGET)

scan-all: ## Run all templates and workflows against a target
	@echo "Running all templates and workflows against $(TARGET)..."
	$(NUCLEI) -c $(CONFIG_FILE) -t $(TEMPLATES_DIR) -w $(WORKFLOWS_DIR) -target $(TARGET)

scan-severity: ## Scan by severity level (e.g., make scan-severity SEVERITY=critical)
	@echo "Running $(SEVERITY) severity templates against $(TARGET)..."
	$(NUCLEI) -c $(CONFIG_FILE) -t $(TEMPLATES_DIR) -severity $(SEVERITY) -target $(TARGET)

scan-tags: ## Scan by tags (e.g., make scan-tags TAGS=cve,exposure)
	@echo "Running $(TAGS) tagged templates against $(TARGET)..."
	$(NUCLEI) -c $(CONFIG_FILE) -t $(TEMPLATES_DIR) -tags $(TAGS) -target $(TARGET)

scan-workflow: ## Run a specific workflow against a target
	@echo "Running workflow $(WORKFLOW) against $(TARGET)..."
	$(NUCLEI) -c $(CONFIG_FILE) -w $(WORKFLOWS_DIR)/$(WORKFLOW) -target $(TARGET)

docker-build: ## Build Docker image
	@echo "Building Docker image $(DOCKER_IMAGE):$(DOCKER_TAG)..."
	docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) .

docker-scan: ## Run scan using Docker (e.g., make docker-scan TARGET=https://example.com)
	@echo "Running Docker scan against $(TARGET)..."
	docker run --rm $(DOCKER_IMAGE):$(DOCKER_TAG) -c /nuclei/config.yaml -t /nuclei/templates -target $(TARGET)

fmt: ## Format all YAML templates
	@echo "Formatting YAML templates..."
	@find $(TEMPLATES_DIR) $(WORKFLOWS_DIR) -name "*.yaml" -exec sh -c 'python3 -c "import yaml; data=yaml.safe_load(open(\"{}\")); open(\"{}\",\"w\").write(yaml.dump(data, default_flow_style=False, sort_keys=False))"' \;

test: ## Run template validation and lint
	@echo "Running tests..."
	$(MAKE) validate
	$(MAKE) lint

clean: ## Clean generated files
	@echo "Cleaning..."
	rm -rf *.jsonl *.json *.md output/ .nuclei/

.DEFAULT_GOAL := help