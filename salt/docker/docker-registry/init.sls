# vi: set ft=yaml.jinja :

include:
  -  python-docker

docker pull registry:
  docker.pulled:
    - name:        registry

docker run registry:
  docker.installed:
    - name:        registry
    - image:       registry:latest
    - volumes:
      - /tmp/registry
    - watch:
      - docker:    docker pull registry

docker start registry:
  docker.running:
    - container:   registry
    - binds:
        /srv/docker/registry:    /tmp/registry
    - lxc_conf:    []
    - port_bindings:
        '5000/tcp':
            HostIp:    '0.0.0.0'
            HostPort:  '5000'
    - watch:
      - docker:    docker run registry
