terraform {
    required_version = ">= 1.0.0"
}

resource "random_string" "randstr" {
    length = var.id_lenght
}

resource "random_integer" "randint" {
    min = var.min_int
    max = var.max_int
}
