# vi: set ft=yaml.jinja :

update-engine:
  service.running: []

/etc/coreos/update.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/coreos/update.conf
    - watch_in:
      - service:   update-engine
