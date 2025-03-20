provider "aws" {
  region = "us-east-1"
}

# Variable Innstance pre-prod
#====================================================
variable "ec2_type_preprod" {
  description = "le type d'instance souhaité"
  type        = string
  default     = "t3.micro"
}

variable "counterInstance_preprod" {
  description = "Nombre d'instance a creer"
  #type = string
  default = 1
}

# Variable autorisation des ip (Innstance pre-prod)
variable "admin-ips" {
  description = "les ip's des admins"
  default     = ["192.168.1.0", "77.207.199.0"]
}

variable "mon_ip" {
  description = "Les adresses acceptéés"
  type        = string
  default     = "176.172.132.0"
}



# ======================================
resource "aws_instance" "terrafom_preprod" {

  count                  = var.counterInstance_preprod # creation multiple des instances
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.ec2_type_preprod
  key_name               = aws_key_pair.vockey.key_name
  subnet_id              = "subnet-0c90a1be41664ad8e" #  sous-réseau appartenant à vpc-013d1e316d56835ef
  vpc_security_group_ids = [aws_security_group.admin_ssh.id]


  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_security_group.admin_ssh, aws_key_pair.vockey] # Assure l'ordre de création

  tags = {
    Name = "terrafom-${count.index}"
  }

}
#création de la clé SSH dans

# Ajout d'un random_string pour générer un nom unique :
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}
# tls_private_key → Génère une clé privée.
resource "tls_private_key" "vockey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
#aws_key_pair → Crée la clé publique sur AWS.
resource "aws_key_pair" "vockey" {
  key_name   = "vockey-${random_string.suffix.result}" #"vockey" avec sufix
  public_key = tls_private_key.vockey.public_key_openssh

  lifecycle {
    ignore_changes = [key_name] # Ignore si la clé existe déjà
  }
}
# local_file → Stocke la clé privée (vockey.pem) localement.
resource "local_file" "vockey_pem" {
  filename        = "${path.module}/vockey-${random_string.suffix.result}.pem"
  content         = tls_private_key.vockey.private_key_pem
  file_permission = "0600"
}

output "instance_info_preprod" {
  value = {
    PreProd_public_ip = aws_instance.terrafom_preprod[*].public_ip
  }
}

output "ssh_key_name" {
  value = aws_key_pair.vockey.key_name
}

output "ssh_private_key_filename" {
  value = local_file.vockey_pem.filename
}


# exportation d'IPs
resource "null_resource" "generate_ansible_inventory" {
  depends_on = [aws_instance.terrafom_preprod]

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ../ansible
      echo "[docker]" > ../ansible/inventory.ini
      ${join("\n", formatlist("echo %s ansible_user=ubuntu ansible_ssh_private_key_file=${path.module}/terrafom_preprod/vockey-${random_string.suffix.result}.pem >> ../ansible/inventory.ini", aws_instance.terrafom_preprod[*].public_ip))}
    EOT
  }
}

#_____________Creation de security group___________
# =================================================

# Création du groupe de sécurité s'il n'existe pas déjà
resource "aws_security_group" "admin_ssh" {
  name = "admin-ssh"
  #description = "groupe-de sécurité pour accès ssh"
  vpc_id = "vpc-013d1e316d56835ef" # The chosen vpc

  lifecycle {
    ignore_changes = [name] # Ignore si le groupe existe déjà
  }

  tags = {
    Name = "admin-ssh"
  }
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

resource "aws_vpc_security_group_egress_rule" "allow_ssh_out" {
  security_group_id = aws_security_group.admin_ssh.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

