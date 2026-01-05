#!/bin/bash
NAME="${1}"
DOMAIN="${2}"
OUTPUT_FILE="results.csv"

# 2つの必須引数が設定されているか確認
if [[ -z "${NAME}" ]] || [[ -z "${DOMAIN}" ]]; then
  echo "You must provide two arguments to this script."
  echo "Example: ${0} mysite nostarch.com"
  exit 1
fi

# CSVヘッダーをファイルに書き込む
echo "status,name,domain,timestamp" > ${OUTPUT_FILE}

if ping -c 1 "${DOMAIN}" &> /dev/null; then
  echo "success,${NAME},${DOMAIN},$(date)" >> "${OUTPUT_FILE}"
else
  echo "failure,${NAME},${DOMAIN},$(date)" >> "${OUTPUT_FILE}"
fi
