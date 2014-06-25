# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  jmxtrans-agent
  -  maven

mvn dependency:copy org.jmxtrans.agent:jmxtrans-agent:
  cmd.run:
    - cwd:        /opt/jmxtrans
    - name:     . /etc/profile && mvn
    - unless:   . /etc/profile && mvn | egrep -q 'already (exists|unpacked)'
    - require:
      - pkg:       maven
      - file:     /opt/jmxtrans/lib
    - watch:
      - file:     /opt/jmxtrans/pom.xml

/opt/jmxtrans/pom.xml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/opt/jmxtrans/pom.xml
    - user:        root
    - group:       root
    - mode:       '0400'
    - require:
      - file:     /opt/jmxtrans
