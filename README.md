# Nexus Helm Chart & Terraform Code

This repository contains a custom Helm chart for deploying Sonatype Nexus on Kubernetes, along with Terraform code for automating infrastructure provisioning. Use these tools to streamline Nexus installation, configuration, and management in cloud-native environments.

This helm chart use default Nexus docker image, and additionally add EULA acceptance, raw proxy repository create,
also some shell commands added for quick reference
```
# Dockerfile to quick entrance into Nexus
FROM sonatype/nexus3
CMD [ "sh" ]
```

# commans line examples
```
# manual chart install
helm install nexus3 ./charts/nexus

# lint/tests
help lint --strict charts/nexus
helm lint charts/nexus
helm template test charts/nexus
helm template test charts/nexus #--debug

# get all logs
kubectl logs $(kubectl get pod | grep nexus | tail -n1 | awk '{print $1}') --all-containers
# get init container logs
kubectl logs $(kubectl get pod | grep nexus | tail -n1 | awk '{print $1}') -c init

# allow pod forward
kubectl port-forward pod/$(kubectl get pod |grep nexus | tail -n1 | awk '{print $1}') 2000:8081 
```