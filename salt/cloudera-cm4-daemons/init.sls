# vi: set ft=yaml.jinja :

cloudera-cm4-daemons:
  pkg.installed:
    - name:        cloudera-manager-daemons
    - require:
      - pkgrepo:   cloudera-cm4
