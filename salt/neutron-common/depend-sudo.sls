# vi: set ft=yaml.jinja :

include:
  -  neutron-common
  -  sudo

/etc/sudoers.d/neutron_sudoers:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0440'
    - require:
      - pkg:       sudo
    - watch:
      - pkg:       neutron-common
    - watch_in:
      - service:   sudo
