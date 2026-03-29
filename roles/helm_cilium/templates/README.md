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

# Write your policies

[Editor](https://editor.networkpolicy.io)
