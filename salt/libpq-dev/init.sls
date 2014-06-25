# vi: set ft=yaml.jinja :

libpq-dev:
  pkg.installed:
    - name:     {{ salt['config.get']('libpq-dev:pkg:name') }}
