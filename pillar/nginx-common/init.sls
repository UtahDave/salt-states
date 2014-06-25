# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

nginx-common:
  conf:
    extension:     .conf

/etc/nginx/sites-available:
  file:
    name:         /etc/nginx/conf.d

/etc/nginx/sites-enabled:
  file:
    name:         /etc/nginx/conf.d

{% elif salt['config.get']('os_family') == 'Debian' %}

/etc/nginx/sites-available:
  file:
    name:         /etc/nginx/sites-available

/etc/nginx/sites-enabled:
  file:
    name:         /etc/nginx/sites-enabled

{% endif %}
