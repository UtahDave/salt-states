# vi: set ft=yaml.jinja :

haproxy:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       haproxy

{% if salt['config.get']('os_family') == 'Debian' %}

/etc/default/haproxy:
  file.replace:
    - pattern:     ENABLED=0
    - repl:        ENABLED=1
    - watch:
      - pkg:       haproxy
    - watch_in:
      - service:   haproxy

{% endif %}

/etc/haproxy/haproxy.cfg:
  file.managed:
    - template:    jinja
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       haproxy
    - watch_in:
      - service:   haproxy
