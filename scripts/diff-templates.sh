#!/bin/bash
# =============================================================================
# diff-templates.sh — Compare local templates with upstream projectdiscovery/nuclei-templates
# =============================================================================

set -euo pipefail

UPSTREAM_DIR="${1:-/tmp/opencode/nuclei-templates-upstream}"
TEMPLATES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/templates"

if [[ ! -d "${UPSTREAM_DIR}" ]]; then
    echo "Usage: $0 <upstream-dir>"
    echo "Upstream directory not found: ${UPSTREAM_DIR}"
    exit 1
fi

echo "Comparing local templates with upstream..."
echo "Upstream: ${UPSTREAM_DIR}"
echo "Local:    ${TEMPLATES_DIR}"
echo ""

MISSING=0
DIFFERENT=0
SAME=0

find "${UPSTREAM_DIR}" -name "*.yaml" | while read -r upstream_file; do
    template_id=$(grep "^id:" "$upstream_file" 2>/dev/null | head -1 | sed 's/^id: *//' | tr -d '[:space:]')
    
    if [[ -z "${template_id}" ]]; then
        continue
    fi
    
    # Skip cosckoya custom templates
    if [[ "${template_id}" == cosckoya-* ]]; then
        continue
    fi
    
    # Find local template with same ID
    local_file=$(grep -rl "^id: ${template_id}$" "${TEMPLATES_DIR}" 2>/dev/null | head -1)
    
    if [[ -z "${local_file}" ]]; then
        MISSING=$((MISSING + 1))
        echo "[MISSING] ${template_id}"
    elif diff -q "${upstream_file}" "${local_file}" > /dev/null 2>&1; then
        SAME=$((SAME + 1))
    else
        DIFFERENT=$((DIFFERENT + 1))
        echo "[DIFFERENT] ${template_id}"
        echo "  Upstream: ${upstream_file}"
        echo "  Local:    ${local_file}"
    fi
done

echo ""
echo "============================================"
echo "  Diff Summary"
echo "============================================"
echo "Missing:    ${MISSING}"
echo "Different:  ${DIFFERENT}"
echo "Same:       ${SAME}"
echo "============================================"
