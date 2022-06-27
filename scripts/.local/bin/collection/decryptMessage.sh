#/bin/bash

content="$1"

response=$(curl 'http://int-support-d01.sixt.de:8081/api/v1/decrypt' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'X-XSRF-TOKEN: f0d437f0-927f-47f8-bde9-165c7e25cf61' \
  -H 'Authorization: Basic bTkzMzg6bzFGZCpgQ10sZ2s5NnE7SyhIfnVoIygpKQ==' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'DNT: 1' \
  -H 'Referer: http://int-support-d01.sixt.de:8081/queue' \
  -H 'Cookie: XSRF-TOKEN=f0d437f0-927f-47f8-bde9-165c7e25cf61; JSESSIONID=E7BE21A0F0DA9714A6CA2258A0591D5B' \
  --data-raw $content \
  --compressed \
  --insecure)

echo -e $response > /tmp/decryptMessage
