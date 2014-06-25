# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

include:
  -  orchestrate.salt-minion
  -  orchestrate.elasticsearch

state_sls_logstash:
  salt.state:
    - tgt:         roles:logstash
    - tgt_type:    grain
    - sls:         logstash
    - require:
      - salt:      state_sls_salt-minion
      - salt:      state_sls_elasticsearch

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_logstash:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:logstash'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_logstash
