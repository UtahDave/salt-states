# vi: set ft=yaml.jinja :

{% set version = 'cm4' %}

include:
  -  cloudera-{{ version }}

oracle-j2sdk1_6:
  pkg.installed:
    - name:     {{ salt['config.get']('oracle-j2sdk1_6:pkg:name') }}
    - require:
      - pkgrepo:   cloudera-{{ version }}
