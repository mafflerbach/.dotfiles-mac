#/bin/bash

content="$1"

response=$(curl 'http://int-support-p01.sixt.de:8081/api/v1/decrypt' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'X-XSRF-TOKEN: e73b0842-8e7e-4469-8b0f-a7fa87bfb793' \
  -H 'Authorization: Basic bTkzMzg6RmsrNlE/JEB8eHlHaGk0dkt6dDR4fTVPSg==' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36' \
  -H 'Content-Type: application/json' \
  -H 'DNT: 1' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Origin: http://int-support-p01.sixt.de:8081' \
  -H 'Referer: http://int-support-p01.sixt.de:8081/queue' \
  -H 'Cookie: optimizelyEndUserId=oeu1650888644921r0.3591095280032124; XSRF-TOKEN=e73b0842-8e7e-4469-8b0f-a7fa87bfb793; JSESSIONID=10169644292F10A67AB112EE838E1AEF' \
  --data-raw $content \
  --compressed \
  -s --insecure)

echo -e $response


