# vi: set ft=yaml.jinja :

include:
  -  incron
  -  salt-minion

incrontab:
  cmd.run:
    - name:      |-
                 ((     echo -n '/etc/salt/grains IN_MODIFY,IN_CREATE,IN_DELETE'
                        echo    ' salt-call state.highstate' )                 \
                 | incrontab -
                 )
    - unless:    |-
                 ( incrontab -l                                                \
                 |     egrep -q '/etc/salt/grains'
                 )
    - require:
      - pkg:       incron
      - pkg:       salt-minion
      - file:     /etc/incron.allow
