# external-etcd

A role for creating ETCD cluster.

## Requirements
All these certificates should exist on:

- /etc/ssl/etcd/ca.csr
- /etc/ssl/etcd/ca-key.pem
- /etc/ssl/etcd/ca.pem
- /etc/ssl/etcd/etcd-key.pem
- /etc/ssl/etcd/etcd.pem


## Role Variables

The following variables can be set in `defaults/main.yml` or overridden in your playbook:

- `etcd_version`: Version of [etcd-io](https://github.com/etcd-io/etcd) 
- `source_cert_dir`:  Directory where the certificates are located, *default* `/etc/ssl/etcd`
- `destination_cert_dir`: Directory where to copy the certificates, *default* `/etc/etcd/pki`


Example:
```yaml
etcd_version: "v3.5.15"
```


## http only

To use http only version you will have to change:
* use template `roles/external-etcd/templates/etcd.service-Witout-https.j2`
* change urls in `roles/external-etcd/tasks/main.yml` from  `https://` to `http://`