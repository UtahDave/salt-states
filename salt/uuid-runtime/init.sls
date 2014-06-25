# vi: set ft=yaml.jinja :

uuid-runtime:
  pkg.installed:
    - name:     {{ salt['config.get']('uuid-runtime:pkg:name') }}
