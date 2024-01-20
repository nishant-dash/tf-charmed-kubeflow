#!/bin/sh
cat <<EOF
{
  "http_proxy": "$http_proxy",
  "https_proxy": "$https_proxy",
  "hostname": "$(hostname -i)"
}
EOF
