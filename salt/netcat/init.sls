# vi: set ft=yaml.jinja :

netcat:
  pkg.installed:
    - name:     {{ salt['config.get']('netcat:pkg:name') }}
