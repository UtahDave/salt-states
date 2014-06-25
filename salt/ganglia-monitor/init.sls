# vi: set ft=yaml.jinja :

ganglia-monitor:
  pkg.installed:
    - name:     {{ salt['config.get']('ganglia-monitor:pkg:name') }}
  service.running:
    - name:     {{ salt['config.get']('ganglia-monitor:service:name') }}
    - enable:      True
    - watch:
      - pkg:       ganglia-monitor

/etc/ganglia/gmond.conf:
  file.managed:
    - name:     {{ salt['config.get']('/etc/ganglia/gmond.conf:file:name') }}
    - template:    jinja
    - source:      salt://{{ sls }}/etc/ganglia/gmond.conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       ganglia-monitor
    - watch_in:
      - service:   ganglia-monitor
