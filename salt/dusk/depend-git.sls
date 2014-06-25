# vi: set ft=yaml.jinja :

include:
  -  git

https://github.com/obfuscurity/dusk.git:
  git.latest:
    - rev:         master
    - user:        root
    - force:       True
    - target:     /opt/dusk
    - require:
      - pkg:       git
