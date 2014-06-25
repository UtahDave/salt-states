# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  tgt

/etc/tgt/conf.d/cinder_tgt.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/tgt/conf.d/cinder_tgt.conf
    - user:        root
    - group:       root
    - mode:       '0664'
    - watch:
      - pkg:       tgt
    - watch_in:
      - service:   tgt
