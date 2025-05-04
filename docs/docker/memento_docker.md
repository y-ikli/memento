# Memento Docker

## 1. Basic Docker Commands

**Check Docker Version**  
`docker --version`  
- Displays the installed Docker version.

**Check Docker Info**  
`docker info`  
- Displays detailed information about the Docker installation, including container and image counts.

**List All Running Containers**  
`docker ps`  
- Lists all currently running containers.

**List All Containers (Including Stopped)**  
`docker ps -a`  
- Lists all containers, including those that are stopped.

**List All Docker Images**  
`docker images`  
- Displays all Docker images present locally.

## 2. Managing Docker Containers

**Run a Container from an Image**  
`docker run <image-name>`  
- Runs a container from a specified image.

**Run a Container in Detached Mode**  
`docker run -d <image-name>`  
- Runs the container in the background (detached mode).

**Run a Container with Interactive Terminal**  
`docker run -it <image-name> /bin/bash`  
- Runs the container with an interactive terminal and opens a bash shell.

**Run a Container with Port Mapping**  
`docker run -p 8080:80 <image-name>`  
- Maps port 8080 on the host to port 80 inside the container.

**Stop a Running Container**  
`docker stop <container-id>`  
- Stops a running container.

**Start a Stopped Container**  
`docker start <container-id>`  
- Starts a container that has been stopped.

**Restart a Container**  
`docker restart <container-id>`  
- Restarts a running or stopped container.

**Remove a Container**  
`docker rm <container-id>`  
- Removes a stopped container from your system.

## 3. Managing Docker Images

**Pull an Image from Docker Hub**  
`docker pull <image-name>`  
- Downloads a Docker image from Docker Hub or another registry.

**Build an Image from a Dockerfile**  
`docker build -t <image-name> <path>`  
- Builds a Docker image from the specified Dockerfile located at the given path.

**Tag an Image**  
`docker tag <image-name> <new-image-name>`  
- Tags an existing image with a new name.

**Remove an Image**  
`docker rmi <image-name>`  
- Removes a Docker image from your local system.

## 4. Docker Volumes

**List All Volumes**  
`docker volume ls`  
- Lists all Docker volumes on your system.

**Create a New Volume**  
`docker volume create <volume-name>`  
- Creates a new volume.

**Remove a Volume**  
`docker volume rm <volume-name>`  
- Removes a volume from your system.

**Mount a Volume to a Container**  
`docker run -v <volume-name>:/path/in/container <image-name>`  
- Mounts a volume to a specific path inside the container.

## 5. Networking
**Understanding Docker Networks**  
Docker creates default networks (`bridge`, `host`, `none`). List them with:  
```docker network ls```  

**Create a Custom Network**  
```docker network create my-network```  
- Isolate containers for secure communication.  

**Attach a Container to a Network**  
```docker run -d --name my-nginx --net my-network nginx```  
- Launches an Nginx container on the custom network.  

## 6. Using GitLab Docker Registry  

**Log in to GitLab Registry**  
```docker login registry.gitlab.com```  
- Authenticate with your GitLab credentials or a personal access token.  

**Tag and Push an Image**  
```docker build -t registry.gitlab.com/your-project/image:tag .```  
```docker push registry.gitlab.com/your-project/image:tag```  
- Builds and uploads the image to GitLab’s registry.  

**Pull an Image**  
```docker pull registry.gitlab.com/your-project/image:tag```  
- Retrieves the image for local use.  

**CI/CD Authentication**  
In `.gitlab-ci.yml`, use:  
```docker login -u $CI_REGISTRY_USER -p $CI_JOB_TOKEN $CI_REGISTRY```  
- Automates registry access during pipelines.  

Last update : 2025-05-04T18:47:58Z
