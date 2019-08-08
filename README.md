# StakaterControlStack
A Stack to Deploy Controller Apps on Kubernetes Cluster via Helm Charts i.e. Nginx controller, Xposer, Reloader etc.

# How to Deploy Manually

0. Replace all variables mentioned below in the files/folders according to the cloud provider 
1. Make sure `kubectl` is configured correctly with your kubernetes cluster. i.e. `~/.kube/config`
2. Create a new namespace in the cluster
```
kubectl create namespace control
```
3. Run pre-install
```
cd pre-install/
./pre-install.sh
```
4. Switch directory to `manifests` folder
```
cd manifests
```
5. Run the following command
```
kubectl apply -f . -n control
```
6. Run the following in folder `kube-system`
```
cd kube-system/
kubectl apply -f . -n control
```
7. Run the following in folder `1`
```
cd 1/
kubectl apply -f . -n control
```
8. Run the following command in foler `2`
```
cd 2/
kubectl apply -f . -n control
```
9. It will take 3-4 minutes for kubernetes to completely reflect all the changes on the dasboard.

# Variables to replace
REPLACE_EFS_ID: EFS id on AWS

REPLACE_DOMAIN_NAME: Domain name e.g. stakater.com

REPLACE_SSL_CERT_EXTERNAL: aws arn ssl certificate external load balancer

REPLACE_SSL_CERT_INTERNAL: aws arn ssl certificate internal load balancer

REPLACE_SOURCE_RANGES: subnets for internal load balancers

REPLACE_GROUP: Group name for common service

REPLACE_PROVIDER: Provider name e.g. stakater

REPLACE_NAMESPACE: Namespace for the application

REPLACE_WEBHOOK_NAMESPACE: Webhook jenkins namespace 

REPLACE_WEBHOOK_DOMAIN_NAME: Webhook jenkins domain name

REPLACE_MONITOR_PROVIDER_CONFIG: Config for Monitor provider for IMC

REPLACE_PROVISIONER:
    AWS:   kubernetes.io/aws-ebs
    Azure: kubernetes.io/azure-disk
    IBM:   kubernetes.io/glusterfs

REPLACE_PARAMETERS:
AWS:
```
parameters:
  type: gp2
```
Azure:
```
parameters:
  storageaccounttype: Standard_LRS
  kind: Managed
```

IBM Cloud:
```
parameters:
  storageaccounttype: ibmc-block-gold
  kind: Managed
```