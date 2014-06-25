# vi: set ft=yaml.jinja :

include:
  -  newrelic

newrelic-daemon:
  pkg.installed:
    - order:      -1
    - require:
      - pkgrepo:   newrelic
  service.running:
    - name:       /usr/bin/newrelic-daemon -A -s -l /var/log/newrelic/newrelic-daemon.log
    - enable:      True
    - sig:        /usr/bin/newrelic-daemon -A -s -l /var/log/newrelic/newrelic-daemon.log
    - watch:
      - pkg:       newrelic-daemon
