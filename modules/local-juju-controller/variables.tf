variable "juju_channel" {
  description = "Channel of juju client and agent to use"
  type        = string
  default     = "3.5/stable"
}

variable "local_ip" {
  description = "Local ip of machine, should not be loopback type"
  type        = string
  default     = "127.0.0.1"
}
