variable "template_name" {
  type = string
}

variable "storage" {
  type = string
}

variable "vm_state" {
  type = string
}

variable "vms_list" {
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

variable "pve_parallel" {
  type = number
}

variable "gateway" {
  type = string
}

variable "PVE_TLS_INSECURE" {
  description = "Allow insecure TLS connections"
  type        = bool
  default     = false
}

variable "bridge" {
  type = string
}

variable "sshkeys" {
  type = string
}

variable "ciuser" {
  type = string
}

variable "cipassword" {
  type = string
}

variable "tags" {

}