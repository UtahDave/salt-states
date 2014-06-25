# vi: set ft=yaml.jinja :

{% if salt['config.get']('os_family') == 'Debian' %}

libapache2-mod-php5:
  pkg.installed:   []

{% endif %}
