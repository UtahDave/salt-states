# vi: set ft=yaml.jinja :

{% set date = salt['cmd.run']('date +%s') %}
{% set psls = sls.split('.')[-1] %}

include:
  -  python-docker
  -  docker.etcd
  -  docker.salt-master
  -  docker.salt-minion

/usr/local/src/{{ psls }}/Dockerfile:
  file.managed:
    - source:      salt://{{ psls }}/Dockerfile
    - user:        root
    - group:       root
    - mode:       '0644'
    - makedirs:    True

/usr/local/src/{{ psls }}/etc/salt/grains:
  file.managed:
    - source:      salt://{{ psls }}/etc/salt/grains
    - user:        root
    - group:       root
    - mode:       '0644'
    - makedirs:    True

docker build {{ psls }}:
  docker.built:
    - name:        {{ psls }}
    - path:       /usr/local/src/{{ psls }}
    - watch:
      - docker:    docker build salt-minion
      - file:     /usr/local/src/{{ psls }}/Dockerfile
      - file:     /usr/local/src/{{ psls }}/etc/salt/grains

#docker tag {{ psls }}:{{ date }}:
# module.run:
#   - name:        docker.tag
#   - image:       {{ psls }}:latest
#   - repository:  {{ psls }}
#   - tag:         {{ date }}
#   - onchanges:
#     - docker:    docker build {{ psls }}

docker run {{ psls }}:
  docker.installed:
    - name:        {{ psls }}
    - image:       {{ psls }}:latest
    - environment:
        ETCD_MACHINES:  http://172.17.42.1:4001
    - watch:
      - docker:    docker start etcd
      - docker:    docker build {{ psls }}

docker start {{ psls }}:
  docker.running:
    - container:   {{ psls }}
    - links:
        salt-master:    salt
    - lxc_conf:    []
    - port_bindings:
        '53/tcp':
            HostIp:    '172.17.42.1'
            HostPort:  '53'
        '53/udp':
            HostIp:    '172.17.42.1'
            HostPort:  '53'
    - watch:
      - docker:    docker start etcd
      - docker:    docker start salt-master
      - docker:    docker run {{ psls }}
