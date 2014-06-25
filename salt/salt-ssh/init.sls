# vi: set ft=yaml.jinja :

salt-ssh:
  pkg.installed:
    - name:     {{ salt['config.get']('salt-ssh:pkg:name') }}

/etc/salt/roster:
  file.managed:
    - source:      salt://{{ sls }}/etc/salt/roster
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       salt-ssh
