# vi: set ft=yaml.jinja :

openvswitch-controller:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       openvswitch-controller
