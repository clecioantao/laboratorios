module "simple_md" {
    source = "../modules"
    id_lenght = 5
    min_int = 0
    max_int = 100
}

output "random_string" {
    value = module.simple_md.result_string
}

output "random_number" {
    value = module.simple_md.result_numeric
}