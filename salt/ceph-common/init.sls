# vi: set ft=yaml.jinja :

{% set version = 'firefly' %}

include:
  -  python-apt

ceph-common:
  pkgrepo.managed:
    - name:     {{ salt['config.get']('ceph-common:pkgrepo:name') }}
    - file:     {{ salt['config.get']('ceph-common:pkgrepo:file') }}
    - gpgkey:      https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc
    - key_url:     https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc
    - humanname:   Ceph packages
    - baseurl:     http://ceph.com/rpm-{{ version }}/el6/$basearch
    - enabled:     1
    - gpgcheck:    1
    - consolidate: True
   {% if salt['config.get']('os_family') == 'Debian' %}
    - require:
      - pkg:       python-apt
   {% endif %}
  pkg.installed:
    - require:
      - pkgrepo:   ceph-common

#ceph-extras:
# pkgrepo.managed:
#   - name:     {# salt['config.get']('ceph-extras:pkgrepo:name') #}
#   - file:     {# salt['config.get']('ceph-extras:pkgrepo:file') #}
#   - gpgkey:      https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc
#   - key_url:     https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc
#   - humanname:   Ceph Extras packages
#   - baseurl:     http://ceph.com/packages/ceph-extras/rpm/rhel6/$basearch
#   - enabled:     1
#   - gpgcheck:    1
#   - consolidate: True
#  {# if salt['config.get']('os_family') == 'Debian' #}
#   - require:
#     - pkg:       python-apt
#  {# endif #}
