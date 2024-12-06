terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6" # specify the version you need
    }
  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_host
  pm_user    = var.proxmox_user
  pm_password = var.proxmox_password
  pm_tls_insecure = var.PVE_TLS_INSECURE
  pm_parallel = var.pve_parallel
  pm_timeout = 1800
  pm_log_enable = true
  pm_log_file   = "module-terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}