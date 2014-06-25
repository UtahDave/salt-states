# vi: set ft=yaml.jinja :

{% set psls = sls.split('.') %}

include:
  -  nginx-common

/usr/share/nginx/html/pxe-cloud-config.yml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/usr/share/nginx/html/pxe-cloud-config.yml
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       nginx-common
