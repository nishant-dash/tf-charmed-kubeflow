# Charmed Microk8s
resource "juju_application" "microk8s" {
  name        = "microk8s"
  model       = var.juju_model_name
  trust       = true

  charm {
    name     = "microk8s"
    channel  = var.microk8s_charm_channel
  }

  config = {
    hostpath_storage             = var.microk8s_hostpath_storage
    containerd_http_proxy        = local.http_proxy
    containerd_https_proxy       = local.https_proxy
    containerd_no_proxy          = local.no_proxy
  }

  units = var.microk8s_units
  expose {}
}

# Charmed Microk8s subordinates
#   - grafana-agent
resource "juju_application" "grafana-agent" {
  name        = "grafana-agent-mk8s"
  model       = var.juju_model_name
  trust       = true

  charm {
    name     = "grafana-agent"
    channel  = var.grafana_agent_charm_channel
  }

  expose {}
}

resource "juju_integration" "microk8s-grafana-agent" {

}
