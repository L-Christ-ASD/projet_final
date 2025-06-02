## aws
aws sts get-caller-identity

Modifier une policy:

1. recuperer l'arn du policy:
aws iam list-policies --scope Local --query "Policies[?PolicyName=='EC2ELBAccessPolicy'].Arn" --output text

2. Créer la version +1
aws iam create-policy-version \
  --policy-arn arn:aws:iam::585768148089:policy/EC2ELBAccessPolicy \
  --policy-document file://eip_elb_policy.json \
  --set-as-default

3. Vérifier la Version
aws iam get-policy-version \
  --policy-arn arn:aws:iam::585768148089:policy/EC2ELBAccessPolicy \
  --version-id v2



## RKE2
### DEBEUG
kubectl logs -n kube-system -l k8s-app=aws-cloud-controller-manager