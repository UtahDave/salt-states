# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

{% if salt['config.get']('virtual_subtype') == 'Docker' %}

include:
  -  supervisor

/etc/bash.bashrc:
  file.append:
    - text:        ps -C supervisord &>- || supervisord &>-
    - watch:
      - pkg:       supervisor

{% endif %}
