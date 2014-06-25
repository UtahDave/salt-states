# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor

glance-api:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       glance-api

/etc/glance/glance-api.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/glance/glance-api.conf
    - user:        glance
    - group:       glance
    - mode:       '0644'
    - watch:
      - pkg:       glance-api
    - watch_in:
      - service:   glance-api

/etc/glance/glance-cache.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/glance/glance-cache.conf
    - user:        glance
    - group:       glance
    - mode:       '0644'
    - watch:
      - pkg:       glance-api
    - watch_in:
      - service:   glance-api

/etc/glance/glance-scrubber.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/glance/glance-scrubber.conf
    - user:        glance
    - group:       glance
    - mode:       '0644'
    - watch:
      - pkg:       glance-api
    - watch_in:
      - service:   glance-api
