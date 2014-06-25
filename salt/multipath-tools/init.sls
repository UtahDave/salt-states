# vi: set ft=yaml.jinja :

multipath-tools:
  pkg.installed:
    - order:      -1
    - name:     {{ salt['config.get']('multipath-tools:pkg:name') }}
  service.running:
    - name:     {{ salt['config.get']('multipath-tools:service:name') }}
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       multipath-tools
