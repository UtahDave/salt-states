# vi: set ft=yaml.jinja :

gem install snmp:
  cmd.run:
    - unless:    |-
                 ( gem list snmp                                               \
                 | egrep -q snmp
                 )
