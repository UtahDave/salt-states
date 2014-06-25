# vi: set ft=yaml.jinja :

heat-common:
  pkg.installed:   []

/etc/heat/heat.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/heat/heat.conf
    - user:        heat
    - group:       heat
    - mode:       '0644'
    - watch:
      - pkg:       heat-common
