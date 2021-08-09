#!/bin/bash
curl 'http://192.168.0.50:8000/player' --data '{"target":"'$1'","client":"null"}'
