# vi: set ft=yaml.jinja :

include:
  -  php5

php5-curl:
  pkg.installed:
    - name:     {{ salt['config.get']('php5-curl:pkg:name') }}
   {% if salt['config.get']('os_family') == 'RedHat' %}
    - require:
      - pkgrepo:   ius
   {% endif %}
