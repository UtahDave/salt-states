# vi: set ft=yaml.jinja :

{% set etc = salt['config.get']('/etc/graphite:file:name') %}
{% set grp = salt['config.get']('graphite-web:group:name') %}
{% set lib = salt['config.get']('/var/lib/graphite:file:name') %}
{% set py  = salt['config.get']('saltpath') + '/../graphite' %}
{% set usr = salt['config.get']('graphite-web:user:name') %}

include:
  -  graphite-web

/usr/lib/python2.7/dist-packages/graphite/settings.py:
  file.replace:
    - name:     {{ py }}/settings.py
    - pattern:   "'NAME': '',"
    - repl:      "'NAME': '{{ lib }}/graphite.db',"
    - watch:
      - pkg:       graphite-web

python manage.py syncdb --noinput:
  cmd.run:
    - cwd:      {{ py }}
    - user:     {{ usr }}
    - group:    {{ grp }}
    - unless:    |-
                 (  [    {{ lib }}/graphite.db -nt {{ etc }}/local_settings.py ] \
                 || [ -s {{ lib }}/graphite.db ]
                 )
    - watch:
      - file:     /etc/graphite/local_settings.py
      - file:     /usr/lib/python2.7/dist-packages/graphite/settings.py
