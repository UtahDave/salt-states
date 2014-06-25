# vi: set ft=yaml.jinja :

include:
  -  git

https://github.com/kenhub/giraffe.git:
  git.latest:
    - rev:         master
    - user:        root
    - force:       True
    - target:     /opt/giraffe
    - require:
      - pkg:       git
