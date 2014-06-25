# vi: set ft=yaml.jinja :

include:
  - .depend-git
  -  ruby-rvm

usermod -G rvm  {{ salt['config.get']('apache2:user:name') }}:
  cmd.run:
    - unless:    |-
                 ( id    -Gn {{ salt['config.get']('apache2:user:name') }}     \
                 | egrep -q rvm
                 )
    - require:
      - pkg:       apache2
