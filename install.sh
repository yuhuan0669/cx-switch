#!/usr/bin/env bash
# ==============================================================================
# Installer for cx-switch
# https://github.com/yuhuan0669/cx-switch
# ==============================================================================

set -euo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/yuhuan0669/cx-switch/main/cx-switch"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
TARGET_FILE="$INSTALL_DIR/cx-switch"

echo "==> 正在安装 cx-switch 到 $INSTALL_DIR ..."

mkdir -p "$INSTALL_DIR"

if [[ -f "./cx-switch" ]]; then
  cp "./cx-switch" "$TARGET_FILE"
else
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$REPO_RAW_URL" -o "$TARGET_FILE"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$TARGET_FILE" "$REPO_RAW_URL"
  else
    echo "错误: 未找到 curl 或 wget，无法下载 cx-switch" >&2
    exit 1
  fi
fi

chmod +x "$TARGET_FILE"

echo "==> 安装完成: $TARGET_FILE"

# 检查 PATH 是否包含 INSTALL_DIR
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  echo "⚠️ 注意: $INSTALL_DIR 暂未包含在系统的 PATH 环境变量中。"
  echo "请将以下内容添加到你的 ~/.zshrc 或 ~/.bashrc:"
  echo ""
  echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
  echo ""
fi

echo "使用方法:"
echo "  cx-switch --help"
echo "  cx-switch status"
