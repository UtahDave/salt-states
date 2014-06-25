# vi: set ft=yaml.jinja :

include:
  -  ebtables
  -  libvirt-bin
  -  nova-compute
  -  open-iscsi

nova-compute-libvirt:
  pkg.installed:   []
