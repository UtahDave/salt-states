# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

oracle-j2sdk1_8:
  pkg:
    name:          jdk

{% elif salt['config.get']('os_family') == 'Debian' %}

oracle-j2sdk1_8:
  pkg:
    name:          oracle-j2sdk1.8

{% endif %}
