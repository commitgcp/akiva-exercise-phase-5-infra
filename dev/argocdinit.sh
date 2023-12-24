
kubectl apply -f service.yaml
gcloud container clusters get-credentials phase4-cluster --region=us-central1
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
argocd admin initial-password -n argocd
echo "Take the above password, run: \n argocd login ARGOCD_SERVER_EXTERNAL_IP \n argocd account update-password \n then add cluster and repo to argo. then create app in argo GUI \n "