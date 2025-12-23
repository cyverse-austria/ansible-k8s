# Hosts bootstrap

Bootstrap once, then let Ansible do the rest


## Preq

1. Generate SSH key: (control node)
Make sure this is actually created in your jumphost, not the docker environment
```bash
ssh @jumphost

ssh-keygen -t ed25519 -f ~/.ssh/ansible
```

# Run playbook
```bash
ansible-playbook -i inventory_bootstrap.ini bootstrap.yml \
        -e "ansible_pub_key_file=~/.ssh/ansible.pub"
```


## CI
make sure you have the private key of ansible user also.
that would be used to ssh to ansible user via the gitlab ci.
