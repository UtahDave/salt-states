# vi: set ft=yaml.jinja :

include:
  -  php5

php5-fpm:
  pkg.installed:
    - name:     {{ salt['config.get']('php5-fpm:pkg:name') }}
   {% if salt['config.get']('os_family') == 'RedHat' %}
    - require:
      - pkgrepo:   ius
   {% endif %}
  service.running:
    - name:     {{ salt['config.get']('php5-fpm:service:name') }}
    - enable:      True
    - reload:      True
    - watch:
      - pkg:       php5-fpm

/etc/php5/fpm/pool.d/www.conf:
  file.absent:
    - name:     {{ salt['config.get']('/etc/php5/fpm/pool.d:file:name') }}/www.conf
    - watch_in:
      - service:   php5-fpm
