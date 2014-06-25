# vi: set ft=yaml.jinja :

incron:
  pkg.installed:
    - order:      -1
  service.running:
    - name:     {{ salt['config.get']('incron:service:name') }}
    - enable:      True
    - reload:      True
    - sig:         incrond
    - watch:
      - pkg:       incron

/etc/incron.allow:
  file.managed:
    - source:      salt://{{ sls }}/etc/incron.allow
    - user:        root
    - group:    {{ salt['config.get']('/etc/incron.allow:file:group') }}
    - mode:       '0640'
    - watch:
      - pkg:       incron
    - watch_in:
      - service:   incron
