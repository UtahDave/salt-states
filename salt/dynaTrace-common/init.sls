# vi: set ft=yaml.jinja :

include:
  - .depend-duplicity
  - .depend-logrotate
  -  oracle-java7-set-default

dynatrace:
  user.present:
    - fullname:    dynaTrace Daemon
    - shell:      /bin/false
    - home:       /opt/dynatrace

/dynatrace-{{ salt['config.get']('version') }}.{{ salt['config.get']('release') }}-linux-x64.jar:
  file.managed:
    - source:      salt://{{ sls }}/dynatrace-{{ salt['config.get']('version') }}.{{ salt['config.get']('release') }}-linux-x64.jar

/etc/profile.d/dynatrace.sh:
  file.managed:
    - source:      salt://{{ sls }}/etc/profile.d/dynatrace.sh
    - user:        root
    - group:       root
    - mode:       '0644'

/opt/dynatrace/duplicity.txt:
  file.managed:
    - source:      salt://{{ sls }}/opt/dynatrace/duplicity.txt
    - user:        root
    - group:       root
    - mode:       '0644'
    - require:
      - cmd:       java-jar

java-jar:
  cmd.run:
    - cwd:        /opt
    - name:      |-
                 ( echo -e 'N\n/opt/dynatrace\nY'                              \
                 | java -jar /dynatrace-{{ salt['config.get']('version') }}.{{ salt['config.get']('release') }}-linux-x64.jar
                 )
    - unless:      test -d /opt/dynatrace
    - require:
      - file:     /dynatrace-{{ salt['config.get']('version') }}.{{ salt['config.get']('release') }}-linux-x64.jar
