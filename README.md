# ansible-k8s-rhel
Ansible playbooks to deploy kubernetes on Centos7 & Rocky Linux 8.

`Ansible version: 2.10.8`

`kubernetes version: 1.26.1`

## preq

Be sure to have a reasonably internet connection. Otherwise there could be timeouts during package installation.  
Remove ansible cache! if you have one.  
There has to be as user with passwordless ssh and passwordless sudo access or root is allowed to login without a password.

### install required ansible roles

`ansible-galaxy install -r requirements.yml`

### Update the inventory

update the [inventory](./inventory\hosts)

### Ping for ssh connections

```bash
ansible -i inventory/ -m ping all --user=<sudo-user>
```

## Get Started

### Run playbooks

#### setup the firewall

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./firewalld-config.yml
```

#### Provision Nodes 
Install all required dependencies for hosts , Which includes installing the `kube-apiserver-haproxy`.

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./provision-nodes.yml
```

#### Init Cluster
This playbook will do the followings:
* init master node
* join master node
* join workers nodes
* install CNI driver

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./multi-master.yml
```

#### Install the vice HAproxy

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./vice-haproxy-install.yaml
```

#### Install the (HAproxy) loadbalancer

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./haproxy-loadbalancer.yml
```

**OR** run all at once:

```bash
for playbook in firewalld-config.yml provision-nodes.yml multi-master.yml vice-haproxy-install.yaml;do
  ansible-playbook --inventory=inventory/ --user=ansible --become ./${playbook}
done
```

**WARNING**
Destroy the kubernetes cluster.

```bash
ansible-playbook -i inventory/ destroy.yml --user root
```

# Extra

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



# add-hosts playbook

Sometimes when you newely generate vms/resources It takes some time
the hostnames are available through DNS. To prevent timeouts, the generated hosts "fetching from inventory" are added to every `/etc/hosts` file
with the following playbook.

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./add-hosts.yml
```


# Install & create ssl certificates

For more documentation see the [README](roles/cert_bot/README.md) 

```bash
ansible-playbook -i inventory/ --user=<sudo-user> --become ./cert_bot.yaml
```
This playbook has an additional variable `var_hosts`. Default ist `'~.*-vice-haproxy\\..*'`. Change this var to the host or group the playbook should run on.


```bash
ansible-playbook -i inventory/ --user=<sudo-user>  --extra-vars="var_hosts=loadbalancer"--become ./cert_bot.yaml
```
