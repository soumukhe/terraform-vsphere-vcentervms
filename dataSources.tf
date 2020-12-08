data "vsphere_compute_cluster" "compute_cluster" {
  name          = "${terraform.workspace}-DC-Cluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_datacenter" "dc" {
  #name = var.datacenter
  name = "${terraform.workspace}-DC"
}


data "vsphere_datastore" "datastore" {
  #name          = join("", ["datastore", "Fab8-DC"])
  name          = "datastore${terraform.workspace}-DC"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "DHCP-10.0.140.0/16"
  datacenter_id = data.vsphere_datacenter.dc.id

}


data "vsphere_virtual_machine" "template" {
  name          = "ubuntu18.04-for-TerraformSpinup-cisco-cisco"
  datacenter_id = data.vsphere_datacenter.dc.id
}

