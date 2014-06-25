# vi: set ft=yaml.jinja :

{% set ipv4     = salt['config.get']('fqdn_ip4') %}
{% set nodename = salt['config.get']('nodename') %}

Cluster 1 - CDH4:
  cloudera_cluster.present:
    - version:     CDH4

{{ nodename }}:
  cloudera_host.present:
    - cluster:     Cluster 1 - CDH4
    - address:  {{ ipv4[0] }}
    - require:
      - cloudera_cluster:    Cluster 1 - CDH4

CDH:
  cloudera_parcel.installed:
    - cluster:     Cluster 1 - CDH4
    - version:     4.5.0-1.cdh4.5.0.p0.30
    - require:
      - cloudera_cluster:    Cluster 1 - CDH4
      - cloudera_host:    {{ nodename }}
