# vi: set ft=yaml.jinja :

include:
  - .depend-nginx
  -  postfix

nagios3:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       nagios3
