# vi: set ft=yaml.jinja :

include:
  -  openssh-client

puppetmaster:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       puppetmaster
