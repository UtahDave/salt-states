# vi: set ft=yaml.jinja :

{% set psls = sls.split('.')[0] %}

include:
  -  iscistarget
