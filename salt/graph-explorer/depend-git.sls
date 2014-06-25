# vi: set ft=yaml.jinja :

include:
  -  git
  -  graph-explorer

extend:
  /opt/graph-explorer/config.py:
    file:
      - require:
        - git:     https://github.com/vimeo/graph-explorer.git

https://github.com/vimeo/graph-explorer.git:
  git.latest:
    - rev:         master
    - user:        root
    - force:       True
    - target:     /opt/graph-explorer
    - require:
      - pkg:       git
