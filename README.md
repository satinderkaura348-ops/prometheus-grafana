                                                 
  **EKS Monitoring Stack with GitOps (ArgoCD)**
<img width="3576" height="5389" alt="final2" src="https://github.com/user-attachments/assets/cffc4816-6edf-47dc-bf56-0e2a4022df2e" />

**🏗️ Architecture Overview**

Production-ready Kubernetes monitoring solution on AWS EKS using GitOps methodology with ArgoCD. This infrastructure deploys a complete observability stack with Grafana for visualization and Prometheus for metrics collection, fully managed as code with Terraform.

**Key Components**
```
AWS VPC with Multi-AZ networking

Amazon EKS managed cluster

ArgoCD for GitOps

Prometheus & Grafana for observability

Sample PetApp with ServiceMonitor

GitHub Actions CI/CD pipeline
```

**📁 Project Structure**

```

├── README.md
├── infra
│   ├── argocd-apps.tf
│   ├── backend.tf
│   ├── main.tf
│   ├── modules
│   │   ├── argocd
│   │   │   └── main.tf
│   │   ├── eks
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── monitoring
│   │   │   └── main.tf
│   │   └── vpc
│   │       ├── main.tf
│   │       ├── output.tf
│   │       └── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── testing.sh
│   └── variables.tf
└── petapp
    ├── deployment.yaml  
    ├── kustomization.yaml   
    ├── namespace.yaml 
    ├── service.yaml
    └── servicemonitor.yaml
```

**🛠️ Quick Deployment**
**Manual Deployment**
```
bash
cd infra/
chmod 755 testing.sh
./testing.sh

```

**Automated Deployment**
```
Push to dev branch triggers GitHub Actions (edit branch preference in cicd.yml)

Terraform provisions infrastructure in stages

ArgoCD syncs applications from Git

Prometheus auto-discovers ServiceMonitors
```
**🔐 Access Credentials**

```
 aws eks update-kubeconfig --region <cluster-region> --name <cluster-name>
```

```
# Get Grafana admin password
kubectl get secret prometheus-stack-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```
```
# Get ArgoCD initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
