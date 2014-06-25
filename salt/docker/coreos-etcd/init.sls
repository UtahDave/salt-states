# vi: set ft=yaml.jinja :

{% set ipv4 = salt['config.get']('fqdn_ip4') %}

include:
  -  python-docker

docker pull coreos/etcd:
  docker.pulled:
    - name:        coreos/etcd

docker run coreos/etcd01:
  docker.installed:
    - name:        etcd01
    - image:       coreos/etcd
    - command:    -name etcd01 -addr {{ ipv4[0] }}:4001 -peer-addr {{ ipv4[0] }}:7001
    - watch:
      - docker:    docker pull coreos/etcd

docker start etcd01:
  docker.running:
    - container:   etcd01
    - lxc_conf:    []
    - port_bindings:
        '4001/tcp':
            HostIp:    '172.17.42.1'
            HostPort:  '4001'
        '7001/tcp':
            HostIp:    '172.17.42.1'
            HostPort:  '7001'
    - watch:
      - docker:    docker run coreos/etcd01

docker run coreos/etcd02:
  docker.installed:
    - name:        etcd02
    - image:       coreos/etcd
    - command:    -name etcd02 -addr {{ ipv4[0] }}:4001 -peer-addr {{ ipv4[0] }}:7001 -peers 172.17.42.1:7001,172.17.42.1:7002,172.17.42.1:7003
    - watch:
      - docker:    docker pull coreos/etcd

docker start etcd02:
  docker.running:
    - container:   etcd02
    - lxc_conf:    []
    - port_bindings:
        '4001/tcp':
            HostIp:    '172.17.42.1'
            HostPort:  '4002'
        '7001/tcp':
            HostIp:    '172.17.42.1'
            HostPort:  '7002'
    - watch:
      - docker:    docker run coreos/etcd02
      - docker:    docker start etcd01

docker run coreos/etcd03:
  docker.installed:
    - name:        etcd03
    - image:       coreos/etcd
    - command:    -name etcd03 -addr {{ ipv4[0] }}:4001 -peer-addr {{ ipv4[0] }}:7001 -peers 172.17.42.1:7001,172.17.42.1:7002,172.17.42.1:7003
    - watch:
      - docker:    docker pull coreos/etcd

docker start etcd03:
  docker.running:
    - container:   etcd03
    - lxc_conf:    []
    - port_bindings:
        '4001/tcp':
            HostIp:    '172.17.42.1'
            HostPort:  '4003'
        '7001/tcp':
            HostIp:    '172.17.42.1'
            HostPort:  '7003'
    - watch:
      - docker:    docker run coreos/etcd03
      - docker:    docker start etcd01
