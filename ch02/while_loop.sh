#!/bin/bash
SIGNAL_TO_STOP_FILE="stoploop"

# このループは"stoploop"ファイルの存在が確認されるまで継続する
while [[ ! -f "${SIGNAL_TO_STOP_FILE}" ]]; do
  echo "The file ${SIGNAL_TO_STOP_FILE} does not yet exist..."
  echo "Checking again in 2 seconds..."
  sleep 2
done

echo "File was found! Exiting..."
