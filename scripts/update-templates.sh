#!/bin/bash
# =============================================================================
# update-templates.sh — Sync Nuclei templates from upstream projectdiscovery/nuclei-templates
# =============================================================================

set -euo pipefail

# --- Configuration ---
UPSTREAM_DIR=""
MODE="full"
CATEGORY=""
DRY_RUN="false"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES_DIR="${PROJECT_ROOT}/templates"
CHANGELOG_FILE="${PROJECT_ROOT}/CHANGELOG.md"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

show_help() {
    cat <<EOF
Usage: $0 [OPTIONS]

Sync Nuclei templates from upstream projectdiscovery/nuclei-templates.

Options:
  --upstream DIR    Path to upstream templates repo (required)
  --mode MODE       Sync mode: full, category, dry-run (default: full)
  --category CAT    Category to sync (cves, exposures, technologies, etc.)
  --dry-run         Show what would change without making changes
  -h, --help        Show this help message

Examples:
  $0 --upstream /tmp/opencode/nuclei-templates --mode full
  $0 --upstream /tmp/opencode/nuclei-templates --mode category --category cves --dry-run
EOF
    exit 0
}

# --- Argument parsing ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --upstream)
            UPSTREAM_DIR="$2"; shift 2 ;;
        --mode)
            MODE="$2"; shift 2 ;;
        --category)
            CATEGORY="$2"; shift 2 ;;
        --dry-run)
            DRY_RUN="true"; shift ;;
        -h|--help)
            show_help ;;
        *)
            log_error "Unknown option: $1" ;;
    esac
done

if [[ -z "${UPSTREAM_DIR}" ]]; then
    log_error "--upstream is required"
fi

if [[ ! -d "${UPSTREAM_DIR}" ]]; then
    log_error "Upstream directory not found: ${UPSTREAM_DIR}"
fi

# --- Sync logic ---
NEW_TEMPLATES=()
UPDATED_TEMPLATES=()
SKIPPED_TEMPLATES=()

get_template_id() {
    grep "^id:" "$1" 2>/dev/null | head -1 | sed 's/^id: *//' | tr -d '[:space:]'
}

# Process templates from upstream
process_templates() {
    local source_dir="$1"
    local target_dir="$2"
    
    find "${source_dir}" -name "*.yaml" | while read -r template_file; do
        local template_id
        template_id=$(get_template_id "$template_file")
        
        if [[ -z "${template_id}" ]]; then
            continue
        fi
        
        # Skip our custom cosckoya templates (we maintain them locally)
        if [[ "${template_id}" == cosckoya-* ]]; then
            continue
        fi
        
        # Filter by category if specified
        if [[ -n "${CATEGORY}" ]]; then
            if [[ "${template_file}" != */${CATEGORY}/* ]]; then
                continue
            fi
        fi
        
        # Determine target path (preserve upstream structure relative to template root)
        local rel_path
        rel_path="${template_file#${UPSTREAM_DIR}/}"
        local target_file="${target_dir}/${rel_path}"
        
        if [[ -f "${target_file}" ]]; then
            # Template exists locally, check if different
            if diff -q "${template_file}" "${target_file}" > /dev/null 2>&1; then
                SKIPPED_TEMPLATES+=("${template_id}")
            else
                UPDATED_TEMPLATES+=("${template_id}")
                if [[ "${DRY_RUN}" == "false" ]]; then
                    cp "${template_file}" "${target_file}"
                fi
            fi
        else
            NEW_TEMPLATES+=("${template_id}")
            if [[ "${DRY_RUN}" == "false" ]]; then
                mkdir -p "$(dirname "${target_file}")"
                cp "${template_file}" "${target_file}"
            fi
        fi
    done
}

echo "============================================"
echo "  Nuclei Template Sync"
echo "  Mode: ${MODE}"
echo "  Category: ${CATEGORY:-all}"
echo "  Dry Run: ${DRY_RUN}"
echo "  Upstream: ${UPSTREAM_DIR}"
echo "============================================"
echo ""

if [[ "${MODE}" == "full" || "${MODE}" == "dry-run" ]]; then
    log_info "Syncing all templates from upstream..."
    process_templates "${UPSTREAM_DIR}" "${TEMPLATES_DIR}"
elif [[ "${MODE}" == "category" && -n "${CATEGORY}" ]]; then
    log_info "Syncing category: ${CATEGORY}..."
    process_templates "${UPSTREAM_DIR}" "${TEMPLATES_DIR}"
fi

# --- Report ---
echo ""
echo "============================================"
echo "  Sync Summary"
echo "============================================"
echo "New templates:    ${#NEW_TEMPLATES[@]}"
echo "Updated templates:${#UPDATED_TEMPLATES[@]}"
echo "Skipped templates:${#SKIPPED_TEMPLATES[@]}"
echo ""

if [[ ${#NEW_TEMPLATES[@]} -gt 0 ]]; then
    echo "New templates:"
    for t in "${NEW_TEMPLATES[@]}"; do
        echo "  + ${t}"
    done
fi

if [[ ${#UPDATED_TEMPLATES[@]} -gt 0 ]]; then
    echo "Updated templates:"
    for t in "${UPDATED_TEMPLATES[@]}"; do
        echo "  ~ ${t}"
    done
fi

# --- Update CHANGELOG ---
if [[ "${DRY_RUN}" == "false" ]] && [[ ${#NEW_TEMPLATES[@]} -gt 0 || ${#UPDATED_TEMPLATES[@]} -gt 0 ]]; then
    log_info "Updating CHANGELOG.md..."
    
    SYNC_DATE=$(date +"%Y-%m-%d")
    CHANGELOG_ENTRY="
## [Unreleased]

### Added
- Synced ${#NEW_TEMPLATES[@]} new templates from projectdiscovery/nuclei-templates

### Changed
- Updated ${#UPDATED_TEMPLATES[@]} templates from upstream"

    # Insert after [Unreleased] header if exists, otherwise prepend
    if grep -q "## \[Unreleased\]" "${CHANGELOG_FILE}"; then
        sed -i "/## \[Unreleased\]/a${CHANGELOG_ENTRY}" "${CHANGELOG_FILE}"
    else
        echo "${CHANGELOG_ENTRY}" | cat - "${CHANGELOG_FILE}" > /tmp/changelog.tmp && mv /tmp/changelog.tmp "${CHANGELOG_FILE}"
    fi
    
    log_success "CHANGELOG.md updated"
fi

if [[ "${DRY_RUN}" == "true" ]]; then
    log_warn "Dry run complete - no changes were made"
else
    log_success "Sync complete"
fi
