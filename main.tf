terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

provider "helm" {
    kubernetes = {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nexusproxy" {
  repository = "charts.local/helm"
  chart      = "nexus"
  version    = "0.1.22"

  name             = "nexus-proxy"
  namespace        = "nexus-proxy"
  create_namespace = "true"

  ##### DENUG ####
  cleanup_on_fail = true
  replace = true

  values = [templatefile("${path.module}/values.yaml",
    {
      master        = "nexusmaster.local",
      admin_pass    = "superpassword",
      port          = 8081,
      #storage_class = kubernetes_storage_class.id
    }
    )
  ]

  #depends_on = [module.aws_lb_controller]
}