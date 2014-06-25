# vi: set ft=yaml.jinja :

include:
  -  neutron-common

neutron-plugin-ml2:
  pkg.installed:   []

/etc/neutron/plugins/ml2/ml2_conf.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2

/etc/neutron/plugins/ml2/ml2_conf_arista.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf_arista.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2

/etc/neutron/plugins/ml2/ml2_conf_brocade.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf_brocade.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2

/etc/neutron/plugins/ml2/ml2_conf_cisco.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf_cisco.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2

/etc/neutron/plugins/ml2/ml2_conf_mlnx.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf_mlnx.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2

/etc/neutron/plugins/ml2/ml2_conf_ncs.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf_ncs.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2

/etc/neutron/plugins/ml2/ml2_conf_odl.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf_odl.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2

/etc/neutron/plugins/ml2/ml2_conf_ofa.ini:
  file.managed:
    - template:    jinja
    - source:      salt://{{ sls }}/etc/neutron/plugins/ml2/ml2_conf_ofa.ini
    - user:        root
    - group:       root
    - mode:       '0644'
    - watch:
      - pkg:       neutron-plugin-ml2
