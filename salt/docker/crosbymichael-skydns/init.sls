# vi: set ft=yaml.jinja :

include:
  -  python-docker

docker pull crosbymichael/skydns:
  docker.pulled:
    - name:        crosbymichael/skydns

docker run crosbymichael/skydns:
  docker.installed:
    - name:        skydns
    - image:       crosbymichael/skydns
    - command:    -nameserver="8.8.8.8:53,8.8.4.4:53"
    - watch:
      - docker:    docker pull crosbymichael/skydns

docker start skydns:
  docker.running:
    - container:   skydns
    - lxc_conf:    []
    - port_bindings:
        '53/udp':
            HostIp:    '172.17.42.1'
            HostPort:  '53'
    - watch:
      - docker:    docker run crosbymichael/skydns
