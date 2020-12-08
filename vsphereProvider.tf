provider "vsphere" {
  user           = join("", [var.whoami, "@anywhere.bootcamp"])
  password       = var.vcenter_password
  vsphere_server = "fabric7vcenter.localdomain"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
