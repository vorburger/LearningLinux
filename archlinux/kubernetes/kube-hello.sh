#!/usr/bin/bash
set -euox pipefail

# https://github.com/GoogleCloudPlatform/kubernetes-engine-samples/blob/master/hello-app/main.go
kubectl create deployment hello --image=gcr.io/google-samples/hello-app:1.0
kubectl expose deployment hello --type=NodePort --port=1234 --target-port=8080

kubectl wait --for=condition=available deployment/hello

kubectl describe pod hello
kubectl describe deployment hello
kubectl get deployment hello

curl http://$(kubectl get nodes -o=jsonpath={.items[0].status.addresses[0].address}):$(kubectl get svc hello --output=jsonpath='{range .spec.ports[0]}{.nodePort}')

kubectl delete service hello
kubectl delete deployment hello
