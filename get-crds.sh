
version="v0.12.1"

kubectl apply -f "https://raw.githubusercontent.com/external-secrets/external-secrets/${version}/deploy/crds/bundle.yaml"

# wait for the CRDs to be created
kubectl wait --for=condition=Established crd/secretstores.external-secrets.io --timeout=90s

# add the helm repo
helm repo add external-secrets https://charts.external-secrets.io && helm repo update || helm repo update