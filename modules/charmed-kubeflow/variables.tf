###################################################################################################
# Kubeflow setup
###################################################################################################
variable "juju_model_name" {
  description = "Juju model name"
  type        = string
  default     = "kubeflow"
}

variable "kubeflow_cloud" {
  description = "K8s cloud to use for Kubeflow"
  type        = string
}

variable "kubeflow_model_series" {
  description = "Ubuntu series to use for the Kubeflow model"
  type        = string
  default     = "jammy"
}

variable "admission_webhook_channel" {
  description = "Charm channel of admission-webhook"
  type        = string
  default     = "1.8/stable"
}

variable "argo_controller_channel" {
  description = "Charm channel of argo-controller"
  type        = string
  default     = "3.3.10/stable"
}

variable "dex_auth_channel" {
  description = "Charm channel of dex-auth"
  type        = string
  default     = "2.36/stable"
}

variable "envoy_channel" {
  description = "Charm channel of envoy"
  type        = string
  default     = "2.0/stable"
}

variable "istio_ingressgateway_channel" {
  description = "Charm channel of istio-gateway"
  type        = string
  default     = "1.17/stable"
}

variable "istio_pilot_channel" {
  description = "Charm channel of istio-pilot"
  type        = string
  default     = "1.17/stable"
}

variable "jupyter_controller_channel" {
  description = "Charm channel of jupyter-controller"
  type        = string
  default     = "1.8/stable"
}

variable "jupyter_ui_channel" {
  description = "Charm channel of jupyter-ui"
  type        = string
  default     = "1.8/stable"
}

variable "katib_controller_channel" {
  description = "Charm channel of katib-controller"
  type        = string
  default     = "0.16/stable"
}

variable "katib_db_channel" {
  description = "Charm channel of mysql-k8s"
  type        = string
  default     = "8.0/stable"
}

variable "katib_db_manager_channel" {
  description = "Charm channel of katib-db-manager"
  type        = string
  default     = "0.16/stable"
}

variable "katib_ui_channel" {
  description = "Charm channel of katib-ui"
  type        = string
  default     = "0.16/stable"
}

variable "kfp_api_channel" {
  description = "Charm channel of kfp-api"
  type        = string
  default     = "2.0/stable"
}

variable "kfp_db_channel" {
  description = "Charm channel of mysql-k8s"
  type        = string
  default     = "8.0/stable"
}

variable "kfp_metadata_writer_channel" {
  description = "Charm channel of kfp-metadata-writer"
  type        = string
  default     = "2.0/stable"
}

variable "kfp_persistence_channel" {
  description = "Charm channel of kfp-persistence"
  type        = string
  default     = "2.0/stable"
}

variable "kfp_profile_controller_channel" {
  description = "Charm channel of kfp-profile-controller"
  type        = string
  default     = "2.0/stable"
}

variable "kfp_schedwf_channel" {
  description = "Charm channel of kfp-schedwf"
  type        = string
  default     = "2.0/stable"
}

variable "kfp_ui_channel" {
  description = "Charm channel of kfp-ui"
  type        = string
  default     = "2.0/stable"
}

variable "kfp_viewer_channel" {
  description = "Charm channel of kfp-viewer"
  type        = string
  default     = "2.0/stable"
}

variable "kfp_viz_channel" {
  description = "Charm channel of kfp-viz"
  type        = string
  default     = "2.0/stable"
}

variable "knative_eventing_channel" {
  description = "Charm channel of knative-eventing"
  type        = string
  default     = "1.10/stable"
}

variable "knative_operator_channel" {
  description = "Charm channel of knative-operator"
  type        = string
  default     = "1.10/stable"
}

variable "knative_serving_channel" {
  description = "Charm channel of knative-serving"
  type        = string
  default     = "1.10/stable"
}

variable "kserve_controller_channel" {
  description = "Charm channel of kserve-controller"
  type        = string
  default     = "0.11/stable"
}

variable "kubeflow_dashboard_channel" {
  description = "Charm channel of kubeflow-dashboard"
  type        = string
  default     = "1.8/stable"
}

variable "kubeflow_profiles_channel" {
  description = "Charm channel of kubeflow-profiles"
  type        = string
  default     = "1.8/stable"
}

variable "kubeflow_roles_channel" {
  description = "Charm channel of kubeflow-roles"
  type        = string
  default     = "1.8/stable"
}

variable "kubeflow_volumes_channel" {
  description = "Charm channel of kubeflow-volumes"
  type        = string
  default     = "1.8/stable"
}

variable "metacontroller_operator_channel" {
  description = "Charm channel of metacontroller-operator"
  type        = string
  default     = "3.0/stable"
}

variable "mlmd_channel" {
  description = "Charm channel of mlmd"
  type        = string
  default     = "1.14/stable"
}

variable "minio_channel" {
  description = "Charm channel of minio"
  type        = string
  default     = "ckf-1.8/stable"
}

variable "oidc_gatekeeper_channel" {
  description = "Charm channel of oidc-gatekeeper"
  type        = string
  default     = "ckf-1.8/stable"
}

variable "pvcviewer_operator_channel" {
  description = "Charm channel of pvcviewer-operator"
  type        = string
  default     = "1.8/stable"
}

variable "seldon_controller_manager_channel" {
  description = "Charm channel of seldon-core"
  type        = string
  default     = "1.17/stable"
}

variable "tensorboard_controller_channel" {
  description = "Charm channel of tensorboard-controller"
  type        = string
  default     = "1.8/stable"
}

variable "tensorboards_web_app_channel" {
  description = "Charm channel of tensorboards-web-app"
  type        = string
  default     = "1.8/stable"
}

variable "training_operator_channel" {
  description = "Charm channel of training-operator"
  type        = string
  default     = "1.7/stable"
}


###################################################################################################
# grafana-agent-k8s info
###################################################################################################
variable "grafana_agent_k8s_charm_channel" {
  description = "Include the grafana-agent-k8s charm"
  type        = string
  default     = "latest/stable"
}
