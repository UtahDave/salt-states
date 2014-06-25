# vi: set ft=yaml.jinja :

auditd:
  pkg.installed:
    - name:     {{ salt['config.get']('auditd:pkg:name') }}
  service.running:
    - enable:      True
    - watch:
      - pkg:       auditd
