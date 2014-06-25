# vi: set ft=yaml.jinja :

include:
  -  cinder-common
  -  sudo

/etc/sudoers.d/cinder_sudoers:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0440'
    - require:
      - pkg:       sudo
    - watch:
      - pkg:       cinder-common
    - watch_in:
      - service:   sudo
