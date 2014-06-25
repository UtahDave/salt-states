# vi: set ft=yaml.jinja :

{% set users = [] %}
{% do  users.append('krichardson') %}

openssh-server:
  pkg.installed:
    - order:      -1
  service.running:
    - name:     {{ salt['config.get']('openssh-server:service:name') }}
    - enable:      True
    - reload:      True
    - sig:        /usr/sbin/sshd
    - watch:
      - pkg:       openssh-server

{% if salt['config.get']('virtual_subtype') == 'Docker' %}

/etc/ssh/sshd_config:
  file.replace:
    - pattern:   '^UsePAM yes'
    - repl:       'UsePAM no'
    - watch_in:
      - service:   openssh-server

{% endif %}
{% for user in users %}

id_rsa.pub.{{ user }}:
  ssh_auth.present:
    - order:      -1
    - user:        root
    - source:      salt://{{ sls }}/root/.ssh/id_rsa.pub.{{ user }}

{% endfor %}
