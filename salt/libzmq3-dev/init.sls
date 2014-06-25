# vi: set ft=yaml.jinja :

libzmq3-dev:
  pkg.installed:
    - name:     {{ salt['config.get']('libzmq3-dev:pkg:name') }}
