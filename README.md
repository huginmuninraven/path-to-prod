- [path-to-prod](#path-to-prod)
  - [Environment](#environment)
    - [Connect VSCode to SSH host](#connect-vscode-to-ssh-host)
  - [Python](#python)
    - [Create a virtual environment for the project](#create-a-virtual-environment-for-the-project)
    - [Create a requirements.txt file](#create-a-requirementstxt-file)
    - [Author a script](#author-a-script)
  - [Docker](#docker)
    - [Non-Root user](#non-root-user)
      - [Sources](#sources)
    - [Build](#build)
    - [TAG](#tag)
    - [Push](#push)
  - [Helm](#helm)
    - [Create Helm Chart](#create-helm-chart)
    - [Configure Helm Chart](#configure-helm-chart)
    - [Package](#package)
    - [Alter Values File](#alter-values-file)
    - [Install / Upgrade](#install--upgrade)
  - [Terraform](#terraform)


# path-to-prod
A rough outline on how to get to production. 

## Environment

- Check for kubectl
- Check for k9s, [install](https://github.com/derailed/k9s/releases) if necessary
- Check Kubernetes version
- Look for a namespace to deploy, create one if necessary

### Connect VSCode to SSH host
https://code.visualstudio.com/docs/remote/ssh


## Python

### Create a virtual environment for the project

```
python3 -m venv bridgephase-venv

# Activate the virtual environment
source bridgephase-venv/bin/activate
```

### Create a requirements.txt file

```
pip install requirements.txt
```

### Author a script

Code from here: https://www.geeksforgeeks.org/read-json-file-using-python/  
Data file from here: https://json.org/example.html  

``` python
import json
import time

def main():

    # Open and read the JSON file
    with open('example_1.json', 'r') as file:
        data = json.load(file)

    while 1 != 0:
        # Print the data every 10 seconds forever
        print(data)
        time.sleep(10)

if __name__ == "__main__":
    main()
```



## Docker

### Non-Root user
#### Sources
https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user
https://www.docker.com/blog/understanding-the-docker-user-instruction/  

``` bash
FROM python:3.13.3

# install app dependencies
# RUN apt-get update && apt-get install -y python3 python3-pip
# RUN pip install requirements.txt

# Begin User portion
ARG USERNAME=PYTHON
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
USER $USER_UID
# End User setup

WORKDIR /opt/python
COPY ./run.py /opt/python/run.py
EXPOSE 8080
CMD ["python3", "run.py"]
```

### Build
`docker build .`

### TAG
` docker tag imageID registry/repo/image:tag `

### Push
` docker push registry/repo/image:tag `


## Helm

https://helm.sh/docs/intro/cheatsheet/

### Create Helm Chart
https://helm.sh/docs/helm/helm_create/

```
helm create python-parser
```

### Configure Helm Chart
- Remove Liveness/Readiness probe
- Configure securityContext if needed https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod


### Package

```
helm package --app-version 1 ./python-parser
```

### Alter Values File
In a values file outside of the packaged Helm chart, set the image

- Add image to values file.

### Install / Upgrade 

https://helm.sh/docs/helm/helm_upgrade/

Run this command from within the helm chart. 

``` bash
helm upgrade  --install  python-container -f ./python-parser/values.yaml python-parser-0.1.0.tgz \
--namespace=python-parser \
--create-namespace
```



## Terraform 

Source: https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks

```
terraform state pull

terraform state show

terraform plan

terraform apply
```

