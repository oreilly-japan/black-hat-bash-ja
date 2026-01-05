#!/bin/bash

DATA_FILE="nmap_frequency_data"

print_help() {
  echo "Usage: $0 <TARGET_IP_1> <TARGET_IP_2> ..."
  echo "  You can specify multiple target IP addresses."
}

# 引数のチェック
if [[ $# -lt 1 ]]; then
  echo "Error: You must specify at least one target IP address." >&2
  print_help
  exit 1
fi

TARGETS=("$@")

# 頻度データファイルが存在するか確認する
if [[ ! -r "$DATA_FILE" ]]; then
  echo "Error: ${DATA_FILE} not found or not readable." >&2
  exit 1
fi

echo "Using frequency data: $DATA_FILE"
echo

# 頻度順（降順）で読み込み、ソート
sort -k3,3nr "$DATA_FILE" | awk '{print $1, $2, $3}' | \
while read -r service port_proto freq; do
  # "22/tcp" からポート番号を抽出する
  port="${port_proto%/tcp}"

  for target in "${TARGETS[@]}"; do
    # nc が while ループの標準入力を消費しないようにする
    if nc -z -w 1 "$target" "$port" </dev/null 2>/dev/null; then
      echo "IP: ${target}"
      echo "Port: ${port}"
      echo "Service: $(grep -w "${port}/tcp" /etc/services | awk '{print $1}')"
      echo
    fi
  done
done
