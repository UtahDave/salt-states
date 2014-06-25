# vi: set ft=yaml.jinja :

cloudera-cm5-daemons:
  pkg.installed:
    - name:        cloudera-manager-daemons
    - require:
      - pkgrepo:   cloudera-cm5
