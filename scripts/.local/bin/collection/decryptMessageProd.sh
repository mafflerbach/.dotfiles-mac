#/bin/bash

content="$1"

response=$(curl 'http://int-support-p01.sixt.de:8081/api/v1/decrypt' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'X-XSRF-TOKEN: 20e2f5ce-697f-49c5-8b19-43b78a36781d' \
  -H 'Authorization: Basic bTkzMzg6dzcwdE1iMlV0aiVNS3EnSTxXXHF+TGRuVg==' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36' \
  -H 'Content-Type: application/json' \
  -H 'DNT: 1' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Origin: http://int-support-p01.sixt.de:8081' \
  -H 'Referer: http://int-support-p01.sixt.de:8081/queue' \
  -H 'Cookie: XSRF-TOKEN=20e2f5ce-697f-49c5-8b19-43b78a36781d; JSESSIONID=D4F33EEA386CBFF4D761038171EBD0E7' \
  --data-raw $content \
  --compressed \
  -s --insecure)



echo -e $response

