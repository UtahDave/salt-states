# vi: set ft=yaml.jinja :

include:
  -  calamari
  -  git

extend:
  /etc/init/kraken.conf:
    file:
      - require:
        - git:     https://github.com/ceph/calamari.git

  /opt/calamari/plugins:
    file:
      - require:
        - git:     https://github.com/ceph/calamari.git

https://github.com/ceph/calamari.git:
  git.latest:
    - rev:         master
    - target:     /opt/calamari
    - require:
      - pkg:       git
      - file:     /opt/calamari
