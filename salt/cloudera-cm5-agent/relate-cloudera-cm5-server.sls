# vi: set ft=yaml.jinja :

{% set ipv4     = salt['config.get']('fqdn_ip4') %}
{% set nodename = salt['config.get']('nodename') %}

Cluster 1 - CDH5:
  cloudera_cluster.present:
    - version:     CDH5

{{ nodename }}:
  cloudera_host.present:
    - cluster:     Cluster 1 - CDH5
    - address:  {{ ipv4[0] }}
    - require:
      - cloudera_cluster:    Cluster 1 - CDH5

CDH:
  cloudera_parcel.installed:
    - cluster:     Cluster 1 - CDH5
    - version:     5.0.1-1.cdh5.0.1.p0.47
    - require:
      - cloudera_cluster:    Cluster 1 - CDH5
      - cloudera_host:    {{ nodename }}
