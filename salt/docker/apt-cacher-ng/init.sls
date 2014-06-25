# vi: set ft=yaml.jinja :

{% set date = salt['cmd.run']('date +%s') %}
{% set psls = sls.split('.')[-1] %}

include:
  -  python-docker
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
    - volumes:
      - /var/cache/apt-cacher-ng
    - watch:
      - docker:    docker build {{ psls }}

docker start {{ psls }}:
  docker.running:
    - container:   {{ psls }}
    - binds:
        /var/cache/apt-cacher-ng:     /var/cache/apt-cacher-ng
    - links:
        salt-master:    salt
    - lxc_conf:    []
    - port_bindings:
        '3142/tcp':
            HostIp:    '0.0.0.0'
            HostPort:  '3142'
    - watch:
      - docker:    docker start salt-master
      - docker:    docker run {{ psls }}
