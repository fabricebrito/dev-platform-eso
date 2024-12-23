# dev-platform-eso

## Helm repo

Add the External Secret Operator helm chart repo:

```
helm repo add external-secrets https://charts.external-secrets.io && helm repo update
```

## Where to create secrets

All secrets are created in the namespace `remote-cluster`

Namespaces where secrets are synched must be labeled:

```yaml
labels:
  eso: enabled
```

## How to request secrets

Secrets are requested and synched with a manifest:

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: data-by-name
  namespace: <target namespace > # this namespace is labelled "eso: enabled" 
spec:
  refreshInterval: 15s
  secretStoreRef:
    kind: ClusterSecretStore
    name: k8s-secret-store

  target:
    name: data-by-name
    creationPolicy: Owner

  data:
    - secretKey: secret-value
      remoteRef:
        key: secret-one # name of the secret
        property: "the-key" # key in the secret
```