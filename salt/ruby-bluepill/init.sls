# vi: set ft=yaml.jinja :

gem install bluepill:
  cmd.run:
    - unless:    |-
                 ( gem list bluepill                                           \
                 | egrep -q bluepill
                 )
