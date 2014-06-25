# vi: set ft=yaml.jinja :

include:
  -  newrelic
  -  unzip

/usr/local/src/newrelic_agent3.1.0.zip:
  file.managed:
    - source:      salt://{{ sls }}/usr/local/src/newrelic_agent3.1.0.zip

unzip newrelic_agent.zip:
  cmd.run:
    - name:        unzip -o /usr/local/src/newrelic_agent3.1.0.zip
    - unless:      test -f ./newrelic/newrelic.jar
    - require:
      - pkg:       unzip
      - file:     /usr/local/src/newrelic_agent3.1.0.zip

newrelic/newrelic.yml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/newrelic/newrelic.yml
    - user:        root
    - group:       root
    - mode:       '0644'
    - defaults:
        appname:   My Application
    - require:
      - cmd:       unzip newrelic_agent.zip
