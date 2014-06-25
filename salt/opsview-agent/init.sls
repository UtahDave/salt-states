# vi: set ft=yaml.jinja :

opsview-agent:
  pkg.installed:
    - require:
      - pkgrepo:   opsview-base
  service.running:
    - enable:      True
    - watch:
      - pkg:       opsview-agent
