# Hosts bootstrap

Bootstrap once, then let Ansible do the rest


## Preq

1. Generate SSH key: (control node)
Make sure this is actually created in your jumphost, not the docker environment
```bash
ssh @jumphost

ssh-keygen -t ed25519 -f ~/.ssh/ansible
```

2. Export `ANSIBLE_PUB_KEY` (control node)
```bash
export ANSIBLE_PUB_KEY=somepublicekey
```

# Run
```bash
ansible-playbook -i inventory_bootstrap.ini bootstrap.yml \
        -e "ansible_pub_key=$ANSIBLE_PUB_KEY"
```
