# ansible-k8s

Ansible playbooks to deploy kubernetes cluster on **Centos7, Debian 11/12 & Rocky Linux 8 and 9**.

`Ansible version: >= 2.10.8`

`kubernetes version: 1.28.2`

## preq

Be sure to have a reasonably internet connection. Otherwise there could be timeouts during package installation.  
**Remove ansible cache!** if you have one.  
There has to be as user with passwordless ssh and passwordless sudo access or root is allowed to login without a password.

### install required ansible roles

`ansible-galaxy install -r requirements.yml`

### Update the inventory

update the [inventory](./inventory/hosts)

### Ping for ssh connections

```bash
ansible -i inventory/ -m ping all --user=<sudo-user> --become 
```

---

## Playbooks

### iptables-config.yml

This playbook install iptables and apply the rules on all nodes related to kubernetes cluster `k8s`.
Due to some automatic iptable-rules installation by kubelet/containerd **firewalld** should not be used in parallel.

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./iptables-config.yml
```

### provision-nodes.yml

Install all required dependencies for hosts , Which includes installing the `kube-apiserver-haproxy`.

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./provision-nodes.yml
```

### multi-master.yml

This playbook will do the followings:
* init master node
* join master node
* join workers nodes
* install CNI driver

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./multi-master.yml
```

**OR** run all at once:

```bash
for playbook in iptables-config.yml provision-nodes.yml multi-master.yml vice-haproxy-install.yaml;do
  ansible-playbook --inventory=inventory/ --user=ansible --become ./${playbook}
done
```

## Extra

## Tainting and Labeling VICE Worker Nodes
Once you have your nodes joined the cluster:

The CyVerse Discovery Environment uses taints and labels to ensure that some nodes are used exclusively for VICE
analyses. To mark a node as a VICE worker node, run this command on any node that has access to the Kubernetes API:

**Run this command to label node**
```bash
kubectl label nodes <VICE-WORKER-NODES> vice=true
```

**To prevent non-VICE pods from running on a node, run this command:**
```bash
kubectl taint nodes <VICE-WORKER-NODES> vice=only:NoSchedule
```

**check if labeld**
```bash
kubectl get nodes -l vice=true
```

## COPY kubeconfig to your local machine
```bash
# this will allow you to access your cluster from your local machine.
scp root@<MASTER_NODE>:/etc/kubernetes/admin.conf ~/.kube/config
```


**WARNING**
Destroy the kubernetes cluster.

```bash
ansible-playbook -i inventory/ destroy.yml --user root
```

---

# Loadbalancers

This ansible repository also have playbooks that will generate and install HAProxy.

**Note:** All HAProxy nodes is a **Debian 11** based.

#### Install the vice HAproxy

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./vice-haproxy-install.yaml
```

#### Install the (HAproxy) loadbalancer

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./haproxy-loadbalancer.yml
```

# Install & create ssl certificates

For more documentation see the [README](roles/cert_bot/README.md) 

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./cert_bot.yaml
```

This playbook has an additional variable `var_hosts`. Default ist `'~.*-vice-haproxy\\..*'`. Change this var to the host or group the playbook should run on.


```bash
ansible-playbook -i inventory/ --user=<sudo-user> --extra-vars="var_hosts=loadbalancer" --become ./cert_bot.yaml
```
