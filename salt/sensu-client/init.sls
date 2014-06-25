# vi: set ft=yaml.jinja :

include:
  -  sensu

sensu-client:
  service.running:
    - enable:      True
    - require:
      - pkg:       sensu
    - watch:
      - file:     /etc/sensu/conf.d/checks-all.json

/etc/sensu/conf.d/checks-all.json:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/sensu/conf.d/checks-all.json
    - user:        sensu
    - group:       sensu
    - mode:       '0440'
    - require:
      - pkg:       sysstat
      - file:     /etc/sensu/conf.d
    - watch_in:
      - file:     /etc/sensu/conf.d/client.json
      - service:   sensu-client

/etc/sensu/conf.d/client.json:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/sensu/conf.d/client.json
    - user:        sensu
    - group:       sensu
    - mode:       '0444'
    - require:
      - file:     /etc/sensu/conf.d
    - watch_in:
      - service:   sensu-client
