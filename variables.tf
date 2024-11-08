variable "environment" {
  description = "environment variables"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "region"
  type        = string
  default     = "us-west-1"
}

variable "instance_type" {
  description = "ec2 tpye"
  type        = string
  default     = "t2.micro"
}

variable "instance_ami" {
  description = "ami"
  type        = string
  default     = "ami-06f932bfd69e55cc3"
}

variable "instance_keypair" {
  description = "ec2 key pair"
  type        = string
  default     = "tf-key"
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "alloy-vpc"
}

variable "vpc_availability_zones" {
  description = "vpc azs"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
}

variable "vpc_cidr_block" {
  description = "cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  description = "public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_private_subnets" {
  description = "private subnets"
  type        = list(string)
  default     = ["10.0.51.0/24", "10.0.52.0/24"]
}

variable "vpc_database_subnets" {
  description = "db subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "db_name" {
  description = "rds name"
  type        = string
  default     = "alloydb"
}

variable "db_identifier" {
  description = "rds instance id"
  type        = string
  default     = "alloy-db"
}

variable "db_username" {
  description = "rds admin username"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "rds admin pass"
  type        = string
  sensitive   = true
  default     = "changeme"
}

