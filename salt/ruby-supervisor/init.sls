# vi: set ft=yaml.jinja :

gem install supervisor:
  cmd.run:
    - unless:    |-
                 ( gem list supervisor                                         \
                 | egrep -q supervisor
                 )
