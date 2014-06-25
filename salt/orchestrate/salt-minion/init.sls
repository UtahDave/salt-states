# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-master

state_sls_salt-minion:
  salt.state:
    - tgt:        '*'
    - sls:         salt-minion
    - require:
      - salt:      state_sls_salt-master

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_salt-minion:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:salt-minion'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_salt-minion
