variable "project" {
  type    = string
  default = "terraform-380221"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "credential" {
  type    = string
  default = "../../secrets.json"
}

variable "script" {
  type    = string
  default = "../script.sh"
}

variable "instance-template-tf" {
  type    = string
  default = "test1"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "autohealing_health_check" {
  type    = string
  default = "autohealing-health-check"
}

variable "instance_group_manager" {
  type    = string
  default = "instance-group-manager"
}

variable "autoscaler" {
  type    = string
  default = "autoscaler-test1"
}






