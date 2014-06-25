# vi: set ft=yaml.jinja :

{% set devs = salt['cmd.run']('ls -1d /dev/{s,{u,x,}v}d{b..z} 2>/dev/null').split('\n') %}

include:
  -  ceph-osd.depend-btrfs-tools

{% for dev in devs %}
{% if  dev %}

/var/lib/ceph/osd/ceph-{{ loop.index0 }}:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       ceph
  mount.mounted:
    - device:   {{ dev }}
    - fstype:      btrfs
    - mkmnt:       True
    - opts:
      - noatime,nodiratime,user_xattr
    - require:
      - cmd:       mkfs.btrfs {{ dev }}
      - file:     /var/lib/ceph/osd/ceph-{{ loop.index0 }}

{% endif %}
{% endfor %}
