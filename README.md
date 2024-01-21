# Terraform plans for a Charmed Kubeflow Deployment

This plan consists of 4 modules. Each module is part if a certain layer and is responsible
for creating resource that the next layer needs.

# How to use
## 1. Installed Terraform and clone this repo
```sh
sudo snap install terraform --classic
git clone https://github.com/nishant-dash/tf-charmed-kubeflow.git
cd tf-charmed-kubeflow
```

## 2. `cd` into the modules you need and terraform it
### 2.1 Get a local bootstrapped juju
```
cd modules/local-juju-controller/
terraform init
terraform plan # and review
terraform apply
```

### 2.2 Get microk8s cloud
Here we will feed in the cloud name `mk8s-cloud` and use machine `0` i.e, the local machine itself
Also input the model name of the node from the previous step, here its `controller` 
```
cd modules/microk8s/
terraform init
terraform plan # and review
terraform apply
```

Once the above is done and microk8s has finished setting up, you can proceed. 
TIP: You can run `juju wait-for application microk8s`

#### 2.2.1 Add the k8s cloud into juju
Currently we need to manually do with via juju cli https://github.com/juju/terraform-provider-juju/issues/232
```sh
mkdir ~/.kube
sudo microk8s.config > ~/.kube/config
juju add-k8s mk8s-cloud --client --controller localhost
```

### 2.3 Deploy charmed kubeflow
```
cd modules/charmed-kubeflow/
terraform init
terraform plan # and review
terraform apply
```

> [!NOTE]
> TODO: Use outputs of modules to automate the flow even further with Terragrunt

# Layout

## Layer 1: Cloud (Optional)
The goal of this layer is to provide a cloud with nodes or a bootstrapped juju controller to make
use in the next layer.

Current modules that accomplish this:
- local-juju-controller

  output: juju controller

## Layer 2: K8s cluster (Required)
Using a juju controller with nodes from the previous layer, we can bootstrap a kubernetes cluster.
If skipping layer 1, be sure to have a juju controller with access to computes. Update this layer
as needed.

Current modules that accomplish this:
- microk8s

  input: juju controller

  output: k8s cloud in juju

## Layer 3: Charmed Kubeflow (Required)
This module assumes you have a juju controller with a k8s cloud added to it.

Current modules that accomplish this:
- charmed-kubeflow

  input: k8s cloud in juju

  output: juju model/k8s namespace with kubeflow deployed

## Layer 4: COS (Optional)
Current modules that accomplish this:
- cos

  input: terragrunt dependencies of module outputs containing
         juju model and grafana-agent application names

  input: k8s cloud in juju

  output: model with COS deployed and integrations added to all grafana agents passed in