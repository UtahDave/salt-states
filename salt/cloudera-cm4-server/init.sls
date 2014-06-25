# vi: set ft=yaml.jinja :

include:
  -  cloudera-cm4-agent
  -  cloudera-cm4-daemons
  -  cloudera-cm4-server-db
  -  oracle-j2sdk1_6

cloudera-cm4-server:
  pkg.installed:
    - name:        cloudera-manager-server
    - require:
      - pkgrepo:   cloudera-cm4
      - pkg:       oracle-j2sdk1_6
  service.running:
    - name:        cloudera-scm-server
    - enable:      True
    - watch:
      - pkg:       cloudera-cm4-server
