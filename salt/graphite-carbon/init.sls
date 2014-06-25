# vi: set ft=yaml.jinja :

graphite-carbon:
  pkg.installed:
    - name:     {{ salt['config.get']('graphite-carbon:pkg:name') }}

{% if salt['config.get']('os_family') == 'RedHat' %}

carbon-aggregator:
  service.running:
    - enable:      True
    - watch:
      - pkg:       graphite-carbon

{% endif %}

carbon-cache:
  service.running:
    - enable:      True
#   - reload:      True
    - watch:
      - pkg:       graphite-carbon

/etc/carbon/storage-aggregation.conf:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0644'
   {% if salt['config.get']('os_family') == 'RedHat' %}
    - watch_in:
      - service:   carbon-aggregator
   {% endif %}

{% if salt['config.get']('os_family') == 'Debian' %}

/etc/default/graphite-carbon:
  file.replace:
    - pattern:     CARBON_CACHE_ENABLED=false
    - repl:        CARBON_CACHE_ENABLED=true
    - watch:
      - pkg:       graphite-carbon
    - watch_in:
      - service:   carbon-cache

{% endif %}

/var/lib/carbon/rrd:
  file.directory:
    - name:     {{ salt['config.get']('/var/lib/carbon:file:name') }}/rrd
    - user:     {{ salt['config.get']('graphite-carbon:user:name') }}
    - group:    {{ salt['config.get']('graphite-carbon:group:name') }}
    - mode:       '0755'
    - watch:
      - pkg:       graphite-carbon
