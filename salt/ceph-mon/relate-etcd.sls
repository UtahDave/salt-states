# vi: set ft=yaml.jinja :

{% set cluster =   salt['grains.get']('environment', 'ceph') %}
{% set host    =   salt['config.get']('host') %}
{% set ipv4    =   salt['config.get']('fqdn_ip4') %}
{% set keyring = '/var/lib/ceph/tmp/' + cluster + '.mon.keyring' %}
{% set monmap  = '/var/lib/ceph/tmp/monmap' %}

{% if salt['config.get']('etcd.host') %}

{% set fsid = salt['etcd.get']('/ceph/' + cluster + '/fsid') %}

{% if fsid %}

monmaptool --create {{ monmap }}:
  cmd.run:
    - name:      |-
                 ( monmaptool --add  {{ host }} {{ ipv4[0] }}                  \
                              --create                                         \
                              --fsid {{ fsid }}                                \
                                     {{ monmap }}
                 )
    - unless:    |-
                 (  test -f /var/lib/ceph/mon/{{ cluster }}-{{ host }}/keyring \
                 || test -f {{ monmap }}
                 )
    - require:
      - pkg:       ceph

ceph-mon --mkfs:
  cmd.wait:
    - name:      |-
                 ( ceph-mon --mkfs                                             \
                            --cluster {{ cluster }}                            \
                            --id      {{ host }}                               \
                            --keyring {{ keyring }}                            \
                            --monmap  {{ monmap }}
                 )
    - unless:      test -f /var/lib/ceph/mon/{{ cluster }}-{{ host }}/keyring
    - require:
      - file:     /var/lib/ceph/mon/{{ cluster }}-{{ host }}
    - watch:
      - cmd:       ceph-authtool {{ keyring }} --import-keyring {{ import }}
      - cmd:       monmaptool --create {{ monmap }}

{% endif %}
{% endif %}
