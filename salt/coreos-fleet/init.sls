# vi: set ft=yaml.jinja :

include:
  -  etcd

fleet:
  service.running:
    - enable:      True
    - watch:
      - pkg:       etcd
