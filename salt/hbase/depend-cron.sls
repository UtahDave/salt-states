# vi: set ft=yaml.jinja :

include:
  -  cron
  -  hbase

hbase org.jruby.Main /usr/lib/hbase/bin/snapshot.rb:
  cron.present:
    - user:        root
    - minute:      0
    - hour:        0
    - require:
      - pkg:       hbase
      - service:   cron
      - file:     /usr/lib/hbase/bin/snapshot.rb
