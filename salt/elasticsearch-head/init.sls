# vi: set ft=yaml.jinja :

include:
  -  elasticsearch

./plugin -install mobz/elasticsearch-head:
  cmd.run:
    - order:      -1
    - cwd:        /usr/share/elasticsearch/bin
    - unless:      test -d /usr/share/elasticsearch/plugins/head
    - require:
      - pkg:       elasticsearch
