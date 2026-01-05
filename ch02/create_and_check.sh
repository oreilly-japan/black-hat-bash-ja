#!/bin/bash

echo "Hello World!" > file.txt

if [[ -f "file.txt" ]] && [[ -s "file.txt" ]]; then
  echo "The file exists and its size is greater than zero."
fi
