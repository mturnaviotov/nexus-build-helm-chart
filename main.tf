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

resource "helm_release" "nexus3" {
  name            = "nexus3"
  chart           = "${path.module}/charts/nexus"
#  force_update    = true
  recreate_pods   = true
  version         = "0.1.1"  # Вказуємо версію чарту
  cleanup_on_fail = true     # Очищати ресурси при помилці
}
