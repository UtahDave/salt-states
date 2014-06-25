# vi: set ft=yaml.jinja :

mysql-common:
  pkg.installed:
    - name:     {{ salt['config.get']('mysql-common:pkg:name') }}

/etc/mysql/my.cnf:
  file.managed:
    - template:    jinja
    - name:     {{ salt['config.get']('/etc/mysql/my.cnf:file:name') }}
    - source:      salt://{{ sls }}/etc/mysql/my.cnf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       mysql-common
