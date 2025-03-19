création de d'un groupe IAM pour spécifier des autorisations pour un ensemble de personnes
création d'un utilisateur "the_chosen" pour eviter de se connecter avec un accès root.
-> Attachement de l'utilisateur au groupe pour qu'il bénéficie des droits nécessaires definit dans ce dernier.

Installation d' awscli:

```bash
sudo apt update && sudo apt upgrade -y
```

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

Si l'installation est réussie, configure AWS :
```bash
aws configure # Entre tes AWS Access Key ID et AWS Secret Access Key.
```

Une fois configuré, teste si AWS CLI fonctionne bien :
```bash
aws sts get-caller-identity # Si tu obtiens un résultat avec ton Account ID, User ARN et User ID, alors tout est bon

# Lister les instances en cours d'exécution :
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,ImageId,State.Name,PublicIpAddress]" --output table

# Affichera des infos sur l'AMI utilisée, y compris son système d'exploitation.
aws ec2 describe-images --image-ids ami-xxxxxxxxxxxxxx --query "Images[*].[ImageId, Name, Description]" --output table



```