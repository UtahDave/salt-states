# vi: set ft=yaml.jinja :

include:
  -  git
  -  skydns2

extend:
  go get -d -v ./...:
    cmd:
      - watch:
        - git:     https://github.com/skynetservices/skydns.git

https://github.com/skynetservices/skydns.git:
  git.latest:
    - rev:         master
    - target:     /usr/local/src/skydns2
    - require:
      - pkg:       git
      - file:     /usr/local/src/skydns2
