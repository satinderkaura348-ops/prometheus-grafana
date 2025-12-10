# prometheus-grafana
# Architecture Diagram

```mermaid
graph TD
    A[GitHub Repo<br/>prometheus-grafana] -->|push| B(GitHub Actions)
    
    subgraph "CI/CD"
    B --> C[Terraform<br/>EKS + VPC + IAM]
    end

    C --> D[AWS EKS Cluster<br/>ap-southeast-2]

    subgraph "GitOps Control Plane"
    B -->|kubectl apply| E[ArgoCD<br/>Bootstrapped declaratively]
    end

    E -->|sync| F[Application: monitoring-stack]
    E -->|sync| G[Application: petapp]

    subgraph "Observability (namespace: monitoring)"
    F --> H[kube-prometheus-stack Helm Chart]
    H --> I[Prometheus<br/>2 replicas, 50Gi gp3]
    H --> J[Alertmanager<br/>2 replicas, 10Gi gp3]
    H --> K[Grafana<br/>2 replicas, 20Gi gp3<br/>LoadBalancer]
    I -->|auto-scrape| L[petapp pods<br/>(via annotations + cAdvisor/kubelet)]
    end

    subgraph "Application (namespace: petapp)"
    G --> M[Deployment: petapp-deployment<br/>image: satinderkaura348/petapp:latest]
    M --> N[Service: LoadBalancer]
    end

    K -->|pre-connected datasource| I
    K -->|dashboards 315, 6417, 8588| L

    style A fill:#2d3748,color:#e2e8f0
    style B fill:#4299e1,color:white
    style C fill:#3182ce,color:white
    style D fill:#1a202c,color:#e2e8f0
    style E fill:#f687b3,color:white
    style H fill:#48bb78,color:white
    style K fill:#ed8936,color:white
