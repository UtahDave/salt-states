# vi: set ft=yaml.jinja :

include:
  -  g++
  -  make
  -  ruby-dev

redmon:
  gem.installed:
    - require:
      - pkg:       g++
      - pkg:       make
      - pkg:       ruby-dev
