# vi: set ft=yaml.jinja :

{% set devs = salt['cmd.run']('ls -1d /dev/{s,{u,x,}v}d{b..z} 2>/dev/null').split('\n') %}

include:
  -  btrfs-tools

{% for dev in devs %}
{% if  dev %}

mkfs.btrfs {{ dev }}:
  cmd.run:
    - unless:      btrfs filesystem show {{ dev }} &>/dev/null
    - require:
      - pkg:       btrfs-tools

{% endif %}
{% endfor %}
