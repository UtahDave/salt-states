# vi: set ft=yaml.jinja :

python-openssl:
  pkg.installed:
    - name:     {{ salt['config.get']('python-openssl:pkg:name') }}
