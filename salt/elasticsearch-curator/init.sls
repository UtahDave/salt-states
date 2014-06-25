# vi: set ft=yaml.jinja :

include:
  -  python-pip

elasticsearch-curator:
  pip.installed:
    - require:
      - pkg:       python-pip
