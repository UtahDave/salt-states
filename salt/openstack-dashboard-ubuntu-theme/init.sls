# vi: set ft=yaml.jinja :

include:
  -  openstack-dashboard

openstack-dashboard-ubuntu-theme:
  pkg.installed:   []

/etc/openstack-dashboard/ubuntu_theme.py:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/openstack-dashboard/ubuntu_theme.py
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       openstack-dashboard-ubuntu-theme
