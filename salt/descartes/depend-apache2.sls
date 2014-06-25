# vi: set ft=yaml.jinja :

include:
  -  apache2
  -  descartes

extend:
  rvm use 1.9.3:
    cmd:
      - user:   {{ salt['config.get']('apache2:user:name') }}
      - require:
        - pkg:     apache2

  bundle install && gem install foreman:
    cmd:
      - user:     {{ salt['config.get']('apache2:user:name') }}
      - require:
        - pkg:       apache2

usermod -G rvm {{ salt['config.get']('apache2:user:name') }}:
  cmd.run:
    - unless:    |-
                 ( id    -Gn {{ salt['config.get']('apache2:user:name') }}     \
                 | egrep -q rvm
                 )
    - require:
      - pkg:       apache2
