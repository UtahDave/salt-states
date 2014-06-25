# vi: set ft=yaml.jinja :

include:
  -  nova-common
  -  sudo

/etc/sudoers.d/nova_sudoers:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0440'
    - require:
      - pkg:       sudo
    - watch:
      - pkg:       nova-common
    - watch_in:
      - service:   sudo
