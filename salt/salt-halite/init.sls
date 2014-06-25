# vi: set ft=yaml.jinja :

include:
# - .depend-git
  - .depend-openssl
# - .depend-supervisor
  -  python-gevent
  -  python-pip
  -  salt-master

salt-halite:
  pip.installed:
    - name:        halite
    - require:
      - pkg:       python-pip

salt:
  group.present:
    - gid:         501
  user.present:
    - fullname:    Salt
    - home:       /home/salt
    - shell:      /bin/bash
    - createhome:  True
    - password:    $1$9bVX1pEh$sp2ceLpbAzBqEknNeu2yv1
    - gid:         501
    - uid:         501
    - require:
      - group:     salt

/etc/salt/master.d/external_auth.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/master.d/external_auth.conf
    - user:        root
    - group:       root
    - mode:       '0640'
    - require:
      - pkg:       salt-master
    - watch_in:
      - service:   salt-master

/etc/salt/master.d/halite.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/master.d/halite.conf
    - user:        root
    - group:       root
    - mode:       '0640'
    - require:
      - pkg:       salt-master
    - watch_in:
      - service:   salt-master
