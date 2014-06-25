# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment', 'base') %}

include:
  -  docker.crosbymichael-skydns
  -  python-docker

docker pull crosbymichael/skydock:
  docker.pulled:
    - name:        crosbymichael/skydock

docker run crosbymichael/skydock:
  docker.installed:
    - name:        skydock
    - image:       crosbymichael/skydock
    - command:    -domain 'skydns.local.' -environment {{ environment }} -ttl 30
    - volumes:
      - /var/run/docker.sock
    - watch:
      - docker:    docker pull crosbymichael/skydock

docker start skydock:
  docker.running:
    - container:   skydock
    - binds:
        /var/run/docker.sock:     /var/run/docker.sock
    - links:
        skydns:    skydns
    - lxc_conf:    []
    - watch:
      - docker:    docker start skydns
      - docker:    docker run crosbymichael/skydock
