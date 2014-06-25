# vi: set ft=yaml.jinja :

include:
  -  git
  -  skydns1

extend:
  go get -d -v ./...:
    cmd:
      - watch:
        - git:     https://github.com/skynetservices/skydns1.git

https://github.com/skynetservices/skydns1.git:
  git.latest:
    - rev:         master
    - target:     /usr/local/src/skydns1
    - require:
      - pkg:       git
      - file:     /usr/local/src/skydns1
