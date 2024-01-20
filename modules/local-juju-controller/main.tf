variable "steps" {
  description = "List of bash commands to run to setup a node for Charmed Micok8s and Kubeflow"
  type        = list(string)
  default = [
    "sudo snap install juju --channel=3.1/stable",
    "mkdir -p ~/.local/share/juju",
    "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa_juju",
    "cat ~/.ssh/id_rsa_juju.pub >> ~/.ssh/authorized_keys",
    "ssh ubuntu@$(hostname -i | awk '{print $NF}')",
    "juju bootstrap manual/$(hostname -i | awk '{print $NF}') localhost"
  ]
}

// resource "null_resource" "node_setup" {
//   provisioner "local-exec" {
//     command = "sudo snap install juju --channel=3.1/stable"
//     interpreter = ["/bin/bash"]
//   }
// }

// resource "null_resource" "juju_manual_cloud" {
//   provisioner "local-exec" {
//     command = "juju bootstrap"
//     interpreter = ["/bin/bash"]
//   }
// }

resource "null_resource" "node_setup" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "for step in $STEPS; do echo $step; done"
    environment = { STEPS = join(" ", var.items) }
  }
}