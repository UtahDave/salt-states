# vi: set ft=yaml.jinja :

include:
  - .depend-golang-go
  - .depend-supervisor

/var/lib/skydns1:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'

/var/lib/skydns1/data:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - file:     /var/lib/skydns1
