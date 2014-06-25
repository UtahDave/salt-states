# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  logrotate

/etc/logrotate.d/calamari:
  file.managed:
    - source:      salt://{{ psls }}/etc/logrotate.d/{{ psls }}
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       logrotate
