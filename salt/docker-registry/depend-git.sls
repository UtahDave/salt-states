# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  git
  -  postfix

git@github.com:dotcloud/docker-registry.git:
  git.latest:
    - rev:         master
    - force:       True
    - target:     /opt/docker/registry
    - require:
      - pkg:       git

/opt/docker/registry/config.yml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ psls }}/opt/docker/registry/config.yml
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - git:       git@github.com:dotcloud/docker-registry.git
