# vi: set ft=yaml.jinja :

trove-common:
  pkg.installed:   []

/etc/trove/trove.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/trove/trove.conf
    - user:        trove
    - group:       trove
    - mode:       '0644'
    - require:
      - pkg:       trove-common
