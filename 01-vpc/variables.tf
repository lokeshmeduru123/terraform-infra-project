variable "project_name" {
    default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "public_subnet_cidrs" {
    default = ["10.0.1.0/24","10.0.2.0/24"]  #one for us-east1a & other for us-east-1b
}

variable "private_subnet_cidrs" {
    default = ["10.0.11.0/24","10.0.12.0/24"] #one for us-east1a & other for us-east-1b
}

variable "database_subnet_cidrs" {
    default = ["10.0.21.0/24","10.0.22.0/24"] #one for us-east1a & other for us-east-1b
}

variable "is_peering_required" {
  default = false # If multiple vpc need to be communicated we need to give true here this project has only 1-vpc
}