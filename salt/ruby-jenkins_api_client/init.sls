# vi: set ft=yaml.jinja :

gem install jenkins_api_client:
  cmd.run:
    - unless:    |-
                 ( gem list jenkins_api_client                                 \
                 | egrep -q jenkins_api_client
                 )
