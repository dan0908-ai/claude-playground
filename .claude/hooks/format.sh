#!/usr/bin/env bash
# PostToolUse フック: 編集されたファイルを拡張子に応じて自動フォーマットする。
# stdin で受け取るフック入力 JSON の tool_input.file_path を対象にする。
# フォーマッタが無い・失敗した場合でも Claude の作業を止めないよう、常に exit 0 で終える。

input="$(cat)"

if ! command -v jq >/dev/null 2>&1; then
  echo "format.sh: jq が見つからないためスキップ" >&2
  exit 0
fi

file_path="$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
if [ -z "$file_path" ] || [ ! -f "$file_path" ]; then
  exit 0
fi

project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"

case "$file_path" in
  *.py)
    if command -v ruff >/dev/null 2>&1; then
      ruff format --quiet "$file_path" >&2 || echo "format.sh: ruff format に失敗: $file_path" >&2
    else
      echo "format.sh: ruff が見つからないためスキップ: $file_path" >&2
    fi
    ;;
  *.js | *.ts | *.tsx | *.jsx | *.json | *.css | *.html)
    # プロジェクトローカルの prettier を優先し、無ければグローバルを使う
    if [ -x "$project_dir/node_modules/.bin/prettier" ]; then
      prettier="$project_dir/node_modules/.bin/prettier"
    elif command -v prettier >/dev/null 2>&1; then
      prettier="prettier"
    else
      prettier=""
    fi
    if [ -n "$prettier" ]; then
      "$prettier" --write --log-level warn "$file_path" >&2 || echo "format.sh: prettier に失敗: $file_path" >&2
    else
      echo "format.sh: prettier が見つからないためスキップ: $file_path" >&2
    fi
    ;;
esac

exit 0
