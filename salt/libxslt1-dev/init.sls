# vi: set ft=yaml.jinja :

libxslt1-dev:
  pkg.installed:
    - name:     {{ salt['config.get']('libxslt1-dev:pkg:name') }}
