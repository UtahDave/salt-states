# vi: set ft=yaml.jinja :

include:
  -  git
  -  etcd

extend:
  /usr/local/src/etcd/build:
    cmd:
      - watch:
        - git:     https://github.com/coreos/etcd.git

https://github.com/coreos/etcd.git:
  git.latest:
    - rev:         master
    - target:     /usr/local/src/etcd
    - require:
      - pkg:       git
      - file:     /usr/local/src/etcd
