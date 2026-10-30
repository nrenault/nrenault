#!/bin/sh
set -eu

# Every new-tab link must opt out of opener access, and the legacy invalid
# target value must not return.
if grep -q 'target="blank"' README.md; then
  echo 'legacy target="blank" found' >&2
  exit 1
fi

new_tab_links=$(grep -o 'target="_blank"' README.md | wc -l)
secured_new_tab_links=$(grep -o 'target="_blank" rel="noopener noreferrer"' README.md | wc -l)

if [ "$new_tab_links" -ne "$secured_new_tab_links" ]; then
  echo 'a target="_blank" link is missing rel="noopener noreferrer"' >&2
  exit 1
fi

echo "README link security checks passed ($new_tab_links links)"
