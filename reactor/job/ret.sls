# vi: set ft=yaml.jinja :

{% if             data.fun     == 'state.highstate'
   and            data.retcode ==  0 %}
{% for  return in data.return.values() %}
{% if   return.changes|length   >  0
   and  return.name            != 'mine.update' %}

grains_setval_high:
  cmd.grains.setval:
    - tgt:        '{{ data.id }}'
    - arg:
      - high
      - True

state_sls_orchestrate:
  cmd.state.sls:
    - tgt:        'G@high:True and not {{ data.id }}'
    - expr_form:   compound
    - arg:
      - orchestrate
    - kwarg:
        queue:     True
        pillar:
          related: {'minion': '{{ data.id }}'}

{% break %}
{% endif %}
{% endfor %}
{% endif %}
