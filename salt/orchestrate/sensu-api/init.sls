# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.sensu-server

state_sls_sensu-api:
  salt.state:
    - tgt:         roles:sensu-api
    - tgt_type:    grain
    - sls:         sensu-api
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_sensu-server

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_sensu-api:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:sensu-api'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_sensu-api
