# vi: set ft=yaml.jinja :

apache2:
  pkg.installed:
    - name:     {{ salt['config.get']('apache2:pkg:name') }}
  service.running:
    - name:     {{ salt['config.get']('apache2:service:name') }}
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       apache2

/etc/apache2/sites-enabled/000-default.conf:
  file.absent:
    - name:     {{ salt['config.get']('/etc/apache2/sites-enabled/000-default.conf:file:name') }}
    - onlyif:      test -d /etc/apache2/sites-enabled
    - watch:
      - pkg:       apache2
    - watch_in:
      - service:   apache2
