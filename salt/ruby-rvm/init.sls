# vi: set ft=yaml.jinja :

include:
  -  curl

curl -L https://get.rvm.io | bash -s stable:
  cmd.run:
    - unless:      test -d /usr/local/rvm/
    - require:
      - pkg:       curl
