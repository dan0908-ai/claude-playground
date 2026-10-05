# CLAUDE.md

このファイルは Claude Code がこのリポジトリで作業するときの指針です。
`<!-- TODO -->` の箇所はプロジェクト開始時に埋めてください。

## プロジェクト概要

- **名前**: <!-- TODO: プロジェクト名 -->
- **目的**: <!-- TODO: 何を解決するプロジェクトか（1〜2文） -->
- **言語 / ランタイム**: <!-- TODO: 例) Python 3.11 / Node.js 22 + TypeScript -->
- **主なフレームワーク・ライブラリ**: <!-- TODO -->
- **ディレクトリ構成**:
  <!-- TODO: 例)
  - `src/` … アプリ本体
  - `tests/` … テスト
  -->

## 作業ルール

1. **大きな変更は実装前に計画を提示する**
   複数ファイルにまたがる変更、設計・API・データ構造の変更、依存関係の追加などは、
   先に「何を・なぜ・どの順で変えるか」を示し、合意を得てから実装する。
2. **小さくコミットする**
   1コミット1目的。動く状態を保ったまま、意味のある単位で細かくコミットする。
   コミットメッセージは変更内容と理由がわかるように書く。
3. **変更後は必ずテストと lint を実行する**
   下の「よく使うコマンド」のテスト・lint を実行し、通ることを確認してから完了とする。
   失敗した場合は結果をそのまま報告し、通ったふりをしない。
4. **不明点は推測で進めず確認する**
   仕様・意図・前提が曖昧なときは、推測で実装せずに質問する。

### 補足

- `.env`、`.env.*`、`secrets/` 以下は読み取らない（`.claude/settings.json` で禁止済み）。
- ファイル編集後は `.claude/hooks/format.sh` が自動でフォーマットする
  （Python: ruff format / JS・TS ほか: prettier）。
- セッション開始時は `.claude/hooks/install-deps.sh` が依存関係を自動インストールする。
- サブエージェント: `reviewer`（差分レビュー）、`test-writer`（テスト作成）を `.claude/agents/` に用意している。

## よく使うコマンド

| 用途 | コマンド |
|---|---|
| 依存インストール | <!-- TODO: 例) `uv sync` / `npm ci` --> |
| テスト（全体） | <!-- TODO: 例) `uv run pytest` / `npm test` --> |
| テスト（単体ファイル） | <!-- TODO: 例) `uv run pytest tests/test_foo.py` / `npx vitest run src/foo.test.ts` --> |
| lint | <!-- TODO: 例) `uv run ruff check .` / `npm run lint` --> |
| フォーマット | <!-- TODO: 例) `uv run ruff format .` / `npx prettier --write .` --> |
| 型チェック | <!-- TODO: 例) `uv run mypy .` / `npx tsc --noEmit` --> |
| ビルド | <!-- TODO: 例) `uv build` / `npm run build` --> |
| 起動 | <!-- TODO: 例) `uv run python -m app` / `npm run dev` --> |
