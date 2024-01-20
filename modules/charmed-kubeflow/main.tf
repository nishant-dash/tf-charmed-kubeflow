# Charmed Kubeflow
resource "juju_model" "kubeflow" {
  name = "kubeflow"

  cloud {
    name = var.kubeflow_cloud
  }
}

# Grafana-agent-k8s
resource "juju_application" "grafana-agent-kf" {
  name  = "grafana-agent-kf"
  model = var.juju_model_name
  trust = true

  charm {
    name    = "grafana-agent-k8s"
    channel = var.grafana_agent_k8s_charm_channel
  }

  units = 1
  expose {}
}

resource "juju_integration" "ckf-grafana-agent" {
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

# Charmed Kubeflow componenets
resource "juju_application" "admission-webhook" {
  name  = "admission-webhook"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "admission-webhook"
    channel = var.admission_webhook_channel
  }

  units = 1
}

resource "juju_application" "argo-controller" {
  name  = "argo-controller"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "argo-controller"
    channel = var.argo_controller_channel
  }

  units = 1
}

resource "juju_application" "dex-auth" {
  name  = "dex-auth"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "dex-auth"
    channel = var.dex_auth_channel
  }

  units = 1
}

resource "juju_application" "envoy" {
  name  = "envoy"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "envoy"
    channel = var.envoy_channel
  }

  units = 1
}

resource "juju_application" "istio-ingressgateway" {
  name  = "istio-ingressgateway"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "istio-gateway"
    channel = var.istio_ingressgateway_channel
  }

  units = 1
}

resource "juju_application" "istio-pilot" {
  name  = "istio-pilot"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "istio-pilot"
    channel = var.istio_pilot_channel
  }

  units = 1
}

resource "juju_application" "jupyter-controller" {
  name  = "jupyter-controller"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "jupyter-controller"
    channel = var.jupyter_controller_channel
  }

  units = 1
}

resource "juju_application" "jupyter-ui" {
  name  = "jupyter-ui"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "jupyter-ui"
    channel = var.jupyter_ui_channel
  }

  units = 1
}

resource "juju_application" "katib-controller" {
  name  = "katib-controller"
  model = var.juju_model_name
  trust = false

  charm {
    name    = "katib-controller"
    channel = var.katib_controller_channel
  }

  units = 1
}

resource "juju_application" "katib-db" {
  name  = "katib-db"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "mysql-k8s"
    channel = var.katib_db_channel
  }

  units = 1
}

resource "juju_application" "katib-db-manager" {
  name  = "katib-db-manager"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "katib-db-manager"
    channel = var.katib_db_manager_channel
  }

  units = 1
}

resource "juju_application" "katib-ui" {
  name  = "katib-ui"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "katib-ui"
    channel = var.katib_ui_channel
  }

  units = 1
}

resource "juju_application" "kfp-api" {
  name  = "kfp-api"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-api"
    channel = var.kfp_api_channel
  }

  units = 1
}

resource "juju_application" "kfp-db" {
  name  = "kfp-db"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "mysql-k8s"
    channel = var.kfp_db_channel
  }

  units = 1
}

resource "juju_application" "kfp-metadata-writer" {
  name  = "kfp-metadata-writer"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-metadata-writer"
    channel = var.kfp_metadata_writer_channel
  }

  units = 1
}

resource "juju_application" "kfp-persistence" {
  name  = "kfp-persistence"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-persistence"
    channel = var.kfp_persistence_channel
  }

  units = 1
}

resource "juju_application" "kfp-profile-controller" {
  name  = "kfp-profile-controller"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-profile-controller"
    channel = var.kfp_profile_controller_channel
  }

  units = 1
}

resource "juju_application" "kfp-schedwf" {
  name  = "kfp-schedwf"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-schedwf"
    channel = var.kfp_schedwf_channel
  }

  units = 1
}

resource "juju_application" "kfp-ui" {
  name  = "kfp-ui"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-ui"
    channel = var.kfp_ui_channel
  }

  units = 1
}

resource "juju_application" "kfp-viewer" {
  name  = "kfp-viewer"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-viewer"
    channel = var.kfp_viewer_channel
  }

  units = 1
}

resource "juju_application" "kfp-viz" {
  name  = "kfp-viz"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kfp-viz"
    channel = var.kfp_viz_channel
  }

  units = 1
}

resource "juju_application" "knative-eventing" {
  name  = "knative-eventing"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "knative-eventing"
    channel = var.knative_eventing_channel
  }

  units = 1
}

resource "juju_application" "knative-operator" {
  name  = "knative-operator"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "knative-operator"
    channel = var.knative_operator_channel
  }

  units = 1
}

resource "juju_application" "knative-serving" {
  name  = "knative-serving"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "knative-serving"
    channel = var.knative_serving_channel
  }

  units = 1
}

resource "juju_application" "kserve-controller" {
  name  = "kserve-controller"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kserve-controller"
    channel = var.kserve_controller_channel
  }

  units = 1
}

resource "juju_application" "kubeflow-dashboard" {
  name  = "kubeflow-dashboard"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kubeflow-dashboard"
    channel = var.kubeflow_dashboard_channel
  }

  units = 1
}

resource "juju_application" "kubeflow-profiles" {
  name  = "kubeflow-profiles"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kubeflow-profiles"
    channel = var.kubeflow_profiles_channel
  }

  units = 1
}

resource "juju_application" "kubeflow-roles" {
  name  = "kubeflow-roles"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "kubeflow-roles"
    channel = var.kubeflow_roles_channel
  }

  units = 1
}

resource "juju_application" "kubeflow-volumes" {
  name  = "kubeflow-volumes"
  model = var.juju_model_name
  trust = false

  charm {
    name    = "kubeflow-volumes"
    channel = var.kubeflow_volumes_channel
  }

  units = 1
}

resource "juju_application" "metacontroller-operator" {
  name  = "metacontroller-operator"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "metacontroller-operator"
    channel = var.metacontroller_operator_channel
  }

  units = 1
}

resource "juju_application" "mlmd" {
  name  = "mlmd"
  model = var.juju_model_name
  trust = false

  charm {
    name    = "mlmd"
    channel = var.mlmd_channel
  }

  units = 1
}

resource "juju_application" "minio" {
  name  = "minio"
  model = var.juju_model_name
  trust = false

  charm {
    name    = "minio"
    channel = var.minio_channel
  }

  units = 1
}

resource "juju_application" "oidc-gatekeeper" {
  name  = "oidc-gatekeeper"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "oidc-gatekeeper"
    channel = var.oidc_gatekeeper_channel
  }

  units = 1
}

resource "juju_application" "pvcviewer-operator" {
  name  = "pvcviewer-operator"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "pvcviewer-operator"
    channel = var.pvcviewer_operator_channel
  }

  units = 1
}

resource "juju_application" "seldon-controller-manager" {
  name  = "seldon-controller-manager"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "seldon-core"
    channel = var.seldon_controller_manager_channel
  }

  units = 1
}

resource "juju_application" "tensorboard-controller" {
  name  = "tensorboard-controller"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "tensorboard-controller"
    channel = var.tensorboard_controller_channel
  }

  units = 1
}

resource "juju_application" "tensorboards-web-app" {
  name  = "tensorboards-web-app"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "tensorboards-web-app"
    channel = var.tensorboards_web_app_channel
  }

  units = 1
}

resource "juju_application" "training-operator" {
  name  = "training-operator"
  model = var.juju_model_name
  trust = True

  charm {
    name    = "training-operator"
    channel = var.training_operator_channel
  }

  units = 1
}

resource "juju_integration" "argo-controller-minio" {
  model = var.juju_model_name

  application {
    name = juju_application.argo-controller.name
  }

  application {
    name = juju_application.minio.name
  }
}

resource "juju_integration" "dex-auth-oidc-gatekeeper-oidc-client" {
  model = var.juju_model_name

  application {
    name     = juju_application.dex-auth.name
    endpoint = "oidc-client"
  }

  application {
    name     = juju_application.oidc-gatekeeper.name
    endpoint = "oidc-client"
  }
}

resource "juju_integration" "istio-pilot-dex-auth-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.dex-auth.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-envoy-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.envoy.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-jupyter-ui-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.jupyter-ui.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-katib-ui-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.katib-ui.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-kfp-ui-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.kfp-ui.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-kubeflow-dashboard-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.kubeflow-dashboard.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-kubeflow-volumes-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.kubeflow-volumes.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-oidc-gatekeeper-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.oidc-gatekeeper.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-oidc-gatekeeper-ingress-auth" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress-auth"
  }

  application {
    name     = juju_application.oidc-gatekeeper.name
    endpoint = "ingress-auth"
  }
}

resource "juju_integration" "istio-pilot-istio-ingressgateway-istio-pilot" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "istio-pilot"
  }

  application {
    name     = juju_application.istio-ingressgateway.name
    endpoint = "istio-pilot"
  }
}

resource "juju_integration" "istio-pilot-tensorboards-web-app-ingress" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.tensorboards-web-app.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "istio-pilot-tensorboard-controller-gateway-info" {
  model = var.juju_model_name

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "gateway-info"
  }

  application {
    name     = juju_application.tensorboard-controller.name
    endpoint = "gateway-info"
  }
}

resource "juju_integration" "katib-db-manager-katib-db-relational-dbdatabase" {
  model = var.juju_model_name

  application {
    name     = juju_application.katib-db-manager.name
    endpoint = "relational-db"
  }

  application {
    name     = juju_application.katib-db.name
    endpoint = "database"
  }
}

resource "juju_integration" "kfp-api-kfp-db-relational-dbdatabase" {
  model = var.juju_model_name

  application {
    name     = juju_application.kfp-api.name
    endpoint = "relational-db"
  }

  application {
    name     = juju_application.kfp-db.name
    endpoint = "database"
  }
}

resource "juju_integration" "kfp-api-kfp-persistence-kfp-api" {
  model = var.juju_model_name

  application {
    name     = juju_application.kfp-api.name
    endpoint = "kfp-api"
  }

  application {
    name     = juju_application.kfp-persistence.name
    endpoint = "kfp-api"
  }
}

resource "juju_integration" "kfp-api-kfp-ui-kfp-api" {
  model = var.juju_model_name

  application {
    name     = juju_application.kfp-api.name
    endpoint = "kfp-api"
  }

  application {
    name     = juju_application.kfp-ui.name
    endpoint = "kfp-api"
  }
}

resource "juju_integration" "kfp-api-kfp-viz-kfp-viz" {
  model = var.juju_model_name

  application {
    name     = juju_application.kfp-api.name
    endpoint = "kfp-viz"
  }

  application {
    name     = juju_application.kfp-viz.name
    endpoint = "kfp-viz"
  }
}

resource "juju_integration" "kfp-api-minio-object-storage" {
  model = var.juju_model_name

  application {
    name     = juju_application.kfp-api.name
    endpoint = "object-storage"
  }

  application {
    name     = juju_application.minio.name
    endpoint = "object-storage"
  }
}

resource "juju_integration" "kfp-profile-controller-minio-object-storage" {
  model = var.juju_model_name

  application {
    name     = juju_application.kfp-profile-controller.name
    endpoint = "object-storage"
  }

  application {
    name     = juju_application.minio.name
    endpoint = "object-storage"
  }
}

resource "juju_integration" "kfp-ui-minio-object-storage" {
  model = var.juju_model_name

  application {
    name     = juju_application.kfp-ui.name
    endpoint = "object-storage"
  }

  application {
    name     = juju_application.minio.name
    endpoint = "object-storage"
  }
}

resource "juju_integration" "kserve-controller-istio-pilot-ingress-gatewaygateway-info" {
  model = var.juju_model_name

  application {
    name     = juju_application.kserve-controller.name
    endpoint = "ingress-gateway"
  }

  application {
    name     = juju_application.istio-pilot.name
    endpoint = "gateway-info"
  }
}

resource "juju_integration" "kserve-controller-knative-serving-local-gateway" {
  model = var.juju_model_name

  application {
    name     = juju_application.kserve-controller.name
    endpoint = "local-gateway"
  }

  application {
    name     = juju_application.knative-serving.name
    endpoint = "local-gateway"
  }
}

resource "juju_integration" "kubeflow-profiles-kubeflow-dashboard" {
  model = var.juju_model_name

  application {
    name = juju_application.kubeflow-profiles.name
  }

  application {
    name = juju_application.kubeflow-dashboard.name
  }
}

resource "juju_integration" "kubeflow-dashboard-jupyter-ui-linksdashboard-links" {
  model = var.juju_model_name

  application {
    name     = juju_application.kubeflow-dashboard.name
    endpoint = "links"
  }

  application {
    name     = juju_application.jupyter-ui.name
    endpoint = "dashboard-links"
  }
}

resource "juju_integration" "kubeflow-dashboard-katib-ui-linksdashboard-links" {
  model = var.juju_model_name

  application {
    name     = juju_application.kubeflow-dashboard.name
    endpoint = "links"
  }

  application {
    name     = juju_application.katib-ui.name
    endpoint = "dashboard-links"
  }
}

resource "juju_integration" "kubeflow-dashboard-kfp-ui-linksdashboard-links" {
  model = var.juju_model_name

  application {
    name     = juju_application.kubeflow-dashboard.name
    endpoint = "links"
  }

  application {
    name     = juju_application.kfp-ui.name
    endpoint = "dashboard-links"
  }
}

resource "juju_integration" "kubeflow-dashboard-kubeflow-volumes-linksdashboard-links" {
  model = var.juju_model_name

  application {
    name     = juju_application.kubeflow-dashboard.name
    endpoint = "links"
  }

  application {
    name     = juju_application.kubeflow-volumes.name
    endpoint = "dashboard-links"
  }
}

resource "juju_integration" "kubeflow-dashboard-tensorboards-web-app-linksdashboard-links" {
  model = var.juju_model_name

  application {
    name     = juju_application.kubeflow-dashboard.name
    endpoint = "links"
  }

  application {
    name     = juju_application.tensorboards-web-app.name
    endpoint = "dashboard-links"
  }
}

resource "juju_integration" "mlmd-envoy-grpc" {
  model = var.juju_model_name

  application {
    name     = juju_application.mlmd.name
    endpoint = "grpc"
  }

  application {
    name     = juju_application.envoy.name
    endpoint = "grpc"
  }
}

resource "juju_integration" "mlmd-kfp-metadata-writer-grpc" {
  model = var.juju_model_name

  application {
    name     = juju_application.mlmd.name
    endpoint = "grpc"
  }

  application {
    name     = juju_application.kfp-metadata-writer.name
    endpoint = "grpc"
  }
}
