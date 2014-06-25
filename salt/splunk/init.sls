# vi: set ft=yaml.jinja :

{% set nodename = salt['config.get']('nodename') %}

splunk:
  pkg:
    - installed
   {% if   salt['config.get']('os_family') == 'Debian' %}
    - sources:
      - splunk:    salt://{{ sls }}/splunk-6.0-182037-linux-2.6-amd64.deb
   {% elif salt['config.get']('os_family') == 'RedHat' %}
    - sources:
      - splunk:    salt://{{ sls }}/splunk-6.0-182037-linux-2.6-x86_64.rpm
   {% endif %}

/opt/splunk/bin/splunk set servername:
  cmd.run:
    - name:       /opt/splunk/bin/splunk --accept-license set servername {{ nodename }}
    - unless:      grep {{ nodename }} /opt/splunk/etc/system/local/server.conf
    - require:
      - pkg:       splunk

/opt/splunk/etc/system/local/props.conf:
  file.managed:
    - source:      salt://{{ sls }}/opt/splunk/etc/system/local/props.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - cmd:      /opt/splunk/bin/splunk set servername

/opt/splunk/bin/splunk start:
  cmd.run:
    - name:       /opt/splunk/bin/splunk --accept-license start
    - require:
      - file:     /opt/splunk/etc/system/local/props.conf
