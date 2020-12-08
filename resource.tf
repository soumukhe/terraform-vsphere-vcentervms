# Create ResourcePool


resource "vsphere_resource_pool" "resource_pool" {
  name                    = var.whoami
  parent_resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
}

# Virtual Machines

resource "vsphere_virtual_machine" "vm" {
  count            = length(var.vmnames)
  name             = join("", [var.whoami, "-", var.vmnames[count.index]])
  resource_pool_id = vsphere_resource_pool.resource_pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  # only if you DO NOT want to wait for an IP address
  wait_for_guest_net_routable = false

  num_cpus = 4
  memory   = 8192
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type


  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }



  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned

  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = join("", [var.whoami, "-", var.vmnames[count.index]])
        domain    = "test.internal"
      }


      network_interface {}

    }
  }


}


output "ip" {
  value = {
    for instance in vsphere_virtual_machine.vm :
    instance.name => instance.default_ip_address
  }
}




