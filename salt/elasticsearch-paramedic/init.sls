# vi: set ft=yaml.jinja :

include:
  -  elasticsearch

./plugin -install karmi/elasticsearch-paramedic:
  cmd.run:
    - order:      -1
    - cwd:        /usr/share/elasticsearch/bin
    - unless:      test -d /usr/share/elasticsearch/plugins/paramedic
    - require:
      - pkg:       elasticsearch
