terraform {
  required_version = ">= 1.5"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
  }
}

resource "null_resource" "node_setup" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      JUJU_CHANNEL_TO_USE = var.juju_channel
      LOCAL_IP            = var.local_ip
    }
    command = <<EOF
        USER=$(whoami)
        echo "fs.inotify.max_user_instances = 1280" | sudo tee /etc/sysctl.d/80-mk8s.conf
        echo "fs.inotify.max_user_watches = 655360" | sudo tee -a /etc/sysctl.d/80-mk8s.conf
        sudo sysctl -q -p /etc/sysctl.d/80-mk8s.conf

        SUDO_ASKPASS=/bin/false sudo -A whoami &> /dev/null &&
        sudo grep -r $USER /etc/{sudoers,sudoers.d} | grep NOPASSWD:ALL &> /dev/null || {
          echo "$USER ALL=(ALL) NOPASSWD:ALL" > /tmp/90-$USER-sudo-access
          sudo install -m 440 /tmp/90-$USER-sudo-access /etc/sudoers.d/90-$USER-sudo-access
          rm -f /tmp/90-$USER-sudo-access
        }

        dpkg -s openssh-server &> /dev/null || {
          sudo apt install -y openssh-server
        }

        sudo sed 's/^PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config.d/50-cloud-init.conf -i
        sudo sed 's/^PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config -i
        sudo service ssh restart

        [ -f $HOME/.ssh/id_rsa ] || ssh-keygen -b 4096 -f $HOME/.ssh/id_rsa -t rsa -N ""
        cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
        ssh-keyscan -H $(hostname --all-ip-addresses) >> $HOME/.ssh/known_hosts

        if [[ $LOCAL_IP == "127.0.0.1" ]]; then
          LOCAL_IP=$(ip route get 1 | awk '{for(i=1;i<=NF;i++) if($i~"src") print$(i+1)}')
        fi

        echo Using $USER@$LOCAL_IP
        ssh -o StrictHostKeyChecking=accept-new $USER@$LOCAL_IP hostname

        sudo snap install juju --channel=$JUJU_CHANNEL_TO_USE
        mkdir -p $HOME/.local/share/juju
        juju bootstrap manual/$USER@$LOCAL_IP localhost
        juju switch controller
        juju status --format oneline
EOF
  }
}