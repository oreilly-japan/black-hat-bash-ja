#!/bin/bash
USER_INPUT="${1}"

# ユーザーが引数を渡したかどうかをチェック
if [[ -z "${USER_INPUT}" ]]; then
  echo "You must provide an argument!"
  exit 1
fi

# 引数がファイルかディレクトリかをチェック
if [[ -f "${USER_INPUT}" ]]; then
 echo "${USER_INPUT} is a file."
elif [[ -d "${USER_INPUT}" ]]; then
  echo "${USER_INPUT} is a directory."
else
  echo "${USER_INPUT} is not a file or a directory."
fi
