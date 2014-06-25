# vi: set ft=yaml.jinja :

dnsutils:
  pkg.installed:
    - name:     {{ salt['config.get']('dnsutils:pkg:name') }}
