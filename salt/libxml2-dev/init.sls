# vi: set ft=yaml.jinja :

libxml2-dev:
  pkg.installed:
    - name:     {{ salt['config.get']('libxml2-dev:pkg:name') }}
