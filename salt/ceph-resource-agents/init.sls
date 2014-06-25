# vi: set ft=yaml.jinja :

include:
  -  ceph-common

ceph-resource-agents:
  pkg.installed:
    - require:
      - pkgrepo:   ceph-common
