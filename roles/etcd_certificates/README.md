# prepare_etcd_certificates

A role for preparing and distributing TLS certificates for etcd nodes in a Kubernetes cluster or similar environment. This role handles the creation of a Certificate Authority (CA), generates etcd certificates signed by the CA, and distributes these certificates to etcd nodes.

## Requirements

- Ansible 2.9 or higher
- `cfssl` and `cfssljson` tools must be installed on the control machine where the playbook is run. These tools are used for certificate generation.
- `githubixx.cfssl` role if needed (defined in `meta/main.yml`)

## Role Variables

The following variables can be set in `defaults/main.yml` or overridden in your playbook:

- `cert_dir`: Directory where certificates and keys are stored. Default is `/etc/ssl/etcd`.

Example:
```yaml
cert_dir: /etc/ssl/etcd
```

**This role will generate CA and TLS certs for `etcd-nodes` group. in directory `/etc/ssl/etcd`**

* /etc/ssl/etcd/ca.csr
* /etc/ssl/etcd/ca-key.pem
* /etc/ssl/etcd/ca.pem
* /etc/ssl/etcd/etcd-key.pem
* /etc/ssl/etcd/etcd.pem

