# vi: set ft=yaml.jinja :

include:
  - .depend-supervisor
  -  swift

swift-proxy:
  pkg.installed:   []
{% if salt['config.get']('virtual_subtype') == 'Docker' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       swift-proxy
