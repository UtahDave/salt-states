# vi: set ft=yaml.jinja :

include:
  -  nodejs

npm:
  pkg.installed:   []

npm config set ca "":
  cmd.run:
    - unless:      test -z "$( npm config get ca )"
    - require:
      - pkg:       npm
