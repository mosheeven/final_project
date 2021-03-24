## Start EKS cluster with Terraform
This will start an EKS cluster with terraform

## Prerequisites
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) on your workstation/server
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your workstation/server
- jeknins server with plugins & credntials (will be automated soon)

## Run
Run the following to start your eks environment:
```bash
terraform init
terraform apply --auto-approve
```

After the environement is up run the following to update your kubeconfig file (you can get the `cluster_name` value from the cluster_name output in terraform)
```bash
aws eks --region=us-east-1 update-kubeconfig --name <cluster_name>
```

## Connect Jenkins with eks
- Copy ~/.kube/config to the kuberenetes credintiael in jenkins. 
- Update /kubeFiles/aws-auth-cm.yaml.
- Run kubectl apply -f /kubeFiles/aws-auth-cm.yaml 
- Run build_kandula_project
- Run deploy_kandula_app