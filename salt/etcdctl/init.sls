# vi: set ft=yaml.jinja :

include:
# - .depend-golang-go
  -  etcd-common

/usr/bin/etcdctl:
  file.symlink:
    - target:     /usr/share/etcd/etcdctl
    - watch:
      - file:     /usr/share/etcd
