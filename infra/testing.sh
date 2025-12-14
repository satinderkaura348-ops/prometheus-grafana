#!/bin/bash

# 1. Initialize
terraform init

# 2. Networking foundation
terraform apply -target=module.vpc -auto-approve



# 3. Kubernetes control plane
terraform apply -target=module.eks -auto-approve 

# 4. Wait for cluster to be ready
echo "=== Waiting for EKS cluster to be ready ==="
sleep 90  # Initial wait

#5. Wait for cluster to be active
echo "Waiting for EKS cluster to become ACTIVE..."
aws eks wait cluster-active --name eks-cluster --region ap-southeast-2

aws eks update-kubeconfig --region ap-southeast-2 --name eks-cluster
sleep 60



 # 6. GitOps platform                   
terraform apply -target=module.argocd -auto-approve
# CRITICAL: Wait for ArgoCD to be fully ready
echo "Waiting for ArgoCD to start..."
kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=300s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

echo "Waiting for ArgoCD CRDs..."
kubectl wait --for=condition=established crd applications.argoproj.io --timeout=300s
kubectl wait --for=condition=established crd appprojects.argoproj.io --timeout=300s
sleep 10

# 7. Monitoring stack
terraform apply -target=module.monitoring -auto-approve

sleep 60

# 9. Anything remaining
terraform apply -auto-approve

# 10. Verification
echo "=== Infrastructure Status ==="
kubectl get pods -n argocd
kubectl get pods -n monitoring 2>/dev/null || echo "Prometheus not installed"
kubectl get svc -A