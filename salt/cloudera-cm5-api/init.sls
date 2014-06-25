# vi: set ft=yaml.jinja :

include:
  -  python-pip

cloudera-cm5-api:
  pip.installed:
    - name:     {{ salt['config.get']('cloudera-cm5-api:pip:name') }}
    - require:
      - pkg:       python-pip
