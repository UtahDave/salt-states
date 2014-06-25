# vi: set ft=yaml.jinja :

include:
  -  python-apt
  -  ubuntu-cloud-keyring

openstack-common:
  pkgrepo.managed:
    - name:     {{ salt['config.get']('openstack-common:pkgrepo:name') }}
    - file:     {{ salt['config.get']('openstack-common:pkgrepo:file') }}
   {% if salt['config.get']('os_family') == 'Debian' %}
    - require:
      - pkg:       python-apt
   {% endif %}
