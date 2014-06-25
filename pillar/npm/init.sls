# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

/usr/local/lib/node_modules:
  file:
    name:         /usr/lib/node_modules

{% elif salt['config.get']('os_family') == 'Debian' %}

/usr/local/lib/node_modules:
  file:
    name:         /usr/local/lib/node_modules

{% endif %}
