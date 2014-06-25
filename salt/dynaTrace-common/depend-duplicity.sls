# vi: set ft=yaml.jinja :

{% set bucket = salt['config.get']('backup:cloud:storage:bucket') %}

include:
  -  dynaTrace-common
  -  duplicity

duplicity full --include-filelist /opt/dynatrace/duplicity.txt / s3+http://{{ bucket }}/{{ dir|default('') }}:
  cron.present:
    - user:        root
    - minute:      0
    - hour:        0
    - daymonth:    1
    - require:
      - pkg:       duplicity
      - file:     /opt/dynatrace/duplicity.txt

duplicity incr --include-filelist /opt/dynatrace/duplicity.txt / s3+http://{{ bucket }}/{{ dir|default('') }}:
  cron.present:
    - user:        root
    - minute:      0
    - hour:        0
    - daymonth:    2-31
    - require:
      - pkg:       duplicity
      - file:     /opt/dynatrace/duplicity.txt
