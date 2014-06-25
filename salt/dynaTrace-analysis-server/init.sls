# vi: set ft=yaml.jinja :

include:
  -  dynaTrace-common

dynaTraceAnalysis:
  service.running:
    - enable:      True
    - require:
      - file:     /etc/init.d/dynaTraceAnalysis

/etc/init.d/dynaTraceAnalysis:
  file.symlink:
    - target:     /opt/dynatrace/init.d/dynaTraceAnalysis
    - require:
      - cmd:       java-jar

/opt/dynatrace/init.d/dynaTraceAnalysis:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - cmd:       java-jar
