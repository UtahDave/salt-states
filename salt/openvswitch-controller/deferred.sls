# vi: set ft=yaml.jinja :

#/etc/default/openvswitch-controller:
# file.managed:
#   - template:    jinja
#   - source:      salt://{{ sls }}/etc/default/openvswitch-controller
#   - user:        root
#   - group:       root
#   - mode:       '0644'
#   - watch:
#     - pkg:       openvswitch-controller
#   - watch_in:
#     - service:   openvswitch-controller
