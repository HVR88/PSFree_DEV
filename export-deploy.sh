#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAGE_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/psfree-deploy.XXXXXX")"
STAGE_DIR="${STAGE_ROOT}/stage"

cleanup() {
  rm -rf "${STAGE_ROOT}"
}
trap cleanup EXIT

if [ -d "${ROOT_DIR}/deploy" ]; then
  SOURCE_DIR="${ROOT_DIR}/deploy"
  RSYNC_EXCLUDES=(
    --exclude ".env*"
    --exclude ".DS_Store"
  )
else
  SOURCE_DIR="${ROOT_DIR}"
  RSYNC_EXCLUDES=(
    --exclude ".git"
    --exclude ".github"
    --exclude ".vscode"
    --exclude ".code"
    --exclude ".DS_Store"
    --exclude ".env*"
    --exclude "dist"
    --exclude "deploy"
    --exclude "archive"
  )
fi

mkdir -p "${STAGE_DIR}"

rsync -a "${RSYNC_EXCLUDES[@]}" "${SOURCE_DIR}/" "${STAGE_DIR}/"

if [ "${SOURCE_DIR}" = "${ROOT_DIR}" ]; then
  if [ -f "${ROOT_DIR}/LICENSE" ] || [ -f "${ROOT_DIR}/THIRD_PARTY_NOTICES.md" ]; then
    mkdir -p "${STAGE_DIR}/License"
    if [ -f "${ROOT_DIR}/LICENSE" ]; then
      cp -f "${ROOT_DIR}/LICENSE" "${STAGE_DIR}/License/LICENSE"
    fi
    if [ -f "${ROOT_DIR}/THIRD_PARTY_NOTICES.md" ]; then
      cp -f "${ROOT_DIR}/THIRD_PARTY_NOTICES.md" "${STAGE_DIR}/License/THIRD_PARTY_NOTICES.md"
    fi
  fi
fi

if [ -n "${DEPLOY_REPO:-}" ]; then
  RSYNC_ARGS=(
    -a
    --exclude ".git"
  )
  if [ "${DEPLOY_DELETE:-0}" = "1" ]; then
    RSYNC_ARGS+=(--delete)
  fi
  rsync "${RSYNC_ARGS[@]}" "${STAGE_DIR}/" "${DEPLOY_REPO}/"
fi

echo "Deploy staging complete: ${STAGE_DIR}"
