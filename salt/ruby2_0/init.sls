# vi: set ft=yaml.jinja :

include:
  -  python-apt

ruby-ng-experimental:
  pkgrepo.managed:
    - ppa:         brightbox/ruby-ng-experimental
   {% if salt['config.get']('os_family') == 'Debian' %}
    - require:
      - pkg:       python-apt
   {% endif %}

ruby2_0:
  pkg.installed:
    - name:        ruby2.0
    - require:
      - pkgrepo:   ruby-ng-experimental
