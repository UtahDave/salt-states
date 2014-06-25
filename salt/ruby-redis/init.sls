# vi: set ft=yaml.jinja :

gem install redis:
  cmd.run:
    - unless:    |-
                 ( gem list redis                                              \
                 | egrep -q redis
                 )
