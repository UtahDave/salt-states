# vi: set ft=yaml.jinja :

gem install crack:
  cmd.run:
    - unless:    |-
                 ( gem list crack                                              \
                 | egrep -q crack
                 )
