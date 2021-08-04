#/bin/bash

content="$1"

response=$(curl 'http://int-support-d01.sixt.de:8081/api/v1/decrypt' \
  -H 'X-XSRF-TOKEN: 56b1468c-5869-4590-926f-2a46dcc78a0a' \
  -H 'Authorization: Basic bTkzMzg6cVxaNj09V2twcnNbMU90WCFASFEwMEhaWw==' \
  -H 'Content-Type: application/json' \
  -H 'Cookie: XSRF-TOKEN=56b1468c-5869-4590-926f-2a46dcc78a0a; JSESSIONID=5D9582179307F3AAFA78C19AACE6591B' \
  --data-raw $content \
  --compressed \
  --insecure)

echo -e $response > /tmp/decryptMessage

