#!/bin/bash
# =============================================================================
# nuclei-scan.sh — Wrapper script for Nuclei security scans
# Project: cosckoya/nuclei
# =============================================================================

set -euo pipefail

# --- Configuration ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
NUCLEI_BIN="${NUCLEI_BIN:-nuclei}"
CONFIG_FILE="${PROJECT_ROOT}/nuclei-config.yaml"
TEMPLATES_DIR="${PROJECT_ROOT}/templates"
WORKFLOWS_DIR="${PROJECT_ROOT}/workflows"
OUTPUT_DIR="${PROJECT_ROOT}/output"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Functions ---

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
    exit 1
}

show_help() {
    cat <<EOF
Usage: $0 [OPTIONS] <target>

Nuclei security scan wrapper for cosckoya/nuclei project.

Arguments:
  target                  Target URL, host, or file with targets (one per line)

Options:
  -t, --template DIR      Template directory or file (default: all templates)
  -w, --workflow FILE     Workflow file or directory
  -s, --severity LEVEL    Minimum severity (info, low, medium, high, critical)
  -g, --tags TAGS         Comma-separated tags to include
  -o, --output FILE       Output file (default: output/nuclei-<timestamp>.jsonl)
  -f, --format FORMAT     Output format: jsonl, sarif, markdown (default: jsonl)
  -v, --validate          Validate templates before scanning
  -u, --update            Update community templates before scanning
  -d, --docker            Run using Docker container
  -h, --help              Show this help message

Environment variables:
  NUCLEI_BIN              Path to Nuclei binary (default: nuclei)
  PDCP_API_KEY            ProjectDiscovery Cloud API key
  GITHUB_TOKEN            GitHub API token

Examples:
  $0 https://example.com
  $0 -s critical -o results.jsonl https://example.com
  $0 -t templates/cves/ -g cve -v targets.txt
  $0 -d https://example.com
EOF
    exit 0
}

# --- Argument parsing ---

TARGET=""
TEMPLATE=""
WORKFLOW=""
SEVERITY=""
TAGS=""
OUTPUT=""
FORMAT="jsonl"
VALIDATE=false
UPDATE=false
USE_DOCKER=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -t|--template)
            TEMPLATE="$2"; shift 2 ;;
        -w|--workflow)
            WORKFLOW="$2"; shift 2 ;;
        -s|--severity)
            SEVERITY="$2"; shift 2 ;;
        -g|--tags)
            TAGS="$2"; shift 2 ;;
        -o|--output)
            OUTPUT="$2"; shift 2 ;;
        -f|--format)
            FORMAT="$2"; shift 2 ;;
        -v|--validate)
            VALIDATE=true; shift ;;
        -u|--update)
            UPDATE=true; shift ;;
        -d|--docker)
            USE_DOCKER=true; shift ;;
        -h|--help)
            show_help ;;
        -*)
            log_error "Unknown option: $1" ;;
        *)
            TARGET="$1"; shift ;;
    esac
done

if [[ -z "${TARGET}" ]]; then
    log_error "Target is required. Use -h for help."
fi

# --- Pre-flight checks ---

if ! command -v "${NUCLEI_BIN}" &> /dev/null && [[ "${USE_DOCKER}" == "false" ]]; then
    log_error "Nuclei binary not found. Install with: go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
fi

if [[ ! -f "${CONFIG_FILE}" ]]; then
    log_warn "Configuration file not found: ${CONFIG_FILE}"
fi

mkdir -p "${OUTPUT_DIR}"

if [[ -z "${OUTPUT}" ]]; then
    OUTPUT="${OUTPUT_DIR}/nuclei-${TIMESTAMP}.${FORMAT}"
fi

# --- Validation ---

if [[ "${VALIDATE}" == "true" ]]; then
    log_info "Validating templates..."
    "${NUCLEI_BIN}" -validate -t "${TEMPLATES_DIR}" -w "${WORKFLOWS_DIR}" || \
        log_warn "Template validation found issues (continuing anyway)"
    log_success "Templates validated"
fi

# --- Template update ---

if [[ "${UPDATE}" == "true" ]]; then
    log_info "Updating community templates..."
    "${NUCLEI_BIN}" -ut || log_warn "Template update failed (continuing with local templates)"
    log_success "Templates updated"
fi

# --- Build Nuclei command ---

NUCLEI_ARGS=(
    -c "${CONFIG_FILE}"
    -target "${TARGET}"
)

if [[ -n "${TEMPLATE}" ]]; then
    NUCLEI_ARGS+=(-t "${TEMPLATE}")
else
    NUCLEI_ARGS+=(-t "${TEMPLATES_DIR}")
fi

if [[ -n "${WORKFLOW}" ]]; then
    NUCLEI_ARGS+=(-w "${WORKFLOW}")
else
    NUCLEI_ARGS+=(-w "${WORKFLOWS_DIR}")
fi

if [[ -n "${SEVERITY}" ]]; then
    NUCLEI_ARGS+=(-severity "${SEVERITY}")
fi

if [[ -n "${TAGS}" ]]; then
    NUCLEI_ARGS+=(-tags "${TAGS}")
fi

case "${FORMAT}" in
    jsonl)
        NUCLEI_ARGS+=(-jsonl -o "${OUTPUT}")
        ;;
    sarif)
        NUCLEI_ARGS+=(-sarif-export "${OUTPUT}")
        ;;
    markdown)
        NUCLEI_ARGS+=(-markdown-export "${OUTPUT}")
        ;;
    *)
        log_error "Unknown format: ${FORMAT}"
        ;;
esac

# --- Execute scan ---

log_info "Starting Nuclei scan against: ${TARGET}"
log_info "Output file: ${OUTPUT}"
log_info "Command: ${NUCLEI_BIN} ${NUCLEI_ARGS[*]}"
echo ""

if [[ "${USE_DOCKER}" == "true" ]]; then
    docker run --rm \
        -v "${PROJECT_ROOT}/templates:/nuclei/templates:ro" \
        -v "${PROJECT_ROOT}/workflows:/nuclei/workflows:ro" \
        -v "${OUTPUT_DIR}:/output:rw" \
        cosckoya/nuclei:latest \
        -c /nuclei/config.yaml \
        -t /nuclei/templates \
        -w /nuclei/workflows \
        -target "${TARGET}" \
        ${SEVERITY:+-severity "${SEVERITY}"} \
        ${TAGS:+-tags "${TAGS}"} \
        -jsonl -o /output/$(basename "${OUTPUT}")
else
    "${NUCLEI_BIN}" "${NUCLEI_ARGS[@]}"
fi

log_success "Scan completed. Results saved to: ${OUTPUT}"

# --- Post-scan summary ---
if [[ -f "${OUTPUT}" ]] && [[ "${FORMAT}" == "jsonl" ]]; then
    FINDINGS_COUNT=$(wc -l < "${OUTPUT}" 2>/dev/null || echo 0)
    log_info "Total findings: ${FINDINGS_COUNT}"
fi
