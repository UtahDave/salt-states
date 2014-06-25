# vi: set ft=yaml.jinja :

snmpd:
  pkg.installed:
    - name:     {{ salt['config.get']('snmpd:pkg:name') }}
  service.running:
    - enable:      True
    - watch:
      - pkg:       snmpd
