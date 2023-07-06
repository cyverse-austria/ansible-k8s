Role Name
=========

Generates a letsencypt certificate for the given domain and a wildcard certificate: `*.domain`.  
(and an additional for `tmp.<random>.domain` to bypass the 5 certificate/week limit (https://letsencrypt.org/docs/duplicate-certificate-limit/))

Role Variables
--------------

| var-name | default | description |
| -------- | ------- | ----------- |
| domain | "cyverse.run" | name the certificate is for |
| cert_mail | "wer.weiss@mailinator.com" | e-mail in the certificate |
| tls_pem_path | "/etc/ssl/certs/{{ domain }}.pem" | path to the certificate |
| do_token | "None" | token with permissions to change DigitlOcean |

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

    - hosts: servers
      roles:
        - role: cert_bot
          domain: cyverse.at
          cert_mail: "cyverse.admin@tugraz.at"
          tls_pem_path: "/etc/ssl/certs/{{ domain }}.pem"

License
-------

BSD

ToDo
----

Update an existing, expired certificate.

Author Information
------------------

franz.marko@tugraz.at
