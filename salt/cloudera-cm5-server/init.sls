# vi: set ft=yaml.jinja :

include:
  -  cloudera-cm5-agent
  -  cloudera-cm5-daemons
  -  cloudera-cm5-server-db
  -  oracle-j2sdk1_7

cloudera-cm5-server:
  pkg.installed:
    - name:        cloudera-manager-server
    - require:
      - pkgrepo:   cloudera-cm5
      - pkg:       oracle-j2sdk1_7
  service.running:
    - name:        cloudera-scm-server
    - enable:      True
    - watch:
      - pkg:       cloudera-cm5-server
