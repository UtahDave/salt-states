# vi: set ft=yaml.jinja :

login:
  pkg.installed:   []

/etc/pam.d/login:
  file.managed:
    - source:      salt://{{ sls }}/etc/pam.d/login
    - user:        root
    - group:       root
    - mode:       '0644'
