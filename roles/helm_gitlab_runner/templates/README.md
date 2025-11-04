# [gitlab-runner](https://gitlab.com/gitlab-org/charts/gitlab-runner/)

## TODO cilium
```bash
apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: ci-job-isolation
  namespace: gitlab-runner
spec:
  endpointSelector: {}   # selects all pods in this namespace
  egress:
    - toEntities:
        - world      # allow internet
        - kube-dns   # allow DNS resolution
  ingress:
    - fromEndpoints:
        - matchLabels:
            io.kubernetes.pod.namespace: gitlab-runner
```
