# vi: set ft=yaml.jinja :

include:
  -  ruby2_0

ruby2_0-dev:
  pkg.installed:
    - name:        ruby2.0-dev
    - require:
      - pkgrepo:   ruby-ng-experimental
