#!/bin/bash

# 配列の設定
IP_ADDRESSES=(192.168.1.1 192.168.1.2 192.168.1.3)

# 配列の全要素の出力
echo "${IP_ADDRESSES[*]}"

# 配列の先頭要素の出力
echo "${IP_ADDRESSES[0]}"