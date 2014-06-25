# vi: set ft=yaml.jinja :

include:
  -  racoon

openvswitch-ipsec:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       openvswitch-ipsec
