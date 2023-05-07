data "aws_ami" "amazon_linux_2" {
  most_recent   = true
  owners        = ["amazon"]

  filter {
    name        = "name"
    values      = ["amzn2-ami-hvm*"]
  }

  filter {
    name        = "architecture"
    values      = ["x86_64"]
  }

  filter {
    name        = "virtualization-type"
    values      = ["hvm"]
  }

  filter {
    name        = "root-device-type"
    values      = ["ebs"]
  }
}

data "aws_security_groups" "my-sg" {
  tags = {
    "Name"      = "Jenkins-SG"
  }
  
}

output "aws_ami" {
  value         = data.aws_ami.amazon_linux_2.id 
}

output "aws_security_groups_id" {
  value         = data.aws_security_groups.my-sg.ids
}