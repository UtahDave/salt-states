# vi: set ft=yaml.jinja :

gem install bunny:
  cmd.run:
    - unless:    |-
                 ( gem list bunny                                              \
                 | egrep -q bunny
                 )
