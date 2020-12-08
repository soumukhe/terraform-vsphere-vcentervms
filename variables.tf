

variable "vcenter_password" {
  type        = string
  description = "Enter vCenter password"
}

variable "whoami" {
  type = string
  #  this get's value from TF_VARS_whoami from .bashrc setting
}


variable "vmnames" {
  type        = list(string)
  description = "name of VMs"
  default     = ["web", "app"]
}
