# vi: set ft=yaml.jinja :

{% set environment = salt['grains.get']('environment') %}

state_sls_salt-master:
  salt.state:
    - tgt:         roles:salt-master
    - tgt_type:    grain
    - sls:         salt-master

#-------------------------------------------------------------------------------
# TODO: this will not work until pillar['roles'] can be passed
#-------------------------------------------------------------------------------

#state_sls_orchestrate_salt-master:
# salt.state:
#   - tgt:        'G:environment:{{ environment }} and not G@roles:salt-master'
#   - tgt_type:    compound
#   - sls:         orchestrate
#   - require:
#     - salt:      state_sls_salt-master
