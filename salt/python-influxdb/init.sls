# vi: set ft=yaml.jinja :

include:
  -  python-pip

python-influxdb:
  pip.installed:
    - require:
      - pkg:       python-pip
