#!/usr/bin/env bash
# 将 skill 主体内容打包成 zip，发布到本仓库的稳定 tag Release（skill-latest），供用户直接下载。
# 在 CNB 流水线 push 事件中运行，依赖环境变量：CNB_TOKEN / CNB_REPO_SLUG / CNB_COMMIT / CNB_COMMIT_SHORT / CNB_BUILD_ID
set -euo pipefail

TAG="skill-latest"
ZIP_NAME="huashu-design-skill.zip"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "${WORK_DIR}"' EXIT

echo "==> 1/5 收集 skill 主体内容"
STAGE="${WORK_DIR}/huashu-design"
mkdir -p "${STAGE}"
for item in SKILL.md README.md README.en.md LICENSE references scripts assets demos package.json .env.example; do
  [ -e "${item}" ] && cp -r "${item}" "${STAGE}/"
done
# 打包前清理产物/中间文件（与 .gitignore 保持一致）
find "${STAGE}" \( -name ".DS_Store" -o -name "__pycache__" \) -exec rm -rf {} + 2>/dev/null || true
find "${STAGE}" -type d -name "_narration*" -exec rm -rf {} + 2>/dev/null || true
find "${STAGE}" -type d -name ".video-tmp-*" -exec rm -rf {} + 2>/dev/null || true
rm -f "${STAGE}/assets/personal-asset-index.json"

echo "==> 2/5 压缩为 ${ZIP_NAME}"
(cd "${WORK_DIR}" && zip -q -r -9 "${ZIP_NAME}" huashu-design)
ZIP_PATH="${WORK_DIR}/${ZIP_NAME}"
ZIP_SIZE=$(stat -c%s "${ZIP_PATH}")
echo "    zip 大小: ${ZIP_SIZE} bytes ($(du -h "${ZIP_PATH}" | cut -f1))"

echo "==> 3/5 准备 Release（tag: ${TAG}）"
BODY_FILE="${WORK_DIR}/body.md"
cat > "${BODY_FILE}" <<EOF
## Huashu Design Skill 最新打包下载

| 文件 | 说明 |
|------|------|
| [${ZIP_NAME}](https://cnb.cool/${CNB_REPO_SLUG}/-/releases/download/${TAG}/${ZIP_NAME}) | skill 主体内容（SKILL.md + references/ + scripts/ + assets/ + demos/），解压后即为完整 skill 目录 |

- Commit: \`${CNB_COMMIT_SHORT}\`
- 构建: [#${CNB_BUILD_ID}](https://cnb.cool/${CNB_REPO_SLUG}/-/build/${CNB_BUILD_ID})
- 更新方式: 每次 master 分支有 push 时自动重新打包并覆盖同名附件

> 本 Release 由流水线自动生成（scripts/release-zip.sh），请勿手动编辑。
EOF

RELEASE_JSON=$(cnb releases get-release-by-tag --repo "${CNB_REPO_SLUG}" --tag "${TAG}" --verbose 2>/dev/null || true)
RELEASE_ID=$(echo "${RELEASE_JSON}" | jq -r 'try (.data.id // .data.release.id // empty)' 2>/dev/null || true)

if [ -z "${RELEASE_ID}" ]; then
  echo "    Release 不存在，创建新的（make-latest=false，不影响正式版本）"
  CREATE_JSON=$(cnb releases post-release --repo "${CNB_REPO_SLUG}" \
    --tag-name "${TAG}" --target-commitish "${CNB_COMMIT}" \
    --name "Skill 最新构建包（自动更新）" \
    --make-latest false --body-file "${BODY_FILE}" --verbose)
  RELEASE_ID=$(echo "${CREATE_JSON}" | jq -r '.data.id // .data.release.id')
else
  echo "    Release 已存在（id=${RELEASE_ID}），更新描述"
  cnb releases patch-release --repo "${CNB_REPO_SLUG}" --release-id "${RELEASE_ID}" --body-file "${BODY_FILE}" >/dev/null
fi
echo "    RELEASE_ID=${RELEASE_ID}"

echo "==> 4/5 上传 zip 附件（覆盖同名）"
UP_JSON=$(cnb releases post-release-asset-upload-url --repo "${CNB_REPO_SLUG}" \
  --release-id "${RELEASE_ID}" --asset-name "${ZIP_NAME}" --size "${ZIP_SIZE}" --overwrite --verbose)
echo "${UP_JSON}" | jq -e '.data' >/dev/null

UPLOAD_URL=$(echo "${UP_JSON}" | jq -r '.data.upload_url // .data.url // empty')
if [ -z "${UPLOAD_URL}" ]; then
  echo "!! 无法从上传地址响应中解析 upload_url，原始响应：" >&2
  echo "${UP_JSON}" | jq '.' >&2
  exit 1
fi

HTTP_CODE=$(curl -sS -o "${WORK_DIR}/put_resp.json" -w "%{http_code}" -X PUT \
  -H "Content-Type: application/zip" --data-binary "@${ZIP_PATH}" "${UPLOAD_URL}")
echo "    PUT ${HTTP_CODE}"
[ "${HTTP_CODE}" -ge 200 ] && [ "${HTTP_CODE}" -lt 300 ] || { cat "${WORK_DIR}/put_resp.json" >&2; exit 1; }

VERIFY_URL=$(echo "${UP_JSON}" | jq -r '.data.verify_url // empty')
UPLOAD_TOKEN=""
ASSET_PATH=""
if [ -n "${VERIFY_URL}" ]; then
  UPLOAD_TOKEN=$(echo "${VERIFY_URL}" | sed -n 's/.*[?&]upload_token=\([^&]*\).*/\1/p')
  ASSET_PATH=$(echo "${VERIFY_URL}" | sed -n 's/.*[?&]asset_path=\([^&]*\).*/\1/p')
fi
UPLOAD_TOKEN=${UPLOAD_TOKEN:-$(echo "${UP_JSON}" | jq -r '.data.upload_token // empty')}
ASSET_PATH=${ASSET_PATH:-$(echo "${UP_JSON}" | jq -r '.data.asset_path // empty')}

echo "==> 5/5 确认附件上传"
if [ -n "${UPLOAD_TOKEN}" ] && [ -n "${ASSET_PATH}" ]; then
  cnb releases post-release-asset-upload-confirmation --repo "${CNB_REPO_SLUG}" \
    --release-id "${RELEASE_ID}" --upload-token "${UPLOAD_TOKEN}" --asset-path "${ASSET_PATH}" --ttl 0 >/dev/null
  echo "    已确认"
else
  echo "    未解析到 upload_token/asset_path，跳过确认（PUT 已成功）"
fi

echo ""
echo "✅ 完成！下载地址："
echo "   https://cnb.cool/${CNB_REPO_SLUG}/-/releases/download/${TAG}/${ZIP_NAME}"
