# vi: set ft=yaml.jinja :

{% set devs = salt['cmd.run']('ls -1d /dev/{s,{u,x,}v}d{b..z} 2>/dev/null').split('\n') %}

include:
  -  cloudera-cm5-agent.depend-parted
  -  e2fsprogs

{% for dev in devs %}
{% if  dev %}

mkfs.ext4 -m 1 -O dir_index,extent,sparse_super {{ dev }}1:
  cmd.run:
    - unless:      dumpe2fs        {{ dev }}1 &>/dev/null
    - require:
      - pkg:       e2fsprogs
      - cmd:       parted -m -s -- {{ dev }} mkpart primary ext4 1 -1

{% endif %}
{% endfor %}
