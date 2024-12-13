
resource "proxmox_vm_qemu" "vm" {
  for_each    = var.vms_list
  name        = each.key
  target_node = each.value.target_node
  vmid        = each.value.vmid
  cores       = each.value.cores
  memory      = each.value.memory
  cpu_type    = "x86-64-v2-AES"
  agent       = 1
  ciupgrade   = true
  tags        = each.value.tags
  ipconfig0   = "ip=${each.value.ipaddress},gw=${var.common_vars.gateway}"
  onboot      = true
  clone       = var.common_vars.template_name
  scsihw      = "virtio-scsi-single"
  nameserver  = var.common_vars.gateway
  qemu_os     = "l26"
  ciuser      = var.common_vars.ciuser
  cipassword  = var.cipassword
  sshkeys     = var.common_vars.sshkeys
  hagroup     = each.value.hagroup
  hastate     = each.value.hastate
  lifecycle {
    ignore_changes = [
      # network,
      disk,
    ]
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = var.common_vars.storage
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size       = each.value.storage_size
          discard    = true
          emulatessd = true
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = var.common_vars.storage
        }
      }
    }
  }

  network {
    id     = "0"
    bridge = var.common_vars.bridge
    model  = "virtio"
  }

  vga {
    type = "std"
  }
}

output "vm_network_details" {
  description = "network details of the VMs created by module"
  value       = { for k, v in proxmox_vm_qemu.vm : k => [v.ssh_host, v.network[0].macaddr] }
}