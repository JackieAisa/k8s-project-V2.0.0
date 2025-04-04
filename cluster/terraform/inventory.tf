# Create ansible inventory file dynamically 

resource "local_file" "ansible_inventory" {
  filename = "/home/ubuntu/k8s-project-V2.0.0/cluster/ansible/hosts"

  content = <<EOT

[master]
${aws_instance.master.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa

[worker1]
${aws_instance.worker1.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa

[worker2]
${aws_instance.worker2.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa

[all:children]
master
workers

[workers]
${aws_instance.worker1.public_ip}
${aws_instance.worker2.public_ip}
EOT
}

# Create variables.tf dynamically for terraform-cluster creation 

resource "local_file" "terraform_variables" {
  filename = "/home/ubuntu/k8s-project-V2.0.0/cluster/terraform-cluster/variables.tf"

  content = <<EOT

variable master_ip {
    default= "${aws_instance.master.public_ip}"
    type = string
}
variable worker1_ip {
    default="${aws_instance.worker1.public_ip}"
    type = string 
}
variable worker2_ip {
    default="${aws_instance.worker2.public_ip}"
    type = string
    }

EOT
}