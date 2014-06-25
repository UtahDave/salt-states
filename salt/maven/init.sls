# vi: set ft=yaml.jinja :

include:
  -  oracle-java7-installer
  -  oracle-java7-set-default

maven:
  pkg.installed:
    - require:
      - pkg:       oracle-java7-installer
     {% if   salt['config.get']('os_family') == 'Debian' %}
      - pkg:       oracle-java7-set-default
     {% endif %}
      - file:     /etc/profile.d/maven.sh
      - file:     /root/.m2/settings.xml

/etc/profile.d/maven.sh:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/profile.d/maven.sh
    - user:        root
    - group:       root
    - mode:       '0644'

/root/.m2/settings.xml:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/root/.m2/settings.xml
    - user:        root
    - group:       root
    - mode:       '0600'
    - makedirs:    True
