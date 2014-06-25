# vi: set ft=yaml.jinja :

include:
  -  python-pip

python-docker:
  pip.installed:
    - name:        docker-py
    - require:
      - pkg:       python-pip
