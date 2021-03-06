# vi: set ft=yaml.jinja :

include:
# - .depend-incron
  - .depend-supervisor
  -  python-etcd
  -  python-psutil
  -  salt-common

salt-minion:
  pkg.installed:
    - enablerepo:  epel-testing
    - unless:    |-
                 ( salt-minion --version                                       \
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
    - order:       1
    - sig:        'salt-minion -d'
    - watch:
      - pkg:       salt-minion

/etc/salt/minion.d/master.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/minion.d/master.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

/etc/salt/minion.d/schedule.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/salt/minion.d/schedule.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-minion
    - watch_in:
      - service:   salt-minion

#-------------------------------------------------------------------------------
# TODO: consider running mine.update via incron instead of state.highstate
# TODO: deprecate with https://github.com/saltstack/salt/issues/8619
#-------------------------------------------------------------------------------

mine.update:
  module.run:
    - order:       1
    - name:        mine.update
    - require:
      - pkg:       python-psutil
