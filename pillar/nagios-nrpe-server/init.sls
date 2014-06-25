# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

nagios-nrpe-server:
  pkg:
    name:          nagios-nrpe
  service:
    name:          nrpe

/etc/nagios/nrpe.cfg:
  file:
    name:         /usr/local/nagios/nrpe.cfg

{% elif salt['config.get']('os_family') == 'Debian' %}

nagios-nrpe-server:
  pkg:
    name:          nagios-nrpe-server
  service:
    name:          nagios-nrpe-server

/etc/nagios/nrpe.cfg:
  file:
    name:         /etc/nagios/nrpe.cfg

{% endif %}
