#/bin/bash

content="$1"

response=$(curl 'http://int-support-d01.sixt.de:8081/api/v1/decrypt' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'X-XSRF-TOKEN: 700bad6e-473a-4dd4-b8c8-716eab167958' \
  -H 'Authorization: Basic bTkzMzg6RSkmKClYWCJedjhhI0llbyVET1JGIl4mVg==' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'DNT: 1' \
  -H 'Origin: http://int-support-d01.sixt.de:8081' \
  -H 'Referer: http://int-support-d01.sixt.de:8081/queue' \
  -H 'Cookie: XSRF-TOKEN=700bad6e-473a-4dd4-b8c8-716eab167958; JSESSIONID=9DD79478A30A6A73755772BFAC949EAE' \
  --data-raw $content \
  --compressed \
  --insecure)

echo -e $response > /tmp/decryptMessage

