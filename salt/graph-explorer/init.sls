# vi: set ft=yaml.jinja :

include:
  - .depend-git
# -  anthracite
  -  elasticsearch
  -  python-elasticsearch

/opt/graph-explorer/config.py:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/opt/graph-explorer/config.py
    - user:        root
    - group:       root
    - mode:       '0644'
