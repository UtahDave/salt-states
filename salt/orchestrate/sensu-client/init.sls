# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.rabbitmq-server
  -  orchestrate.sensu-api

state_sls_sensu-client:
  salt.state:
    - tgt:         roles:sensu-client
    - tgt_type:    grain
    - sls:         sensu-client
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_rabbitmq-server
      - salt:      state_sls_sensu-api

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_sensu-client:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:sensu-client'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_sensu-client
