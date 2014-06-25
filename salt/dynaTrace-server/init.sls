# vi: set ft=yaml.jinja :

include:
  -  dynaTrace-common

dynaTraceServer:
  service.running:
    - enable:      True
    - require:
      - file:     /etc/init.d/dynaTraceServer

/etc/init.d/dynaTraceServer:
  file.symlink:
    - target:     /opt/dynatrace/init.d/dynaTraceServer
    - require:
      - cmd:       java-jar

/opt/dynatrace/init.d/dynaTraceServer:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - cmd:       java-jar
