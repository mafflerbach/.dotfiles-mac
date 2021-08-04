#!/bin/bash

pod=$(echo $(kubectl get pods | fzf) | cut -f1 -d' ')
port=$(echo -e "9090\r\n9091" | fzf)
kubectl port-forward $pod $port:8080 &
kubectl logs $pod -f


