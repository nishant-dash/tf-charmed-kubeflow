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
        sudo snap install juju --channel=3.1/stable
        mkdir -p ~/.local/share/juju
        ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
        cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
        ssh ubuntu@$(hostname -i | awk '{print $NF}') hostname
        juju bootstrap manual/ubuntu@$(hostname -i | awk '{print $NF}') localhost
EOF
  }
}