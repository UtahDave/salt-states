# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

supervisor:
  service:
    name:          supervisord

{% elif salt['config.get']('os_family') == 'Debian' %}

supervisor:
  service:
    name:          supervisor

{% endif %}
