# vi: set ft=yaml.jinja :

include:
  -  elasticsearch

./plugin -install lukas-vlcek/bigdesk:
  cmd.run:
    - order:      -1
    - cwd:        /usr/share/elasticsearch/bin
    - unless:      test -d /usr/share/elasticsearch/plugins/bigdesk
    - require:
      - pkg:       elasticsearch
