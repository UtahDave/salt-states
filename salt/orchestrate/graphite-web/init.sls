# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.graphite-carbon

state_sls_graphite-web:
  salt.state:
    - tgt:         roles:graphite-web
    - tgt_type:    grain
    - sls:         graphite-web
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_graphite-carbon

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_graphite-web:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:graphite-web'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_graphite-web
