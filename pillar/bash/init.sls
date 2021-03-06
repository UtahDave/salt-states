# vi: set ft=yaml.jinja :

{% if   salt['config.get']('os_family') == 'RedHat' %}

bash:
  pkg:
    name:          setup
  service:
    name:          setup

/etc/bash.bashrc:
  file:
    name:         /etc/bashrc

{% elif salt['config.get']('os_family') == 'Debian' %}

bash:
  pkg:
    name:          bash
  service:
    name:          bash

/etc/bash.bashrc:
  file:
    name:         /etc/bash.bashrc

{% endif %}
