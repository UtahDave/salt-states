# vi: set ft=yaml.jinja :

{% set uid_min = 500 %}

byobu:
  pkg.installed:   []

{% for user in salt['user.getent']() %}
{% if  user['uid']  >= uid_min
   and user['name'] in user['groups'] %}

byobu-launcher-install && su - {{ user['name'] }} -c 'byobu-launcher-install':
  cmd.run:
    - unless:      grep -q '_byobu_sourced=1' ~/.profile
    - require:
      - pkg:       byobu

/home/{{ user['name'] }}/.byobu:
  file.directory:
    - user:     {{ user['name'] }}
    - group:    {{ user['name'] }}
    - mode:       '0755'
    - require:
      - pkg:       byobu

/home/{{ user['name'] }}/.byobu/status:
  file.managed:
    - user:     {{ user['name'] }}
    - group:    {{ user['name'] }}
    - mode:       '0644'
    - source:      salt://{{ sls }}/root/.byobu/status
    - require:
      - file:     /home/{{ user['name'] }}/.byobu

{% endif %}
{% endfor %}

/root/.byobu:
  file.directory:
    - user:        root
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       byobu

/root/.byobu/status:
  file.managed:
    - user:        root
    - group:       root
    - mode:       '0644'
    - source:      salt://{{ sls }}/root/.byobu/status
    - require:
      - file:     /root/.byobu
