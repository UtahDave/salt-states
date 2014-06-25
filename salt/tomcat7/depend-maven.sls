# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  maven
  -  tomcat7

extend:
  /root/pom.xml:
    file:
      - source:    salt://{{ psls }}/root/pom.xml
