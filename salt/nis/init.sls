# vi: set ft=yaml.jinja :

nis:
  pkg.installed:
    - name:     {{ salt['config.get']('nis:pkg:name') }}
  service.running:
    - enable:      True
    - watch:
      - pkg:       nis

/etc/yp.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/yp.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       nis
    - watch_in:
      - service:   nis
