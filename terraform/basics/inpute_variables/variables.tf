
variable "fname" {
    type = string
    default = "example.txt"
}

variable "cont" {
    type = string
    default = "Testando 123"
}

variable "perm" {
    type = string
    default = "0770"
}

variable "zones" {
    type = list
    default = ["us-west-1a", "us-west-1c", "us-west-1d", "us-west-1e"]
}

