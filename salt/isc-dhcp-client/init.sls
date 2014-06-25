# vi: set ft=yaml.jinja :

isc-dhcp-client:
  pkg.installed:   []

/etc/dhcp/dhclient.conf:
  file.managed:
    - source:      salt://{{ sls }}/etc/dhcp/dhclient.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       isc-dhcp-client
