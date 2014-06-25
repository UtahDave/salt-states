# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.elasticsearch

state_sls_kibana:
  salt.state:
    - tgt:         roles:kibana
    - tgt_type:    grain
    - sls:         kibana
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_elasticsearch

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_kibana:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:kibana'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_kibana
