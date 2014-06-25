# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.redis-server

state_sls_node-redis-commander:
  salt.state:
    - tgt:         roles:node-redis-commander
    - tgt_type:    grain
    - sls:         node-redis-commander
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_redis-server

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_node-redis-commander:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:node-redis-commander'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_node-redis-commander
