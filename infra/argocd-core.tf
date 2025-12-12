#infra/argocd-core.tf

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.0"  
  namespace  = "argocd"
  create_namespace = true
  timeout    = 600  # Increase timeout to 10 minutes
  
  # SIMPLIFIED CONFIGURATION
  set = [
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    },
    
    {
      name  = "server.ingress.enabled"
      value = "false"
    },
   
    {
      name  = "redis.secret.create"
      value = "false"
    },
    {
      name  = "redis.secret.name"
      value = ""
    },
   
    {
      name  = "redis.enabled"
      value = "true"
    },
    {
      name  = "redis-ha.enabled"
      value = "false"  
    },
    
    {
      name  = "server.replicas"
      value = "1"
    },
    {
      name  = "controller.replicas"
      value = "1"
    },
    {
      name  = "repoServer.replicas"
      value = "1"
    },
    
    {
      name  = "global.image.tag"
      value = "v2.10.4" 
    }
  ]


  wait = true
}