# vi: set ft=yaml.jinja :

ovirt-engine:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       ovirt-engine
