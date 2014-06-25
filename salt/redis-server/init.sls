# vi: set ft=yaml.jinja :

include:
  -  procps

redis-server:
  pkg.installed:
    - name:     {{ salt['config.get']('redis-server:pkg:name') }}
  service.running:
    - name:     {{ salt['config.get']('redis-server:service:name') }}
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       redis-server

/etc/redis/redis.conf:
  file.replace:
    - name:     {{ salt['config.get']('/etc/redis/redis.conf:file:name') }}
    - pattern:   '^bind 127.0.0.1'
    - repl:      '#bind ${HOST}'
    - watch:
      - pkg:       redis-server
    - watch_in:
      - service:   redis-server

{% if not salt['config.get']('virtual_subtype') == 'Docker' %}

vm.overcommit_memory:
  sysctl.present:
    - value:       1
    - require:
      - pkg:       procps

{% endif %}
