# vi: set ft=yaml.jinja :

#state_sls_python-psutil:
# cmd.state.sls:
#   - tgt:      {{ data.id }}
#   - arg:
#     - python-psutil
#   - kwarg:
#       queue:     True

state_highstate:
  cmd.state.highstate:
    - tgt:      {{ data.id }}
    - kwarg:
        queue:     True

state_sls_orchestrate:
  cmd.state.sls:
    - tgt:      {{ data.id }}
    - arg:
      - orchestrate
    - kwarg:
        queue:     True
