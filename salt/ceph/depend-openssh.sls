# vi: set ft=yaml.jinja :

include:
  -  ceph
  -  openssh-server

/home/ceph/.ssh:
  file.directory:
    - user:        ceph
    - group:       ceph
    - mode:       '0700'
    - require:
      - file:     /home/ceph
