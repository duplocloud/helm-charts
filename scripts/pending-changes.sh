#!/usr/bin/env bash
set -euo pipefail

CHART="aos"
LAST_TAG=$(git tag --sort=-version:refname | grep "^${CHART}-" | head -1)

if [ -z "$LAST_TAG" ]; then
  echo "No previous release tag found for '${CHART}'. Showing all commits:"
  git log --pretty=format:"  - %s (%h)" -- "charts/${CHART}/"
else
  COUNT=$(git rev-list --count "${LAST_TAG}..HEAD" -- "charts/${CHART}/")
  echo "Changes since last release (${LAST_TAG}) — ${COUNT} commit(s):"
  echo ""
  git log --pretty=format:"  - %s (%h)" "${LAST_TAG}..HEAD" -- "charts/${CHART}/"
  echo ""
  echo "Current version: $(grep '^version:' "charts/${CHART}/Chart.yaml" | awk '{print $2}')"
fi
