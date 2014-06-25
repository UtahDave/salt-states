# vi: set ft=yaml.jinja :

include:
  -  python-apt

newrelic:
  pkgrepo.managed:
    - name:     {{ salt['config.get']('newrelic:pkgrepo:name') }}
    - file:     {{ salt['config.get']('newrelic:pkgrepo:file') }}
    - gpgkey:      https://download.newrelic.com/548C16BF.gpg
    - key_url:     https://download.newrelic.com/548C16BF.gpg
    - humanname:   New Relic packages for Enterprise Linux 5 - $basearch
    - baseurl:     http://yum.newrelic.com/pub/newrelic/el5/$basearch
    - comps:       non-free
    - enabled:     1
    - gpgcheck:    1
    - consolidate: True
   {% if salt['config.get']('os_family') == 'Debian' %}
    - require:
      - pkg:       python-apt
   {% endif %}
