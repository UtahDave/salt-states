# vi: set ft=yaml.jinja :

cron:
  pkg.installed:
    - order:      -1
    - name:     {{ salt['config.get']('cron:pkg:name') }}
  service.running:
    - name:     {{ salt['config.get']('cron:service:name') }}
    - enable:      True
    - watch:
      - pkg:       cron
