# vi: set ft=yaml.jinja :

include:
  -  git
  -  sensu

https://github.com/sensu/sensu-community-plugins.git:
  git.latest:
    - target:     /etc/sensu/community
    - require:
      - pkg:       git
      - pkg:       sensu

/etc/sensu/plugins:
  file.symlink:
    - target:     /etc/sensu/community/plugins
    - force:       True
    - require:
      - git:       https://github.com/sensu/sensu-community-plugins.git
