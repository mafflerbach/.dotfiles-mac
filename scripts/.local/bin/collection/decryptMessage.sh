#/bin/bash

content="$1"

response=$(curl 'http://int-support-d01.sixt.de:8081/api/v1/decrypt' \
  -H 'X-XSRF-TOKEN: 379979ce-da94-4010-8c89-e1659825049e' \
  -H 'Authorization: Basic bTkzMzg6OW9YKDpDe008ZS0/JkV9RmRhfG9TOXhrVw==' \
  -H 'Content-Type: application/json' \
  -H 'Cookie: XSRF-TOKEN=379979ce-da94-4010-8c89-e1659825049e; JSESSIONID=EF040F7AE996CFDDA95F1C5C320B0905' \
  --data-raw $content \
  --compressed \
  --insecure)


echo -e $response > /tmp/decryptMessage

