# vi: set ft=yaml.jinja :

{% if salt['config.get']('os_family') == 'Debian' %}

debconf-utils:
  pkg.installed:   []

{% endif %}
