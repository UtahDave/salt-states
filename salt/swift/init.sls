# vi: set ft=yaml.jinja :

swift:
  pkg.installed:   []

/etc/swift:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

/etc/swift/swift.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/swift/swift.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - file:     /etc/swift
