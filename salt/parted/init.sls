# vi: set ft=yaml.jinja :

{% set devs = salt['cmd.run']('ls -1d /dev/{s,{u,x,}v}d{b..z} 2>/dev/null').split('\n') %}

parted:
  pkg.installed:   []

{% for dev in devs %}
{% if  dev %}

parted -m -s    {{ dev }} mklabel msdos:
  cmd.run:
    - unless:      test -b         {{ dev }}1
    - require:
      - pkg:       parted

{% endif %}
{% endfor %}
