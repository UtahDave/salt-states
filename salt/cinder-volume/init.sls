# vi: set ft=yaml.jinja :

include:
# - .depend-iscsitarget
  - .depend-supervisor
  - .depend-tgt
  -  cinder-common
  -  lvm2

cinder-volume:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       cinder-volume
#     - file:     /etc/cinder/api-paste.ini
      - file:     /etc/cinder/cinder.conf
#     - file:     /etc/cinder/logging.conf
#     - file:     /etc/cinder/policy.json

/etc/cinder/rootwrap.d/volume.filters:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/cinder/rootwrap.d/volume.filters
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       cinder-volume
