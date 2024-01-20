###################################################################################################
# Proxy configuration
# - http and https point to your proxy
# - no_proxy: includes cidr of k8s internal network, services and other networking you want to
#             constrain to the k8s cluster
###################################################################################################
variable "http_proxy" {
  description = "MicroK8s HTTP proxy"
  type        = string
  default     = "http://squid.internal:3128"
}

variable "https_proxy" {
  description = "MicroK8s HTTPS proxy"
  type        = string
  default     = "http://squid.internal:3128"
}

variable "no_proxy" {
  description = "MicroK8s proxy exclusions"
  type        = string
  default     = "127.0.0.1,10.0.0.0/8,192.168.0.0/16,172.16.0.0/12,rocks.canonical.com,10.152.183.0/24,.svc,.nip.io"
}

###################################################################################################
# Charmed MicroK8s setup
###################################################################################################
variable "juju_model_name" {
  description = "Juju model name"
  type        = string
}

variable "microk8s_charm_channel" {
  description = "MicroK8s charm channel"
  type        = string
  default     = "1.28/stable"
}

variable "microk8s_lsb_base" {
  description = "Ubuntu base to use for the Microk8s Charm"
  type        = string
  default     = "ubuntu@22.04"
}

variable "microk8s_units" {
  description = "Number of MicroK8s units"
  type        = number
  default     = 1
}

variable "microk8s_addons_hostpath_storage" {
  description = "Flag to enable hostpath_storage add-on for MicroK8s"
  type        = bool
  default     = true
}

variable "microk8s_addons_dns" {
  description = "Flag to enable dns add-on for MicroK8s"
  type        = bool
  default     = true
}

variable "microk8s_addons_metallb" {
  description = "Flag to enable metallb add-on for MicroK8s"
  type        = bool
  default     = true
}


###################################################################################################
# Charmed MicroK8s subordinate info
###################################################################################################
variable "subordinates_include_grafana_agent" {
  description = "Include the grafana-agent subordinate"
  type        = bool
  default     = false
}

variable "grafana_agent_charm_channel" {
  description = "Include the grafana-agent subordinate"
  type        = string
  default     = "latest/stable"
}

variable "subordinates_grafana_agent_dashboard_offer_url" {
  description = "Offer URL for grafana-agent Dashboard integration"
  type        = string
  default     = ""
}

variable "subordinates_grafana_agent_loki_offer_url" {
  description = "Offer URL for grafana-agent Loki integration"
  type        = string
  default     = ""
}

variable "subordinates_grafana_agent_prometheus_offer_url" {
  description = "Offer URL for grafana-agent Prometheus integration"
  type        = string
  default     = ""
}
