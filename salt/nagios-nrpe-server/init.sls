# vi: set ft=yaml.jinja :

nagios-nrpe-server:
  pkg.installed:
    - name:     {{ salt['config.get']('nagios-nrpe-server:pkg:name') }}
  service.running:
    - name:     {{ salt['config.get']('nagios-nrpe-server:service:name') }}
    - enable:      True
    - watch:
      - pkg:       nagios-nrpe-server

/etc/nagios/nrpe.cfg:
  file.managed:
    - name:     {{ salt['config.get']('/etc/nagios/nrpe.cfg:file:name') }}
    - template:    jinja
    - source:      salt://{{ sls }}/etc/nagios/nrpe.cfg
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       nagios-nrpe-server
    - watch_in:
      - service:   nagios-nrpe-server
