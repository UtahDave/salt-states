# vi: set ft=yaml.jinja :

include:
  -  python-pip

python-elasticsearch:
  pip.installed:
    - name:        elasticsearch
    - require:
      - pkg:       python-pip
