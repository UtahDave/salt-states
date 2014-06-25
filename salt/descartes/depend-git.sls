# vi: set ft=yaml.jinja :

include:
  -  descartes
  -  git

extend:
  /opt/descartes/.env:
    file:
      - require:
        - git:     https://github.com/obfuscurity/descartes.git

  rvm use 1.9.3:
    cmd:
      - require:
        - git:     https://github.com/obfuscurity/descartes.git

  bundle install && gem install foreman:
    cmd:
      - require:
        - git:     https://github.com/obfuscurity/descartes.git

https://github.com/obfuscurity/descartes.git:
  git.latest:
    - rev:         master
    - user:        root
    - force:       True
    - target:     /opt/descartes
    - require:
      - pkg:       git
