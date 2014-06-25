# vi: set ft=yaml.jinja :

{% set cluster = salt['grains.get']('environment', 'ceph') %}

include:
  - .depend-openssh
  -  ceph

ceph-deploy:
  pkg.installed:
    - require:
      - pkgrepo:   ceph-common

/home/ceph/{{ cluster }}:
  file.directory:
    - user:        ceph
    - group:       ceph
    - mode:       '0755'
    - require:
      - file:     /home/ceph
