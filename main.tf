terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.37.0"
    }
  }
}

data "terraform_remote_state" "dns" {
  backend = "remote"

  config = {
    organization = "matelang"
    workspaces = {
      name = "hwsw-tf-cloud-dns"
    }
  }
}

resource "aws_route53_record" "record" {
  name = "record"
  type = "CNAME"
  records = ["binhatch.com"]
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  ttl = 300
}
