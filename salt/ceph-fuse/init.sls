# vi: set ft=yaml.jinja :

include:
  -  ceph-common

ceph-fuse:
  pkg.installed:
    - require:
      - pkgrepo:   ceph-common
