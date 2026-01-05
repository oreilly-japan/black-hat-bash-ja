#!/bin/bash
VARIABLE_ONE="nostarch"
VARIABLE_TWO="nostarch"

# 2つの変数が等しいかテストする
if [[ "${VARIABLE_ONE}" == "${VARIABLE_TWO}" ]]; then
  echo "They are equal!"
else
  echo "They are not equal!"
fi
