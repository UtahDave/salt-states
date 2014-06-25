# vi: set ft=yaml.jinja :

include:
  -  sensu

sensu-server:
{% if salt['environ.get']('bootstrap') == 'true' %}
  service.dead:
    - enable:      False
{% else %}
  service.running:
    - enable:      True
{% endif %}
    - watch:
      - pkg:       sensu

/etc/sensu/conf.d/handlers.json:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/sensu/conf.d/handlers.json
    - user:        sensu
    - group:       sensu
    - mode:       '0444'
    - require:
      - file:     /etc/sensu/conf.d
    - watch_in:
      - service:   sensu-server
