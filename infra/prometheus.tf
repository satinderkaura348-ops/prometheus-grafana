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
        value = "LoadBalancer"
    },
    {
        name = "prometheus.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
        value = "internet-facing"
    },
    # Critical for GitOps - allows monitoring ANY namespace
    {
      name  = "prometheus.prometheusSpec.serviceMonitorNamespaceSelector.any"
      value = "true"
    },
    {
      name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
      value = "false"
    }
  ]

  depends_on = [module.eks]
}