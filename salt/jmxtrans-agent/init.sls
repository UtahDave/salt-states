# vi: set ft=yaml.jinja :

include:
  - .depend-maven

/opt/jmxtrans:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

/opt/jmxtrans/etc:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - file:     /opt/jmxtrans

/opt/jmxtrans/lib:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - file:     /opt/jmxtrans
