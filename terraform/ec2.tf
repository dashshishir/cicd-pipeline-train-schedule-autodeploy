resource "aws_instance" "master" {
  
  instance_type           = "t2.medium"
  ami                     = data.aws_ami.amazon_linux_2.id
  vpc_security_group_ids  = data.aws_security_groups.my-sg.ids
  user_data = file("C:/Users/sishi/Edureka/DevOps Certification/projCert/cicd-pipeline-train-schedule-autodeploy/terraform/user_data.sh")
  key_name = "Jenkins-Edureka"

  tags = {
    Name = "kubernetes-master"
  }

}

resource "aws_instance" "worker" {
  
  instance_type           = "t2.medium"
  ami                     = data.aws_ami.amazon_linux_2.id
  vpc_security_group_ids  = data.aws_security_groups.my-sg.ids
  user_data = file("C:/Users/sishi/Edureka/DevOps Certification/projCert/cicd-pipeline-train-schedule-autodeploy/terraform/user_data.sh")

  tags = {
    Name = "kubernetes-worker"
  }
}

output "master" {
  value = aws_instance.master.private_ip
  
}

output "worker" {
  value =  aws_instance.worker.private_ip
}
