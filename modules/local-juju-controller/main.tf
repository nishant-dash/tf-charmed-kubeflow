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
    command     = <<EOF
        echo "sudo snap install juju --channel=3.1/stable"
        echo "mkdir -p ~/.local/share/juju"
        echo "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa_juju"
        echo "cat ~/.ssh/id_rsa_juju.pub >> ~/.ssh/authorized_keys"
        echo "ssh ubuntu@$(hostname -i | awk '{print $NF}')"
        echo "juju bootstrap manual/$(hostname -i | awk '{print $NF}') localhost"
EOF
  }
}