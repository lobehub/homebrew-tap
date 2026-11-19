#!/usr/bin/env bash
# 把 tap 里的 cask / formula 更新到 upstream 最新版本。
#
#   ./scripts/bump.sh          # 全量（stable cask + canary cask + CLI formula）
#   ./scripts/bump.sh stable   # 只查 LobeHub Desktop 正式版
#   ./scripts/bump.sh canary   # 只查 LobeHub Desktop canary
#   ./scripts/bump.sh formula  # 只查 @lobehub/cli
#
# 有变更时会改写工作区文件并输出 changed=1（供 CI 判断是否提交）。
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${root}"

target="${1:-all}"
changed=0
api="https://api.github.com/repos/lobehub/lobehub"

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1
  then
    sha256sum "${1}" | awk '{print $1}'
  else
    shasum -a 256 "${1}" | awk '{print $1}'
  fi
}

current_version() {
  sed -nE 's/^  version "([^"]+)"$/\1/p' "$1"
}

# 下载 dmg 并回显 sha256
dmg_sha256() {
  local version="${1}" arch="${2}" dest="${3}"
  local file="LobeHub-${version}-${arch}.dmg"
  curl -fL --retry 3 --retry-delay 2 -o "${dest}/${file}" \
    "https://github.com/lobehub/lobehub/releases/download/v${version}/${file}" >/dev/null
  sha256_of "${dest}/${file}"
}

tmp="$(mktemp -d)"
trap 'rm -rf "${tmp}"' EXIT

bump_stable() {
  local cask="Casks/lobehub.rb"
  local version current arm_sha intel_sha

  version="$(curl -fsSL "${api}/releases/latest" | jq -r '.tag_name' | sed 's/^v//')"
  current="$(current_version "${cask}")"

  if [[ "${version}" == "${current}" ]]
  then
    echo "stable: up to date (${current})"
    return 0
  fi

  echo "stable: ${current} -> ${version}"
  arm_sha="$(dmg_sha256 "${version}" arm64 "${tmp}")"
  intel_sha="$(dmg_sha256 "${version}" x64 "${tmp}")"

  sed -i.bak -E "s/^  version \".*\"\$/  version \"${version}\"/" "${cask}"
  perl -0pi -e \
    "s/sha256 arm:   \"[0-9a-f]{64}\",\n\s+intel: \"[0-9a-f]{64}\"/sha256 arm:   \"${arm_sha}\",\n         intel: \"${intel_sha}\"/" \
    "${cask}"
  rm -f "${cask}.bak"
  changed=1
}

bump_canary() {
  local cask="Casks/lobehub@canary.rb"
  local version current arm_sha

  # canary 是 prerelease，releases/latest 拿不到，直接取最新的 canary tag。
  version="$(curl -fsSL "${api}/releases?per_page=40" | jq -r '
    [.[] | select(.prerelease) | .tag_name | select(test("canary"))][0] // empty' | sed 's/^v//')"
  if [[ -z "${version}" ]]
  then
    echo "canary: no canary release found"
    return 0
  fi

  current="$(current_version "${cask}")"
  if [[ "${version}" == "${current}" ]]
  then
    echo "canary: up to date (${current})"
    return 0
  fi

  echo "canary: ${current} -> ${version}"
  # canary 目前只出 arm64 dmg
  arm_sha="$(dmg_sha256 "${version}" arm64 "${tmp}")"

  sed -i.bak -E "s/^  version \".*\"\$/  version \"${version}\"/" "${cask}"
  sed -i.bak -E "s/^  sha256 \"[0-9a-f]{64}\"\$/  sha256 \"${arm_sha}\"/" "${cask}"
  rm -f "${cask}.bak"
  changed=1
}

bump_formula() {
  local formula="Formula/lobehub-cli.rb"
  local meta version tarball current sha

  meta="$(curl -fsSL https://registry.npmjs.org/@lobehub/cli/latest)"
  version="$(jq -r '.version' <<<"${meta}")"
  tarball="$(jq -r '.dist.tarball' <<<"${meta}")"
  current="$(sed -nE 's|^  url ".*cli-([0-9][^"]*)\.tgz"$|\1|p' "${formula}")"

  if [[ "${version}" == "${current}" ]]
  then
    echo "formula: up to date (${current})"
    return 0
  fi

  echo "formula: ${current} -> ${version}"
  curl -fL --retry 3 --retry-delay 2 -o "${tmp}/cli.tgz" "${tarball}" >/dev/null
  sha="$(sha256_of "${tmp}/cli.tgz")"

  sed -i.bak -E "s|^  url \"https://registry.npmjs.org/@lobehub/cli/-/cli-.*\.tgz\"\$|  url \"${tarball}\"|" "${formula}"
  sed -i.bak -E "s/^  sha256 \"[0-9a-f]{64}\"\$/  sha256 \"${sha}\"/" "${formula}"
  rm -f "${formula}.bak"
  changed=1
}

case "${target}" in
  all)
    bump_stable
    bump_canary
    bump_formula
    ;;
  stable) bump_stable ;;
  canary) bump_canary ;;
  formula) bump_formula ;;
  *)
    echo "usage: ${0} [all|stable|canary|formula]" >&2
    exit 2
    ;;
esac

if [[ "${changed}" == "1" ]]
then
  echo "changed=1" >>"${GITHUB_OUTPUT:-/dev/null}"
else
  echo "changed=0" >>"${GITHUB_OUTPUT:-/dev/null}"
fi
