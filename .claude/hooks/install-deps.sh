#!/usr/bin/env bash
# SessionStart フック: プロジェクトの依存関係をインストールする。
# 依存定義ファイルが無ければ何もしない。失敗してもセッションを止めないよう、常に exit 0 で終える。

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

run() {
  echo "install-deps.sh: $*" >&2
  "$@" >&2 || echo "install-deps.sh: 失敗しました（続行します）: $*" >&2
}

# Node.js（node_modules が既にあれば再インストールしない）
if [ -f package.json ] && [ -d node_modules ]; then
  echo "install-deps.sh: node_modules が既に存在するため npm のインストールをスキップ" >&2
elif [ -f package-lock.json ]; then
  if command -v npm >/dev/null 2>&1; then run npm ci; else echo "install-deps.sh: npm が見つからないためスキップ" >&2; fi
elif [ -f package.json ]; then
  if command -v npm >/dev/null 2>&1; then run npm install; else echo "install-deps.sh: npm が見つからないためスキップ" >&2; fi
fi

# Python
if [ -f pyproject.toml ]; then
  if command -v uv >/dev/null 2>&1; then run uv sync; else echo "install-deps.sh: uv が見つからないためスキップ" >&2; fi
elif [ -f requirements.txt ]; then
  if command -v uv >/dev/null 2>&1; then run uv pip install --system -r requirements.txt; else echo "install-deps.sh: uv が見つからないためスキップ" >&2; fi
fi

exit 0
