#!/usr/bin/env bash
# Checks that app-ads.txt is reachable where the AdMob crawler looks for it.
# AdMob strips "www." from the developer website, so it fetches rexbuilds.com/app-ads.txt.
set -u
DOMAIN="${1:-rexbuilds.com}"
status=0

if grep -q "pub-0000000000000000" app-ads.txt; then
  echo "FAIL  app-ads.txt still has the placeholder publisher ID"
  status=1
fi

echo "DNS   $DOMAIN -> $(dig +short "$DOMAIN" A | tr '\n' ' ')"

for scheme in https http; do
  url="$scheme://$DOMAIN/app-ads.txt"
  code=$(curl -sSL -o /tmp/app-ads-check.txt -w "%{http_code} %{content_type}" --max-time 15 "$url" 2>&1)
  if [[ "$code" == 200\ text/plain* ]]; then
    echo "OK    $url  ($code)"
    if ! diff -q <(tr -d '\r' < /tmp/app-ads-check.txt) <(tr -d '\r' < app-ads.txt) >/dev/null; then
      echo "WARN  live file differs from local app-ads.txt (GitHub Pages can take a few minutes to update)"
    fi
  else
    echo "FAIL  $url  ($code)"
    status=1
  fi
done
exit $status
