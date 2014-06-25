# vi: set ft=yaml.jinja :

openssh-client:
  pkg.installed:
    - order:      -1

/root/.ssh:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0700'
    - require:
      - pkg:       openssh-client

/root/.ssh/id_rsa:
  file.managed:
    - contents_pillar:  openssh-client:id_rsa
    - user:        root
    - group:       root
    - mode:       '0400'
    - require:
      - pkg:       openssh-client

/root/.ssh/id_rsa.pub:
  cmd.run:
    - name:      |-
                 ( ssh-keygen -q -N '' -t rsa -b 2048 -f /root/.ssh/id_rsa     \
                                                       > /root/.ssh/id_rsa.pub
                 )
    - require:
      - file:     /root/.ssh/id_rsa
