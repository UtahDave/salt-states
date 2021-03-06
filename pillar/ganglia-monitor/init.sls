# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

ganglia-monitor:
  pkg:
    name:          ganglia-gmond
  service:
    name:          gmond

/etc/ganglia/gmond.conf:
  file:
    name:         /etc/gmond.conf

{% elif salt['config.get']('os_family') == 'Debian' %}

ganglia-monitor:
  pkg:
    name:          ganglia-monitor
  service:
    name:          ganglia-monitor

/etc/ganglia/gmond.conf:
  file:
    name:         /etc/ganglia/gmond.conf

{% endif %}
