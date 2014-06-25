# vi: set ft=yaml.jinja :

include:
  -  python-pip

cloudera-cm4-api:
  pip.installed:
    - name:     {{ salt['config.get']('cloudera-cm4-api:pip:name') }}
    - require:
      - pkg:       python-pip
