# vi: set ft=yaml.jinja :

{% set date = salt['cmd.run']('date +%s') %}
{% set psls = sls.split('.')[-1] %}

include:
  -  python-docker
  -  docker.ubuntu

/usr/local/src/salt-minion/Dockerfile:
  file.managed:
    - source:      salt://{{ psls }}/Dockerfile
    - user:        root
    - group:       root
    - mode:       '0644'
    - makedirs:    True

/usr/local/src/salt-minion/bootstrap.sh:
  file.managed:
    - source:      salt://{{ psls }}/bootstrap.sh
    - user:        root
    - user:        root
    - group:       root
    - mode:       '0644'
    - makedirs:    True

docker build salt-minion:
  docker.built:
    - name:        salt-minion
    - path:       /usr/local/src/salt-minion
    - watch:
      - docker:    docker pull ubuntu
      - file:     /usr/local/src/salt-minion/Dockerfile
      - file:     /usr/local/src/salt-minion/bootstrap.sh

#docker tag {{ psls }}:{{ date }}:
# module.run:
#   - name:        docker.tag
#   - image:       {{ psls }}:latest
#   - repository:  {{ psls }}
#   - tag:         {{ date }}
#   - onchanges:
#     - docker:    docker build {{ psls }}
