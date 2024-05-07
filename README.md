## Title: Node.js "Hello World" Application Dockerization and Kubernetes Deployment

### Overview:
This project involves Dockerizing a Node.js "Hello World" application, creating a Kubernetes Helm chart for deployment, and utilizing ArgoCD for GitOps management.

prerequisites for completing the tasks outlined in the project:

1. Dockerization:
Docker Installed: Ensure Docker is installed on your local machine or the environment where you plan to build Docker images. You can download and install Docker from https://www.notion.so/Minikube-Installation-Guide-for-Ubuntu-f0778b09e52e44a0800620a699b4726f?pvs=4
- **GitHub Account:** You'll need a GitHub account to clone the Node.js "Hello World" application repository and push to dockerHub.
- **DockerHub Account:** Create a DockerHub account if you haven't already. You'll need this account to push your Docker images

2. Kubernetes Deployment:
Kubernetes Cluster: Set up a Kubernetes cluster where you'll deploy the Helm chart. You can use local tools like Minikube or kind for development and testing purposes, or deploy to a cloud provider like Google Kubernetes Engine (GKE), Amazon Elastic Kubernetes Service (EKS), or Microsoft Azure Kubernetes Service (AKS).
- **Docker/Minikube/Kubectl Installation:** https://www.notion.so/Minikube-Installation-Guide-for-Ubuntu-f0778b09e52e44a0800620a699b4726f?pvs=4

Helm Installed: Install Helm on your local machine or the environment where you'll be managing the Helm charts.
- **ArgoCD Installed:** Set up ArgoCD for GitOps management of your Kubernetes deployments.
You can find guide from https://www.notion.so/Helm-Installation-9a327f6d97964fbaa6bb981ee41889d1?pvs=4 

-----------------------------------------------------------------------------------------------------
Process:
**1. Dockerization:**

- **Application Source:** The Node.js "Hello World" application source code is hosted on GitHub at https://github.com/johnpapa/node-hello.
- **Commands:**
    - Clone the application repository:
        
        ```bash
        git clone https://github.com/johnpapa/node-hello.git
        ```
        
    - Change directory to the cloned repository:
        
        ```bash
        cd node-hello
        ```
        
- **Docker Image Creation:** The Docker image for the application was created using a multi-stage Dockerfile for efficiency in image creation. The Dockerfile retrieves the application source code, installs dependencies, and exposes the application on port 8000.
    
    Dockerfile:
    
    ```
    # -------------------------------- Stage 1: Build Stage -------------------------------
    FROM node:12.2.0-alpine AS build
    WORKDIR /app
    COPY . .
    RUN npm install
    RUN npm run test
    
    # ------------------------------- Stage 2: Production Stage ----------------------------
    FROM node:12.2.0-alpine AS prod
    WORKDIR /app
    COPY --from=build /app .
    EXPOSE 8000
    CMD ["npm", "start"]
    
    ```
    
- **Docker Image Push:** The Docker image was pushed to DockerHub using GitHub Actions. A GitHub workflow file (**`build-push-image.yaml`**) was created in the **`.github/workflows`** directory to automate the build and push process.
    
    GitHub Workflow:
    
    ```yaml
    name: Build then Push Docker Image
    
    on:
      push:
        branches:
          - main
    
    jobs:
      build:
        runs-on: ubuntu-latest
    
        steps:
          - name: Checkout code
            uses: actions/checkout@v2
    
          - name: Login to DockerHub
            run: echo "${{ secrets.DOCKERHUB_TOKEN }}" | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
    
          - name: Build and push Docker image
            uses: docker/build-push-action@v2
            with:
              context: .
              push: true
              tags: pbaloriya/hello-node:latest
              DOCKERHUB_TOKEN: ${{ secrets.DOCKERHUB_TOKEN }}
    
    ```
    

**2. Kubernetes Deployment:**

- **Helm Chart Creation:** A Helm chart named **`hello-node-chart`** was created for deploying the Node.js application on Kubernetes. The Helm chart includes necessary Kubernetes manifests such as deployment and service configurations. Follow here or Find commands below: https://www.notion.so/Helm-Installation-9a327f6d97964fbaa6bb981ee41889d1?pvs=4
    
    Helm Chart Structure:
    
    ```
    hello-node-chart/
    ├── charts
    ├── Chart.yaml
    ├── templates
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   └── ...
    ├── values.yaml
    └── ...
    
    ```
    
- **Commands:**
    - Initialize Helm in the project directory:
        
        ```lua
        helm create hello-node-chart
        
        ```
        
    - Modify Helm chart templates and values.yaml as required.
- **1. ArgoCD Integration:** ArgoCD was utilized for GitOps management of the Helm chart deployment on a Kubernetes cluster. ArgoCD YAML files were created to define the Helm chart deployment. 
  ``` argocd-application.yaml ```

another way
**2. Kubernetes Deployment:**
- **ArgoCD Integration:** ArgoCD was utilized for GitOps management of the Helm chart deployment on a Kubernetes cluster. Instead of creating YAML files manually, the deployment was managed through the ArgoCD dashboard.

