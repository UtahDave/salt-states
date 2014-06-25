# vi: set ft=yaml.jinja :

include:
  -  cloudera-cm4

cloudera-cm4-server-db:
  pkg.installed:
    - name:        cloudera-manager-server-db
    - require:
      - pkgrepo:   cloudera-cm4
  service.running:
    - name:        cloudera-scm-server-db
    - enable:      True
    - watch:
      - pkg:       cloudera-cm4-server-db
