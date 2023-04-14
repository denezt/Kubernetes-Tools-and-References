# Useful Kubernetes Commands for Cluster Administration

## Basic Commands
``` sh
kubectl get all
kubectl describe service SERVICE_NAME
kubectl describe deployment DEPLOYMENT_NAME
```

### Extracting secrets and decoding
``` sh
kubectl get secrets
kubectl describe secret SECRET
kubectl get secret SECRET
kubectl get secret SECRET -o yaml
kubectl get secret SECRET -o jsonpath="{.data.accesskey}" | base64 --decode
kubectl get secret SECRET -o jsonpath="{.data.secretkey}" | base64 --decode
```

### Exposing a Pod and creating a service
``` sh
# Will create a service for us
kubectl expose deployment DEPLOYMENT_NAME --type=NodePort
```

### Replicate Sets and Rollouts
``` sh
# Get information on current deployments 
kubectl get deployments

# Get information about the replica sets
kubectl get rs

# Get pods and also show labels attached to those pods
kubectl get pods --show-labels

# Get deployment status
kubectl rollout status deployment/DEPLOYMENT_NAME

# Run k8s-demo with the image label version 2
kubectl set image deployment/DEPLOYMENT_NAME k8s-demo=k8s-demo:2

# Edit the deployment object
kubectl edit deployment/DEPLOYMENT_NAME

# Get the status of the rollout
kubectl rollout status deployment/DEPLOYMENT_NAME

# Get the rollout history
kubectl rollout history deployment/DEPLOYMENT_NAME

# Rollback to previous version
kubectl rollout undo deployment/DEPLOYMENT_NAME

# Rollback to any version
kubectl rollout undo deployment/DEPLOYMENT_NAME --to-revision=REVISION_NUMBER
```

### Change Namespace
``` sh
kubectl config set-context --current --namespace=qs-datalake
kubectl config set-context --current --namespace=NAMESPACE_NAME
```

### Daemonize services
``` sh
# Start services
nohup kubectl port-forward services/SERVICE_NAME 9200:9200 > /dev/null &
nohup kubectl port-forward services/SERVICE_NAME 5601:5601 > /dev/null &
nohup kubectl port-forward services/SERVICE_NAME 9000:9000 > /dev/null &
```

### Run a command on a pod
``` sh
# Attach to a running container
kubectl attach PODNAME
# Execute a command in container
kubectl exec NAME_POD -- ls
kubectl exec NAME_POD -- touch test.c
kubectl exec NAME_POD -- ls
```

### Scaling a pod via CLI
``` sh
# Upscaling with replication-controller file
kubectl scale --replicas=4 -f my-repl-controller.yaml
# Upscaling via calling the replication-controller name
kubectl scale --replicas=4 rc/REPLICATION_NAME
# Downscaling with replication-controller file
kubectl scale --replicas=1 -f my-repl-controller.yaml
# Downscaling via calling the replication-controller name
kubectl scale --replicas=1 rc/REPLICATION_NAME
# Finally, we can remove the replication-controller
kubectl delete rc/my-controller
```

### Useful Commands
``` sh
# Get information on current deployments
kubectl get deployments

# Get information about the replica sets
kubectl get rs

# Get pods, an also show labels attached to those pods
kubectl get pods --show-labels

# Get deployment status
kubectl rollout status deployment/DEPLOYMENT_NAME

# Run k8s-demo with the image label (Change Image)
kubectl set image deployment/DEPLOYMENT_NAME OLD_IMAGE=NEW_IMAGE

# Edit the deployment object
kubectl edit deployment/DEPLOYMENT_NAME

# Get the status of the rollout
kubectl rollout status deployment/DEPLOYMENT_NAME

# Get the rollout history
kubectl rollout history deployment/DEPLOYMENT_NAME

# Rollback to previous version
kubectl rollout undo deployment/DEPLOYMENT_NAME
```

### More Useful Commands
``` sh
kubectl set image deployment/DEPLOYMENT_NAME OLD_IMAGE=NEW_IMAGE
```

### Some Advanced topics
``` sh
# If a pod is not removing, then you might need to remove the stateful set.
# WARNING: Use with caution it will remove a stateful application like a database
kubectl delete statefulsets.apps/STATEFULSET_NAME
```


