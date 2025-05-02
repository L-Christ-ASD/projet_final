Terraform crée les instances EC2 et génère un inventaire Ansible (inventory.ini).
Ansible peut directement utiliser cet inventaire pour se connecter aux machines.
Plus besoin de récupérer manuellement les IPs !


(Error: creating EC2 Instance: operation error EC2: RunInstances, https response error StatusCode: 400, RequestID: ddff9211-0605-41dc-9536-ef2841b9ab51, api error InvalidKeyPair.NotFound: The key pair 'vockey' does not exist
│ 
│   with aws_instance.terrafom[2],
│   on main.tf line 18, in resource "aws_instance" "terrafom":
│   18: resource "aws_instance" "terrafom" {)

🔄 Étapes pour corriger
Vérifie si la Key Pair existe avec :
 
aws ec2 describe-key-pairs --query 'KeyPairs[*].KeyName'
Si elle n'existe pas, crée-la avec :
 
aws ec2 create-key-pair --key-name vockey --query 'KeyMaterial' --output text > vockey.pem
chmod 400 vockey.pem
Applique à nouveau Terraform :
 
terraform apply -auto-approve🔄 

Étapes pour corriger
Vérifie si la Key Pair existe avec :
 
aws ec2 describe-key-pairs --query 'KeyPairs[*].KeyName'
Si elle n'existe pas, crée-la avec :
 
aws ec2 create-key-pair --key-name vockey --query 'KeyMaterial' --output text > vockey.pem
chmod 400 vockey.pem
Applique à nouveau Terraform :
bash


 # vérifier si tes instances EC2 sont bien démarrées après leur création
aws ec2 describe-instances --filters "Name=tag:Name,Values=terrafom-*" --query "Reservations[*].Instances[*].State.Name" --output table
aws ec2 describe-instances --filters "Name=tag:Name,Values=terrafom-*" --output table


terraform init -upgrade
terraform apply -auto-approve

On peut se connecter aux instances avec:

ssh -i vockey.pem ubuntu@<ip>

christ@christ-VirtualBox:~/dns-wp$ ssh -i vockey.pem ubuntu@54.162.208.147
ubuntu@ip-172-31-46-96:~$ ls
