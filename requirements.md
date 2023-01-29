* Make a Docker Image
 - docker build -t nome_da_imagem -f caminho .

* Verify if image was created and enter
 - docker container run -it ubuntu-curl /bin/bash

* Rename image
 - Default image name
  - tfk8s/ubuntu-curl:v1 (recommended latest tag)
    - docker build -t tfk8scloud/ubuntu-curl:v1 -f .\packages\services\Dockerfile .

    - docker tag tfk8scloud/appointments-srv:v1 tfk8scloud/appointments-srv:latest

* Deploy Image
  - docker push tfk8scloud/ubuntu-curl:latest

** KUBERNETES **

* Instalar o k3d - para criação de cluster

- kubectl api-resources

- kubectl get nodes - verificar os nodes
- kubectl get pods - verificar_ os pods
- kubectl describe pod nome_do_pod
- kubectl port-forward pod/nome_do_pod 4000:80

  COM LOADBALANCER
  k3d cluster create "80:30000@loadbalancer"k3d create cluster tfk8s -p "80:4000@loadbalancer"

- KUBERNETES STRUCTURE
  apiVersion:
  kind:
  metadata:
  spec:

- REPLICASET
  * Replica os pods na mesma quantidade de pods e os mantem rodando
  * ele garante que a quantidade desejada está em execução

- DEPLOYMENT
  * Gerencia as versões do replicaset
  * Quando alterado a versão, o deployment  muda a versão do replicaset

  - desfazer as alteraçoes
    * kubectl rollout undo deployment nome_do_deployment

POSTGRES KUBERNETES 
- kubectl apply -f .\deployment.yaml
- kubectl apply -f .\service.yaml
- kubectl get all (verificar os processos) / kubectl get pods (verificar os pods)
- kubectl port-forward service/postgres 5432:5432

APAGAR
kubectl delete pod node_do_pod

SUBIR O KAFKA COM O NAMESPACE 
kubectl port-forward nome_do_pod_kafka 9092 -n kafka

resources:
  limits: 
    memory: 512
    cpu: "1"
  requests:
    memory: 256
    cpu: "0.2"

