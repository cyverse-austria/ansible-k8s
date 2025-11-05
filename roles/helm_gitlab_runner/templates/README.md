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


# Check SA - in shell executer
```bash
root@cy-condor01:~# kubectl -n gitlab-runner exec -it gitlab-runner-7c9ffc9ccf-xvvws -- bash
gitlab-runner-7c9ffc9ccf-xvvws:/$ TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
gitlab-runner-7c9ffc9ccf-xvvws:/$ NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
gitlab-runner-7c9ffc9ccf-xvvws:/$ CA=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
gitlab-runner-7c9ffc9ccf-xvvws:/$ API_SERVER="https://kubernetes.default.svc"
gitlab-runner-7c9ffc9ccf-xvvws:/$ curl --cacert $CA -H "Authorization: Bearer $TOKEN" \
  $API_SERVER/api/v1/namespaces/$NAMESPACE/pods
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "pods is forbidden: User \"system:serviceaccount:gitlab-runner:default\" cannot list resource \"pods\" in API group \"\" in the namespace \"gitlab-runner\"",
  "reason": "Forbidden",
  "details": {
    "kind": "pods"
  },
  "code": 403
}
```

# kubernete executer
```bash
kubectl get role,rolebinding -n gitlab-runner

kubectl get rolebinding gitlab-runner-rolebinding -n gitlab-runner -o yaml

```