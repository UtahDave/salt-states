# vi: set ft=yaml.jinja :

openvswitch-switch:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       openvswitch-switch
