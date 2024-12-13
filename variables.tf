variable "vms_list" {
}

variable "common_vars" {
}

variable "proxmox_host" {
  type = string
}

variable "proxmox_user" {
  type = string
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "PVE_TLS_INSECURE" {
  description = "Allow insecure TLS connections"
  type        = bool
  default     = false
}

variable "cipassword" {
  type = string
}