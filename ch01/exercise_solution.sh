#!/bin/bash

# 引数1と引数2を変数に代入
FIRST_NAME="${1}"
LAST_NAME="${2}"

# output.txtという名前のファイルを作成
touch output.txt

# DD-MM-YYYY形式で現在の日付を書き込む
date +%d-%m-%Y >> output.txt

# ファイルに名と姓を追加
echo "${FIRST_NAME} ${LAST_NAME}" >> output.txt

# output.txtファイルを新しいbackup.txtファイルにバックアップ
cp output.txt backup.txt

# output.txtファイルの内容を出力
cat output.txt
