# vi: set ft=yaml.jinja :

include:
  -  git
  -  etcdctl

extend:
  /usr/local/src/etcdctl/build:
    cmd:
      - watch:
        - git:     https://github.com/coreos/etcdctl.git

https://github.com/coreos/etcdctl.git:
  git.latest:
    - rev:         master
    - target:     /usr/local/src/etcdctl
    - require:
      - pkg:       git
      - file:     /usr/local/src/etcdctl
