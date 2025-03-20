provider "aws" {
  region                  = "us-east-1"
  skip_metadata_api_check = true # force Terraform à utiliser les variables d’environnement githubaction
}

# Variabele instances prod
# ====================================================
variable "ec2_type" {
  description = "le type d'instance souhaité"
  type        = string
  default     = "t3.2xlarge"
}

variable "counterInstance" {
  description = "Nombre d'instance a creer"
  #type = string
  default = 1
}
# Création d'instance
#=================================================
resource "aws_instance" "terrafom" {

  count                  = var.counterInstance # creation multiple des instances
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.ec2_type
  key_name               = aws_key_pair.vockey.key_name
  vpc_security_group_ids = [aws_security_group.admin_ssh.id]

  depends_on = [aws_security_group.admin_ssh, aws_key_pair.vockey] # Assure l'ordre de création

  tags = {
    Name = "terrafom-${count.index}"
  }

}

# création de la clé SSH dans
#==================================

# tls_private_key → Génère une clé privée.
resource "tls_private_key" "vockey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
#aws_key_pair → Crée la clé publique sur AWS.
resource "aws_key_pair" "vockey" {
  key_name   = "vockey"
  public_key = tls_private_key.vockey.public_key_openssh
}
# local_file → Stocke la clé privée (vockey.pem) localement.
resource "local_file" "vockey_pem" {
  filename        = "${path.module}/vockey.pem"
  content         = tls_private_key.vockey.private_key_pem
  file_permission = "0600"
}



output "instance_info" {
  value = {
    public_ip   = aws_instance.terrafom[*].public_ip
    ami_id      = aws_instance.terrafom[*].ami
    isntance_id = aws_instance.terrafom[*].id
  }
}


# exportation d'IPs
resource "null_resource" "generate_ansible_inventory" {
  depends_on = [aws_instance.terrafom]

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ../ansible
      echo "[docker]" > ../ansible/inventory.ini
      ${join("\n", formatlist("echo %s ansible_user=ubuntu ansible_ssh_private_key_file=~/dns-wp/terraform/vockey.pem >> ../ansible/inventory.ini", aws_instance.terrafom[*].public_ip))}
    EOT
  }
}



#_____________Creation de security group___________
# =================================================
resource "aws_security_group" "admin_ssh" {
  name = "admin-ssh"
  #description = "groupe-de sécurité pour accès ssh"
  vpc_id = "vpc-09c4b38653df63f28"


  tags = {
    Name = "admin-ssh"
  }
}

variable "admin-ips" {
  description = "les ip's des admins"
  default     = ["192.168.1.0", "77.207.199.0"]
}

variable "mon_ip" {
  description = "Les adresses acceptéés"
  type        = string
  default     = "176.172.132.0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in_myip" {
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "${var.mon_ip}/24"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in" {
  for_each          = toset(var.admin-ips)
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "${each.value}/24"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_in" {
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_in" {
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_ssh_out" {
  security_group_id = aws_security_group.admin_ssh.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

output "sg_name" {
  value = aws_security_group.admin_ssh.name
}
output "sg_id" {
  value = aws_security_group.admin_ssh.id
}