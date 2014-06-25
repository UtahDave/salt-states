# vi: set ft=yaml.jinja :

include:
  -  python-openssl
  -  salt-halite

{% if  not salt['file.file_exists']('/etc/pki/tls/certs/salt-halite.crt')
   and not salt['file.file_exists']('/etc/pki/tls/certs/salt-halite.key') %}

/etc/pki/tls/certs/salt-halite.crt:
  module.run:
    - name:        tls.create_self_signed_cert
    - days:        1825
    - CN:          salt-halite
    - ST:       {{ salt['config.get']('openssl:subject:ST') }}
    - L:        {{ salt['config.get']('openssl:subject:L') }}
    - O:       '{{ salt['config.get']('openssl:subject:O') }}'
    - OU:          Domain Control Validated
    - require:
      - pkg:       python-openssl

{% endif %}
