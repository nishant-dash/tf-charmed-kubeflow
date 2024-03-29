# Charmed Microk8s
resource "juju_application" "microk8s" {
  name  = "microk8s"
  model = var.juju_model_name
  trust = true

  charm {
    name    = "microk8s"
    channel = var.microk8s_charm_channel
    series  = var.microk8s_charm_series
  }

  config = {
    hostpath_storage       = var.microk8s_addons_hostpath_storage
    containerd_http_proxy  = var.http_proxy
    containerd_https_proxy = var.https_proxy
    containerd_no_proxy    = var.no_proxy
  }

  units     = var.microk8s_units
  placement = 0
  expose {}
}

# Charmed Microk8s subordinates
#   - grafana-agent
resource "juju_application" "grafana-agent" {
  name  = "grafana-agent-mk8s"
  model = var.juju_model_name
  trust = true

  charm {
    name    = "grafana-agent"
    channel = var.grafana_agent_charm_channel
  }

  units = 0
  expose {}
}

resource "juju_integration" "microk8s-grafana-agent" {
  model = var.juju_model_name

  application {
    name     = juju_application.microk8s.name
    endpoint = "cos-agent"
  }

  application {
    name     = juju_application.grafana-agent.name
    endpoint = "cos-agent"
  }
}
