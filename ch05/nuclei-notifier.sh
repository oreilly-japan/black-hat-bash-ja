#!/bin/bash

FROM_ADDR="from@example.com"
TO_ADDR="test@example.com"

SMTP_SERVER="localhost"
SMTP_PORT="1025"

for ip_address in "$@"; do
  echo "Testing ${ip_address} with Nuclei..."
  result=$(nuclei -u "${ip_address}" -silent -severity medium,high,critical)

  if [[ -n "${result}" ]]; then
    while read -r line; do
      template=$(echo "${line}" | awk '{print $1}' | tr -d '[]')
      url=$(echo "${line}" | awk '{print $4}')

      echo "Sending an email with the findings ${template} ${url}"

      sendemail \
        -f "${FROM_ADDR}" \
        -t "${TO_ADDR}" \
        -u "[Nuclei] Vulnerability Found!" \
        -m "${template} - ${url}" \
        -s "${SMTP_SERVER}:${SMTP_PORT}"

    done <<< "${result}"
  fi
done
