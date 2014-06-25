# vi: set ft=yaml.jinja :

qemu-kvm:
  pkg.installed:   []
  service.running:
    - enable:      True
    - watch:
      - pkg:       qemu-kvm

/dev/kvm:
  file.managed:
    - user:        root
    - group:       kvm
    - mode:       '0770'
    - watch:
      - pkg:       qemu-kvm
    - watch_in:
      - service:   qemu-kvm
