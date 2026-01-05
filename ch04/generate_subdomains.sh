#!/bin/bash
DOMAIN="${1}"
FILE="${2}"

# 標準入力からファイルを読み込み、完全なドメイン名を表示する。
while IFS= read -r subdomain || [ -n "$subdomain" ]; do
  echo "${subdomain}.${DOMAIN}"
done < "${FILE}"