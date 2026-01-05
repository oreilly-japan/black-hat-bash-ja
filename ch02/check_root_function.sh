#!/bin/bash

# この関数は現在のユーザーIDが0（root）であるかどうかを確認します。
check_if_root(){
  if [[ "${EUID}" -eq "0" ]]; then
    return 0
  else
    return 1
  fi
}

if check_if_root; then
  echo "User is root!"
else
  echo "User is not root!"
fi
