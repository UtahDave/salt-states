# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  cinder-common

cinder-backup:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       cinder-backup
#     - file:     /etc/cinder/api-paste.ini
      - file:     /etc/cinder/cinder.conf
#     - file:     /etc/cinder/logging.conf
#     - file:     /etc/cinder/policy.json
