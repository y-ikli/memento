## Introduction to Kubernetes
**What is Kubernetes?**
- Kubernetes is an open-source platform for automating the deployment, scaling, and management of containerized applications.
- It groups containers into logical units for easy management and discovery.
- Kubernetes provides high availability, scalability, and fault tolerance for applications in production.

## Prerequisites
**Before starting, you’ll need:**
- A basic understanding of containers (Docker)
- Access to a Kubernetes cluster (local or cloud-based)
- kubectl (Kubernetes command-line tool)
- A container registry (e.g., Docker Hub)

## Setting Up Kubernetes Cluster
**Using Minikube for a Local Cluster:**
- Minikube allows you to run Kubernetes clusters locally.

**Install Minikube:**
```
brew install minikube
```

**Start the Minikube Cluster:**
```
minikube start
```

**Check Cluster Status:**
```
kubectl cluster-info
```

## Deploying a Simple Application on Kubernetes
**Create a deployment YAML file:**
- Example: `deployment.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

**Deploy the application:**
```
kubectl apply -f deployment.yaml
```

**Check the deployment status:**
```
kubectl get deployments
```

## Exposing the Application
**Expose the deployment via a service:**
- Example: `service.yaml`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```

**Create the service:**
```
kubectl apply -f service.yaml
```

**Get the external IP of the service:**
```
kubectl get svc nginx-service
```

## Scaling the Application
**Scale the number of replicas:**
```
kubectl scale deployment nginx-deployment --replicas=3
```

**Verify the new number of pods:**
```
kubectl get pods
```

## Updating the Application
**Update the deployment with a new image:**
```
kubectl set image deployment/nginx-deployment nginx=nginx:latest
```

**Check if the deployment was updated:**
```
kubectl rollout status deployment/nginx-deployment
```

## Deleting Resources
**Delete the service and deployment:**
```
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
```

## Conclusion
**Key Takeaways:**
- Kubernetes helps with managing containerized applications in production with features like scaling, monitoring, and self-healing.
- The key components include Pods, Deployments, and Services.
- Kubernetes provides high availability, fault tolerance, and easy scaling.

**Next Steps:**
- Learn about ConfigMaps and Secrets for managing application configuration.
- Explore Helm for easier package management in Kubernetes.
- Experiment with Kubernetes in the cloud (e.g., GKE, EKS, AKS).


Last update : 2025-05-04T19:26:13Z
