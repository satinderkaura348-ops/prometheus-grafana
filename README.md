EKS Monitoring Stack with GitOps (ArgoCD)
🏗️ Architecture Overview
Production-ready Kubernetes monitoring on AWS EKS using GitOps methodology with ArgoCD. Fully managed infrastructure-as-code with Terraform and automated CI/CD.

Key Components
AWS VPC with Multi-AZ networking

Amazon EKS managed cluster

ArgoCD for GitOps

Prometheus & Grafana for observability

Sample PetApp with ServiceMonitor

GitHub Actions CI/CD pipeline

📁 Project Structure
'''
├── infra/ # Terraform Infrastructure
│ ├── modules/ # Reusable modules
│ │ ├── vpc/ # VPC with public/private subnets
│ │ ├── eks/ # EKS cluster & node groups
│ │ ├── argocd/ # ArgoCD installation
│ │ └── monitoring/ # Prometheus Stack
│ ├── main.tf # Root configuration
│ ├── variables.tf # Input variables
│ └── argocd-apps.tf # ArgoCD app definitions
│
└── petapp/ # Sample application
├── kustomization.yaml # Kustomize config
├── deployment.yaml # App deployment
└── servicemonitor.yaml # Prometheus monitoring
'''
