# vi: set ft=yaml.jinja :

memcached:
  pkg.installed:   []
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       memcached

/etc/memcached.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/memcached.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       memcached
    - watch_in:
      - service:   memcached
