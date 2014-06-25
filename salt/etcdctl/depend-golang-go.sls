# vi: set ft=yaml.jinja :

include:
  -  etcdctl.depend-git
  -  golang-go

extend:
  /usr/bin/etcdctl:
    file:
      - target:   /usr/local/src/etcdctl/bin/etcdctl
      - watch:
        - cmd:    /usr/local/src/etcdctl/build

/usr/local/src/etcdctl:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

/usr/local/src/etcdctl/build:
  cmd.wait:
    - cwd:        /usr/local/src/etcdctl
    - env:
      - GOPATH:   /usr/local
    - require:
      - pkg:       golang-go
