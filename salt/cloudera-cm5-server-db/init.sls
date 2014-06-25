# vi: set ft=yaml.jinja :

include:
  -  cloudera-cm5

cloudera-cm5-server-db:
  pkg.installed:
    - name:        cloudera-manager-server-db
    - require:
      - pkgrepo:   cloudera-cm5
  service.running:
    - name:        cloudera-scm-server-db
    - enable:      True
    - watch:
      - pkg:       cloudera-cm5-server-db
