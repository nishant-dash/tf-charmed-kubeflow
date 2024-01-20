resource "null_resource" "node_setup" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = { JUJU_CHANNEL_TO_USE = var.juju_channel }
    command     = <<EOF
        sudo snap install juju --channel=$JUJU_CHANNEL_TO_USE
        mkdir -p ~/.local/share/juju
        ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
        cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
        ssh ubuntu@$(hostname -i | awk '{print $NF}') hostname
        juju bootstrap manual/ubuntu@$(hostname -i | awk '{print $NF}') localhost
        juju switch controller
        juju status
EOF
  }
}