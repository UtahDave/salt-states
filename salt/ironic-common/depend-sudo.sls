# vi: set ft=yaml.jinja :

include:
  -  ironic-common
  -  sudo

/etc/sudoers.d/ironic_sudoers:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0440'
    - require:
      - pkg:       sudo
    - watch:
      - pkg:       ironic-common
    - watch_in:
      - service:   sudo
