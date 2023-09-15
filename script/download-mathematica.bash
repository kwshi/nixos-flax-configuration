#!/bin/bash
set -euo pipefail

csrf="$(curl -fsS -c cookies \
  'https://account.wolfram.com/login/oauth2/sign-in' \
  | pup 'input[name="_csrf"] attr{value}'
)"

curl -fsS -c cookies -b cookies \
  --data-urlencode 'j_password@-' \
  --data-urlencode 'j_username=kwshi@hmc.edu' \
  -d 'spring-security-redirect=' \
  -d "_csrf=$csrf" \
  --data-urlencode 'timeZone=America/Los_Angeles' \
  --data-urlencode 'j_staySignedIn=remember-me' \
  'https://account.wolfram.com/login/j_spring_security_check' \
    < <(pass show wolfram.com/kwshi@hmc.edu | head -n 1 | tr -d '\n')

path="$(curl -fsSL -c cookies -b cookies \
  'https://user.wolfram.com/portal/myProducts.html' \
  | pup -p 'table.PortalTable a attr{href}' \
  | head -n 1
)"

readarray -t -d ';' fields < <(curl -fsSL -c cookies -b cookies \
  "https://user.wolfram.com$path" \
  | pup 'a[rel*=";Linux;"] attr{rel}'
)


tmp="$(mktemp --tmpdir="${XDG_RUNTIME_DIR:-/tmp}" -d 'mathematica-download.XXXXX')"
curl -c cookies -b cookies -o "$tmp/${fields[5]}" -L \
  "https://user.wolfram.com/portal/download.html?exec=${fields[0]}&lic=${fields[6]}&lpid=${fields[8]}"
mkdir -p 'mathematica'
mv -t 'mathematica' "$tmp/${fields[5]}"
rm -rf "$tmp"
