# vi: set ft=yaml.jinja :

{% set devs = salt['cmd.run']('ls -1d /dev/{s,{u,x,}v}d{b..z} 2>/dev/null').split('\n') %}

include:
  -  parted

{% for dev in devs %}
{% if  dev %}

parted -m -s -- {{ dev }} mkpart primary ext4 1 -1:
  cmd.run:
    - unless:      test -b         {{ dev }}1
    - require:
      - cmd:       parted -m -s    {{ dev }} mklabel msdos

{% endif %}
{% endfor %}
