# vi: set ft=yaml.jinja :

{% if salt['config.get']('os_family') == 'Debian' %}

postgresql-client-common:
  pkg.installed:   []

{% endif %}
