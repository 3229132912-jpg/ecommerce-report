#!/usr/bin/env bash
# 一键推送「作品二 · 电商竞品分析交互报告」到 GitHub 并可选开启 Pages
# 用法：bash push_to_github.sh <你的GitHub用户名> <仓库名>
# 示例：bash push_to_github.sh zhangsan ecommerce-report
set -e

USER_NAME="${1:?请传入 GitHub 用户名}"
REPO="${2:?请传入仓库名}"
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

echo "==> 目标仓库：https://github.com/${USER_NAME}/${REPO}"

# 1. 如果远程仓库还不存在，请先在网页端新建：
#    https://github.com/new  →  Repository name 填 ${REPO} → Public → 不要勾选 README → Create
read -p "已在 GitHub 网页端创建好空仓库 ${REPO} 了吗？(y/n) " yn
[ "$yn" = "y" ] || { echo "请先到 https://github.com/new 创建仓库后重试"; exit 1; }

# 2. 关联远程并推送（会提示输入用户名和密码——密码处粘贴 Personal Access Token）
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/${USER_NAME}/${REPO}.git"
git push -u origin main

echo ""
echo "==> 推送完成！"
echo "==> 开启 GitHub Pages（可选）："
echo "    仓库页 → Settings → Pages → Source 选 'Deploy from a branch'"
echo "    → Branch 选 main / (root) → Save"
echo "    约 1 分钟后访问：https://${USER_NAME}.github.io/${REPO}/"
echo ""
echo "==> 若要并入作品集网站：把本目录内容复制到作品集仓库的 works/ecommerce-report/ 提交即可"
