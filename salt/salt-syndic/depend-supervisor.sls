# vi: set ft=yaml.jinja :

{% if salt['config.get']('virtual_subtype') == 'Docker' %}

include:
  -  salt-syndic
  -  supervisor

extend:
  salt-syndic:
    supervisord.running:
      - watch:
        - pkg:     salt-syndic
        - service: supervisor

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

{% endif %}
