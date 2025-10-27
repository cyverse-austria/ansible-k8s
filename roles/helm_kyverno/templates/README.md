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