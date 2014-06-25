# vi: set ft=yaml.jinja :

ifupdown:
  pkg.installed:   []
  service.running:
    - name:        networking
    - enable:      True
    - watch:
      - pkg:       ifupdown

/etc/network/interfaces:
  file.append:
    - text:        []
    - watch_in:
      - service:   ifupdown
