#!/bin/bash

# 終了コードの確認

ls -l > /dev/null
echo "The status code of the ls command was: $?"

lzl 2> /dev/null
echo "The status code of the non-existing lzl command was: $?"
