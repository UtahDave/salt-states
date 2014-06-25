# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor

glance-registry:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       glance-registry

/etc/glance/glance-registry-paste.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/glance/glance-registry-paste.ini
    - user:        glance
    - group:       glance
    - mode:       '0644'
    - watch:
      - pkg:       glance-registry
    - watch_in:
      - service:   glance-registry

/etc/glance/glance-registry.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/glance/glance-registry.conf
    - user:        glance
    - group:       glance
    - mode:       '0644'
    - watch:
      - pkg:       glance-registry
    - watch_in:
      - service:   glance-registry
