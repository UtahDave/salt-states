# vi: set ft=yaml.jinja :

{% if salt['config.get']('os_family') == 'Debian' %}

java-common:
  pkg.installed:   []

{% endif %}
