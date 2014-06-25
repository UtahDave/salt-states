# vi: set ft=yaml.jinja :

include:
  -  git

https://github.com/scobal/seyren.git:
  git.latest:
    - rev:         master
    - user:        root
    - force:       True
    - target:     /opt/scobal/seyren
    - require:
      - pkg:       git
