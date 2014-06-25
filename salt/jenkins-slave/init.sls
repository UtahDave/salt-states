# vi: set ft=yaml.jinja :

include:
  -  jenkins-common
  -  oracle-java7-installer

jenkins-slave:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       jenkins-slave
