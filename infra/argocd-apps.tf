#infra/argocd-apps.tf

resource "kubernetes_manifest" "argocd_app_of_apps" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
     kind       = "Application"
    metadata = {
      name      = "bootstrap"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/satinderkaura348-ops/prometheus-grafana.git"
        targetRevision = "main"
        path           = "petapp"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "petapp"
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }
  depends_on = [helm_release.argocd]
}