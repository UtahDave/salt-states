# vi: set ft=yaml.jinja :

{% set environment =  salt['grains.get']('environment') %}
{% set version     = 'cm4' %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.cloudera-{{ version }}-server

state_sls_zookeeper-server:
  salt.state:
    - tgt:         roles:zookeeper-server
    - tgt_type:    grain
    - sls:         zookeeper-server
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_cloudera-{{ version }}-server

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_zookeeper-server:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:zookeeper-server'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_zookeeper-server
