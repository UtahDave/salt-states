# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  logrotate

/etc/logrotate.d/{{ psls }}:
  file.managed:
    - source:      salt://{{ psls }}/etc/logrotate.d/{{ psls }}
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       logrotate
