#!/bin/bash

set -e

REPO_URL="https://github.com/KevinN2025/nvim_config.git"
NVIM_CONFIG_DIR="${HOME}/.config/nvim"

echo "Syncing Neovim configuration from ${REPO_URL}"

mkdir -p "${HOME}/.config"

if [ -d "${NVIM_CONFIG_DIR}/.git" ]; then
  echo "Existing Neovim config repository found, pulling latest changes"
  git -C "${NVIM_CONFIG_DIR}" pull --ff-only
elif [ -e "${NVIM_CONFIG_DIR}" ]; then
  echo "Cannot install Neovim config because ${NVIM_CONFIG_DIR} exists and is not a git repository"
  exit 1
else
  echo "Cloning Neovim config into ${NVIM_CONFIG_DIR}"
  git clone "${REPO_URL}" "${NVIM_CONFIG_DIR}"
fi

echo "Neovim configuration is up to date"
