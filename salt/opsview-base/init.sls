# vi: set ft=yaml.jinja :

include:
  -  python-apt
  -  rpmforge-release

opsview-base:
  pkgrepo.managed:
    - name:     {{ salt['config.get']('opsview:pkgrepo:name') }}
    - file:     {{ salt['config.get']('opsview:pkgrepo:file') }}
    - gpgkey:   {{ salt['config.get']('opsview:pkgrepo:key_url') }}
    - key_url:  {{ salt['config.get']('opsview:pkgrepo:key_url') }}
    - humanname:   Opsview
    - baseurl:     http://downloads.opsview.com/opsview-core/latest/yum/centos/6/$basearch
    - enabled:     1
    - gpgcheck:    0
    - consolidate: True
   {% if salt['config.get']('os_family') == 'Debian' %}
    - require:
      - pkg:       python-apt
   {% endif %}
  pkg.installed:
    - require:
      - pkgrepo:   opsview-base
