# vi: set ft=yaml.jinja :

{% set latest  = salt['pkg.latest_version']('libgit2-dev') %}
{% set version = salt['pkg.version']('libgit2-dev') %}

include:
  -  libgit2-dev
  -  python-dev
  -  python-pip

python-pygit2:
  pip.installed:
    - name:        pygit2 == {{ (latest|default(version, True)).split('-')[0] }}
    - require:
      - pkg:       python-dev
      - pkg:       python-pip
    - watch:
      - pkg:       libgit2-dev
