provider "aws" {
  region = "us-east-1"
}

# Variable Innstance pre-prod
#====================================================
variable "ec2_type_preprod" {
  description = "le type d'instance souhaité"
  type        = string
  default     = "t2.xlarge"
}

variable "counterInstance_preprod" {
  description = "Nombre d'instance a creer"
  #type = string
  default = 3
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


# Cluster rke2 instances
# ======================================

# 3 Masters
resource "aws_instance" "masters" {

  count                  = var.counterInstance_preprod # creation multiple des instances
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.ec2_type_preprod
  key_name               = aws_key_pair.vockeyprod.key_name
  subnet_id              = "subnet-07ef8d731542349d5" #  sous-réseau appartenant au vpc-09c4b38653df63f28
  vpc_security_group_ids = [aws_security_group.admin_ssh_production.id]


  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_security_group.admin_ssh_production, aws_key_pair.vockeyprod] # Assure l'ordre de création

  tags = {
    Name = "master-tf-${count.index}"
  }

}


# morker1
resource "aws_instance" "worker1" {

  #count         = var.counterInstance_preprod # creation multiple des instances
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = "t2.xlarge" #var.ec2_type_preprod
  key_name               = aws_key_pair.vockeyprod.key_name
  subnet_id              = "subnet-07ef8d731542349d5" #  sous-réseau vpc-09c4b38653df63f28
  vpc_security_group_ids = [aws_security_group.admin_ssh_production.id]


  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_security_group.admin_ssh_production, aws_key_pair.vockeyprod] # Assure l'ordre de création

  tags = {
    Name = "worker1-tf"
  }

}


#resource "aws_network_interface" "VIP" {
#  subnet_id   = "subnet-07ef8d731542349d5"   # ID du sous-réseau
#  private_ips = ["10.0.1.100"]       # Adresse IP privée
#  security_groups = [aws_security_group.admin_ssh_production.id]  # ID du groupe de sécurité
#  depends_on = [aws_security_group.admin_ssh_production, aws_key_pair.vockeyprod]
#
#}

#création de la clé SSH pour la prod

# Ajout d'un random_string pour générer un nom unique :
#resource "random_string" "suffix" {
#  length  = 4
#  special = false
#  upper   = false
#}

# tls_private_key → Génère une clé privée.
resource "tls_private_key" "vockeyprod" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
#aws_key_pair → Crée la clé publique sur AWS.
resource "aws_key_pair" "vockeyprod" {
  key_name   = "vockeyprod"
  public_key = tls_private_key.vockeyprod.public_key_openssh

  lifecycle {
    ignore_changes = [key_name] # Ignore si la clé existe déjà
  }
}
# local_file → Stocke la clé privée (vockey.pem) localement.
resource "local_file" "vockeyprod_pem" {
  filename        = "${path.module}/vockeyprod.pem"
  content         = tls_private_key.vockeyprod.private_key_pem
  file_permission = "0600"
}


output "instance_info_prod_master" {
  value = {
    master_prod_public_ip = aws_instance.masters[*].public_ip
  }
}
output "instance_info_prod_worker" {
  value = {
    worker_prod_public_ip = aws_instance.worker1[*].public_ip
  }
}


output "ssh_key_name" {
  value = aws_key_pair.vockeyprod.key_name
}

output "ssh_private_key_filename" {
  value = local_file.vockeyprod_pem.filename
}


# exportation d'IP masters

#resource "null_resource" "generate_ansible_inventory-masters" {
#  depends_on = [aws_instance.masters]
#
#  provisioner "local-exec" {
#    command = <<EOT
#      mkdir -p ../ansible_production
#      echo "[masters]" >> ../ansible_production/inventory
#      # Ajouter master1 avec l'IP spécifique
#      echo "master1 ansible_host=${aws_instance.masters[0].public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./vockeyprod.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'" >> ../ansible_production/inventory
#      # Ajouter les autres masters
#      ${join("\n", formatlist("echo ansible_host=%s ansible_user=ubuntu ansible_ssh_private_key_file=./vockeyprod.pem ansible_ssh_extra_args='\"-o StrictHostKeyChecking=no\"' >> ../ansible_production/inventory", slice(aws_instance.masters[*].public_ip, 1, length(aws_instance.masters))))}
#    EOT
#  }
#}

resource "null_resource" "generate_ansible_inventory-masters" {
  depends_on = [aws_instance.masters]

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ../ansible_production
      echo "[masters]" >> ../ansible_production/inventory

      # Ajouter master1 avec son IP spécifique
      echo "master1 ansible_host=${aws_instance.masters[0].public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./vockeyprod.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'" >> ../ansible_production/inventory

      # Ajouter les autres masters avec un nom explicite
      ${join("\n", formatlist("echo \"master%d ansible_host=%s ansible_user=ubuntu ansible_ssh_private_key_file=./vockeyprod.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'\" >> ../ansible_production/inventory", range(2, length(aws_instance.masters) + 1), slice(aws_instance.masters[*].public_ip, 1, length(aws_instance.masters))))}
    EOT
  }
}



resource "null_resource" "generate_ansible_inventory_w1" {
  depends_on = [aws_instance.worker1]

  provisioner "local-exec" {
    command = <<EOT
      echo "DEBUG: Création de l’inventaire des workers..." >> ../ansible_production/debug_ansible_inventory.log
      mkdir -p ../ansible_production
      echo "[workers]" >> ../ansible_production/inventory
      echo "worker1 ansible_host=${aws_instance.worker1.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./vockeyprod.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'" >> ../ansible_production/inventory
      echo "DEBUG: Fin de l’inventaire des workers." >> ../ansible_production/debug_ansible_inventory.log
    EOT
  }
}


#_____________Creation de security group___________
# =================================================.

# Création du groupe de sécurité s'il n'existe pas déjà
resource "aws_security_group" "admin_ssh_production" {
  name   = "admin_ssh_production"
  vpc_id = "vpc-09c4b38653df63f28" # The chosen vpc

  lifecycle {
    ignore_changes = [name] # Ignore si le groupe existe déjà
  }

  tags = {
    Name = "admin_ssh_production"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in_myip" {
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "${var.mon_ip}/24"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

#========================K8S PORTS================================================
# temporairement pour le worker k8s
resource "aws_vpc_security_group_ingress_rule" "allow_port_9345" {
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 9345
  ip_protocol       = "tcp"
  to_port           = 9345
}
# temporairement pour le worker k8s
resource "aws_vpc_security_group_ingress_rule" "allow_port_6443" {
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 6443
  ip_protocol       = "tcp"
  to_port           = 6443
}
# temporairement pour le worker k8s
resource "aws_vpc_security_group_ingress_rule" "allow_port_UDP" {
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 8472
  ip_protocol       = "udp"
  to_port           = 8472
}
# temporairement pour le worker k8s
resource "aws_vpc_security_group_ingress_rule" "allow_port_10250" {
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 10250
  ip_protocol       = "tcp"
  to_port           = 10250
}



#=======================================================================
# permettre le trafic interne entre les ressources qui appartiennent au groupe admin_ssh_production
resource "aws_security_group_rule" "allow_tcp_2379" {
  type                     = "ingress"
  from_port                = 2379
  to_port                  = 2379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.admin_ssh_production.id # Groupe de sécurité cible
  source_security_group_id = aws_security_group.admin_ssh_production.id # Groupe de sécurité source
}

resource "aws_security_group_rule" "allow_tcp_2380" {
  type                     = "ingress"
  from_port                = 2380
  to_port                  = 2380
  protocol                 = "tcp"
  security_group_id        = aws_security_group.admin_ssh_production.id # Groupe de sécurité cible
  source_security_group_id = aws_security_group.admin_ssh_production.id # Groupe de sécurité source
}



resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in" {
  for_each          = toset(var.admin-ips)
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "${each.value}/24"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh_out" {
  security_group_id = aws_security_group.admin_ssh_production.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_in" {
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_in" {
  security_group_id = aws_security_group.admin_ssh_production.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
