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

  COM LOADBALANCER k3d create cluster tfk8s -p "80:30000@loadbalancer"

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

####################################
* JENKINS
Depois da instalação, pegar o ip e adicionar a porta :8080 no final (onde o jenkins estará rodando)

- Para verificar a senha
 1 - /var/lib/jenkins/secrets/initialAdminPassword
 2 - Install suggested plugins
 3 - Criar um usuário com uma senha
 4 - Configuração da url: url que está rodando o jenkins
 5 - Gerenciar Jenkins
 6 - Gerenciar extensões
  * Plugins (disponíveis): Docker, Docker Pipeline, Kubernetes CLI
  * Marcar Reiniciar o Jenkins depois da instalação
 7 - Desenvolver a Pipeline
  * Nova Tarefa -> Selecionar Pipeline -> Nome do Projeto 
  * Definition (Pipeline script from SCM)
  * Url do repositório GIT, branch (main), script Jenkinsfile
 8 - Gerenciar credenciais para o script jenkins
  * Painel de controle -> Gerenciar Jenkins -> Credentials        -> System -> Global credentials (unrestricted) -> New credentials
  Kind -> Username with password - Colocar usuário e senha e id (dockerhub "exemplo") e create
  -> Passar a credencial no script
 9 - Adicionar credencias também para o Kube config (Tipo Secret file)
 10 - Trigger para a construção e deploy da imagem serem automáticos
  * Painel de controle -> NomeDoProjeto -> General -> Github hook trigger for GITScm polling -> Salvar
  * Pegar o endereço do jenkins -> ir em settings do projeto do Github -> Webhooks -> Payload URL -> endereço_do_jenkins/github-webhook/ (Importante ter a barra no final)

* MONITORING
  kubectl apply -f ./observability&monitoring/deploy-prometheus-grafana.yaml





