# vi: set ft=yaml.jinja :

include:
  -  elasticsearch

./plugin -install royrusso/elasticsearch-HQ:
  cmd.run:
    - order:      -1
    - cwd:        /usr/share/elasticsearch/bin
    - unless:      test -d /usr/share/elasticsearch/plugins/HQ
    - require:
      - pkg:       elasticsearch
