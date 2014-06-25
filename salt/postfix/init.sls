# vi: set ft=yaml.jinja :

postfix:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       postfix

/etc/postfix/main.cf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/postfix/main.cf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch_in:
      - service:   postfix
