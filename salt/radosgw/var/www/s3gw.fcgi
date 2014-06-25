{% set cluster = salt['grains.get']('environment', 'ceph') -%}
#!/bin/sh
exec /usr/bin/radosgw --cluster {{ cluster }}                                  \
                      --conf      /etc/ceph/{{ cluster }}.conf                 \
                      --name       client.radosgw.gateway
