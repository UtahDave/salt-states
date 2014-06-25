# vi: set ft=yaml.jinja :

include:
  -  datastax
  -  oracle-java7-installer
  -  oracle-java7-set-default

cassandra:
  pkg.installed:
    - require:
      - pkgrepo:   datastax
