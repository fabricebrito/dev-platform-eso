# dev-platform-eso

```
helm repo add external-secrets https://charts.external-secrets.io && helm repo update
```

All secrets are created in the namespace `remote-cluster`

Namespaces where secrets are synched must be labeled:

```
labels:
  eso: enabled
```