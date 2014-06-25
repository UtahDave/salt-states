# vi: set ft=yaml.jinja :

lxc-docker:
  pkg.installed:
    - name:     {{ salt['config.get']('lxc-docker:pkg:name') }}
  service.running:
    - name:        docker
    - enable:      True
    - watch:
      - pkg:       lxc-docker

/etc/default/docker:
  file.replace:
    - name:     {{ salt['config.get']('/etc/default/docker:file:name') }}
    - pattern:  '^#DOCKER_OPTS=".*"$'
    - repl:       'DOCKER_OPTS="-dns 172.17.42.1 -dns 8.8.8.8"'
    - watch:
      - pkg:       lxc-docker
    - watch_in:
      - service:   lxc-docker
