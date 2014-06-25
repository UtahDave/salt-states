# vi: set ft=yaml.jinja :

rsyslog:
  pkg.installed:
    - order:      -1
  service.running:
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       rsyslog

{% if 'rsyslog'  not in salt['config.get']('roles', []) %}

/etc/rsyslog.d/00-remote.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/rsyslog.d/00-remote.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       rsyslog
    - watch_in:
      - service:   rsyslog

{% else %}
{% if 'logstash' not in salt['config.get']('roles', []) %}

/etc/rsyslog.d/60-imtcp.conf:
  file.managed:
    - source:      salt://{{ sls }}/etc/rsyslog.d/60-imtcp.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       rsyslog
    - watch_in:
      - service:   rsyslog

/etc/rsyslog.d/60-imudp.conf:
  file.managed:
    - source:      salt://{{ sls }}/etc/rsyslog.d/60-imudp.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - pkg:       rsyslog
    - watch_in:
      - service:   rsyslog

/mnt/rsyslog:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

{% endif %}
{% endif %}
