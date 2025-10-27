
# [Kyverno](https://github.com/kyverno/kyverno)

Cloud Native Policy Management

**About Kyverno**: 

Kyverno is a **Kubernetes-native policy engine designed for platform engineering teams**. It enables security, compliance, automation, and governance through policy-as-code. Kyverno can:

* **Validate**, **mutate**, **generate**, and **clean up** resources using Kubernetes admission controls and background scans.
* Verify container image signatures for supply chain security.
* Operate with tools you already use — like kubectl, kustomize, and Git.

---

# Kyverno Restricted policies

See also [Pod Security](https://kyverno.io/policies/pod-security)

## Disallow Capabilities (Strict)
Adding capabilities other than `NET_BIND_SERVICE` is disallowed. In addition, all containers must explicitly drop `ALL` capabilities.

## Disallow Privilege Escalation
Privilege escalation, such as via set-user-ID or set-group-ID file mode, should not be allowed. This policy ensures the `allowPrivilegeEscalation` field is set to `false`.

## Require Run As Non-Root User
Containers must be required to run as non-root users. This policy ensures `runAsUser` is either unset or set to a number greater than zero.

## Require runAsNonRoot
Containers must be required to run as non-root users. This policy ensures `runAsNonRoot` is set to `true`. A known issue prevents a policy such as this using `anyPattern` from being persisted properly in Kubernetes 1.23.0-1.23.2.

## Restrict Seccomp (Strict)
The seccomp profile in the Restricted group must not be explicitly set to Unconfined but additionally must also not allow an unset value. This policy, requiring Kubernetes v1.19 or later, ensures that seccomp is set to `RuntimeDefault` or `Localhost`. A known issue prevents a policy such as this using `anyPattern` from being persisted properly in Kubernetes 1.23.0-1.23.2.

## Restrict Volume Types
In addition to restricting HostPath volumes, the restricted pod security profile limits usage of non-core volume types to those defined through PersistentVolumes. This policy blocks any other type of volume other than those in the allow list.

## E.G
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ok-restricted-deployment
  namespace: testing
spec:
  replicas: 2
  selector:
    matchLabels:
      app: ok-restricted
  template:
    metadata:
      labels:
        app: ok-restricted
    spec:
      securityContext:
        runAsNonRoot: true
        seccompProfile:
          type: RuntimeDefault
      containers:
        - name: app
          image: busybox
          command: ["sleep", "3600"]
          securityContext:
            runAsNonRoot: true
            runAsUser: 1000   
            allowPrivilegeEscalation: false
            capabilities:
              drop: ["ALL"]
```

## Conclusion

* No root
* No privilege escalation
* Drop all capabilities
* Use RuntimeDefault seccomp
* Disallow host access
* Restrict SELinux, AppArmor, etc.


## Exception to some ns

These could be added to the `values.yaml` to allow certain policies.

```bash
validationFailureActionOverrides:
  all: []
  # all:
  #   - action: audit
  #     namespaces:
  #       - ingress-nginx
  # disallow-host-path:
  #   - action: audit
  #     namespaces:
  #       - fluent

# Example: allow Argo CD to deploy
validationFailureActionOverrides:
  all:
    - action: audit
      namespaces:
        - argocd

# Example: only allow runAsNonRoot exceptions
validationFailureActionOverrides:
  require-run-as-nonroot:
    - action: audit
      namespaces:
        - argocd

```

---

# [High availability](https://github.com/kyverno/kyverno/tree/main/charts/kyverno#high-availability)
