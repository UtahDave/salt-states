# vi: set ft=yaml.jinja :

proxychains:
  pkg.installed:   []

/etc/proxychains.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/proxychains.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       proxychains
