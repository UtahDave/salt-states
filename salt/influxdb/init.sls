# vi: set ft=yaml.jinja :

{% set osarch  =  salt-call['config.get']('osarch') %}
{% set version = 'latest' %}

influxdb:
  pkg.installed:
    - sources:
     {% if   salt['config.get']('os_family') == 'RedHat' %}
      - influxdb: http://s3.amazonaws.com/influxdb/influxdb-{{ version }}-1.{{ osarch }}.rpm
     {% elif salt['config.get']('os_family') == 'Debian' %}
      - influxdb: http://s3.amazonaws.com/influxdb/influxdb_{{ version }}_{{ osarch }}.deb
     {% endif %}
  service.running:
    - enable:      True
    - watch:
      - pkg:       influxdb
