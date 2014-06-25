# vi: set ft=yaml.jinja :

include:
  -  ceph

radosgw-agent:
  pkg.installed:
    - require:
      - pkgrepo:   ceph-common
  service.running:
    - enable:      True
    - watch:
      - pkg:       radosgw-agent
