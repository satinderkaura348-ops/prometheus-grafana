#infra/prometheus.tf

resource "helm_release" "prometheus-helm" {
    name = "prometheus"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "kube-prometheus-stack"
    version = "65.0.0"
    namespace = "monitoring"
    create_namespace = true 

    timeout = 2000

    set = [
    {
      name  = "podSecurityPolicy.enabled"
      value = true
    },
    {
      name  = "server.persistentVolume.enabled"
      value = true
    },
    {
        name = "grafana.service.type"
        value = "LoadBalancer"
    },
    {
        name = "grafana.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
        value = "internet-facing"
    },
    {
        name = "prometheus.service.type"
        value = "ClusterIP"
    },
    # {
    #     name = "prometheus.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
    #     value = "internet-facing"
    # },
    # Critical for GitOps - allows monitoring ANY namespace
    {
      name  = "prometheus.prometheusSpec.serviceMonitorNamespaceSelector.any"
      value = "true"
    },
    {
      name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
      value = "false"
    },
     #  Storage for metrics data
    {
      name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName"
      value = "gp2"
    },
    {
      name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage"
      value = "10Gi"
    },
     #  Resource limits
    {
      name  = "prometheus.prometheusSpec.resources.limits.memory"
      value = "1Gi"
    },
    {
      name  = "prometheus.prometheusSpec.resources.limits.cpu"
      value = "1000m"
    },
     # ✅ Disable deprecated PSP
    {
      name  = "podSecurityPolicy.enabled"
      value = "false"
    },
       #  Alertmanager (also internal)
    {
      name  = "alertmanager.enabled"
      value = "true"
    },
    {
      name  = "alertmanager.service.type"
      value = "ClusterIP"
    },
    
    #  Ensure Prometheus Operator is enabled
    {
      name  = "prometheusOperator.enabled"
      value = "true"
    }
  ]

}

