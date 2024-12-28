# dev-platform-eso

This repository provides a deployment of the External Secret Operator and a kubernetes secret store.

The kubernetes secret store allows synchronyzing secrets from a namespace to other namespaces when they're requested.

These other namespaces have the label `eso: enabled` to tell the operator that secrets can be synched.

This allows setting all needed secrets in a single namespace acting as a secret store and then "claim" these secrets when needed in other namespaces.

## Helm repo

Add the External Secret Operator helm chart repo:

```
helm repo add external-secrets https://charts.external-secrets.io && helm repo update
```

## Deployment

Use: 

```
skaffold dev
```

## Where to create secrets

All secrets are created in the namespace `remote-cluster`

Namespaces where secrets are synched must be labeled:

```yaml
labels:
  eso: enabled
```

This can be achieved using `kubectl`:

```bash
kubectl label namespace eso-demo eso=enabled
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