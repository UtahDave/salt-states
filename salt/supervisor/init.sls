# vi: set ft=yaml.jinja :

supervisor:
  pkg.installed:   []
  service.running:
    - name:     {{ salt['config.get']('supervisor:service:name') }}
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       supervisor
