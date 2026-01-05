#!/bin/bash

# ユーザーから入力を受け取り、変数に代入します。
echo "What is your first name?"
read -r firstname

echo "What is your last name?"
read -r lastname

echo "Your first name is ${firstname} and your last name is ${lastname}"
