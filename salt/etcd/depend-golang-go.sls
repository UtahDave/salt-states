# vi: set ft=yaml.jinja :

include:
  -  etcd.depend-git
  -  golang-go

extend:
  /usr/bin/etcd:
    file:
      - target:   /usr/local/src/etcd/bin/etcd
      - watch:
        - cmd:    /usr/local/src/etcd/build

/usr/local/src/etcd:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

/usr/local/src/etcd/build:
  cmd.wait:
    - cwd:        /usr/local/src/etcd
    - env:
      - GOPATH:   /usr/local
    - require:
      - pkg:       golang-go
