# vi: set ft=yaml.jinja :

include:
  - .depend-git
  - .depend-supervisor
  -  salt-common

salt-master:
  pkg.installed:
    - enablerepo:  epel-testing
    - unless:    |-
                 ( salt-master --version                                       \
                 | grep -q '....\..\..-'
                 )
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
    - reload:      True
{% endif %}
    - order:      -1
    - sig:        'salt-master -d'
    - watch:
      - pkg:       salt-master

{% if salt['config.get']('virtual_subtype') == 'Docker' %}

/etc/salt/master.d/auto_accept.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/master.d/auto_accept.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-master
    - watch_in:
      - service:   salt-master

{% endif %}

/etc/salt/master.d/file_recv.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/master.d/file_recv.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-master
    - watch_in:
      - service:   salt-master

/etc/salt/master.d/peer.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/master.d/peer.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-master
    - watch_in:
      - service:   salt-master

/etc/salt/master.d/presence.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/master.d/presence.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-master
    - watch_in:
      - service:   salt-master

/etc/salt/master.d/reactor.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/master.d/reactor.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-master
    - watch_in:
      - service:   salt-master
