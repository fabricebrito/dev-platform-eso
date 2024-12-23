# dev-platform-eso


```
helm repo add external-secrets https://charts.external-secrets.io && helm repo update
```


kubectl create secret generic secret-one -n remote-cluster --from-literal=the-key=secret-value