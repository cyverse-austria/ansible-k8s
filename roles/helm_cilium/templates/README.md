# Cilium Policy Layers

Cilium’s policies can filter traffic at three key (**L3/L4/L7**) layers of the OSI networking model 

| Layer | Name | Example in Cilium | What it controls |
|-------|------|-------------------|------------------|
| **L3** | Network layer | IP addresses (source/destination) | Which pods / IPs can talk to which |
| **L4** | Transport layer | TCP / UDP ports and protocols | Which ports can be used for communication |
| **L7** | Application layer | HTTP, gRPC, Kafka, DNS, etc. | What application-level actions or paths are allowed |


## [Policy Enforcement Modes](https://docs.cilium.io/en/stable/security/policy/intro/#policy-enforcement-modes)
The configuration of the Cilium agent and the Cilium Network Policy determines whether an endpoint accepts traffic from a source or not. The agent can be put into the following three policy enforcement modes:

### default
This is the default behavior for policy enforcement. In this mode, endpoints have unrestricted network access until selected by policy. Upon being selected by a policy, the endpoint permits only allowed traffic. This state is per-direction and can be adjusted on a per-policy basis. For more details, see the dedicated section on default mode.

### always
With always mode, policy enforcement is enabled on all endpoints even if no rules select specific endpoints.

If you want to configure health entity to check cluster-wide connectivity when you start cilium-agent with enable-policy: always, you will likely want to enable communications to and from the health endpoint. See Example: Add Health Endpoint.

```yaml
# kubectl apply -f add-health.yaml
apiVersion: "cilium.io/v2"
kind: CiliumClusterwideNetworkPolicy
metadata:
  name: "cilium-health-checks"
spec:
  endpointSelector:
    matchLabels:
      'reserved:health': ''
  ingress:
    - fromEntities:
      - remote-node
  egress:
    - toEntities:
      - remote-node
```

### never
With never mode, policy enforcement is disabled on all endpoints, even if rules do select specific endpoints. In other words, all traffic is allowed from any source (on ingress) or destination (on egress).


# hubble relay:
  Warning  PolicyViolation  9m56s  kyverno-scan  policy require-run-as-nonroot/run-as-non-root fail: validation error: Running as root is not allowed. Either the field spec.securityContext.runAsNonRoot must be set to `true`, or the fields spec.containers[*].securityContext.runAsNonRoot, spec.initContainers[*].securityContext.runAsNonRoot, and spec.ephemeralContainers[*].securityContext.runAsNonRoot must be set to `true`. rule run-as-non-root[0] failed at path /spec/securityContext/runAsNonRoot/ rule run-as-non-root[1] failed at path /spec/containers/0/securityContext/
  Warning  PolicyViolation  9m56s  kyverno-scan  policy restrict-seccomp-strict/check-seccomp-strict fail: validation error: Use of custom Seccomp profiles is disallowed. The fields spec.securityContext.seccompProfile.type, spec.containers[*].securityContext.seccompProfile.type, spec.initContainers[*].securityContext.seccompProfile.type, and spec.ephemeralContainers[*].securityContext.seccompProfile.type must be set to `RuntimeDefault` or `Localhost`. rule check-seccomp-strict[0] failed at path /spec/securityContext/seccompProfile/ rule check-seccomp-strict[1] failed at path /spec/containers/0/securityContext/
  Warning  PolicyViolation  9m56s  kyverno-scan  policy disallow-privilege-escalation/privilege-escalation fail: validation error: Privilege escalation is disallowed. The fields spec.containers[*].securityContext.allowPrivilegeEscalation, spec.initContainers[*].securityContext.allowPrivilegeEscalation, and spec.ephemeralContainers[*].securityContext.allowPrivilegeEscalation must be set to `false`. rule privilege-escalation failed at path /spec/containers/0/securityContext/
