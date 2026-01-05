#!/bin/bash

# sleepコマンドをバックグラウンドで実行
echo "Sleeping for 10 seconds..."
sleep 10 &

# ファイル作成
echo "Creating the file test123"
touch test123

# ファイル削除
echo "Deleting the file test123"
rm test123
