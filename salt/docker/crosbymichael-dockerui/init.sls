# vi: set ft=yaml.jinja :

include:
  -  python-docker

docker pull crosbymichael/dockerui:
  docker.pulled:
    - name:        crosbymichael/dockerui

docker run crosbymichael/dockerui:
  docker.installed:
    - name:        dockerui
    - image:       crosbymichael/dockerui
    - volumes:
      - /var/run/docker.sock
    - watch:
      - docker:    docker pull crosbymichael/dockerui

docker start dockerui:
  docker.running:
    - container:   dockerui
    - binds:
        /var/run/docker.sock:    /var/run/docker.sock
    - lxc_conf:    []
    - port_bindings:
        '9000/tcp':
            HostIp:    '0.0.0.0'
            HostPort:  '9000'
    - watch:
      - docker:    docker run crosbymichael/dockerui
