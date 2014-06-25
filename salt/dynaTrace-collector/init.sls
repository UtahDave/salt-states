# vi: set ft=yaml.jinja :

include:
  -  dynaTrace-common

dynaTraceCollector:
  service.running:
    - enable:      True
    - require:
      - file:     /etc/init.d/dynaTraceCollector

/etc/init.d/dynaTraceCollector:
  file.symlink:
    - target:     /opt/dynatrace/init.d/dynaTraceCollector
    - require:
      - cmd:       java-jar

/opt/dynatrace/init.d/dynaTraceCollector:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - cmd:       java-jar
