# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion

state_sls_rabbitmq-server:
  salt.state:
    - tgt:         roles:rabbitmq-server
    - tgt_type:    grain
    - sls:         rabbitmq-server
    - require:
      - salt:      state_sls_salt-minion

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_rabbitmq-server:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:rabbitmq-server'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_rabbitmq-server
