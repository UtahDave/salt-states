# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

incron:
  service:
    name:          incrond

/etc/incron.allow:
  file:
    group:         root

{% elif salt['config.get']('os_family') == 'Debian' %}

incron:
  service:
    name:          incron

/etc/incron.allow:
  file:
    group:         incron

{% endif %}
