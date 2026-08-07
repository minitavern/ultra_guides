#!/usr/bin/env bash
# 将当前目录（已由 tavernmm/guides/sync-to-ultra-guides.sh 同步的静态站）提交并推到 minitavern/ultra_guides 的 gh-pages。
# 用法：
#   ./publish.sh
#   ./publish.sh "更新本地模型教程"
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

if [[ -f .publish.env ]]; then
  # shellcheck disable=SC1091
  set -a
  source .publish.env
  set +a
fi

GIT_NAME="${GIT_NAME:-minitavern}"
GIT_EMAIL="${GIT_EMAIL:-}"
REMOTE_URL="${REMOTE_URL:-git@github.com:minitavern/ultra_guides.git}"
MSG="${1:-Publish user guides}"

if [[ -z "$GIT_EMAIL" ]]; then
  echo "error: 请设置 GIT_EMAIL（推荐复制 .publish.env.example → .publish.env）" >&2
  exit 1
fi

if [[ ! -d .git ]]; then
  echo "==> git init (branch gh-pages)"
  git init
  git checkout -b gh-pages
  git remote add origin "$REMOTE_URL"
else
  # 确保在 gh-pages
  current="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
  if [[ "$current" != "gh-pages" ]]; then
    if git show-ref --verify --quiet refs/heads/gh-pages; then
      git checkout gh-pages
    else
      git checkout -b gh-pages
    fi
  fi
  # remote
  if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$REMOTE_URL"
  else
    git remote add origin "$REMOTE_URL"
  fi
fi

git add -A
if git diff --cached --quiet; then
  echo "无变更，跳过 commit。"
else
  git -c user.name="$GIT_NAME" -c user.email="$GIT_EMAIL" commit -m "$MSG"
fi

echo "==> push origin gh-pages"
git push -u origin gh-pages

echo "完成。若尚未开启 Pages：仓库 Settings → Pages → Branch: gh-pages / root"
echo "站点：https://minitavern.github.io/ultra_guides/"
