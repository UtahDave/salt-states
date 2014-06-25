# vi: set ft=yaml.jinja :

include:
  -  python-apt

jenkins-common:
  pkgrepo.managed:
    - name:     {{ salt['config.get']('jenkins-common:pkgrepo:name') }}
    - file:     {{ salt['config.get']('jenkins-common:pkgrepo:file') }}
    - gpgkey:   {{ salt['config.get']('jenkins-common:pkgrepo:key_url') }}
    - key_url:  {{ salt['config.get']('jenkins-common:pkgrepo:key_url') }}
    - humanname:   Jenkins
    - baseurl:     http://pkg.jenkins-ci.org/redhat
    - enabled:     1
    - gpgcheck:    1
    - consolidate: True
   {% if salt['config.get']('os_family') == 'Debian' %}
    - require:
      - pkg:       python-apt
   {% endif %}
