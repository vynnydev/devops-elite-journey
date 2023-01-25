* Make a Docker Image
 - docker build -t nome_da_imagem -f caminho .

* Verify if image was created and enter
 - docker container run -it ubuntu-curl /bin/bash

* Rename image
 - Default image name
  - tfk8s/ubuntu-curl:v1 (recommended latest tag)
    - docker build -t tfk8scloud/ubuntu-curl:latest -f .\packages\services\Dockerfile .

* Deploy Image
  - docker push tfk8scloud/ubuntu-curl:latest