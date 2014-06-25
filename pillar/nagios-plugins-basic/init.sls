# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

/home/nagios:
  file:
    name:         /var/spool/nagios

/usr/lib/nagios/plugins:
  file:
    name:         /usr/lib64/nagios/plugins

{% elif salt['config.get']('os_family') == 'Debian' %}

/home/nagios:
  file:
    name:         /home/nagios

/usr/lib/nagios/plugins:
  file:
    name:         /usr/lib/nagios/plugins

{% endif %}
