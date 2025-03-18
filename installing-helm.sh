# Setup Helm repository
helm repo add conduktor https://helm.conduktor.io
helm repo update

export ADMIN_EMAIL="<your_admin_email>"
export ADMIN_PASSWORD="<your_admin_password>"
export ORG_NAME="<your_org_name>"
export NAMESPACE="<your_kubernetes_namespace>"

# Deploy Helm chart
helm install console conduktor/console \
  --create-namespace -n ${NAMESPACE} \
  --set config.organization.name="${ORG_NAME}" \
  --set config.admin.email="${ADMIN_EMAIL}" \
  --set config.admin.password="${ADMIN_PASSWORD}" \
  --set config.database.password="<your_postgres_password>" \
  --set config.database.username="<your_postgres_user>" \
  --set config.database.host="<your_postgres_host>" \
  --set config.database.port="5432" \
  --set config.license="${LICENSE}" # can be omitted if deploying the free tier
    
# Port forward to access Conduktor
kubectl port-forward deployment/console -n ${NAMESPACE} 8080:8080
open http://localhost:8080
