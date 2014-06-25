# vi: set ft=yaml.jinja :

include:
  -  netbase
  -  python-apt

cloudera-cm4:
  pkgrepo.managed:
    - name:     {{ salt['config.get']('cloudera-cm4:pkgrepo:name') }}
    - file:     {{ salt['config.get']('cloudera-cm4:pkgrepo:file') }}
    - gpgkey:   {{ salt['config.get']('cloudera-cm4:pkgrepo:key_url') }}
    - key_url:  {{ salt['config.get']('cloudera-cm4:pkgrepo:key_url') }}
    - humanname:   Cloudera Manager
    - baseurl:     http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/4/
    - comps:       contrib
    - enabled:     1
    - gpgcheck:    1
    - consolidate: True
   {% if salt['config.get']('os_family') == 'Debian' %}
    - require:
      - pkg:       python-apt
   {% endif %}
