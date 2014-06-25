# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.elasticsearch

state_sls_elasticsearch-kopf:
  salt.state:
    - tgt:         roles:elasticsearch-kopf
    - tgt_type:    grain
    - sls:         elasticsearch-kopf
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_elasticsearch

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_elasticsearch-kopf:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:elasticsearch-kopf'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_elasticsearch-kopf
