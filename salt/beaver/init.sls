# vi: set ft=yaml.jinja :

include:
  -  python-pip

python-beaver:
  pip.installed:
    - name:        beaver
    - require:
      - pkg:       python-pip

/etc/beaver:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - pip:       beaver

/etc/beaver/conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/beaver/conf
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - file:     /etc/beaver

/etc/beaver/conf.d:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - file:     /etc/beaver
