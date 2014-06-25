# vi: set ft=yaml.jinja :

include:
  -  php5

php5-cli:
  pkg.installed:
    - name:     {{ salt['config.get']('php5-cli:pkg:name') }}
   {% if salt['config.get']('os_family') == 'RedHat' %}
    - require:
      - pkgrepo:   ius
   {% endif %}
