# [Ceph-CSI](https://github.com/ceph/ceph-csi)

Ceph Container Storage Interface (CSI) driver for RBD, CephFS.


## Set RBD storageclass as default

```bash
kubectl patch storageclass ceph-rbd -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```



## CephRBD
How to get existing volumes of images

1. create your keyring file
```bash
# ceph.keyring
[client.rdmkube]
key = <user-key>
```

2. Create ceph conf
```bash
# ceph.conf
[global]
mon_host = <IP>:6789,<IP>:6789,<IP>:6789
```

3. RBD commands

```bash
# list aval volumes
rbd ls --pool=rdmkube --id rdmkube --keyring ./ceph.keyring --conf ./ceph.conf

# list with Volume usage
rbd du --pool=rdmkube --id rdmkube --keyring ./ceph.keyring --conf ./ceph.conf

# Volume info on selected volume
# rbd info <volume> --pool=rdmkube --id rdmkube --keyring ./ceph.keyring --conf ./ceph.conf
rbd info csi-vol-2859e85d-5d0b-42a0-a0da-ba9475fb2db4 --pool=rdmkube --id rdmkube --keyring ./ceph.keyring --conf ./ceph.conf


# check aval pool sizes
ceph df --id rdmkube --keyring ./ceph.keyring --conf ./ceph.conf
```

4. Find which PVC is which image in CEPH

```bash
# This will give you the exact image name which is in ceph
kubectl get pv pvc-b2a2b5ef-d8c5-494e-9815-c335498fa2c5 -o yaml |grep imageName
```

5. Deleting a cephRBC image (WARNING)
```bash
rbd rm csi-vol-d1365722-d99a-4db9-8245-a7ebc33e6bdd --pool=rdmkube --id rdmkube --keyring ./ceph.keyring --conf ./ceph.conf
```

## CephFS
TODO...

[values.yaml](https://github.com/ceph/ceph-csi/blob/release-v3.15/charts/ceph-csi-cephfs/values.yaml)
