#!/usr/bin/bash
set -xe

TKN=`curl localhost:5000/api/token | jq -r .token` && echo $TKN

curl -X POST -d 'key=helloworld&content=helloworld' localhost:5000/api/$TKN/add
curl -X POST -d 'key=loremipsum&content=loremipsum' localhost:5000/api/$TKN/add
curl localhost:5000/api/$TKN/list