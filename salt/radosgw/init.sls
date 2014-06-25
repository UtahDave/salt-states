# vi: set ft=yaml.jinja :

include:
  - .depend-apache2
# - .depend-haproxy
  -  ceph

radosgw:
  pkg.installed:
    - name:     {{ salt['config.get']('radosgw:pkg:name') }}
    - require:
      - pkgrepo:   ceph-common
  service.running:
    - enable:      True
    - watch:
      - pkg:       radosgw
