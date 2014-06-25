# vi: set ft=yaml.jinja :

{% if salt['config.get']('os_family') == 'Debian' %}

nfs-common:
  pkg.installed:   []

{% endif %}
