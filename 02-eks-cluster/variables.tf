variable "tags" {
  type = map(string)
  default = {
    "Environment" = "production"
    "Project"     = "workshop-devops-na-nuvem"
  }
}

variable "assume_role" {
  type = object({
    arn    = string
    region = string
  })

  default = {
    arn    = "arn:aws:iam::629614691642:role/workshop-march"
    region = "us-east-1"
  }
}

variable "ecr_repositories" {
  type    = list(string)
  default = ["workshop-dvn/production/backend", "workshop-dvn/production/frontend"]
}