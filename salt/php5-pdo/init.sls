# vi: set ft=yaml.jinja :

include:
  -  php5

php5-pdo:
  pkg.installed:
    - name:     {{ salt['config.get']('php5-pdo:pkg:name') }}
   {% if salt['config.get']('os_family') == 'RedHat' %}
    - require:
      - pkgrepo:   ius
   {% endif %}
