# vi: set ft=yaml.jinja :

{% set environment =  salt['grains.get']('environment') %}
{% set version     = 'cm4' %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.cloudera-{{ version }}-server
  -  orchestrate.hadoop
  -  orchestrate.zookeeper-server
  -  orchestrate.hbase-regionserver

state_sls_hbase-master:
  salt.state:
    - tgt:         roles:hbase-master
    - tgt_type:    grain
    - sls:         hbase-master
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_cloudera-{{ version }}-server
      - salt:      state_sls_hadoop
      - salt:      state_sls_zookeeper-server
      - salt:      state_sls_hbase-regionserver

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_hbase-master:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:hbase-master'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_hbase-master
