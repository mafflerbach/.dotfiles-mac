#!/bin/bash

pod=$(echo $(kubectl get pods | fzf) | cut -f1 -d' ')
port=$(echo -e "9090\n9091\n8080\n5005" | fzf)
podPort=$(echo -e "8080\n5005" | fzf)
kubectl port-forward $pod $port:$podPort &
kubectl logs $pod -f


