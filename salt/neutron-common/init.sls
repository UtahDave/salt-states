# vi: set ft=yaml.jinja :

include:
  - .depend-sudo
  -  netbase
  -  procps

neutron-common:
  pkg.installed:   []

/etc/neutron/fwaas_driver.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/fwaas_driver.ini
    - user:        root
    - group:       neutron
    - mode:       '0644'
    - watch:
      - pkg:       neutron-common

/etc/neutron/l3_agent.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/l3_agent.ini
    - user:        root
    - group:       neutron
    - mode:       '0644'
    - watch:
      - pkg:       neutron-common

/etc/neutron/neutron.conf:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/neutron.conf
    - user:        root
    - group:       neutron
    - mode:       '0644'
    - watch:
      - pkg:       neutron-common

/etc/neutron/vpn_agent.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/vpn_agent.ini
    - user:        root
    - group:       neutron
    - mode:       '0644'
    - watch:
      - pkg:       neutron-common

/var/run/neutron:
  file.directory:
    - user:        neutron
    - group:       root
    - mode:       '0755'
    - require:
      - pkg:       neutron-common

{% if not salt['config.get']('virtual_subtype') == 'Docker' %}

net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - value:       0
    - require:
      - pkg:       procps

net.ipv4.conf.default.rp_filter:
  sysctl.present:
    - value:       0
    - require:
      - pkg:       procps

{% endif %}
