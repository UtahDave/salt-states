# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  skydns1
  -  supervisor

skydns1:
  supervisord.running:
    - require:
      - file:     /var/lib/skydns1/data
    - watch:
      - service:   supervisor
      - cmd:       go install -v . ./...

/etc/supervisor/conf.d/{{ psls }}.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/etc/supervisor/conf.d/{{ psls }}.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       supervisor
    - watch_in:
      - service:   supervisor
